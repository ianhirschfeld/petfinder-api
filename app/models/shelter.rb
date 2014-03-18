class Shelter < ActiveRecord::Base

  attr_accessor :import_count

  has_many :animals

end
