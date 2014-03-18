class CreateAnimals < ActiveRecord::Migration
  def change
    create_table :animals do |t|
      t.integer :shelter_id
      t.text :breed
      t.text :shelter_pet_id
      t.text :name
      t.text :address
      t.text :city
      t.text :state
      t.text :zip
      t.text :phone
      t.text :fax
      t.text :description
      t.text :sex
      t.text :size
      t.text :mix
      t.text :animal
      t.text :photos

      t.timestamps
    end

    add_index :animals, :shelter_id
    add_index :animals, :shelter_pet_id
  end
end
