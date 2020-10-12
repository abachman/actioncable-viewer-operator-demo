class CreateChatSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_sessions, id: :uuid do |t|
      t.string :token
      t.boolean :active
      t.references :operator

      t.timestamps
    end
  end
end
