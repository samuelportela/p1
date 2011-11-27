class Product < ActiveRecord::Base
  validates :name, :presence => {:message => :is_mandatory}
end
