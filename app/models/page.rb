class Page < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def self.default
    self.new(
      :title => "Welcome", 
      :description => "<p>This is the portfolio of Brittany Maxwell. Please explore.</p>",
      :image_folder => "//"
    )
  end
  def self.random
    Page.find(:all).shuffle.first
  end
end
