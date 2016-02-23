module FileHandler
  def read_fixture(file_name)
    return read_file("../fixtures/#{file_name}")
  end

  def fixture_exist?(file_name)
    return file_exist?("../fixtures/#{file_name}")
  end

  def read_file(file_name)
    file_path = File.expand_path(file_name, File.dirname(__FILE__))
    File.open(file_path, 'rb').read
  end

  def file_exist?(file_name)
    file_path = File.expand_path(file_name, File.dirname(__FILE__))
    File.exist?(file_path)
  end
end
