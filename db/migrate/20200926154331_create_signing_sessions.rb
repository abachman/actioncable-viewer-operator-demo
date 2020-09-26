class CreateSigningSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :signing_sessions do |t|
      t.string :token
      t.boolean :active

      t.timestamps
    end
  end
end
