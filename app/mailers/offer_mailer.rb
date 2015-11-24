class OfferMailer < ActionMailer::Base  
  default :from => "phil@invoicely.co.uk"  

  def offer_email(pin)  
    @pin = pin  
    #mail(:to => @pin.suppler_name, :replyto => "phil@invoicely.co.uk", :subject => "Hi #{pin.suppler_ref}")  
    mail(:to => @pin.supplier_email, :replyto => "phil@invoicely.co.uk", :subject => "Good news! Fat Face has approved your invoice")  
  end  

    def offers_email(pins)  
    @pins = pins  
    #mail(:to => @pin.suppler_name, :replyto => "phil@invoicely.co.uk", :subject => "Hi #{pin.suppler_ref}")  
    mail(:to => @pins.first.supplier_email, :replyto => "phil@invoicely.co.uk", :subject => "Good news! Fat Face has approved your invoices")  
  end  


end  



