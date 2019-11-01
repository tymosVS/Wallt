class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    source = Account.where(acount_id: params[:transaction][:account_source])
    destination = Account.where(acount_id: params[:transaction][:account_destination])
    if source != destination
      if source.any? && destination.any?
        if source.first.execute_transaction(destination.first, params[:transaction][:cash].to_i)
          source_cash = source.first.cash - params[:transaction][:cash].to_i
          dest_cash = destination.first.cash + params[:transaction][:cash].to_i
          source.first.update(cash: source_cash)
          destination.first.update(cash: dest_cash)
          redirect_to accounts_path if @transaction.save
        else
          flash[:notice] = 'No needed cash on account'
          render :new
        end
      else
        flash[:notice] = 'No such account_id'
        render :new
      end
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:account_source, :cash, :account_destination)
  end
end
