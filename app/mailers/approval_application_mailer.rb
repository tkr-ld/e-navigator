class ApprovalApplicationMailer < ApplicationMailer
  default from: ENV['GMAIL_USER_ADDRESS']

  def application_email(approver,current_user)
    @current_user = current_user

    mail(
      subject: '面接希望日が決まりました',
      to: approver.email,
    )
  end
end
