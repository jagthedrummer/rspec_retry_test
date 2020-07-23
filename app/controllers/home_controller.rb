class HomeController < ApplicationController
  include RandomGen
  before_action :set_random
  def index
  end
end
