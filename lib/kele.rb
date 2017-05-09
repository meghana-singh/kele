require_relative 'roadmap'
require 'json'
require 'httparty'

class Kele
  attr_accessor :auth_token, :user_data, :mentor_avail, :json_user_data_response
  
  include JSON
  include HTTParty
  include Roadmap
  
  def initialize(email, pwd)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {email: email, password: pwd})
    if response.code == 200
      @auth_token = response["auth_token"] 
    else
      puts "The Credentials passed aren't right. Please enter valid email and pwd. Thanks."
    end
  end

  def get_me 
    @json_user_data_response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { authorization: @auth_token })
    @user_data = JSON.parse(json_user_data_response.body) 
    puts "name:  #{@user_data["name"]}" + "\n" + "email: #{@user_data["email"]}\n"  + "course name: #{@user_data["course"]["name"]}\n" 
  end
  
  def get_mentor_availability
     mentor_id = @json_user_data_response["current_enrollment"]["mentor_id"] 
     response  = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", body: {id: mentor_id}, headers: {authorization: @auth_token})
     mentor_app_details = JSON.parse(response.body)
     puts mentor_app_details
  end
  
end