class OfferMailer < ActionMailer::Base
	add_template_helper(ApplicationHelper)
  default :from => "fatface.offers@invoicely.co.uk"  

    def offers_email(pins)  
	    @pins = pins
	    #mail(:to => @pin.suppler_name, :replyto => "phil@invoicely.co.uk", :subject => "Hi #{pin.suppler_ref}")  
	    mail(:to => @pins.first.supplier_email, :replyto => "fatface.offers@invoicely.co.uk", :subject => "Good news! Fat Face has approved your invoices")
  	end

    def response_email(pinsaccepted,pinsrejected)  
	    @pinsaccepted = pinsaccepted
	    @pinsrejected = pinsrejected

	    if @pinsaccepted.first
	    	email = @pinsaccepted.first.supplier_email
	    	name = @pinsaccepted.first.ref
	    	date = @pinsaccepted.first.prop_settlement_date
	    	link = @pinsaccepted.first.string
	    	totalEarlyPayment = @pinsaccepted.map {|s| s['offer_amount']}.reduce(0, :+)
	    else
	    	email = @pinsrejected.first.supplier_email
	    	name = @pinsrejected.first.ref
	    	link = @pinsrejected.first.string
	    end
			
	    mail(:to => email, :replyto => "fatface.offers@invoicely.co.uk", :subject => "Response confirmed") do |format|
			  format.html {
			    render locals: { name: name, totalEarlyPayment: totalEarlyPayment, date: date, link: link }
			  }
			end
  	end  

  	def fatface_email(pinsaccepted,pinsrejected)  
	    @pinsaccepted = pinsaccepted
	    @pinsrejected = pinsrejected

	    if @pinsaccepted.first
	    	supplieremail = @pinsaccepted.first.supplier_email
	    	suppliername = @pinsaccepted.first.suppler_name
	    	date = @pinsaccepted.first.prop_settlement_date
	    	saving = @pinsaccepted.map {|s| s['saving']}.reduce(0, :+)
	    	totalEarlyPayment = @pinsaccepted.map {|s| s['offer_amount']}.reduce(0, :+)
	    else
	    	supplieremail = @pinsrejected.first.supplier_email
	    	suppliername = @pinsrejected.first.suppler_name
	    end
			
	    mail(:to => 'fatface.offers@invoicely.co.uk', :replyto => "fatface.offers@invoicely.co.uk", :subject => "Offer response from #{suppliername}") do |format|
			  format.html {
			    render locals: { suppliername: suppliername, supplieremail: supplieremail, totalEarlyPayment: totalEarlyPayment, saving: saving, date: date }
			  }
			end
  	end  

end  



