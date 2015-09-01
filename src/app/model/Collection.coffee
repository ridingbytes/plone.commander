Ext.define  "App.model.Collection",
    extend: "App.model.Node"

    proxy:
        type: "ploneproxy"
        api:
            read    : "#{AppConfig.plone_api_url}/collections"
            create  : "#{AppConfig.plone_api_url}/collections/create"
            update  : "#{AppConfig.plone_api_url}/collections/update"
            destroy : "#{AppConfig.plone_api_url}/collections/delete"
