require_relative './automated_init'

context "Account" do
  context "Handle deposit command" do
    deposit = Controls::Commands::Deposit.example

    account = Controls::Account.build

    account.(deposit)

    test "Writes Deposited event" do
      writer = account.write

      event = writer.one_message do |msg|
        msg.instance_of?(Controls::Events::Deposited)
      end

      refute(event.nil?)
    end
  end

  context "Project deposited event" do
    deposited = Controls::Events::Deposited.example

    account = Controls::Account.build

    previous_balance = account.balance

    account.(deposited)

    test "Increases balance" do
      assert(account.balance == previous_balance + deposited.amount)
    end
  end

  context "Handle withdraw command" do
    context "Sufficient funds" do
      withdraw = Controls::Commands::Withdraw.example

      account = Controls::Account.new
      account.balance = withdraw.amount

      account.(withdraw)

      test "Writes Withdrawn event" do
        writer = account.write

        event = writer.one_message do |msg|
          msg.instance_of?(Controls::Events::Withdrawn)
        end

        refute(event.nil?)
      end
    end

    context "Insufficient funds" do
      withdraw = Controls::Commands::Withdraw.example

      account = Controls::Account.new
      account.balance = withdraw.amount - 1

      account.(withdraw)

      test "Writes WithdrawalRejected event" do
        writer = account.write

        event = writer.one_message do |msg|
          msg.instance_of?(Controls::Events::WithdrawalRejected)
        end

        refute(event.nil?)
      end
    end
  end

  context "Project withdrawn event" do
    withdrawn = Controls::Events::Withdrawn.example

    account = Controls::Account.build

    previous_balance = account.balance

    account.(withdrawn)

    test "Decreases balance" do
      assert(account.balance == previous_balance - withdrawn.amount)
    end
  end
end
