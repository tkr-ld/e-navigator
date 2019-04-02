class InterviewsController < ApplicationController
  before_action :set_user, only: [:index, :show]
  before_action :correct_user, only: [:destroy]
  before_action :different_user, only: [:approve]
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
      update_success_redirect(@interview)
    else
      render :edit
    end
  end

  def destroy
    @interview.destroy
    redirect_to user_interviews_path(@interview.user), notice: "面接日程を削除しました。"
  end

  def apply
    @approver = User.find(params[:approver_id])
    @current_user = current_user
    ApplyInterviewMailer.interviewer(@approver, @current_user).deliver
    redirect_to user_interviews_path(params[:user_id]), notice: "申請が完了しました。"
  end

  def approve
    @interview = Interview.find(params[:interview_id])
    if @interview.approve_datetime
      ApproveInterviewMailer.interviewee(@interview, @current_user).deliver
      ApproveInterviewMailer.interviewer(@interview, @current_user).deliver
      update_success_redirect(@interview)
    else
      render :edit
    end
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

  def update_success_redirect(interview)
    redirect_to user_interview_path(interview.user.id, interview), notice: "面接が更新されました。"
  end

  def correct_user
    unless current_user.interviews.find_by(id: params[:id])
      redirect_to root_url
    end
  end

  def different_user
    if current_user.interviews.find_by(id: params[:id])
      redirect_to root_url
    end
  end
end
