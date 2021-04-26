class Review < ApplicationRecord
  belongs_to :challenge
  belongs_to :fixture, required: false
  belongs_to :challenger, class_name: "User"
  belongs_to :creator, class_name: "User"
end