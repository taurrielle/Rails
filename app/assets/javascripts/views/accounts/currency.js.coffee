class DemoApp.Views.Currency extends Backbone.View

  template: JST['accounts/new_account']

  events:
    'submit #new_account': 'createAccount'

  initialize: ->
  	@collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(currency: @collection))
    this

  createAccount: (event) ->
    event.preventDefault()
    attributes = name: $('#new_account_name').val(),
    balance: $('#new_account_balance').val(),
    currency_id: $('#new_account_currency').val()
    @cur = new DemoApp.Collections.Currencies() 
    @cur.fetch()
    console.log(attributes)
    @cur.create attributes,
      wait: true
      success: -> $('#new_account')[0].reset()
      error: @handleError

  handleError: (account, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages