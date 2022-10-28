class Question < ApplicationRecord
  include Commentable

  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }

  # in decorate
  # def formatted_created_at
  #   created_at.strftime('%d-%m-%y %H:%M:%S')
  # end
end
