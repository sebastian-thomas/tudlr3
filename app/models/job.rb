class Job < ActiveRecord::Base
  attr_accessible :category, :tag_list, :coins, :completedby, :desc, :expiry, :grade, :jtime, :jtype, :status, :title, :user_id
  
  validates :title, presence: true
  validates :jtype, presence: true
  validates :desc, presence: true
  validates :expiry, presence: true
  validates :jtime, presence: true
  validates :grade, presence: true

  acts_as_taggable
  acts_as_taggable_on :tags

  belongs_to :user
end
