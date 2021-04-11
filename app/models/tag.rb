class Tag < ApplicationRecord
  validates :title, presence: true, length: {  minimum: 1 }, allow_blank: false
  has_many :task_tags, dependent: :destroy
  # paginates_per 20
end
