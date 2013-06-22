class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  has_many :jobs , dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:linkedin]

  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :location, :lurl, :img, :coins, :sucssesrate, :portlink, :id , :password_confirmation, :remember_me ,:provider, :uid
  
  def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
  user = User.where(:provider => auth.provider, :uid => auth.uid).first
  unless user
    user = User.create(name:auth.info.name,
    	                 coins: 250,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         lurl:auth.info.urls.public_profile,
                         location:auth.info.location,
                         img:auth.info.image,
                         password:Devise.friendly_token[0,20]
                         )
  end
  user
  end

  
  
end
