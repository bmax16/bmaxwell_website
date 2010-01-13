class ViewController < ApplicationController
  ROOT = "#{RAILS_ROOT}/public"

  def index
    if params[:id]
      @images = (session[:images] ||= get_all_images(@content.image_folder))
      @content = (session[:content] ||= Page.default)
      @current_image = @images.first
      @display_nav = true if @images[1]
    else
      session_clear
      @content = Page.default
      until @current_image
        page = Page.random
        if page
          @content.id = page.id
          @images = get_all_images(page.image_folder).shuffle.first
          @current_image = @images
        end
      end
      @display_nav = false
    end
    @pages = Page.find(:all)
  end

  def change_page
    session[:content] = Page.find(params[:id])
    @content = (session[:content] ||= Page.default)
    set_session_images get_all_images(@content.image_folder)
    if request.xhr?
      render :partial => 'content', :layout => false
    else
      redirect_to :action => 'index', :id => @content.id
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
      redirect_to :action => 'index', :id => @content.id
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
      redirect_to :action => 'index', :id => @content.id
    end
  end

  def get_all_images folder
    images = Dir.glob(ROOT + "/images/" + folder + "/*.{jpg,png,gif}")
    images.each {|image| image.gsub!(ROOT, '') }
    images
  end

private
  def set_session_images images
    session[:current_image] = images.first
    session[:images] = images
    @current_image = session[:current_image]
    @images = session[:images]
    @display_nav = true if @images[1]
  end

  def session_clear
    session[:content] = nil
    session[:images] = nil
  end

  def authorize
  end
end
