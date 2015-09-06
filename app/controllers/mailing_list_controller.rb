class MailingListController < ApplicationController

  layout false
  before_filter :parse_request

  before_filter :only => :create do
  unless @json.has_key?('email')
    render :nothing => true, :status => :bad_request
  end
  end

  def create
    @email = Email.new(:email => @json['email'])

    @email.valid?

    if @email.valid? && @email.save
      render :json => @email
    else
      render :nothing => true, :status => :bad_request
    end
  end
end
