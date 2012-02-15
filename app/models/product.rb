class Product < ActiveRecord::Base
  has_many :auctions
  
  has_attached_file :image, :styles => {:medium => "300x300>", :thumb => "100x100>"}
  
  validates :name, :presence => {:message => :is_mandatory}
end
