module Aggregate
  module Controls
    class Account
      include Aggregate

      #######################################################################
      # Macros
      #######################################################################
      category :account

      #######################################################################
      # Attributes
      #######################################################################
      attribute :id, String
      attribute :balance, Numeric, default: 0
      attribute :opened_time, Time
      attribute :closed_time, Time

      #######################################################################
      # Command Handlers
      #######################################################################
      handle Commands::Deposit do |deposit|
        deposited = Events::Deposited.follow(deposit)

        stream_name = self.stream_name(deposit.account_id)

        write.(deposited, stream_name)
      end

      handle Commands::Withdraw do |withdraw|
        amount = withdraw.amount

        if self.sufficient_funds?(amount)
          event = Events::Withdrawn.follow(withdraw)
        else
          event = Events::WithdrawalRejected.follow(withdraw)
        end

        stream_name = self.stream_name(withdraw.account_id)

        write.(event, stream_name)
      end

      #######################################################################
      # Event Projections
      #######################################################################
      apply Events::Deposited do |deposited|
        self.id ||= deposited.account_id

        amount = deposited.amount

        self.deposit(amount)
      end

      apply Events::Withdrawn do |withdrawn|
        self.id ||= withdrawn.account_id

        amount = withdrawn.amount

        self.withdraw(amount)
      end

      #######################################################################
      # Methods
      #######################################################################
      def deposit(amount)
        self.balance += amount
      end

      def withdraw(amount)
        self.balance -= amount
      end

      def sufficient_funds?(amount)
        self.balance >= amount
      end
    end
  end
end
