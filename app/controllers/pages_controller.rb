class PagesController < ApplicationController
	before_action :authenticate_user!, :except => [:team, :home, :about, :FAQS]

  def home
  end
  def team
  end
  def about
  end


 	def dashboard
    @users = User.all
  end

end
