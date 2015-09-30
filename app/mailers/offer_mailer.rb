class OfferMailer < ActionMailer::Base  
  default :from => "ian@ctrl-r.com"  

  def offer_email(pin)  
    @pin = pin  
    #mail(:to => "#{@pin.user.name} <#{@pin.user.email}>", :replyto => @user.email, :subject => "#{@user.name} has requested #{@pin.description}")  
    mail(:to => "phillip.watts1@googlemail.com", :replyto => "phill_666@hotmail.com", :subject => "offer")  
  end  
end  