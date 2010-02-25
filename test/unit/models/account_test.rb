require File.join(File.dirname(__FILE__), '/../../test_helper')

class AccountTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Account.create!
  end
  
end