class SemanticVersion
  
  def compare(current_version, newest_version)
    @newest_version = newest_version.split(".")
    @current_version = current_version.split(".")
    all = true
    @current_version.each_with_index do |value, key|
      all = false unless (value == @newest_version[key.to_i])
    end
    return all
  end

  def what_changed?
    status = "No semantic Versioning but update"
    status = "Patch" if @newest_version[2] != @current_version[2]
    status = "Minor Update" if @newest_version[1] != @current_version[1]
    status = "Major Update" if @newest_version[0] != @current_version[0]
    return status
  end

  private

  def level level
    case level
    when :major
      return 3
    when :minor
      return 3
    else
      return 1
    end
  end
end