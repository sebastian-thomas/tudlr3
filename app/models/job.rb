class Job < ActiveRecord::Base
  attr_accessible :category, :coins, :completedby, :desc, :expiry, :grade, :jtime, :jtype, :status, :title, :user_id
  
  validates :title, presence: true
  validates :jtype, presence: true
  validates :desc, presence: true
  validates :expiry, presence: true
  validates :jtime, presence: true
  validates :grade, presence: true

  belongs_to :user
end
