class QuestionDecorator < Draper::Decorator
  delegate_all

  def formatted_created_at
    # created_at.strftime('%d-%m-%y %H:%M:%S')
    l created_at, format: :long
  end
end
