module RandomGen
  def set_random
    puts "@message = #{@message}"
    @message ||= rand(4)
  end
end
