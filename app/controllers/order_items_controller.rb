class OrderItemsController < ApplicationController
 

  def create
    @order = current_order
    if current_order.id.nil?
    @order.user_id = current_user.id
    @order.save
    end
    
    
    @similaritem = @order.order_items.find_by_book_id(params[:book_id])
    totalcost=0
    if !@similaritem.nil? #not first orderitem or first order so no need to update session
      @order_item = @similaritem 
      totalcost = @similaritem.total_cost + (params[:quantity].to_i * params[:cost].to_f)
      quantity = @similaritem.quantity + params[:quantity].to_i
      @order_item.update_attributes(quantity: quantity, total_cost: totalcost)
      @book = Book.find(params[:book_id])
      updatestock = @book.quantity - params[:quantity].to_i
      orderedtimes = @book.ordered_times.to_i + params[:quantity].to_i
      @book.update_attributes(quantity: updatestock, ordered_times: orderedtimes)
       @order.total_cost = @order.total_cost +  (params[:quantity].to_i * params[:cost].to_f)
    else
      totalcost = params[:quantity].to_i * params[:cost].to_f
      @order_item =  OrderItem.new(book_id: params[:book_id], quantity: params[:quantity], 
                                                    cost: params[:cost], total_cost: totalcost)
      @book = Book.find(params[:book_id])
      updatestock = @book.quantity - params[:quantity].to_i
      orderedtimes = @book.ordered_times.to_i + params[:quantity].to_i
      @book.update_attributes(quantity: updatestock, ordered_times: orderedtimes)  
       @order.total_cost = @order.total_cost + totalcost                                          
    end
      
   
    @order.save
    @order_item.order_id = @order.id
    @order_item.save
    session[:order_id] = @order.id

   

     flash[:success] = "#{@book.name} was added to cart"
     redirect_to request.referrer

  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    totalcost = @order_item.total_cost + (params[:quantity].to_i * params[:cost].to_f)
    quantity = @order_item.quantity + params[:quantity].to_i
    @order_item.update_attributes(quantity: quantity, total_cost: totalcost)
    @book = Book.find(@order_item.book_id)
    updatestock = @book.quantity - params[:quantity].to_i
    orderedtimes = @book.ordered_times.to_i + params[:quantity].to_i
    
    @book.update_attributes(quantity: updatestock, ordered_times: orderedtimes)
    @order.total_cost = @order.total_cost +  (params[:quantity].to_i * params[:cost].to_f)
    @order.save
   # @order_item.update_attributes(order_item_params)
   # @order_items = @order.order_items
   
    respond_to do |format|
    format.js 
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @book = Book.find(@order_item.book_id)
    updatestock = @book.quantity + @order_item.quantity.to_i
    @order.total_cost = @order.total_cost - @order_item.total_cost
    @order.save
    @order_item.destroy
    @order_items = @order.order_items
    orderedtimes = @book.ordered_times.to_i - @order_item.quantity.to_i
    @book.update_attributes(quantity: updatestock, ordered_times: orderedtimes)
    respond_to do |format|
    #format.html { redirect_to root_path }
    format.js 
    end
    #redirect_to request.referrer
    #flash[:danger] = "#{@book.name} was removed from cart"
    #redirect_to order_path(@order)
  end
private
  def order_item_params
    params.require(:order_item).permit(:quantity, :book_id, :cost)
  end

end
