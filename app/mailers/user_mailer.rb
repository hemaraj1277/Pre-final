class UserMailer < ActionMailer::Base


  default from: "hemaraj1277@gmail.com"

   def notification_email(email_id, u_name)
    

 
  mail(to: email_id, subject: 'Regarding Request', body: u_name)

    
  end

  def forgot_password(name, email, token)
  @user = name
  @greeting = "Hi"
  @token = token
  
  mail(to: email, subject: 'Reset password instructions')
end

end
