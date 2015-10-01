class OfferMailer < ActionMailer::Base  
  default :from => "invoicebutler@invoicebutler.com"  

  def offer_email(pin)  
    @pin = pin  
    #mail(:to => "#{@pin.user.name} <#{@pin.user.email}>", :replyto => @user.email, :subject => "#{@user.name} has requested #{@pin.description}")
    mail(:to => @pin.supplier_email, :replyto => "invoicebutler@invoicebutler.com", :subject => "Good news! #{pin.user.company} has approved your invoice #{pin.invoice_number}.")  
  end  
end  
