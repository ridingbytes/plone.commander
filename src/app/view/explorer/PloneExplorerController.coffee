Ext.define "App.view.explorer.PloneExplorerController",
    extend: "Ext.app.ViewController"
    alias: "controller.plone-explorer"

    init: (view) ->
        console.debug "*** PloneExplorerController::init"
        window.ploneexplorer = @
