class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction, :set_action_count


  def import
    Pin.import(params[:file], current_user.id)
    redirect_to importinvoices_path, notice: "Invoices imported."
  end


  def all_invoices
    @pins = Pin.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
      respond_to do |format|
      format.html
      format.csv { send_data @pins.to_csv }
      end
  end

  def index
    @pins = Pin.where(user_id: current_user, status: "imported").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def pendingoffers
    @pins = Pin.where(user_id: current_user, status: "pending").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def acceptedoffersadmin
    @pins = Pin.where(user_id: current_user).where.not(status: ["imported","pending"]).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def acceptedoffers
    @pinsaccepted = Pin.where(supplier_email: current_user.email, status: 'Accept').order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
    @pinsrejected = Pin.where(supplier_email: current_user.email, status: ['Reject','expired']).order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
  end

  def offersreceived
    @pins = Pin.where(supplier_email: current_user.email, status: "pending").order(sort_column + ' ' + sort_direction)
    @pinscount = @pins.count 
    @totalEarlyPayment = @pins.map {|s| s['offer_amount']}.reduce(0, :+)
    @pinsid = @pins.map(&:id)
    @RubyHash = Hash[@pins.map{|pin| [pin.id, "#{pin.offer_amount}"]}]
    @pinsOffers = @RubyHash.to_json
  end

  def show
  end


  def new
    @pin = current_user.pins.build
  end


  def deleteAllImported
    i = 0
    @pins = Pin.where(user_id: current_user, status: "imported")
    @pins.each do |f|
      i += 1
      f.destroy
    end
    redirect_to importinvoices_path, notice:"Successfully deleted #{i} invoices"
  end

  def deleteAll
    i = 0
    @pins = Pin.all
    @pins.each do |f|
      i += 1
      f.destroy
    end
    redirect_to all_invoices_path, notice:"Successfully deleted all #{i} invoices"
  end




  def sendGroupOffers
    @pins = Pin.where(user_id: current_user, status: "imported")
    @pinscount = Pin.where(user_id: current_user, status: "imported").count
    #OfferMailer.offers_email(@pins).deliver
    time = Time.new
    if @pinscount == 0
        @recipient = "no one"
    else
        @recipient = @pins.first.supplier_email
    end
    redirect_to importinvoices_path, notice:"Successfully sent offer for #{@pinscount} invoices to #{@recipient}."
    @pins.update_all "status = 'pending', offer_sent_date ='#{time}'"
  end


  def ExpirePendingOffers
    @pins = Pin.where(user_id: current_user, status: "pending")
    @pinscount = Pin.where(user_id: current_user, status: "pending").count
    time = Time.new
    redirect_to pendingoffers_path, notice:"Successfully expired offers for #{@pinscount} invoices."
    @pins.update_all "status = 'expired', offer_accepted_date ='#{time}'"
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
    if params[:pins]
      @pinsaccepted = []
      @pinsrejected = []
      params[:pins].each do |id, attrs|
        pin = Pin.find_by_id(id)
        time = Time.new
        pin.update(status: attrs)
        pin.update(offer_accepted_date: time)
        if attrs == "Accept"
          @pinsaccepted << pin
        else
          @pinsrejected << pin
        end
      end
      redirect_to offersreceived_path, notice: "Repsonse noted. We'll sent confirmation emails"
      #OfferMailer.response_email(@pinsaccepted,@pinsrejected).deliver
      #OfferMailer.fatface_email(@pinsaccepted,@pinsrejected).deliver
    elsif @pin.update(pin_params)
      if params[:commit] == 'Edit Invoice'
        redirect_to all_invoices_path, notice: 'Invoice was successfully updated.'          
      end
    elsif
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
      # if params[:commit] == 'Accept Offer' || params[:commit] == 'Reject Offer'
      #   #allow user to edit
      # else
      #   @pin = current_user.pins.find_by(id: params[:id])
      #   redirect_to pins_path, notice: "Can't find this invoice. (Not authorised to view or edit this invoice)" if @pin.nil?
      # end
    end

    def pin_params
      params.require(:pin).permit(:description, :ref, :suppler_ref, :suppler_name, :invoice_number, :string, :invoice_date, :due_date, :invoice_curr, :invoice_amount, :status, :prop_settlement_date, :offer_amount, :saving, :supplier_email, :offer_sent_date, :offer_accepted_date, :customer_name)
    end

    def sort_column
      Pin.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end
end
