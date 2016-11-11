class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all.order(created_at: :desc).page params[:page]
  end

  def new
  end
  
  def create
    if @category.save
      flash[:success] = t "controllers.admin.categories.flash.create_category"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controllers.admin.categories.flash.edit_category"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "controllers.admin.categories.flash.delete_category"
    else
      flash[:success] = t "controllers.admin.categories.flash.not_delete"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
