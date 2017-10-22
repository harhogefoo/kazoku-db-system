class User < ApplicationRecord
  has_one :profile_family, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :contact, dependent: :destroy
  has_many :event_dates, dependent: :destroy
  has_many :reply_log, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}
  validates :gender, presence: true

  enum genders:  {
    "#{Settings.gender.str.woman}": 0,
    "#{Settings.gender.str.man}": 1,
    "#{Settings.gender.str.unknown}": 2
  }

  # 働き方の文字列を取得する
  def job_style_str
    job_style = self.profile_family.job_style
    if job_style == Settings.job_style.both
      Settings.job_style.str.both
    elsif job_style == Settings.job_style.both_single
      Settings.job_style.str.both_single
    elsif job_style == Settings.job_style.homemaker
      Settings.job_style.str.homemaker
    end
  end

  # 打診回数を取得する
  def request_times
    email_pc = self.contact.email_pc
    # Email queue から打診メールの数を取得して返却する
    EmailQueue.where(
        email_type: Settings.email_type.request,
        to_address: email_pc
    ).size
  end


  # 最終打診日を取得する
  def last_request_day
    email_pc = self.contact.email_pc
    # Email queue から打診メールの中で最後の日を取得して返却する
    eq = EmailQueue.where(
        email_type: Settings.email_type.request,
        to_address: email_pc
    ).order('time_delivered desc').first

    # nil check
    eq.time_delivered.strftime('%Y/%m/%d') unless eq.nil?
  end

end
