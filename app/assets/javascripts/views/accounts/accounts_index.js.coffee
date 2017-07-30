class DemoApp.Views.AccountsIndex extends Backbone.View

  template: JST['accounts/index']

  events:
  	'submit #new_account': 'createAccount'

  initialize: ->
  	@collection.on('reset', @render, this)
  	@collection.on('add', @appendAccount, this)

  render: ->
  	$(@el).html(@template())
  	@collection.each(@appendAccount)
  	this

  appendAccount: (account) =>
  	view = new DemoApp.Views.Account(model: account)
  	@$('#accounts').append(view.render().el)

  createAccount: (event) ->
  	event.preventDefault()
  	attributes = name: $('#new_account_name').val(),
  	balance: $('#new_account_balance').val()
  	@collection.create attributes,
  		wait: true
  		success: -> $('#new_account')[0].reset()
  		error: @handleError

  handleError: (account, response) ->
  	if response.status == 422
  		errors = $.parseJSON(response.responseText).errors
  		for attribute, messages of errors
  			alert "#{attribute} #{message}" for message in messages


