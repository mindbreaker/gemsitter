class GemLockfileParser

  def read	
	
	  @lockfile.split(/(\r?\n)+/).each do |line|
      if line.match(/^    ([a-zA-Z0-9\-_]+) \((.*)\)/)
        gem = line.split(/^    ([a-zA-Z0-9\-_]+) \((.*)\)/)
        @gems << {:name => gem[1], :version => gem[2]}
      end
	  end

    return @gems

  end
  
  def readfile(file)
    if File.exists?(file)
      file = File.new(file, "r")
      while (line = file.gets)
        @lockfile += line
	    end
      file.close
      read
    else
      puts "No such file"
    end
  end

  def get_gems
    readfile(Rails.root + "Gemfile.lock")
  end


  def initialize
    @lockfile = ""
    @gems = []
  end
end