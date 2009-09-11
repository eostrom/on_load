module OnLoadHelper
  def on_load(content = nil, &block)
    if block_given?
      content = update_page(&block)
    end
    
    if content && content.include?("\n")
      /\A\n*(.*[^\n])\n*\Z/m =~ content
      content = content.sub(/\A\n*(.*[^\n])\n*\Z/m, "\n#{$1}\n")
    end
    
    %{document.observe('dom:loaded', function() {#{content}})\n}
  end
end
