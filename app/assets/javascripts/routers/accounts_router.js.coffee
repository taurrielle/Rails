class DemoApp.Routers.Accounts extends Backbone.Router
  routes:
    'pages/accounts': 'allAccounts'
    'pages/new_account': 'newAccount'


  initialize: ->
    @collection = new DemoApp.Collections.Accounts() 
    @collection.fetch({ reset: true })
    @currency = new DemoApp.Collections.Currencies() 
    @currency.fetch({ reset: true })

  newAccount: ->
    view = new DemoApp.Views.Currency(collection: @currency)
    $('#app').html(view.render().el)   

  allAccounts: ->
    view = new DemoApp.Views.AccountsIndex(collection: @collection)
    $('#app').html(view.render().el)
    
