class Seller < ActiveRecord::Base
   validates :name, :location, :story, :blurb, :specialty, presence: true
   has_many :products
   has_many :images  
end
