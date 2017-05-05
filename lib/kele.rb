require 'httparty'

class Kele
  attr_accessor :auth_token, :user_data
  
  include HTTParty
  
  def initialize(email, pwd)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {email: email, password: pwd})
    @auth_token = response["auth_token"] 
  end

  def get_me 
    @user_data = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token }) 
     
    puts "name:  #{@user_data["name"]}" + "\n" + "email: #{@user_data["email"]}\n"  + "course name: #{@user_data["course"]["name"]}\n" 
  end
end