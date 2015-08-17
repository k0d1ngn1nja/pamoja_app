class Seller < ActiveRecord::Base
   validates :name, :location, :specialty, presence: true
   validates :blurb, length: { maximum: 140 }
   validates :story, length: { minimum: 140 }
   has_many :products
   has_many :images  
end
