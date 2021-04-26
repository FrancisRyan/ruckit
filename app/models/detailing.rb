class Detailing < ApplicationRecord
  belongs_to :fixture
  enum detailing_type: [:fixture]
end
