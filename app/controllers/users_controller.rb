class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # Geschiedenis
    @transfers = Transfer.all
    # Opdracht formulier
    @transfer = Transfer.new
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
  
end
