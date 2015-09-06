Ext.define 'App.view.search.SearchController',
    extend: 'Ext.app.ViewController'
    alias: 'controller.searchcontroller'

    init: (view) ->
        console.debug "*** SearchViewController::init"
        @store = Ext.StoreManager.get "Search"

    ### * Event handlers
    ###

    onKeyUp: (field, e) ->
        console.debug "°°° SearchController::onKeyUp: #{e}"

        value = field.getValue()
        if value and value isnt @memo
            @store.proxy.extraParams.q = value
            @store.reload()
            @memo = value

        if value is "" and value isnt @memo
            @memo = ""
            delete @store.proxy.extraParams.q
            @store.reload()

    onClearClick: (btn) ->
        console.debug "°°° SearchController::onClearClick: #{btn}"
        btn.up().down("textfield").setValue("")
        delete @store.proxy.extraParams.q
        @store.reload()
        @memo = ""
