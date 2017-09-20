# Aggregate

## Usage

1. Define an entity class
2. Handle command messages by writing events
3. Apply events to entity by mutating its state
4. ???
5. Profit!

## Example

```ruby
class Account
  include Aggregate

  attribute :id, String
  attribute :balance, Numeric, default: 0
  attribute :opened_time, Time
  attribute :closed_time, Time

  category :account

  def deposit(amount)
    self.balance += amount
  end

  def withdraw(amount)
    self.balance -= amount
  end

  handle Commands::Deposit do |deposit|
    deposited = Deposited.follow(deposit)

    stream_name = self.stream_name(deposit.account_id)

    write.(deposited, stream_name)
  end

  apply Events::Deposited do |deposited|
    self.id ||= deposited.account_id

    amount = deposited.amount

    self.deposit(amount)
  end

  handle Commands::Withdraw do |withdraw|
    amount = withdraw.amount

    if self.sufficient_funds?(amount)
      event = Withdrawn.follow(withdraw)
    else
      event = WithdrawalRejected.follow(withdraw)
    end

    stream_name = self.stream_name(withdraw.account_id)

    write.(event, stream_name)
  end

  apply Events::Withdrawn do |withdrawn|
    self.id ||= withdrawn.account_id

    amount = withdrawn.amount

    self.withdraw(amount)
  end

  def sufficient_funds?(amount)
    self.balance >= amount
  end
end
```

Copyright (c) 2018 Eventide Project under the MIT License. All rights reserved.
