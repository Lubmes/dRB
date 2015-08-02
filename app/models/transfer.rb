class Transfer < ActiveRecord::Base
  has_one :sender,
          :class_name => "User", 
          :foreign_key => "sender_id"
  has_one :recipient, 
          :class_name => "User", 
          :foreign_key => "recipient_id"

  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :amount, numericality: { greater_than: 0, only_integer: true }

  def recipient_id=(value)
    user = User.find_by_user_name(value)
    self[:recipient_id] = user.id 
  end

  def amount=(value)
    cents = value.to_f * 100
    self[:amount] = cents.to_i
  end

end