###* Base Model
 *
 * Super class for models
###
Ext.define  "App.model.Content",
    extend: "Ext.data.Model"

    idProperty: "uid"

    fields: [
        name: "url"
        type: "string"
    ,
        name: "path"
        type: "string"
    ,
        name: "uid"
        type: "string"
    ,
        name: "id"
        type: "string"
    ,
        name: "title"
        type: "string"
    ,
        name: "description"
        type: "string"
    ,
        name: "creator"
        type: "string"
    ,
        name: "created"
        type: "date"
        dateFormat: "c"
    ,
        name: "modified"
        type: "date"
        dateFormat: "c"
    ,
        name: "effective"
        type: "date"
        dateFormat: "c"
    ,
        name: "parent_id"
        type: "string"
    ,
        name: "parent_uid"
        type: "string"
    ,
        name: "parent_url"
        type: "string"
    ]

    # ########################################################################
    # GETTER
    # ########################################################################

    getUID: ->
        return @get "uid"

    getTitle: ->
        return @get "title"

    getIdOrTitle: ->
        return @get("id") or @get("title")

    getDescription: ->
        return @get "description"

    getCreator: ->
        return @get "creator"

    getPath: ->
        return @get "path"


    proxy:
        type: "ploneproxy"
        api:
            read    : "#{AppConfig.plone_api_url}/search"
            create  : "#{AppConfig.plone_api_url}/create"
            update  : "#{AppConfig.plone_api_url}/update"
            destroy : "#{AppConfig.plone_api_url}/delete"
