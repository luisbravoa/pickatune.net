class ContactMailer < ApplicationMailer
  default from: 'noreply@pickatune.net'

  def contact(name, email, message)
    @name = name
    @email = email
    @message = message
    mail(:to => 'info@pickatune.net', :subject => "New message from #{name}")
  end
end
