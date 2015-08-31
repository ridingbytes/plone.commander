path = require "path"
fs = require "fs"

Ext.define "App.services.AppConfig",
    singleton: yes

    constructor: ->
        console.debug "*** AppConfig::constructor"
        @_storage = Ext.create "Ext.util.LocalStorage",
            id: "settings"
        @loadDefaults()

        # API URLs
        @plone_api = "/@@API/plone/api/1.0"
        @base_url = @getValue("url")
        @plone_api_url = @getValue("url") + @plone_api

        window.AppConfig = @

    readPackageJSON: ->
        # read package json from application director
        pth = path.join path.resolve __dirname, "package.json"
        return JSON.parse fs.readFileSync pth

    getDefaultSettings: ->
        @config = @readPackageJSON()
        return @config.settings

    loadDefaults: ->
        # load the default values into the local storage if they aren't set
        # already
        Ext.each @getDefaultSettings(), (setting, index) ->
            custom = @get setting.key
            if not custom?
                console.debug "Adding key **#{setting.key}** to storage"
                @set setting.key, setting
        , this

    getSettings: ->
        out = []
        for key in @keys()
            # skip private keys
            if Ext.String.startsWith key, "_"
                continue
            out.push @get key
        return out

    keys: ->
        # return a list of all local storage keys
        return @_storage.getKeys()

    set: (key, value) ->
        # set and encode the value for the given key
        console.debug "AppConfig::set: key=#{key} value=#{Ext.encode value}"
        @_storage.setItem key, Ext.encode value

    get: (key) ->
        # get and decode the value for the given key
        console.debug "AppConfig::get: key=#{key}"
        return Ext.decode @_storage.getItem key

    delete: (key) ->
        # delete the key from the storage
        console.debug "AppConfig::delete: key=#{key}"
        @_storage.removeItem key

    getDefault: (key, value) ->
        return @get(key) ? value

    getValue: (key) ->
        setting = @get key
        return setting.value

    getDefaultValue: (key, value) ->
        setting = @getDefault key, value
        return setting.value ? value

    reset: ->
        # reset the values of the local storage with the values from the package.json config
        console.debug "AppConfig::reset"
        Ext.each @getDefaultSettings(), (setting, index) ->
            @set setting.key, setting
        , this

    clear: ->
        # clear all values of the local storage
        console.debug "AppConfig::clear"
        @_storage.clear()
