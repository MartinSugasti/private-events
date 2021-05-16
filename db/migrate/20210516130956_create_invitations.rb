class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.integer :status, null: false, default: 0
      t.belongs_to :guest, index: true, foreign_key: { to_table: 'users' }
      t.belongs_to :event, index: true, foreign_key: true
    end
  end
end
