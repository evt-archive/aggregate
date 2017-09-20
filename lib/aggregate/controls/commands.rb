module Aggregate
  module Controls
    module Commands
      class Deposit
        include Messaging::Message

        attribute :account_id, String
        attribute :amount, Numeric

        def self.example
          account_id = ID.example
          amount = Money.example

          build({ account_id: account_id, amount: amount })
        end
      end

      class Withdraw
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
