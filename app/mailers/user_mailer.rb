class UserMailer < ApplicationMailer

  default from: 'andsbf.dev@gmail.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def bye_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'byebye from rotten')
  end
end
