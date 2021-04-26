class Category < ApplicationRecord
    has_many :fixtures
    has_many :requests
end