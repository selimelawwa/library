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
        @order.destroy
        session[:order_id] = nil
            flash[:danger] = "Order successfully deleted"
            redirect_to orders_path
    end 
    
    def checkout
    @order = current_order
    @order.cart = false
    @order.save
    @order = Order.new
    @order.user_id = current_user.id
    @order.save
    session[:order_id] = @order.id
    end


end
