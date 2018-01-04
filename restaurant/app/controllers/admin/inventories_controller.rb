class Admin::InventoriesController < Admin::BaseController
  before_action :set_branch, only: [:index, :edit, :update]
  before_action :set_inventory, only: [:edit, :update]
  before_action :set_inventories, only: [:index]

  def index
    session[:current_location] = params[:branch] if params[:branch]
  end

  def edit
    set_comments
  end

  def update
    if @inventory.update(permitted_params)
      redirect_with_flash("success", "successfully_updated", admin_inventories_path(session[:current_location]))
    else
      set_comments
      render :edit
    end
  end

  private

    def set_inventory
      @inventory = Inventory.find_by(id: params[:id])
    end

    def set_inventories
      @inventories = Inventory.where(branch: @branch)
    end

    def set_branch
      if params[:branch]
        @branch = Branch.find_by(name: params[:branch])
      else
        @branch = Branch.find_by(name: session[:current_location])
      end
    end

    def permitted_params
      params.require(:inventory).permit(:quantity, comments_attributes: [:body, :user_id])
    end

    def set_comments
      @comments = @inventory.comments.includes(:user).limit(ENV["COMMENT_LIMIT"]).order(created_at: :desc)
    end
end
