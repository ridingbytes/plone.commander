Ext.define  "App.model.Image",
    extend: "App.model.Node"

    proxy:
        type: "ploneproxy"
        api:
            read    : "#{AppConfig.plone_api_url}/images"
            create  : "#{AppConfig.plone_api_url}/images/create"
            update  : "#{AppConfig.plone_api_url}/images/update"
            destroy : "#{AppConfig.plone_api_url}/images/delete"
