# A controller that just passes control to the view, so we can
# test the helper methods.
class OnLoadTestController < ApplicationController
  # Respond to any action by rendering a template.
  def method_missing(symbol, *args); end
end
