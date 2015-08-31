Ext.define 'App.view.settings.SettingsController',
    extend: 'Ext.app.ViewController'
    alias: 'controller.settings'

    init: (view) ->
        console.debug "*** SettingsController::init"
        view.on 'edit', @onEdit

    ###* Even Handler
    ###

    onRefresh: ->
        # Ask before refreshing the application
        Ext.Msg.confirm 'Confirm', 'Reload Application?', (choice) ->
            if choice == 'yes'
                window.location.reload()
            return
        return

    onReset: (button) ->
        console.debug "°°° SettingsController::Reset: reset to default settings!"
        Ext.StoreManager.get("Settings").reset()

    onEdit: (editor, e) ->
        key = e.record.get "key"
        value = e.record.data
        console.debug "°°° SettingsController::edit: setting changed #{key} -> #{value}"
        AppConfig.set key, value
