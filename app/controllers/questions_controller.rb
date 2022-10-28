class QuestionsController < ApplicationController
  include QuestionsAnswers

  before_action :set_question!, only: %i[show edit update destroy]

  def index
    @pagy, @questions = pagy Question.order.includes(:user).(created_at: :desc)
    @questions = @questions.decorate
    # @questions = Question.order(created_at: :desc).page params[:page]
    # debugger
  end

  def show
    load_question_answers
    # @question = @question.decorate
    # @answer = @question.answers.build
    # @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    # @answers = @answers.decorate
    # @answers = @question.answers.order(created_at: :desc).page(params[:page]).per(3)
  end

  def new
    @question = Question.new
  end

  def create
    # render plain: params
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = 'Question created!'
      redirect_to(questions_path)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:success] = 'Question updated!'
      redirect_to(questions_path)
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = t('.success')
    redirect_to(questions_path)
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find(params[:id]) # RecordNotFound если запись не найдена.
    # @question = Question.find_by(id: params[:id]) аналогичная запись/ Если вопрос с id не будет найден, получим ошибку
    # NoMethodError. Поэтому лучше использовать Question.find(params[:id])
  end
end
