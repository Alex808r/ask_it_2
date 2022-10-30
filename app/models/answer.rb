class Answer < ApplicationRecord
  include Authorship
  include Commentable

  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: { minimum: 5 }

  # in decorate
  # def formatted_created_at
  #   created_at.strftime('%d-%m-%y %H:%M:%S')
  # end
end
