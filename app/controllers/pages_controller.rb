class PagesController < ApplicationController
	before_action :authenticate_user!, :except => [:team, :home, :about, :FAQS]
	helper_method :sort_column, :sort_direction

  def home
  end
  def team
  end
  def about
  end

 	def dashboard
    @users = User.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
    @usersAll = Uesr.all
      respond_to do |format|
        format.html
        format.csv { send_data @usersAll.to_csv }
      end
  end

  private

	  def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
    end

end
