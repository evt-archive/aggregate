module Aggregate
  module Controls
    class Account
      include Aggregate
      include Commands
      include Events

      attribute :id, String
      attribute :balance, Numeric, default: 0
      attribute :opened_time, Time
      attribute :closed_time, Time

      dependency :write, Messaging::Write

      category :account

      def deposit(amount)
        self.balance += amount
      end

      def withdraw(amount)
        self.balance -= amount
      end

      handle Deposit do |deposit|
        deposited = Deposited.follow(deposit)

        stream_name = self.stream_name(deposit.account_id)

        write.(deposited, stream_name)
      end

      apply Deposited do |deposited|
        self.id ||= deposited.account_id

        amount = deposited.amount

        self.deposit(amount)
      end

      handle Withdraw do |withdraw|
        amount = withdraw.amount

        if self.sufficient_funds?(amount)
          event = Withdrawn.follow(withdraw)
        else
          event = WithdrawalRejected.follow(withdraw)
        end

        stream_name = self.stream_name(withdraw.account_id)

        write.(event, stream_name)
      end

      apply Withdrawn do |withdrawn|
        self.id ||= withdrawn.account_id

        amount = withdrawn.amount

        self.withdraw(amount)
      end

      def sufficient_funds?(amount)
        self.balance >= amount
      end
    end
  end
end
