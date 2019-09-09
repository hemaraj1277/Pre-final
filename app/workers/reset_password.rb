class ResetPassword
  include Sidekiq::Worker
 
  def perform(name, email, token)
    
  
    UserMailer.forgot_password(name, email, token).deliver
  end

  end	