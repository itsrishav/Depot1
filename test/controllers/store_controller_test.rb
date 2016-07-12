require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select "#column #side a", minimum: 4
    assert_select "#main .entry", 3
    assert_select 'h3', 'Version 2.2.0'
    assert_select ".entry .price", /\$[\d]+\.\d\d/
  end

end
