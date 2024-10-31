class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to short_path(slug: @link.slug)
    else
      render :new
    end
  end

  def show
    @link = Link.find_by(slug: params[:slug])
    if @link
      @link.increment!(:clicked)
      redirect_to @link.url, allow_other_host: true # Allow redirect to external URL
    else
      render 'errors/404', status: :not_found
    end
  end


  private

  def link_params
    params.require(:link).permit(:url, :slug)
  end
end
