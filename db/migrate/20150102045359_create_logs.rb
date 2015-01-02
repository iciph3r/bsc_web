class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :title
      t.string :path
      t.references :user, index: true
      t.integer :view_count, default: 0
      t.boolean :bsc, default: false
      t.boolean :hidden, default: false
      t.string :description

      t.timestamps
    end
  end
end
