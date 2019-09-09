
class NotifyUsers
  include Sidekiq::Worker
 
  def perform(email, u_name)

     byebug
    UserMailer.notification_email(email, u_name).deliver
  end

  end	