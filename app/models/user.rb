class User < ActiveRecord::Base
  has_secure_password

  has_one :account
  after_create :build_personal_account

  private 
    def build_personal_account
      @account = Account.new
      @account.name = "Persoonlijke account"
      @account.cents = 100000
      @account.user_id = self.id
      @account.save
    end

end
