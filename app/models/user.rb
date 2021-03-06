class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email,
    :password,
    :password_confirmation,
    :remember_me,
    :role,
    :display_name,
    :remaining_bids
  
  has_many :bids
  
  ROLES = ['administrator', 'analyzer', 'bidder']
  
  validates :role, :presence => true
  
  validates :display_name, :presence => true
  
  validates :remaining_bids, :presence => true
  
  def is?(role_name)
    self.role.to_s == role_name.to_s
  end
  
  def has_remaining_bids?
    self.remaining_bids > 0
  end
  
  def decrease_remaining_bids
    self.update_attribute(:remaining_bids, self.remaining_bids - 1)
  end
end
