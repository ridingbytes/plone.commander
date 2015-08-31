Ext.define "App.model.User",
    extend: "Ext.data.Model"

    idProperty: "id"

    fields: [
        name: "id"
        type: "string"
    ,
        name: "username"
        type: "string"
    ,
        name: "fullname"
        type: "string"
    ,
        name: "email"
        type: "string"
    ,
        name: "url"
        type: "string"
    ,
        name: "roles"
        type: "auto"
    ,
        name: "groups"
        type: "auto"
    ,
        name: "authenticated"
        type: "boolean"
    ,
        name: "last_login_time"
        type: "date"
        dateFormat: "c"
    ,
        name: "login_time"
        type: "date"
        dateFormat: "c"
    ]

    proxy:
        type: "ploneproxy"
        url: "#{AppConfig.plone_api_url}/users"
        reader:
            type: "json"
            rootProperty: "items"
            totalProperty: "count"
            messageProperty: "message"
