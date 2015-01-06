class EnumForModels < ActiveRecord::Migration
  def change
    change_table :logs do |t|
      t.remove :bsc
      t.remove :hidden
      t.integer :log_level, default: 0
      t.integer :log_status, default: 1
    end

    change_table :topics do |t|
      t.remove :bsc
      t.remove :hidden
      t.integer :topic_level, default: 0
      t.integer :topic_status, default: 1
    end

    change_table :users do |t|
      t.remove :admin
      t.remove :bsc
      t.remove :activated
      t.integer :account_level, default: 0
      t.integer :account_status, default: 0
    end
  end
end
