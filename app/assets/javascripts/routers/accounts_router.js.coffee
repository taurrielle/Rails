class DemoApp.Routers.Accounts extends Backbone.Router
	routes:
		'pages/accounts': 'index'


	initialize: ->
		@collection = new DemoApp.Collections.Accounts() 
		@collection.fetch({reset: true})

	index: ->
		view = new DemoApp.Views.AccountsIndex(collection: @collection)
		$('#app').html(view.render().el)