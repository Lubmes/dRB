class TransfersController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    #transfer
    @transfer = Transfer.new(transfer_params)
    @transfer.sender_id = @user.id
    @recipient = User.find(@transfer.recipient_id)
    #transactie tussen accounts
    @account_a = @user.account
    @account_b = @recipient.account
      if @account_a != @account_b
        if @account_a.cents >= @transfer.amount
          Account.transaction do
              @account_a.cents -= @transfer.amount
              @account_a.save!
              @account_b.cents += @transfer.amount
              @account_b.save!
              @transfer.save!
              flash.notice = "Uw opdracht is verzonden."
          end
        else
          flash.notice = "U beschikt niet over voldoende saldo om uw opdracht te doen slagen."
        end
      else
        flash.notice = "U kunt geen geld overmaken naar uw eigen account."
      end
    redirect_to user_path(@user)
  end

  private
  def transfer_params
    params.require(:transfer).permit(:sender_id, :recipient_id, :amount)
  end
end