class EventDate < ApplicationRecord
  belongs_to :request_log
  belongs_to :user

  include ActiveModel::Model
  attr_accessor :event_time


  def nil_replace
    self.information == "" ? "特にありません" : self.information
  end

  def is_first?
    self.is_first_time ? "初めて" : "初めてではない"
  end

  def is_amazon_card?
    self.is_amazon_card ? "受け取る" : "受け取らない"
  end

end
