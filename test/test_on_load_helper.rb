require 'test_helper'
require 'on_load_helper'

class TestOnLoadHelper < ActionController::TestCase
  include OnLoadHelper
  include ActionView::Helpers::PrototypeHelper
  
  def setup
    @controller = OnLoadTestController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
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
  
  test "on_load treats a no-args block in ERB as JavaScript" do
    get :on_load_with_block_with_no_args

    assert_match(
      code_regexp(%[
        document.observe('dom:loaded', function() {
          alert('block');
        })
      ]),
      @response.body)
  end

  test "on_load treats a one-arg block like update_page" do
    get :on_load_with_block_with_one_arg
    
    assert_match(
      code_regexp(%[
        document.observe('dom:loaded', function() {alert("hi!");})\n
      ]),
      @response.body)
  end

protected
  
  def code_regexp(code)
    Regexp.new(
      code.strip.split("\n").map do |line|
        Regexp.quote(line.strip)
      end.join('\s+'),
      'm')
  end
end
