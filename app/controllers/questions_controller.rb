class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_question, only: %i[show new update destroy]




  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new

  end

  def new

  end

  def create
    @question = Question.new(question_params)
    @question.author = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    @question.update(question_params)
    @questions = Question.all
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: 'Your question successfully deleted.'
    else
      render questions_path
    end
  end

  private

  def set_question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new

  end

  def question_params
    params.require(:question).permit(:title, :body, files: [])
  end


end