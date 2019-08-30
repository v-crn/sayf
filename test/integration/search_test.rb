require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  def setup
    @existent_valid_terms = ['-', '--', '---', '-is', 'this is --   ', '『', '\'', '-,']
    @non_existent_valid_terms = ['くぁｗせｄｒｆｔｇｙふじこｌｐ', 'WTF!?', '\n']
    @invalid_terms = ['', '              ', nil]
  end

  test 'should display posts after searching with existent valid terms' do
    @existent_valid_terms.each do |term|
      get root_path
      assert_select 'div#search_sayings'
      assert_no_match 'search_results', @response.body
      get search_sayings_path, xhr: true, params: { keywords: term }
      assert_response :success
      assert_match 'search_results', @response.body
      assert_match 'saying', @response.body
      assert_select 'li'
    end
  end

  test 'should not display any posts after searching with non-existent valid terms' do
    @non_existent_valid_terms.each do |term|
      get root_path
      assert_no_match 'search_results', @response.body
      get search_sayings_path, xhr: true, params: { keywords: term }
      assert_response :success
      assert_match 'search_results', @response.body
      assert_select 'li', false
    end
  end

  test 'should not display search results after searching with invalid terms' do
    @invalid_terms.each do |term|
      get root_path
      assert_select 'div#search_sayings'
      assert_no_match 'search_results', @response.body
      get search_sayings_path, xhr: true, params: { keywords: term }
      assert_response :success
      assert_no_match 'search_results', @response.body
    end
  end
end
