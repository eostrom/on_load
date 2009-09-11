require 'test_helper'
require 'on_load_helper'

class TestOnLoadHelper < ActiveSupport::TestCase
  include OnLoadHelper
  
  test 'on_load treats a string as JavaScript' do
    assert_equal(
      %{document.observe('dom:loaded', function() {true && false})\n},
      on_load('true && false'))
  end
  
  test 'on_load puts newlines around a multiline string' do
    assert_equal([
        "document.observe('dom:loaded', function() {",
        "true && false;\nfalse && true;",
        "})\n"
      ].join("\n"),
      on_load("true && false;\nfalse && true;"))
  end
  
#   test "on_load treats a no-args block as JavaScript"
  
#   test "on_load treats a one-arg block as RJS"
end
