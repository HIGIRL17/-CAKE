class Admin::CustomersController < ApplicationController
  def index
    @customer = Customer.page(params[:page])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
       redirect_to admin_customers_path
    else
       render :edit
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :telephone_number, :address, :is_deleted, :email)
  end
  
end
