class ApproveInterviewMailer < ApplicationMailer
  def interviewee(interview,current_user)
    @interview = interview
    @current_user = current_user

    mail(
      subject: '面接日時が確定しました',
      to: @interview.user.email
    )
  end

  def interviewer(interview,current_user)
    @interview = interview

    mail(
      subject: '面接日時が確定しました',
      to: current_user.email
    )
  end
end
