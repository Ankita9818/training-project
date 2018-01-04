class Admin::IngredientsController < Admin::BaseController
  before_action :set_ingredient, only: [:destroy, :edit, :update]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(permitted_params)
    if @ingredient.save
      redirect_with_flash("success", "ingredient_created", admin_ingredients_url)
    else
      render 'new'
    end
  end

  def index
    @ingredients = Ingredient.all
  end

  def update
    if @ingredient.update(permitted_params)
      redirect_with_flash("success", "successfully_saved", admin_ingredients_url)
    else
      render 'edit'
    end
  end

  def destroy
    redirect_with_flash("success", "successfully_destroyed", admin_ingredients_url) if @ingredient.destroy
  end

  private
    def permitted_params
      params.require(:ingredient).permit(:name, :price, :category, :extra_allowed)
    end

    def set_ingredient
      @ingredient = Ingredient.find_by(id: params[:id])
    end
end
