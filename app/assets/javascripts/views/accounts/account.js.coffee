class DemoApp.Views.Account extends Backbone.View

  template: JST['accounts/account']
  tagName: 'li'


  render: ->
  	$(@el).html(@template(account: @model))
  	this

