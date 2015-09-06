class ContactMailer < ApplicationMailer
  default from: 'info@pickatune.net'

  def contact(name, email, message)
    mail(:to => email, :subject => "New message #{name}")
  end
end
