class DosesController < ApplicationController
  def new
    @ingredients = Ingredient.all
    @dose = Dose.new
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def create
    @dose = Dose.new(dose_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail = @cocktail
    if @dose.valid?
      @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new, locals: { dose: @dose }
    end
  end

  def destroy
    Dose.find(params[:id]).destroy
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
