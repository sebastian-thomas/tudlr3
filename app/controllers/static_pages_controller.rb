class StaticPagesController < ApplicationController

  before_filter :correct_user, only: [:accept]

  def about
  end

  def myprojects
  	@myprojects = current_user.jobs
  end

  def myjobs
  	myjobbids =  Bid.find_all_by_user_id(current_user.id)
  	@myjobs = Job.find(:all, :conditions => ["id in (?)", myjobbids.collect(&:job_id)])
  end

  def accept
  	bid = Bid.find(params[:bid])
  	coins = bid.coins
  	buf = Coinbuffer.new
  	buf.user_id = bid.user_id
  	buf.job_id = bid.job_id
  	buf.coins = bid.coins
  	buf.save
  	byuser = User.find(bid.user_id)
  	if current_user.coins > coins
	  	current_user.coins = current_user.coins - coins
	  	current_user.save	 
	  	bid.status = 1
	  	bid.save	
	  	redirect_to myprojects_path, :notice => "Bid accepted in queue."
	else
		redirect_to myprojects_path, :notice => "not enough coins."
	end
  end

  def oncompletion
  	bid = Bid.find(params[:bid])
  	coins = bid.coins
  	buf = Coinbuffer.find_by_job_id(bid.job_id)
  	byuser = User.find(bid.user_id)
	byuser.coins = byuser.coins + coins
	byuser.save  
	bid.status = 0
	bid.save	
	redirect_to myprojects_path, :notice => "the deal is over"    
  end

  def onrejection
  	bid = Bid.find(params[:bid])
  	coins = bid.coins
  	buf = Coinbuffer.find_by_job_id(bid.job_id)
	current_user.coins = current_user.coins + coins
	current_user.save  
	bid.status = 2
	bid.save	
	redirect_to myprojects_path, :notice => "the deal has been cancelled"    
  end

  def bid
  	b = Bid.new
  	b.user_id = current_user.id 
  	b.job_id = params[:job_id]
  	b.coins = params[:coins]
  	b.status = -1
    b.save
    redirect_to myjobs_path
  end

  def correct_user
  	bid = Bid.find(params[:bid])
    @jobs = current_user.jobs.find_by_id(bid.job_id)
    redirect_to root_path if @jobs.nil?
  end
end
