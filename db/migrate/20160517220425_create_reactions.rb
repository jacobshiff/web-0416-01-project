class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|

      t.timestamps null: false
    end
  end
end
