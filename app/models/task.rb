class Task < ApplicationRecord
  validates :title, presence: true, length: {  minimum: 1 }, allow_blank: false

  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags

  accepts_nested_attributes_for :tags, allow_destroy: true
  # accepts_nested_attributes_for :task_tags

  def to_json
    json_to_render = self.attributes
    json_to_render[:tags] = self.tags.map(&:to_json)
    json_to_render
  end

end
