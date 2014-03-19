class RenameAnimalBreedToBreeds < ActiveRecord::Migration
  def change
    rename_column :animals, :breed, :breeds
  end
end
