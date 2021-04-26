class Challenge < ApplicationRecord
   belongs_to :fixture, required: false
   belongs_to :request, required: false
   
   belongs_to :challenger, class_name: "User"
   belongs_to :creator, class_name: "User"
   
   has_many :reviews
  

   enum status: [:reviewing, :accepted, :rejected]
end
