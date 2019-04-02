class ApproveInteviewMailer < ApplicationMailer
  def approval_email_for_applicant(interview,current_user)
    @interview = interview
    @current_user = current_user

    mail(
      subject: '面接日時が確定しました',
      to: @interview.user.email
    )
  end

  def approval_email_for_approver(interview,current_user)
    @interview = interview

    mail(
      subject: '面接日時が確定しました',
      to: current_user.email
    )
  end
end
