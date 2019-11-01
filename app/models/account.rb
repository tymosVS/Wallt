class Account < ApplicationRecord

  scope :users, -> { where(type: 'User') }
  scope :stocks, -> { where(type: 'Stock') }
  scope :teams, -> { where(type: 'Team') }

  self.inheritance_column = :type

  def self.types
    %w(User Stock Team)
  end

  validates :acount_id, uniqueness: true
  validates :type, presence: true
  validates :cash, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def execute_transaction(source, value)
    if enough_cash?(value)
      credit(value, source)
      debit(value)
    else
      return false
    end
  end

  def check_cash(value)
    enough_cash?(value)
  end

  private

  def credit(value, source_account)
    self.cash += value
  end

  def debit(value)
    self.cash -= value
  end

  def enough_cash?(value)
    cash >= value
  end
end
