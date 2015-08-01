class Transfer < ActiveRecord::Base
  has_one :sender,
          :class_name => "User", 
          :foreign_key => "sender_id"
  has_one :recipient, 
          :class_name => "User", 
          :foreign_key => "recipient_id"

  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :transfer_amount, numericality: {:greater_than => 0}

  before_create :transfer_amount_to_cents
  private
    def transfer_amount_to_cents
      cents = self.transfer_amount * 100
      cents.to_i
      self.transfer_amount = cents
    end

end
