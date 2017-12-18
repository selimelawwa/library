class OrdersController < ApplicationController
    load_and_authorize_resource
    def index
    @orders = current_user.orders
    end 
    def all
        @orders = Order.all
    end
    def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    end

    def destroy
        @order = Order.find(params[:id])
        if @order.cart?
          orderitems = @order.order_items
          orderitems.each do |oi|
            book = oi.book
            updatestock = book.quantity.to_i + oi.quantity.to_i
            orderedtimes = book.ordered_times.to_i - oi.quantity.to_i
            book.update_attributes(quantity: updatestock, ordered_times: orderedtimes)
          end
          @order.destroy
          @order = Order.new
          session[:order_id] = @order.id
        else 
          @order.destroy
        end
        flash[:danger] = "Order successfully deleted"
        redirect_to orders_path
    end 
    
    def checkout
    @order = current_order
    @recomendedbook = Category.find_by_name(fav_category).books

    @recomendedbook.each do |rb|
      if !@order.order_items.find_by_book_id(rb.id).nil?
        @recomendedbook = @recomendedbook.without(rb)
      end
    end
    @recomendedbook = @recomendedbook.first(2)
    

    @confirmedorder = @order
    if !@order.order_items.empty?
    @order.cart = false
    @order.save
    @order = Order.new
    @order.user_id = current_user.id
    @order.save
    session[:order_id] = @order.id
    end

    end

    def fav_category
    h = Hash.new
    cat = Category.all
    cat.each do |c|
      h.store(c.name, 0)
    end
    useroreder = current_order
   
      orderitem = useroreder.order_items
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
    
   
    h.delete("Fiction")
    fav = h.max_by{|k,v| v}
    fav[0]
  end


end
