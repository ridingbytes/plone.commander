### * Plone Content Node
###
Ext.define  "App.model.Node",
    extend: "Ext.data.TreeModel"

    idProperty: "uid"

    schema :
        namespace : 'App.model'

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
    ,
        name: 'immediatelyAddableTypes'
        type: 'auto'
    ]


    ### * Methods
    ###
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


    ### * Node specific
    ###
    isFolder: ->
        return @get("portal_type") is "Folder"

    isPortal: ->
        return @get("portal_type") is "Plone Site"

    isLeaf: ->
        if @isRoot() then return no
        if @isPortal() then return no
        if @isFolder() then return no
        if @get("immediatelyAddableTypes") then return no
        @data.leaf = yes
        return yes


    ### * Proxy Configuration
    ###
    proxy:
        type: "ploneproxy"
        extraParams:
            children: yes
        reader:
            rootProperty: "children"
            typeProperty: "portal_type"
        api:
            read    : "#{AppConfig.plone_api_url}/get"
            create  : "#{AppConfig.plone_api_url}/create"
            update  : "#{AppConfig.plone_api_url}/update"
            destroy : "#{AppConfig.plone_api_url}/delete"
