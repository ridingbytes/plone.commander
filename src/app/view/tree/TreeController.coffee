Ext.define "App.view.tree.TreeController",
    extend: "Ext.app.ViewController"
    alias: "controller.tree"

    init: (view) ->
        console.debug "*** TreeController::init"

        view.on "nodeopen", @onOpen
        view.on "nodeselect", @onSelect

    ### * Methods
    ###
    onOpen: (record) ->
        console.debug "°°° TreeController::onOpen: #{record.get 'id'}"
        console.debug "portal_type=#{record.get 'portal_type'}"

    onSelect: (record) ->
        console.debug "°°° TreeController::onSelect: #{record.get 'id'}"
        console.debug "portal_type=#{record.get 'portal_type'}"
