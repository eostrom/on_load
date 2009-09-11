module OnLoadHelper
  def on_load(content = nil)
    if content && content.include?("\n")
      /\A\n*(.*[^\n])\n*\Z/m =~ content
      content = content.sub(/\A\n*(.*[^\n])\n*\Z/m, "\n#{$1}\n")
    end
    
    %{document.observe('dom:loaded', function() {#{content}})\n}
  end
end
