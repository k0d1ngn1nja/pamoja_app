class Seller < ActiveRecord::Base
   validates :name, :location, :story, :specialty, presence: true
   validates :blurb, length: { maximum: 140 }
   has_many :products
   has_many :images  
end
