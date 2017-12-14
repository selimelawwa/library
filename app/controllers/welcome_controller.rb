class WelcomeController < ApplicationController
  def index
     @categories = Category.all
     @books = Book.all
     @bestsellers = Book.order('ordered_times DESC').first(5)
     if logged_in?
     @recomendedbooks = @categories.find_by_name(fav_category).books.first(5)
     end

  end
 

  def fav_category
    h = Hash.new
    cat = Category.all
    cat.each do |c|
      h.store(c.name, 0)
    end
    useroreder = current_user.orders
    useroreder.each do |o|
      orderitem = o.order_items
      orderitem.each do |oi|
        bookcategories = oi.book.categories
          bookcategories.each do |bc|
            if  h[bc.name] == 0
              h[bc.name] = h[bc.name].to_i + 1
            elsif  h[bc.name] < 3
              h[bc.name] = h[bc.name].to_i + 2
            elsif  h[bc.name] < 7
              h[bc.name] = h[bc.name].to_i + 2.5
            else  
              h[bc.name] = h[bc.name].to_i + 3
            end
          end 
      end
    end
   
    h.delete("Fiction")
    fav = h.max_by{|k,v| v}
    fav[0]
  end

end
