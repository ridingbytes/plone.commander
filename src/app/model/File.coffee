Ext.define  "App.model.File",
    extend: "App.model.Node"

    proxy:
        type: "ploneproxy"
        api:
            read    : "#{AppConfig.plone_api_url}/files"
            create  : "#{AppConfig.plone_api_url}/files/create"
            update  : "#{AppConfig.plone_api_url}/files/update"
            destroy : "#{AppConfig.plone_api_url}/files/delete"
