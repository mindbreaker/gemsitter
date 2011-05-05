require 'net/http'
require 'rexml/document'

class VersionCheck


  def check_version(gem)
    
		# get the XML data as a string
		url = "http://rubygems.org/api/v1/gems/#{gem.to_s}.xml"
    begin
      
      xml_data = Net::HTTP.get_response(URI.parse(url)).body
      return false if xml_data.size < 8
      doc = REXML::Document.new(xml_data)
      return doc.elements['rubygem/version'].text

    rescue Exception => e

      raise Exception, e
      return
    end
	end

  def time_to_update? interval
    case interval
    when :month
      days = 30
    when :day
      days = 1
    else
      days = 7
    end

    return true unless File.exists?("tmp/gs.yml")
    file_time = File.stat("tmp/gs.yml").mtime
    next_check = Time.now + days * 60 * 60 * 24

    next_check < file_time ? true : false

  end

end