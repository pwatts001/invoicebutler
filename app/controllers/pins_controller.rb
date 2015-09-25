class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    # @pins = Pin.where(user_id: current_user).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def pendingoffers
    # @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    @pins = Pin.where(user_id: current_user).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def acceptedoffers
    # @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
    @pins = Pin.where(user_id: current_user).order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
  end

  def show
  end


  def new
    @pin = current_user.pins.build
  end


  def edit
  end


  def create
    @pin = current_user.pins.build(pin_params)

    if @pin.save
      redirect_to @pin, notice: 'Invoice was successfully added.'
    else
      render :new
    end
  end


  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Invoice was successfully updated.'
    else
      render :edit
    end
  end


  def destroy
    @pin.destroy
    redirect_to pins_url, notice: 'Invoice was successfully deleted.'
  end

  private
  
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user 
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorised to edit this invoice" if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
