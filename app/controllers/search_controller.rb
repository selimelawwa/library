class SearchController < ApplicationController

    def index
      @books = Book.all
      @categories = Category.all
      if params[:search] 
        if params[:search] == ""
          @books = nil
          flash[:danger] = "Search can not be empty"
        else
          @books = Book.where('name LIKE ?', "%#{params[:search]}%") | 
                   Book.where('author LIKE ?', "%#{params[:search]}%") | 
                   Book.where('isbn LIKE ?', "%#{params[:search]}%") 
          
         # @books = @books.paginate(page: params[:page]|| 1, per_page: 8)
        end
        if @books == nil and params[:search] != ""
          flash[:danger] = "No matches found"
        end
      end
      
    end

    def from_category
    @category = Category.find(params[:cat_id])
    @books = @category.books
    params[:search] = nil
    # .paginate(page: params[:page]|| 1, per_page: 8)
    respond_to do |format|
        format.js
    end
    end
    
    def search_params
      params.require(:book).permit(:search)
    end
    
end
