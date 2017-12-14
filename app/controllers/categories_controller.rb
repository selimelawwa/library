class CategoriesController < ApplicationController

  load_and_authorize_resource

    def index
     @categories = Category.paginate(page: params[:page], per_page: 8)
    end 

    def new
      @category = Category.new
    end 

    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:success] = "Category saved"
        redirect_to categories_path
      else
        render 'new'
      end
    end 

    def show
       @category = Category.find(params[:id])
       @category_books = @category.books.paginate(page: params[:page], per_page: 8)
    end 
    
    def edit
      @category = Category.find(params[:id])
    
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        flash[:success] = "Category edited successfully"
        redirect_to category_path(@category)
      else
        render 'edit'
      end
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end
    
    
end