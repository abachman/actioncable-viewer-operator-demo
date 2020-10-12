class AddStatesToChatSessions < ActiveRecord::Migration[6.0]
  def change
    add_column :chat_sessions, :viewer_state, :string
    add_column :chat_sessions, :operator_state, :string
  end
end
