class ViewController < ApplicationController
  ROOT = "#{RAILS_ROOT}/public"

  def index
    @current_page = (session[:current_page] ||= Page.default)
    @images = get_all_images @current_page.image_folder
    @pages = Page.find(:all, :order => 'created_at')
  end

  def change_page
    session[:current_page] = Page.find(params[:id])
    redirect_to :action => 'index'
  end

  def get_all_images folder
    images = Dir.glob(ROOT + "/images" + folder + "*.{jpg,png,gif}")
    images.each {|image| image.gsub!(ROOT, '') }
    images
  end
end
