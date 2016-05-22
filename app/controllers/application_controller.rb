class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def hello
  	  render text: "<h1> Telemedycyna to przyszłość </h1><br><a href='exams/new'>WRZUĆ SYGNAU</a>"
  end

end
