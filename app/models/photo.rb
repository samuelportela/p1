class Photo < ActiveRecord::Base
  belongs_to :photographable, :polymorphic => true
  
  has_attached_file :file,
    :styles => {:small => "100x100>", :medium => "300x300>", :large => "500x500>"},
    :default_style => :small
end
