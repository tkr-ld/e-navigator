class ApprovalApplicationMailer < ApplicationMailer
  default from: ENV['GMAIL_USER_ADDRESS']

  def application_email(approver,current_user)
    @current_user = current_user

    mail(
      subject: '面接希望日が決まりました',
      to: approver.email
    )
  end

  def approval_email(interview,current_user)
    @interview = interview
    @applicant = @interview.user
    @current_user = current_user

    mail(
      subject: '面接日時が確定しました',
      to: "#{@applicant.email}, #{@current_user.email}"
    )
  end
end
