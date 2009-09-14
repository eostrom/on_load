module OnLoadHelper
  def on_load(content = nil, &block)
    if block_given?
      if block.arity > 0
        content = update_page(&block)
      else
        content = capture(&block)
      end
    end
    
    if content && content.include?("\n")
      /\A\n*(.*[^\n])\n*\Z/m =~ content
      content = content.sub(/\A\n*(.*[^\n])\n*\Z/m, "\n#{$1}\n")
    end
    
    result = OnLoadHelper::wrap_with_on_load {|out| out << content}
    
    if block_given? && block_called_from_erb?(block)
      concat(result)
    else
      result
    end
  end
  
  ON_LOAD_WRAPPER_START =
    %[document.observe('dom:loaded', function() {]
  ON_LOAD_WRAPPER_END = %[})\n]
  
  def self.wrap_with_on_load(output = '')
    output << ON_LOAD_WRAPPER_START
    yield(output)
    output << ON_LOAD_WRAPPER_END
  end
end

module ActionView #:nodoc:
  module Helpers #:nodoc:
    module PrototypeHelper #:nodoc:
      class JavaScriptGenerator #:nodoc:
        module GeneratorMethods
          def on_load(&block)
            OnLoadHelper::wrap_with_on_load(self, &block)
          end
        end
      end
    end
  end
end
