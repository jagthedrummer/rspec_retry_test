class HomeController < ApplicationController
  def index
    puts "before optional assignment @message = #{@message}"
    @message ||= rand(4)
    puts "after optional assignment @message = #{@message}"
  end
end
