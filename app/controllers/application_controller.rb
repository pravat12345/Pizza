class ApplicationController < ActionController::API

  before_action :authenticate_client! 

  private

  # Ensures valid OAuth token as filter applied
  def authenticate_client!
    doorkeeper_authorize! 
  end
end
