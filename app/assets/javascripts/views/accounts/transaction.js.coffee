class DemoApp.Views.Transaction extends Backbone.Marionette.ItemView

  template: JST['transactions/transaction']

  initialize: (options) ->
    @transaction = options.model
    @currency = options.currency_collection
    @accounts = options.accounts_collection

  serializeData: ->
    currency: @currency
    accounts: @accounts
    transaction: @transaction






