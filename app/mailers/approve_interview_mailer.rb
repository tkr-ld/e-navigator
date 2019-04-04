class ApproveInterviewMailer < ApplicationMailer
  def interviewee(interview, approver)
    @interview = interview
    @approver = approver

    mail(
      subject: '面接日時が確定しました',
      to: @interview.user.email
    )
  end

  def interviewer(interview, approver)
    @interview = interview

    mail(
      subject: '面接日時が確定しました',
      to: approver.email
    )
  end
end
