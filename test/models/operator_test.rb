require 'test_helper'

class OperatorTest < ActiveSupport::TestCase
  test 'can create chat sessions' do
    op = operators(:one)
    chat = op.chat_sessions.create!
    assert chat.token.present?
  end
end
