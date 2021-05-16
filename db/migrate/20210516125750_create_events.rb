class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :location
      t.datetime :start_at
      t.datetime :end_at
      t.text :description
      t.belongs_to :creator, index: true, foreign_key: { to_table: 'users' }
    end
  end
end
