class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :view_count, default: 0
      t.boolean :sticky, default: false
      t.boolean :hidden, default: false
      t.boolean :bsc, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
