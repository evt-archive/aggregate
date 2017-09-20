require_relative './automated_init'

context "Deposit" do
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
