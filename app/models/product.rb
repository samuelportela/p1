class Product < ActiveRecord::Base
  has_many :auctions
  has_many :photos, :as => :photographable, :dependent => :destroy
  
  accepts_nested_attributes_for :photos, :allow_destroy => true
  
  validates :name, :presence => true
end
