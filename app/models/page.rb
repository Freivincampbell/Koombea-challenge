class Page < ApplicationRecord
  belongs_to :user
  has_many :links, dependent: :destroy


  paginates_per 50
end
