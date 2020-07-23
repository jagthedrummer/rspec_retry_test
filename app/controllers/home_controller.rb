class HomeController < ApplicationController
  def index
    @message ||= rand(3)
  end
end
