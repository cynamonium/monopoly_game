Reflux             = require('reflux')
actions            = require('js/flux/actions/monopoly_actions')
FilterStoreHandler = require('./filter_store_handler')



FilterStore = Reflux.createStore({
    # automatic forwarding based on action name to corresponding function on self
    listenables: actions,

    preloadStore: (page)->
      @handler = new FilterStoreHandler()
      @handler.preLoad( page.query )


    getParams: ->
      @handler.getParams.apply(@handler, arguments)


    # only for debugging!
    _getHandler: ->
      @handler

})

module.exports = FilterStore
