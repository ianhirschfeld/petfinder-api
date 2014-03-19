class Api::Rest::V1::SheltersController  < Api::Rest::V1::BaseController

  respond_to :json

  def create
    valid_params = shelter_params

    # If shelter already exists, update its info and reimport its pets
    # Else do normal creation flow
    if @shelter = Shelter.find_by_awo_id(valid_params[:awo_id])
      @shelter.import_count = valid_params[:import_count]
      ShelterService.import(@shelter)
      ShelterService.import_pets(@shelter)
    else
      @shelter = ShelterService.create(valid_params)
    end

    respond_with @shelter
  end

  private

  def shelter_params
    params.require(:shelter).permit(
      :awo_id,
      :import_count
    )
  end

end
