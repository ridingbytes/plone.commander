Ext.define "App.services.UserService",
    singleton: yes

    requires: [
        "App.model.User"
        "App.lib.Proxy"
    ]

    constructor:  ->
        console.debug "*** UserService::constructor"
        window.UserService = @

        store = Ext.create "Ext.data.Store",
            model: "App.model.User"
            proxy:
                type: "ploneproxy"
                url:  "#{AppConfig.plone_api_url}/users"
                extraParams:
                    complete: yes

        # Keep the service private
        _user = null
        Ext.applyIf @, do ->
            return {
                get_user: ->
                    return _user
                set_user: (record) ->
                    # handle response object
                    if record?.responseText
                        record = @parse_user record
                    _user = record
                    Ext.GlobalEvents.fireEvent "userchange", record
                has_user: ->
                    return _user isnt null
                get_user_store: ->
                    return store
            }

    # ########################################################################
    # Public API
    # ########################################################################

    fetch_current_user: ->
        console.debug "UserService::fetch_current_user"
        Ext.Ajax.request
            url: "#{AppConfig.plone_api_url}/users/current"
            scope: @
            method: "GET"
            params:
                complete: yes
            success: (response, opts) ->
                @set_user @parse_user response

    parse_user: (response) ->
        # parse user from the response
        reader = Ext.create "Ext.data.reader.Json",
            rootProperty: "items"
            model: "App.model.User"
        result = reader.read response
        if result.records.length is 0
            return null
        return result.records[0]

    getUser: ->
        # return the current logged in user
        return @get_user()

    getUserName: ->
        user = @get_user()
        return "Anonymous User" unless user
        return user.get "username"

    getUserById: (userid) ->
        store = @get_user_store()
        return store.getById userid
