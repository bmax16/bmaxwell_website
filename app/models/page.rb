class Page < ActiveRecord::Base
  ROOT = "#{RAILS_ROOT}/public"

  validates_presence_of :title, :description
  validates_uniqueness_of :title

  attr_accessor :image, :image_array

  def self.default
    self.new(
      :title => "Welcome", 
      :description => "<p>This is the portfolio of Brittany Maxwell. Please explore.</p>",
      :image_folder => "//"
    )
  end

  def self.random
    Page.all.shuffle.first
  end

  def get_all_images
    @image_array = Dir.glob(ROOT + "/images/" + self.image_folder + "/*.{jpg,png,gif}").sort
    @image_array.each {|image| image.gsub!(ROOT, '') }
    @image = @image_array.first
    @image_array
  end

  def get_random_image
    @image = self.get_all_images.shuffle.first
  end

  def get_next_image
    index = @image_array.index(@image) + 1
    index = (index >= @image_array.length ? 0 : index ) 
    @image = @image_array[index]
  end

  def get_prev_image
    index = @image_array.index(@image) - 1
    index = (index < 0 ? @image_array.length - 1 : index ) 
    @image = @image_array[index]
  end
end
