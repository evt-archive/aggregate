module Aggregate
  module Controls
    module Events
      class Deposited
        include Messaging::Message

        attribute :account_id, String
        attribute :amount, Numeric

        def self.example
          account_id = ID.example
          amount = Money.example

          build({ account_id: account_id, amount: amount })
        end
      end

      class Withdrawn
        include Messaging::Message

        attribute :account_id, String
        attribute :amount, Numeric

        def self.example
          account_id = ID.example
          amount = Money.example

          build({ account_id: account_id, amount: amount })
        end
      end

      class WithdrawalRejected
        include Messaging::Message

        attribute :account_id, String
        attribute :amount, Numeric

        def self.example
          account_id = ID.example
          amount = Money.example

          build({ account_id: account_id, amount: amount })
        end
      end
    end
  end
end
