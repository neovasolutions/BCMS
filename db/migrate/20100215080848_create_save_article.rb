class CreateSaveArticle < ActiveRecord::Migration
  def self.up
     create_table "save_articles", :force => true do |t|
       t.string :name, :link
       t.integer :user_id
       t.timestamps
     end
  end

  def self.down
    drop_table "save_articles"
  end
end
