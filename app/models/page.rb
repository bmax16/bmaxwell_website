class Page < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def self.default
    self.new(
      :title => "Welcome", 
      :description => "<p>Welcome to my web page! Please explore and click on the links to the right.</p>",
      :image_folder => "//"
    )
  end
  def self.random
    Page.find(:all).shuffle.first
  end
end
