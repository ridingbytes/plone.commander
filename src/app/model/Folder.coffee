Ext.define  "App.model.Folder",
    extend: "App.model.Node"

    proxy:
        type: "ploneproxy"
        api:
            read    : "#{AppConfig.plone_api_url}/folders"
            create  : "#{AppConfig.plone_api_url}/folders/create"
            update  : "#{AppConfig.plone_api_url}/folders/update"
            destroy : "#{AppConfig.plone_api_url}/folders/delete"

