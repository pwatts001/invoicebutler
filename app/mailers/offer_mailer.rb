class OfferMailer < ActionMailer::Base  
  default :from => "phil@invoicely.co.uk"  


    def offers_email(pins)  
    @pins = pins  
    #mail(:to => @pin.suppler_name, :replyto => "phil@invoicely.co.uk", :subject => "Hi #{pin.suppler_ref}")  
    mail(:to => @pins.first.supplier_email, :replyto => "phil@invoicely.co.uk", :subject => "Good news! Fat Face has approved your invoices")  
  end  


end  



