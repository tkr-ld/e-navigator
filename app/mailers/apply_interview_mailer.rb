class ApplyInterviewMailer < ApplicationMailer
  def application_email(approver,current_user)
  @current_user = current_user

  mail(
    subject: '面接希望日が決まりました',
    to: approver.email
  )
  end
end
