class Buyer < ActiveRecord::Base
  has_many :products
end
