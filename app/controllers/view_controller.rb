class ViewController < ApplicationController

  def index
    if params[:id]
      @content = find_content
      @display_nav = true if @content.image_array[1]
    else
      @content = Page.default
      until @content.image
        @content = Page.random
        @content.image = @content.get_random_image
      end
      @content.title = Page.default.title
      @content.description = Page.default.description
      @display_nav = false
    end
    @pages = Page.find(:all, :order => 'created_at').reverse
  end

  def change_page
    change_content params[:id]
    @content = find_content
    @content.image = @content.get_all_images.first
    if request.xhr?
      @display_nav = true if @content.image_array[1]
      render :partial => 'content', :layout => false
    else
      redirect_to :action => 'index', :id => @content.id
    end
  end

  def next_image
    @content = find_content
    @content.image = @content.get_next_image
    if request.xhr?
      @display_nav = true if @content.image_array[1]
      render :partial => 'content', :layout => false
    else
      redirect_to :action => 'index', :id => @content.id
    end
  end

  def prev_image 
    @content = find_content
    @content.image = @content.get_prev_image
    if request.xhr?
      @display_nav = true if @content.image_array[1]
      render :partial => 'content', :layout => false
    else
      redirect_to :action => 'index', :id => @content.id
    end
  end
  
  def construction
  end

protected
  def authorize
  end

  def find_content
    @content = (session[:content] ||= Page.default)
  end

  def change_content id
    session[:content] = Page.find(id)
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid page #{params[:id]}" )
    flash[:notice] = "Invalid page"
    redirect_to :action => 'index'
  end

end
