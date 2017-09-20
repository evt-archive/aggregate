require_relative './automated_init'

context "Withdrawn" do
  withdrawn = Controls::Events::Withdrawn.example

  account = Controls::Account.build

  previous_balance = account.balance

  account.(withdrawn)

  test "Decreases balance" do
    assert(account.balance == previous_balance - withdrawn.amount)
  end
end
