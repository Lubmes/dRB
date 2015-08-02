class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @transfer = Transfer.new
    @transfers = @user.all_transfers
    @transfers = @transfers.sort_by { |f| f.created_at }
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
  
end
