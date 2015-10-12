class OfferMailer < ActionMailer::Base  
  default :from => "paulroiter@gmail.com"  

  def offer_email(pin)  
    @pin = pin  
    mail(:to => @pin.supplier_email, :replyto => "paulroiter@gmail.com", :subject => "Good news! #{pin.user.company} has approved your invoice #{pin.invoice_number}.")  
  end  
end  
