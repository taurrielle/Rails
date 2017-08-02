class DemoApp.Views.AccountsIndex extends Backbone.View

  template: JST['accounts/index']

  events:
    'submit #new_account': 'createAccount'
    'click #account_button': 'showForm'


  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendAccount, this)
    @currency = new DemoApp.Collections.Currencies()
    @currency.fetch({ reset: true })
    @currency.on('reset', @render, this)

  render: ->
    $(@el).html(@template(currency: @currency))
    @collection.each(@appendAccount)
    this

  appendAccount: (account) =>
    view = new DemoApp.Views.Account(model: account, collection:@currency)
    @$('#accounts').append(view.render().el)

  showForm: ->
    if ( $('#account_form').css('display') == 'none' )
      $('#account_form').css('display', 'block')
      $('#account_button').html('Cancel')
    else
      $('#account_form').css('display', 'none')
      $('#new_account')[0].reset()
      $('#account_button').html('Add account')

  createAccount: (event) ->
    event.preventDefault()
    attributes = name: $('#new_account_name').val(),
    balance: $('#new_account_balance').val(),
    currency: $('#new_account_currency').val()
    @collection.create attributes,
      wait: true
      success: ->
        $('#new_account')[0].reset()
        $('#account_form').css('display', 'none')
        $('#account_button').html('Add account')
        $('#error').css('display', 'none')
      error: @handleError

  handleError: (account, response) ->
    if response.status == 422
      $('#error').empty()
      $('#error').css('display', 'block')
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        $('#error').append('<li>' + 'The ' + attribute + ' ' + message + '</li>') for message in messages

