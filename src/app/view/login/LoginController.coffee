Ext.define "App.view.login.LoginController",
    extend: "Ext.app.ViewController"
    alias: "controller.login"

    KEY: "_credentials"

    init: (view) ->
        console.debug "*** LoginViewController::init"
        window.logincontroller = @

    control:
        "#":
            # handle view events
            afterrender: "onAfterRender"

    ###** Even Handler
    ###

    onLoginClick: (button) ->
        # Callback when the 'Login' button was clicked
        console.debug "°°° LoginViewController::onLoginClick"

        # Get the form values (__ac_name, __ac_password)
        values = @view.getForm().getValues()

        # Store user credentials if the remember checkbox is checked
        if values.remember
            AppConfig.set @KEY, values

        # Call the login route of plone.jsonapi.routes
        Ext.Ajax.request
            url: "#{AppConfig.plone_api_url}/login"
            scope: @
            method: "GET"
            params: values
            success: @onLoginSuccess
            failure: @onLoginFailure

    onLoginSuccess: (response, opts) ->
        # Login succeeded
        console.debug "°°° LoginViewController::onLoginSuccess"

        # set user in user service
        UserService.set_user response

        name = UserService.getUserName()
        Ext.Msg.show
            title: "Login Success"
            msg:   "You are now logged in as #{name}"
            buttons: Ext.Msg.OK
            icon: Ext.Msg.INFO

    onLoginFailure: (response, opts) ->
        # Login failed
        console.debug "°°° LoginViewController::onLoginFailure"

        # Display error message
        Ext.Msg.show
            title: "Login failed!"
            msg:   "The server did not accept the credentials you entered."
            buttons: Ext.Msg.OK
            icon: Ext.Msg.ERROR

    onLogoutClick: (button) ->
        # Callback when the 'Login' button was clicked
        console.debug "°°° LoginViewController::onLogoutClick"

        # Call the login route of plone.jsonapi.routes
        Ext.Ajax.request
            url: "#{AppConfig.plone_api_url}/logout"
            scope: @
            method: "GET"
            callback: @onLogout

    onLogout: (response, opts) ->
        # Logout succeeded

        # remove user in user service
        UserService.fetch_current_user()

        Ext.Msg.show
            title: "Logged out"
            msg:   "You are now logged out"
            buttons: Ext.Msg.OK
            icon: Ext.Msg.INFO

    onRemember: (checkbox, newValue, oldValue, eOpts) ->
        # Callback when the `Remember my credentials` checkbox was clicked
        console.debug "°°° LoginViewController::onRemember"

        values = @view.getValues()
        if checkbox.checked
            # Save user credentials to the local storage
            AppConfig.set @KEY, values
        else
            # Delete user credentials from the local storage
            AppConfig.delete @KEY

    onAfterRender: ->
        # Callback when the attached view is rendered
        console.debug "°°° LoginViewController::onAfterRender"

        # Check for stored credentials
        credentials = AppConfig.get @KEY
        if credentials
            # Restore user credentials to the login form
            form = @view.getForm()
            form.setValues credentials
