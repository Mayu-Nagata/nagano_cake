class Public::CustomersController < ApplicationController


  def show
    @customers = Customer.find(params[:id])
  end

  def unsubscribe
  end

  def withdraw
  end

  private

  def customer_params
    params.require(:customer).permit( :last_name, :first_name, :last_name_kana, :first_name_kana, )

  end

end
