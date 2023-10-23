class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]

  # GET /pages/1 or /pages/1.json
  def show
    @links = @page.links.paginate(page: params[:page], per_page: 50)
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params.merge(user: current_user))

    respond_to do |format|
      if @page.save
        ScrapePageWorker.perform_in(5.seconds, @page.id)
        format.html { redirect_to root_path, notice: "Page was successfully created." }
      else
        format.html { redirect_to root_path, notice: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:link)
    end
end
