class Api::Rest::V1::SheltersController  < Api::Rest::V1::BaseController

  respond_to :json

  def create
    @shelter = ShelterService.create(shelter_params)
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
