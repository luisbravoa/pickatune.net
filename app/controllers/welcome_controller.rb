class WelcomeController < ApplicationController
  def index
    @platform = platform(request.user_agent)
    @platforms = get_all_platforms
  end

  def download
    @path = "#{params['platform']}/#{params['file']}"
  end
  def contact

    parse_request

    unless @json.has_key?('email') && @json.has_key?('name') && @json.has_key?('message')
      return render :nothing => true, :status => :bad_request
    end


    ContactMailer.contact(@json['name'], @json['email'], @json['message']).deliver_now

    render :nothing => true

  end

  def get_all_platforms
    platforms = {}
    ['win32', 'win64', 'linux32', 'linux64', 'osx32', 'osx64'].each do |platform|
      platforms[platform] = get_file_by_platform(platform)
    end
    platforms
  end

  def get_file_by_platform platform
    path = "public/dist/#{platform}"
    if File.exist?(path)
      filepath = Dir["#{path}/*"].max_by { |f|
        version = File.basename(f, '.zip').split('-').last
        Gem::Version.new(version)
      }
      # Pathname.new(filepath).basename
      File.basename(filepath, '.zip')
      {
          'file' => File.basename(filepath),
          'version' => File.basename(filepath, '.zip').split('-').last,
          'platform' => platform
      }
    end
  end

  def platform (user_agent)
    if user_agent.index('Win32') != nil && user_agent.index('x86') != nil
      return 'win32';
    end

    if user_agent.index('MacIntel') != nil
      return 'osx64';
    end

    if user_agent.index('Win64') != nil && user_agent.index('x64') != nil
      return 'win64';
    end

    if user_agent.index('Linux i686') != nil
      return 'linux32';
    end

    if user_agent.index('Linux x86_64') != nil
      return 'linux64';
    end

    'win64'

  end
end
