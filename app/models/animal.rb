class Animal < ActiveRecord::Base

  serialize :breeds
  serialize :photos

  belongs_to :shelter

end
