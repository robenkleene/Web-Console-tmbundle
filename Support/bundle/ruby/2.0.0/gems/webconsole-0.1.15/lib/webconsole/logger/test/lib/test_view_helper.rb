require_relative 'test_constants'

class TestViewHelper

    def initialize(window_id, view_id)
      @view = WebConsole::View.new(window_id, view_id)
      javascript = File.read(TEST_JAVASCRIPT_FILE)
      @view.do_javascript(javascript)
    end

    def log_message_at_index(index)
      return @view.do_javascript_function('innerTextOfBodyChildAtIndex', [index])
    end

    def number_of_log_messages
      # TODO: Do JavaScript should coerce types
      return @view.do_javascript(TEST_MESSAGE_COUNT_JAVASCRIPT).chomp.to_i
    end

    def last_log_message
      return @view.do_javascript(TEST_MESSAGE_JAVASCRIPT).chomp
    end
  
    def last_log_class
      return @view.do_javascript(TEST_CLASS_JAVASCRIPT).chomp
    end

end
