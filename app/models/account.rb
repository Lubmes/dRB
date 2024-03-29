class Account < ActiveRecord::Base

  belongs_to :user
  validates :user_id, :presence => true
  validates :cents, numericality: {:greater_than_or_equal_to => 0}

end
