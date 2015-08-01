class TransfersController < ApplicationController
  before_filter :transfer_name_to_id

  def create
    @user = User.find(params[:user_id])
    @transfer = Transfer.new(transfer_params)
    @transfer.sender_id = @user.id

    #transactie tussen accounts
    @account_a = @user.account
    @account_b = Account.find_by_user_id(@transfer.recipient_id)
      if @account_a != @account_b
        if @account_a.cents >= @transfer.transfer_amount * 100
          Account.transaction do
              @account_a.cents -= @transfer.transfer_amount * 100
              @account_a.save!
              @account_b.cents += @transfer.transfer_amount * 100
              @account_b.save!
              @transfer.save!
              flash.notice = "U opdracht is verzonden."
          end
        else
          flash.notice = "U beschikt niet over voldoende saldo om uw opdracht te doen slagen."
        end
      else
        flash.notice = "U kunt geen geld overmaken naar uw eigen account."
      end
    #@transfer.save
    redirect_to user_path(@user)
  end

  private
  def transfer_name_to_id
    name = params[:recipient_id]
    user = User.find_by_user_name(name)
    id = user.id
    params[:recipient_id] = id
  end

  def transfer_params
    params.require(:transfer).permit(:sender_id, :recipient_id, :transfer_amount)
  end



end