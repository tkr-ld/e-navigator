class ApplyInterviewMailer < ApplicationMailer
  def interviewer(approver,current_user)
  @current_user = current_user

  mail(
    subject: '面接希望日が決まりました',
    to: approver.email
  )
  end
end
