class ViewController < ApplicationController
  ROOT = "#{RAILS_ROOT}/public"

  def index
    @content = (session[:content] ||= Page.default)
    @images = (session[:images] ||= get_all_images(@content.image_folder))
    @current_image = @images.first
    @pages = Page.find(:all)
  end

  def change_page
    session[:content] = Page.find(params[:id])
    @content = (session[:content] ||= Page.default)
    set_session_images get_all_images(@content.image_folder)
    if request.xhr?
      render :partial => 'content', :layout => false
    else
      redirect_to :action => 'index'
    end
  end

  def next_image
    @content = (session[:content] ||= Page.default)
    @images = session[:images]
    i = @images.shift
    @images << i
    set_session_images @images
    if request.xhr?
      render :partial => 'content', :layout => false
    else
      redirect_to :action => 'index'
    end
  end

  def prev_image 
    @content = (session[:content] ||= Page.default)
    @images = session[:images]
    i = @images.pop
    @images.unshift i
    set_session_images @images
    if request.xhr?
      render :partial => 'content', :layout => false
    else
      redirect_to :action => 'index'
    end
  end

  def get_all_images folder
    images = Dir.glob(ROOT + "/images/" + folder + "/*.{jpg,png,gif}")
    images.each {|image| image.gsub!(ROOT, '') }
  end

private
  def set_session_images images
    session[:current_image] = images.first
    session[:images] = images
    @current_image = session[:current_image]
    @images = session[:images]
  end
end
