class ApplicationController < ActionController::Base
  # Remove the current_user method
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include DeviseWhitelist
end
