require File.join(File.dirname(__FILE__), '/../../test_helper')

class ContactTest < ActiveSupport::TestCase

  test "should be able to create new block" do
    assert Contact.create!
  end
  
end