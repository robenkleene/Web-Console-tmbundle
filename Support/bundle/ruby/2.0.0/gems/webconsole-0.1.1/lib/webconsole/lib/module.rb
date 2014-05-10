require 'Shellwords'
module WebConsole
  LOAD_PLUGIN_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "load_plugin.scpt")
  def self.load_plugin(path)
    self.run_applescript(LOAD_PLUGIN_SCRIPT, [path])
  end

  EXISTS_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "exists.scpt")
  def self.application_exists
    result = self.run_applescript(EXISTS_SCRIPT)
    result.chomp!
    if result == "true"
      return true
    else
      return false
    end
  end

  RUN_PLUGIN_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "run_plugin.scpt")
  def self.run_plugin(name, directory = nil, arguments = nil)
    parameters = [name]
    if directory
      parameters.push(directory)
    end
    if arguments
      parameters = parameters + arguments
    end
    self.run_applescript(RUN_PLUGIN_SCRIPT, parameters)
  end

  PLUGIN_HAS_WINDOWS_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "plugin_has_windows.scpt")
  def self.plugin_has_windows(name)
    result = self.run_applescript(PLUGIN_HAS_WINDOWS_SCRIPT, [name])
    result.chomp!
    if result == "true"
      return true
    else
      return false
    end
  end

  WINDOW_ID_FOR_PLUGIN_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "window_id_for_plugin.scpt")
  def self.window_id_for_plugin(name)
    result = self.run_applescript(WINDOW_ID_FOR_PLUGIN_SCRIPT, [name])
    result.chomp!
    return result
  end

  # Shared Resources

  RESOURCE_PATH_FOR_PLUGIN_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "resource_path_for_plugin.scpt")
  def self.resource_path_for_plugin(name)
    result = self.run_applescript(RESOURCE_PATH_FOR_PLUGIN_SCRIPT, [name])
    result.chomp!
    return result
  end

  # Shared Resource Path

  SHARED_RESOURCES_PLUGIN_NAME = "Shared Resources"
  SHARED_TEST_RESOURCES_PLUGIN_NAME = "Shared Test Resources"
  def self.shared_resources_path
    return resource_path_for_plugin(SHARED_RESOURCES_PLUGIN_NAME)
  end
  def self.shared_test_resources_path
    return resource_path_for_plugin(SHARED_TEST_RESOURCES_PLUGIN_NAME)
  end

  def self.shared_resource(resource)
    return File.join(self.shared_resources_path, resource)
  end
  def self.shared_test_resource(resource)
    return File.join(self.shared_test_resources_path, resource)    
  end

  # Shared Resource URL

  RESOURCE_URL_FOR_PLUGIN_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "resource_url_for_plugin.scpt")
  def self.resource_url_for_plugin(name)
    result = self.run_applescript(RESOURCE_URL_FOR_PLUGIN_SCRIPT, [name])
    result.chomp!
    return result
  end
  def self.shared_resources_url
    return resource_url_for_plugin(SHARED_RESOURCES_PLUGIN_NAME)
  end


  PLUGIN_READ_FROM_STANDARD_INPUT_SCRIPT = File.join(APPLESCRIPT_DIRECTORY, "plugin_read_from_standard_input.scpt")
  def self.plugin_read_from_standard_input(name, text)
    self.run_applescript(PLUGIN_READ_FROM_STANDARD_INPUT_SCRIPT, [name, text])
  end

  private

  def self.run_applescript(script, arguments = nil)
    command = "osascript #{Shellwords.escape(script)}"
    if arguments
      arguments.each { |argument|
        if argument
          argument = argument.to_s
          command = command + " " + Shellwords.escape(argument)
        end
      }
    end
    return `#{command}`
  end
end