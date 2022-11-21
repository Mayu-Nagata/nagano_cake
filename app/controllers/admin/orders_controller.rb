class Admin::OrdersController < ApplicationController

  def show

    @order = Order.find(params[:id])


    @total_items = @order.order_details.inject(0) { |sum, order_detail| sum + order_detail.subtotal }

  end


  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "confirmation"
      @order.order_details.update(making_status: 1)
    end
    redirect_to admin_order_path(@order.id)
  end


  private



  def order_params
  params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost, :status)
  end

  def order_detail_params
  params.require(:order_detail).permit(:price, :amount, :making_status)
  end

end
