class Bid < ActiveRecord::Base
  attr_accessible :coins, :job_id, :status, :user_id, :id
end
