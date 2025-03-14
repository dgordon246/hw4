class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :place
  has_one_attached :uploaded_image
end
