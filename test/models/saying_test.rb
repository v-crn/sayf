require 'test_helper'

class SayingTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_0)
    @saying = @user.sayings.build(content: '虎の威を借るきつねうどん')
  end

  test 'should be valid' do
    assert @saying.valid?
  end

  test 'user id should be present' do
    @saying.user_id = nil
    assert_not @saying.valid?
  end

  test 'content should be present' do
    @saying.content = '   '
    assert_not @saying.valid?
  end

  test 'content should be at most 200 characters' do
    @saying.content = 'a' * 201
    assert_not @saying.valid?
  end

  test 'order should be most recent first' do
    assert_equal sayings(:most_recent), Saying.first
  end
end
