class DemoApp.Routers.Accounts extends Backbone.Router
  routes:
    'pages/accounts': 'allAccounts'
    'pages/transactions': 'allTransactions'

  initialize: ->
    @collection = new DemoApp.Collections.Accounts()
    @collection.fetch({ reset: true })
    @currency = new DemoApp.Collections.Currencies()
    @currency.fetch({ reset: true })
    @transactions = new DemoApp.Collections.Transactions()
    @transactions.fetch({ reset: true })

  allAccounts: ->
    view = new DemoApp.Views.AccountsIndex(collection: @collection)
    $('#app').html(view.render().el)

  allTransactions: ->
    view = new DemoApp.Views.TransactionsIndex(collection: @transactions)
    $('#app').html(view.render().el)