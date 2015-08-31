Ext.define 'App.controller.Main',
    extend: 'Ext.app.Controller'

    init: (application) ->
        console.debug "*** MainController::init: application=", application

        # see: https://github.com/atom/electron/blob/master/docs/tutorial/online-offline-events.md
        window.addEventListener 'offline', @onNetworkDown

        ###* Load the current authenticated user
         *
         * Note: it is not possible to use the static `User.load` method here.
         *       because the Ext fails with a validation error with the id `current`.
        ###
        Ext.Ajax.request
            url: "#{AppConfig.plone_api_url}/users/current"
            scope: @
            method: "GET"
            success: @onCurrentUserLoaded
            failure: @onCurrentUserLoadFailure

    ###* Even Handler
    ###

    onCurrentUserLoaded: (response, opts) ->
        # Loading succeeded
        console.debug "°°° MainController::onCurrentUserLoaded"

        # handle user object
        reader = Ext.create "Ext.data.reader.Json",
            rootProperty:  "items"
            model: "App.model.User"
        result = reader.read response
        if result.records.length
            record = result.records[0]
            UserService.set_user record

    onCurrentUserLoadFailure: (response, opts) ->
        # Loading failed
        console.debug "°°° MainController::onCurrentUserLoadFailure"

        # Display error message
        Ext.Msg.show
            title: "Load Error"
            msg: "<p>Could not load data from the Server. Please check the Server Settings</p>"
            buttons: Ext.Msg.OK
            icon: Ext.Msg.ERROR

    onNetworkDown: ->
        # No network connection
        console.debug "°°° MainController::onNetworkDown"

        # Display error message
        Ext.Msg.show
            title: "Network Error"
            msg: "Please check your network connection"
            buttons: Ext.Msg.OK
            icon: Ext.Msg.ERROR
