class ShelterService

  API_URL = 'http://api.petfinder.com'
  API_KEY = 'ea7dcc7ca68dbd7e84e740378eed514c'

  def self.create(attrs)
    shelter = Shelter.new(attrs)
    import(shelter)
    shelter.save
    shelter
  end

  def self.import(shelter)
    url = "#{API_URL}/shelter.get?format=json&key=#{API_KEY}&id=#{shelter.awo_id}"
    response = open(url) { |v| JSON(v.read).with_indifferent_access }
    data = response[:petfinder][:shelter]

    address = data[:address1]['$t']
    address += ' ' + data[:address2]['$t'] if data[:address2]['$t']

    shelter.name = data[:name]['$t']
    shelter.address = address
    shelter.city = data[:city]['$t']
    shelter.state = data[:state]['$t']
    shelter.zip = data[:zip]['$t']
    shelter.phone = data[:phone]['$t']
    shelter.fax = data[:fax]['$t']
  end

end
