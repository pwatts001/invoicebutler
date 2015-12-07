class UsersController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @user = User.find(params[:id])
    @pinsUploaded = Pin.where(user_id: @user.id)
    @pinsSupplied = Pin.where(supplier_email: @user.email)

    if @pinsUploaded.count > 0
      redirect_to dashboard_path, notice: 'User has uploaded invoices and sent offers therefore cannot delete.'
    else
      if @user.destroy
        if @pinsSupplied.count > 0
          redirect_to dashboard_path, notice: "User was successfully deleted. (Note: this user #{@user.email}, has previously received offers)"
        else
          redirect_to dashboard_path, notice: "User was successfully deleted."
        end
      end
    end
  end



end
