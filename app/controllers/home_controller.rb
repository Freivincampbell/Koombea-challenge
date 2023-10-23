class HomeController < ApplicationController
  def index
    @pages = current_user.pages.paginate(page: params[:page], per_page: 50)
  end
end
