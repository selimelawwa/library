class SearchController < ApplicationController

    def search
       if params[:search]
       @books = Book.where('name LIKE ?', "%#{params[:search]}%")
       else
       @books = nil
       end 
    end
     def search_params
      params.require(:book).permit(:search)
    end
    
end
