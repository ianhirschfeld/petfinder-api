class CreateShelters < ActiveRecord::Migration
  def change
    create_table :shelters do |t|
      t.text :awo_id
      t.text :name
      t.text :address
      t.text :city
      t.text :state
      t.text :zip
      t.text :phone
      t.text :fax

      t.timestamps
    end

    add_index :shelters, :awo_id, unique: true
  end
end
