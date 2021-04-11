class TaskTag < ApplicationRecord

  validates :task_id, presence: true, allow_blank: false
  validates :tag_id, presence: true, allow_blank: false

  belongs_to :task
  belongs_to :tag
end
