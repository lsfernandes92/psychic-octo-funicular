class Order < ApplicationRecord
  belongs_to :customer

  validates :description, presence: true
end
