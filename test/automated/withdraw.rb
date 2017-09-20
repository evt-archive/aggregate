require_relative './automated_init'

context "Withdraw" do
  context "Sufficient Funds" do
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

  context "Insufficient Funds" do
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
