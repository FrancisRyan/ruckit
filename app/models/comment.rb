class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  has_one_attached :attachment_file
end
