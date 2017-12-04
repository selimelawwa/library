class SearchController < ApplicationController

    def index
      if params[:search] 
        if params[:search] == ""
          @books = nil
          flash[:danger] = "Search can not be empty"
        else
          @books = Book.where('name LIKE ?', "%#{params[:search]}%") | 
                   Book.where('author LIKE ?', "%#{params[:search]}%") | 
                   Book.where('publisher LIKE ?', "%#{params[:search]}%") |
                   Book.where('category LIKE ?', "%#{params[:search]}%")
        end
        if @books == nil and params[:search] != ""
          flash[:danger] = "No matches found"
        end
      end
    end
    
    def search_params
      params.require(:book).permit(:search)
    end
    
end
