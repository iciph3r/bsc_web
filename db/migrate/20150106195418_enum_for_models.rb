class EnumForModels < ActiveRecord::Migration
  def change
    change_table :logs do |t|
      t.remove :bsc
      t.remove :hidden
      t.integer :level, default: 0
      t.integer :status, default: 1
    end

    change_table :topics do |t|
      t.remove :bsc
      t.remove :hidden
      t.integer :level, default: 0
      t.integer :status, default: 1
    end

    change_table :users do |t|
      t.remove :admin
      t.remove :bsc
      t.remove :activated
      t.integer :level, default: 0
      t.integer :status, default: 0
    end
  end
end
