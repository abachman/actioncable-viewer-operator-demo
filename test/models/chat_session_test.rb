require 'test_helper'

class ChatSessionTest < ActiveSupport::TestCase
  test 'has token' do
    chat = ChatSession.create!
    assert_not chat.token.nil?
  end
end
