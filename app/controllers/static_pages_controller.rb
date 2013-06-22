class StaticPagesController < ApplicationController
  def about
  end

  def myprojects

  	@myprojects = current_user.jobs
  end

  def myjobs
  	myjobbids =  Bid.find_all_by_user_id(current_user.id)
  	@myjobs = Job.find(:all, :conditions => ["id in (?)", myjobbids.collect(&:job_id)])
  end

  def bid
  	b = Bid.new
  	b.user_id = current_user.id 
  	b.job_id = params[:job_id]
  	b.coins = params[:coins]
    b.save
    redirect_to myjobs_path
  end
end
