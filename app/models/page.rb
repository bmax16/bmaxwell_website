class Page < ActiveRecord::Base
  validates_presence_of :title, :description
  validates_uniqueness_of :title

  def self.default
    self.new(
      :title => "Welcome", 
      :description => "Welcome to my web page! Please explore and click on the links to the right.",
      :image_folder => "//",
      :postdate => nil
    )
  end
end
