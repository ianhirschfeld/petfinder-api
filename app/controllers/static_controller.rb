class StaticController < ApplicationController

  def home
    @shelter = Shelter.new
  end

end
