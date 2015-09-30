class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction


  def index
    @pins = Pin.where(user_id: current_user, status: "imported").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def pendingoffers
    @pins = Pin.where(user_id: current_user, status: "pending").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)

    # @q = Pin.order(sort_column + ' ' + sort_direction).search(params[:q])
    # @invoiceresults = @q.result.paginate(:page => params[:page], :per_page => 20)
  end

  def acceptedoffers
    @pins = Pin.where(user_id: current_user).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
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
      redirect_to importinvoices_path, notice: 'Invoice was successfully added.'
    else
      render :new
    end
  end


  def update
      #if (params[:id] == "delete_selected")
      #   params[:ids].each do |id|
      #     @pin = Pin.find(id)
      #     @pin.destroy
      #   end unless params[:ids].blank?
      #   redirect_to pins_url, :notice => 'Selected invoices were deleted successfully!'
      #else

        if @pin.update(pin_params)
            if params[:commit] == 'Send'
            #send email
            # @pin = Pin.find(params[:id]) #is this line needed?
            # OfferMailer.offer_email(@pin).deliver
            redirect_to pins_url, notice: 'Offer sent!'
          elsif params[:commit] == 'Edit Invoice'
            redirect_to pins_url, notice: 'Invoice was successfully updated.'
          end
        else
          render :edit
        end
      #end
  end


  def destroy
    @pin.destroy
    redirect_to pins_url, notice: 'Invoice was successfully deleted.'
  end


  def delete_selected
    # params[:ids].each do |id|
    #   @pin = Pin.find(id)
    #   @pin.destroy
    # end unless params[:ids].blank?
    # redirect_to pins_url, :notice => 'Selectedlly!'
  end


  private
  
    def set_pin
      if (params[:id] == "delete_selected")
        #no need to set pin
      else
        @pin = Pin.find(params[:id])
      end
    end

    def correct_user 
      # @pin = current_user.pins.find_by(id: params[:id])
      # redirect_to pins_path, notice: "Not authorised to edit this invoice" if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :ref, :suppler_ref, :suppler_name, :invoice_number, :invoice_date, :due_date, :invoice_curr, :invoice_amount, :status, :prop_settlement_date, :offer_amount, :saving)
    end

    def sort_column
      Pin.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end


end
