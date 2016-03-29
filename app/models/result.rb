class Result

  attr_accessor :success, :message, :redirect
  def initialize success, message, redirect
    @success = success
    @message = message
    @redirect = redirect
  end

end
