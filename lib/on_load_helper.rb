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
    
    result = %{document.observe('dom:loaded', function() {#{content}})\n}
    
    if block_given? && block_called_from_erb?(block)
      concat(result)
    else
      result
    end
  end
end
