class DemoApp.Collections.Accounts extends Backbone.Collection
  url: '/api/accounts'
  model: DemoApp.Models.Account

  setBalance: (account, ammount) ->
    account.set(balance: account.get('balance') - ammount)
    account.save()