class Task < ApplicationRecord
  belongs_to :list

  validates :content, presence: true

  def completed?
    !completed_at.blank?
  end
end
