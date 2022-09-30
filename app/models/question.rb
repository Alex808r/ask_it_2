class Question < ApplicationRecord
  has_many :answers,dependent: :destroy

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  def formatted_created_at
    created_at.strftime('%d-%m-%y %H:%M:%S')
  end
end
