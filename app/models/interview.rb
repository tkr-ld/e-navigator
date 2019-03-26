class Interview < ApplicationRecord
  belongs_to :user

  validates :start_datetime, presence: true
  validate :add_error_start_datetime, on: :create
  validate :add_error_start_datetime, on: :update

  enum status: { reservation: 0, rejection: 1, approval: 2 }

  def add_error_start_datetime
    if start_datetime.past?
      set_past_error
    end
  end

  def approve_datetime
    if self.start_datetime.future?
      self.update(status: :approval)

      user = self.user
      interviews = user.interviews.where.not(id: self.id)
      interviews.each do |interview|
        interview.update(status: :rejection) 
      end
    else
      set_past_error
      return false
    end
  end

  private

  def set_past_error
    errors.add(:start_datetime, "は未来の時間を指定してください")
  end
end
