require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
	test "full title helper" do
		assert_equal full_title,	"Sayf"
		assert_equal full_title("Help"), "Sayf | Help"
	end
end