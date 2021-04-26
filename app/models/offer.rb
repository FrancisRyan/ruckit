class Offer < ApplicationRecord
  belongs_to :request
  belongs_to :user
  
  enum status: [:pending, :accepted, :rejected]
  validates :age, numericality: { only_integer: true, message: "must be a number" }
end

