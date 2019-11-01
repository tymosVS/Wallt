class AccountsController < ApplicationController
  before_action :set_type

  def index
    @accounts = type_class.all
    @total = 0
    @accounts.each { |account| @total += account.cash }
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(accaunt_params)
    if @account.save
      redirect_to accounts_path
    else
      render :new
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_type 
    @type  = type
  end

  def type 
    Account.types.include?(params[:type]) ? params[:type] : 'Account'
  end

  def type_class 
    type.constantize 
  end

  def accaunt_params
    params.require(type.underscore.to_sym).permit(:acount_id, :cash, :title, :type)
  end
end
