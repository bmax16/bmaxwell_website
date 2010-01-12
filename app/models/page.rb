class Page < ActiveRecord::Base
  validates_presence_of :title, :image_folder, :description
  validates_uniqueness_of :title
  validates_format_of :image_folder,
    :with => %r{^\/.+\/$}i,
    :message => "Must be a proper folder name"

  def self.default
    self.new(
      :title => "Welcome", 
      :description => "Welcome to my web page! Please explore and click on the links to the right.",
      :image_folder => "//",
      :postdate => nil
    )
  end
end
