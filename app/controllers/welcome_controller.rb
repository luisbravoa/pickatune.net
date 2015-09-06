class WelcomeController < ApplicationController
  def index

    @platform = platform(request.user_agent)
    @platforms = get_all_platforms
    puts @platforms
  end

  def download
    @path = "#{params['platform']}/#{params['file']}"
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
      filepath = Dir["#{path}/*"].max_by { |f| File.ctime(f) }
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

  end
end