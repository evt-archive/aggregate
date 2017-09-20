require_relative './automated_init'

context "Deposited" do
  deposited = Controls::Events::Deposited.example

  account = Controls::Account.build

  previous_balance = account.balance

  account.(deposited)

  test "Increases balance" do
    assert(account.balance == previous_balance + deposited.amount)
  end
end
