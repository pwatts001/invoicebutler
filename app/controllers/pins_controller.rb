class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction


  def index
    @pins = Pin.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def pendingoffers
    @q = Pin.order(sort_column + ' ' + sort_direction).search(params[:q])
    @invoiceresults = @q.result.paginate(:page => params[:page], :per_page => 20)
  end

  def acceptedoffers
    @pins = Pin.where(user_id: current_user).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
    # @pins = Pin.where(user_id: current_user).order(params[:sort] + ' ' + params[:direction]).paginate(:page => params[:page], :per_page => 20)
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

    def sort_column
      Pin.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end


end
