class Link < ApplicationRecord
  belongs_to :page

  paginates_per 50
end
