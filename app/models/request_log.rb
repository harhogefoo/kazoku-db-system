class RequestLog < ApplicationRecord
  has_many :request_day, dependent: :destroy
  has_many :reply_log, dependent: :destroy
  has_many :email_queue, dependent: :destroy
  has_one :event_date, dependent: :destroy


  def self.three_days_reminder
    # Find families to send a reminder email.
    # The way how it works is
    # 1. Find request log that has not been approved, using event table.

    logs = RequestLog.includes(:event_date)

    logs.each do |log|

      # Check if there is event date.
      # Execute reminder mail functions in case of event date nil
      # RequestLog の中から EventDate のないものを探す。
      # 且つ3日たち、リマインドメールを送っていない場合

      # TODO: check remind status.
      if log.event_date == nil && log.created_at + 3.days < Time.now

        # リマインドメールを送る家庭を探すために、ReplyLog から何もアクションをしていない家庭を探す。
        # すべての送信履歴を参照
        mail_queues = EmailQueue.where(request_log_id: log.id, email_type: "request_email_to_family").select(:to_address)

        # 返信履歴（ReplyLog）の中に、送信履歴（EmailQueue）から割り出した家庭が存在していないものを取り出す。
        # つまりは、返信していない家庭の割り出し。
        mail_queues.each do |mail_queue|
          contact = Contact.find_by(email_pc: mail_queue.to_address)

          rl = ReplyLog.find_by(request_log_id: log.id, user_id: contact.user_id)

        end
      end
    end
  end
  
end
