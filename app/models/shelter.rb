class Shelter < ActiveRecord::Base

  attr_accessor :import_count

  validates :awo_id, presence: true, uniqueness: true

  has_many :animals, dependent: :destroy

end
