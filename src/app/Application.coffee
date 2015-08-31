Ext.define 'App.Application',
    extend: 'Ext.app.Application'

    name: 'App'

    requires: [
        "App.services.AppConfig"
        "App.services.UserService"
        "App.lib.Proxy"
        "App.model.Content"
        "App.model.Document"
        "App.model.Setting"
        "App.store.Contents"
        "App.store.Settings"
        "App.controller.Main"
    ]

    controllers: [
        "Main"
    ]

    stores: [
        "Contents"
        "Settings"
    ]

    models: [
        "Content"
        "Document"
        "Setting"
        "User"
    ]

    launch: ->
        console.debug "°°° App::launch"

    onAppUpdate: ->
        Ext.Msg.confirm 'Application Update', 'This application has an update, reload?', (choice) ->
            if choice == 'yes'
                window.location.reload()
            return
        return
