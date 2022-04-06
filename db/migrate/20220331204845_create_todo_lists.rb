class CreateTodoLists < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_lists do |t|
      t.string :title, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :routine, default: 0
      t.datetime :completed_at

      t.timestamps
    end
  end
end
