module Roadmap
    
  def get_roadmaps
    roadmaps_id = @json_user_data_response["current_enrollment"]["roadmap_id"]
    response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{roadmaps_id}", headers: {authorization: @auth_token})
    @roadmaps_details = JSON.parse(response.body)
    puts @roadmaps_details
  end
  
  def get_checkpoint(chkpt_id)
    response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{chkpt_id}", headers: {authorization: @auth_token})
    checkpoint_details = JSON.parse(response.body)
    puts checkpoint_details
  end
  
end