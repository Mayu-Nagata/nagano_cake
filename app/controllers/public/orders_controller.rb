class Public::OrdersController < ApplicationController


  def index
    @orders = current_customer.orders


  end




  def new
    @order = Order.new
    @cart_item = current_customer.cart_items




  end

  def show
    @order = Order.find(params[:id])


  end




  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @address = Address.find(params[:order][:address_id])

    @shipping_cost = 800
    @total_items = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_payment = @total_items + @shipping_cost

    if params[:order][:select_address] == "0"



      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    end

    if params[:order][:select_address] == "1"

      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    end




  end



  def create

   @order = Order.new(order_params)
   @cart_items = current_customer.cart_items
   @order.customer_id = current_customer.id

    if @order.save

      @cart_items.each do |cart_item|


        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.price

        order_detail.save



      end

       redirect_to orders_complete_path




    else

      @order = Order.new(order_params)

      render :new

    end




    @cart_items.destroy_all
  end



  def complete

  end

  private


  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost, :status)
  end

end
