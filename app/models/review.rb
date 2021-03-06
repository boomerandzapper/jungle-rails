class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates_presence_of :user_id, :product_id, :description, :rating
end
