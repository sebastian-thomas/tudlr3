class HomeController < ApplicationController
  def index
    @jobs = Job.paginate(page: params[:page] , :per_page => 3)
  end

  def landingpage
  end
end
