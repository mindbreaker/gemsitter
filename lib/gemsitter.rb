module Gemsitter
  autoload :VersionCheck,	'gemsitter/versioncheck'
  autoload :GemLockfileParser, 'gemsitter/myparser'
  autoload :SemanticVersion, 'gemsitter/semanticversion'


class << self
    def run(interval=:week, level=:minor)
      base = Base.new(interval, level)
      base.load
    end
  end

  class Base

    require "yaml"

    def initialize(interval, level=:minor)
      @interval = interval
      @level = level
      @logger = Logger.new(STDOUT)
    end

 

    def load
      parser = GemLockfileParser.new
      logger("Fetching Gems from Gemfile.lock")
      @gems =  parser.get_gems
      logger("#{@gems.size} loaded")
      logger("Checking the newest Version")

      actual_version

      check_versions
    end

    def actual_version
      version = VersionCheck.new

      # Test if its time to update from Rubygems
      if version.time_to_update? @interval

        @gems.each do |gem|
          newest_version = version.check_version(gem[:name])
          gem[:newest_version] = newest_version if newest_version
        end

        File.open("tmp/gs.yml","w") do |f|
          f.write @gems.to_yaml
        end
      else
        @gems = YAML::load_file("tmp/gs.yml")
      end
    end

    def check_versions
      updates = SemanticVersion.new
      @gems.each do |gem|
        unless gem[:newest_version]
          logger("Rubygem-Source of #{gem[:name]} not found")
        else
          unless updates.compare(gem[:version],gem[:newest_version])
            logger("#{updates.what_changed?} of #{gem[:name]}: #{gem[:newest_version]} / Your Version: #{gem[:version]}")
          end
        end
      end
    end


    def logger(text)
      @logger.warn(text)
    end
  end


  class Railtie < Rails::Railtie

    rake_tasks do
      desc 'Check used Gems for an update'
      task :gemsitter do
        Gemsitter.run
      end
    end
  end



end