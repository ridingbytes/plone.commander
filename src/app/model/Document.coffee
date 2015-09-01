Ext.define  "App.model.Document",
    extend: "App.model.Node"

    fields: [
        name: "text"
        type: "string"
    ]

    proxy:
        type: "ploneproxy"
        api:
            read    : "#{AppConfig.plone_api_url}/documents"
            create  : "#{AppConfig.plone_api_url}/documents/create"
            update  : "#{AppConfig.plone_api_url}/documents/update"
            destroy : "#{AppConfig.plone_api_url}/documents/delete"
