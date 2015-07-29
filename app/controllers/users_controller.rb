class UsersController < ApplicationController

  # def create
  #   @user = User.new(user_params)
  #   @account = @user.accounts.build(name: "Personal account", wholes: 1000 , cents: 0)
  #   @account.save
  # end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
