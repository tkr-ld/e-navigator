class ApplyInterviewMailer < ApplicationMailer
  def interviewer(approver, applicant)
  @applicant = applicant

  mail(
    subject: '面接希望日が決まりました',
    to: approver.email
  )
  end
end
