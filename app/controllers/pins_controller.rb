class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction, :set_action_count



  def index
    @pins = Pin.where(user_id: current_user, status: "imported").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def pendingoffers
    @pins = Pin.where(user_id: current_user, status: ["pending","rejected"]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
    # @q = Pin.order(sort_column + ' ' + sort_direction).search(params[:q])
    # @invoiceresults = @q.result.paginate(:page => params[:page], :per_page => 20)
  end

  def acceptedoffers
    @pins = Pin.where(user_id: current_user, status: "accepted").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def offersreceived
    @pins = Pin.where(supplier_email: current_user.email).where.not(status: "imported").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
    #@action_count = Pin.where(supplier_email: current_user.email, status: "pending").count
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
    if @pin.update(pin_params)
      if params[:commit] == 'Send'
        @pin = Pin.find(params[:id]) #is this line needed?
        OfferMailer.offer_email(@pin).deliver
        redirect_to pins_url, notice: 'Offer sent!'
      elsif params[:commit] == 'Edit Invoice'
        redirect_to pins_url, notice: 'Invoice was successfully updated.'
      elsif params[:commit] == 'Accept Offer'
        #send emails
        redirect_to offersreceived_path, notice: "Offer accepted! We have informed #{@pin.customer_name}."
      elsif params[:commit] == 'Reject Offer'
        #send emails
        redirect_to offersreceived_path, notice: 'Offer rejected!'           
      end
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
      if params[:commit] == 'Accept Offer' || params[:commit] == 'Reject Offer'
        #allow user to edit
      else
        @pin = current_user.pins.find_by(id: params[:id])
        redirect_to pins_path, notice: "Can't find this invoice. (Not authorised to view or edit this invoice)" if @pin.nil?
      end
    end

    def pin_params
      params.require(:pin).permit(:description, :ref, :suppler_ref, :suppler_name, :invoice_number, :invoice_date, :due_date, :invoice_curr, :invoice_amount, :status, :prop_settlement_date, :offer_amount, :saving, :supplier_email, :offer_sent_date, :offer_accepted_date, :customer_name)
    end

    def sort_column
      Pin.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end

    def set_action_count
      #@action_count = Pin.where(supplier_email: current_user.email, status: "pending").count
      @action_count = "2"
    end


end
