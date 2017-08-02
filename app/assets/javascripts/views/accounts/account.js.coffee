class DemoApp.Views.Account extends Backbone.View

  template: JST['accounts/account']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(account: @model, currency: @collection))
    this

