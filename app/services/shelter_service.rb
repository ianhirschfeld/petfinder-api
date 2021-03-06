class ShelterService

  API_URL = 'http://api.petfinder.com'
  API_KEY = 'ea7dcc7ca68dbd7e84e740378eed514c'

  # Creates a shelter by pulling information from the Petfinder API.
  # After creation, import pets for the shelter.
  # Returns the created shelter
  def self.create(attrs)
    shelter = Shelter.new(attrs)
    if shelter.valid?
      import(shelter)
      import_pets(shelter) if !shelter.errors.any? && shelter.save
    end
    shelter
  end

  # Create an animal or update it if it exists already.
  def self.create_animal(shelter, animal_attrs = {})
    if animal = shelter.animals.find_by_shelter_pet_id(animal_attrs[:shelter_pet_id])
      animal.update_attributes animal_attrs
    else
      animal = shelter.animals.create animal_attrs
    end

    animal
  end

  # Import shelter data from the Petfinder API
  # Returns the shelter
  def self.import(shelter)
    url = "#{API_URL}/shelter.get?format=json&key=#{API_KEY}&id=#{shelter.awo_id}"
    response = open(url) { |v| JSON(v.read).with_indifferent_access }

    data = response[:petfinder][:shelter]

    if data
      address = data[:address1]['$t']
      address += ' ' + data[:address2]['$t'] if data[:address2]['$t']

      shelter.name = data[:name]['$t']
      shelter.address = address
      shelter.city = data[:city]['$t']
      shelter.state = data[:state]['$t']
      shelter.zip = data[:zip]['$t']
      shelter.phone = data[:phone]['$t']
      shelter.fax = data[:fax]['$t']
    else
      shelter.errors.add(:awo_id, 'not found')
    end

    shelter
  end

  # Import pets for the given shelter from the Petfinder API.
  # Returns an array of new animals for the shelter
  def self.import_pets(shelter)
    import_count = shelter.import_count || 30

    url = "#{API_URL}/shelter.getPets?format=json&key=#{API_KEY}&id=#{shelter.awo_id}&count=#{import_count}"
    response = open(url) { |v| JSON(v.read).with_indifferent_access }

    pets = response[:petfinder][:pets]
    animals = []

    if pets[:pet].is_a? Array
      pets[:pet].each do |pet|
        # Only import dogs and cats
        next unless ['Dog', 'Cat'].include?(pet[:animal]['$t'])

        attrs = get_pet_attrs(pet)
        animal = create_animal(shelter, attrs)
        animals.push animal
      end
    else
      attrs = get_pet_attrs(pets[:pet])
      animal = create_animal(shelter, attrs)
      animals.push animal
    end

    animals
  end

  def self.get_pet_attrs(pet = {})
    address = pet[:contact][:address1]['$t']
    address += ' ' + pet[:contact][:address2]['$t'] if pet[:contact][:address2]['$t']

    attrs = {
      breeds: [],
      shelter_pet_id: pet[:shelterPetId]['$t'],
      name: pet[:name]['$t'],
      address: address,
      city: pet[:contact][:city]['$t'],
      state: pet[:contact][:state]['$t'],
      zip: pet[:contact][:zip]['$t'],
      phone: pet[:contact][:phone]['$t'],
      fax: pet[:contact][:fax]['$t'],
      description: pet[:description]['$t'],
      sex: pet[:sex]['$t'],
      size: pet[:size]['$t'],
      mix: pet[:mix]['$t'],
      animal: pet[:animal]['$t'],
      photos: []
    }

    if pet[:breeds][:breed].is_a? Array
      pet[:breeds][:breed].each do |breed|
        attrs[:breeds].push breed['$t']
      end
    else
      attrs[:breeds].push pet[:breeds][:breed]['$t']
    end

    if pet[:media][:photos][:photo].is_a? Array
      pet[:media][:photos][:photo].each do |photo|
        attrs[:photos].push photo['$t']
      end
    else
      attrs[:photos].push pet[:media][:photos][:photo]['$t']
    end

    attrs
  end

end
