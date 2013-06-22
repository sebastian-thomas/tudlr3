class JobsController < ApplicationController
  # GET /jobs
  # GET /jobs.json
  before_filter :authenticate_user!, only: [:new ,:create, :destroy]
  before_filter :correct_user, only: [:destroy, :edit ,:update]

  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    bids = Bid.find_all_by_job_id(params[:id])
    userbid = Bid.find(:all, :conditions => ["user_id = ? and job_id = ?", current_user.id, params[:id]])
    @biddetails = Array.new
     @acceptflag = "openforbid"
    i=0
    if signed_in?                           #authenticated-user
      @usr = "signedin"
      if current_user.id == @job.user_id #owner-user
        @usr = "owner"
        bids.each do |b| 
          @biddetails[i] = Hash.new
          @biddetails[i]['id'] = b.id
          @biddetails[i]['by'] = b.user_id
          @biddetails[i]['coins'] = b.coins
          @biddetails[i]['userimage'] = User.find(b.user_id).img
          if b.status == 1
            @acceptflag = "accepted"
            @acceptedbid =  @biddetails[i]
          elsif b.status == 0
            @acceptflag = "completed"
            @acceptedbid =  @biddetails[i]
          end
          i = i+1
        end
      elsif userbid.empty?
        @usr = "general"
      else
        @usr = "bidder"
        @status = userbid[0].status
        @c=userbid[0].coins
      end
    end
    @bidcount = bids.count
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(params[:job])
    @job.user_id = current_user.id
    @job.status = 0
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end

  def correct_user
    @jobs = current_user.jobs.find_by_id(params[:id])
    redirect_to root_path if @jobs.nil?
  end
end
