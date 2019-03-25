class InterviewsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  def index
    @interviews = @user.interviews.order('start_datetime ASC')
  end

  def show
  end

  def new
    @interview = current_user.interviews.build
  end

  def create
    @interview = current_user.interviews.build(interview_params)

    if @interview.save
      redirect_to user_interview_path(current_user, @interview), notice: "面接が作成されました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @interview.update(interview_params)
      redirect_to user_interview_path(current_user.id, @interview), notice: "面接が更新されました。"
    else
      render :edit
    end
  end

  def destroy
    @interview.destroy
    redirect_to user_interviews_path(@interview.user), notice: "面接日程を削除しました。"
  end

  def approve
  end

  private

  def interview_params
    params.require(:interview).permit(:start_datetime, :status)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def correct_user
    interview = current_user.interviews.find_by(id: params[:id])
    unless interview.present?
      redirect_to root_url
    end
  end
end
