class User < ActiveRecord::Base
  has_secure_password

  has_one :account
  after_create :build_personal_account

  has_many  :sent_transfers, 
            :class_name => 'Transfer', 
            :foreign_key => 'sender_id'
  
  has_many  :received_transfers, 
            :class_name => 'Transfer', 
            :foreign_key => 'recipient_id'

  def all_transfers
    self.sent_transfers + self.received_transfers
  end

  private 
    def build_personal_account
      @account = Account.new
      @account.name = "Persoonlijke account"
      @account.cents = 100000
      @account.user_id = self.id
      @account.save
    end

end
