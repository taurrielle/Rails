class DemoApp.Views.TransactionsIndex extends Backbone.View

  template: JST['transactions/index']

  events:
    'submit #new_transaction': 'createTransaction'
    'click #transaction_button': 'showForm'


  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendTransaction, this)

    @currency = new DemoApp.Collections.Currencies()
    @currency.fetch({ reset: true })
    @currency.on('reset', @render, this)

    @accounts = new DemoApp.Collections.Accounts()
    @accounts.fetch({ reset: true })
    @accounts.on('reset', @render, this)

  render: ->
    $(@el).html(@template(accounts: @accounts))
    @collection.each(@appendTransaction)
    this

  appendTransaction: (transaction) =>
    view = new DemoApp.Views.Transaction(model: transaction, currency_collection: @currency, accounts_collection: @accounts)
    @$('#transactions').append(view.render().el)

  createTransaction: (event) ->
    event.preventDefault()
    account = @accounts.findWhere(id: parseInt($('#new_transaction_account').val()), 10)
    ammount = parseInt($('#new_transaction_ammount').val(), 10)
    if account
      currency = account.get('currency')
    attributes = ammount: $('#new_transaction_ammount').val(),
    description: $('#new_transaction_description').val(),
    made_on_date: $('#new_transaction_date').val(),
    account_id: $('#new_transaction_account').val(),
    currency: currency
    @collection.create attributes,
      wait: true
      success: =>
        @accounts.setBalance(account, ammount)
        @showForm()
      error: @handleError

  handleError: (account, response) ->
    if response.status == 422
      $('#error').empty()
      $('#error').css('display', 'block')
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        $('#error').append('<li>' + 'The ' + attribute + ' ' + message + '</li>') for message in messages

  showForm: ->
    if ( $('#transaction_form').css('display') == 'none' )
      $('#transaction_form').css('display', 'block')
      $('#transaction_button').html('Cancel')
    else
      $('#transaction_form').css('display', 'none')
      $('#new_transaction')[0].reset()
      $('#transaction_button').html('Add transaction')
      $('#error').css('display', 'none')