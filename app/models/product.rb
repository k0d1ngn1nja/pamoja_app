class Proudct < ActiveRecords::Base
  belongs_to :seller
  belongs_to :buyer
end
