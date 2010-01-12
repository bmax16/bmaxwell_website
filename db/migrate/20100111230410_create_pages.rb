class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title, :limit => 40
      t.text :description
      t.string :image_folder, :limit => 40

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
