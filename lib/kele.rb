require 'httparty'

class Kele
    
  include HTTParty
  
  def initialize(email, pwd)
    @email = email
    @pwd   = pwd
    @response = self.class.post("https://www.bloc.io/api/v1/sessions", body:{email: @email, password: @pwd})
  end

end