class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale

  def parse_request
    @json = JSON.parse(request.body.read)
  end

  def set_locale
    if locale_available?
      I18n.locale = extract_locale_from_accept_language_header
    end

    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  private
  def extract_locale_from_accept_language_header
    if !request.env['HTTP_ACCEPT_LANGUAGE'].nil?
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    else
      "en"
    end
  end

  def locale_available?
    I18n.available_locales.map(&:to_s).include? extract_locale_from_accept_language_header
  end
end
