window.DemoApp =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new DemoApp.Routers.Accounts()
    Backbone.history.start(pushState: true)


$(document).ready ->
  DemoApp.initialize()


