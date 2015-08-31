Ext.define 'App.view.search.SearchController',
    extend: 'Ext.app.ViewController'
    alias: 'controller.searchcontroller'

    init: (view) ->
        console.debug "*** SearchViewController::init"
        @store = Ext.StoreManager.get "Contents"

    onKeyUp: (field, e) ->
        console.debug "°°° SearchViewController::onKeyUp: #{e}"

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
        console.debug "°°° SearchViewController::onClearClick: #{btn}"
        btn.up().down("textfield").setValue("")
        delete @store.proxy.extraParams.q
        @store.reload()
        @memo = ""
