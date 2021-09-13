class CreateNotiffications < ActiveRecord::Migration[5.2]
  def change
    create_table :notiffications do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :comment_id
      t.integer :inquiries_id
      t.integer :chat_id
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
