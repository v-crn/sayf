require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'associated sayings should be destroyed' do
    @user.save
    @user.sayings.create!(content: 'Lorem ipsum')
    assert_difference 'Saying.count', -1 do
      @user.destroy
    end
  end

  test 'should follow and unfollow a user' do
    user_0 = users(:user_0)
    user_2 = users(:user_2)
    assert_not user_0.following?(user_2)
    user_0.follow(user_2)
    assert user_0.following?(user_2)
    assert user_2.followers.include?(user_0)
    user_0.unfollow(user_2)
    assert_not user_0.following?(user_2)
  end

  test 'feed should have the right posts' do
    john = users(:john)
    user_0 = users(:user_0)
    user_2 = users(:user_2)
    # フォローしているユーザーの投稿を確認
    user_0.sayings.each do |post_following|
      assert john.feed.include?(post_following)
    end
    # 自分自身の投稿を確認
    john.sayings.each do |post_self|
      assert john.feed.include?(post_self)
    end
    # フォローしていないユーザーの投稿を確認
    user_2.sayings.each do |post_unfollowed|
      assert_not john.feed.include?(post_unfollowed)
    end
  end
end
