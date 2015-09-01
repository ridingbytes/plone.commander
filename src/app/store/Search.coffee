Ext.define  "App.store.Search",
    extend: "Ext.data.Store"
    model:  "App.model.Node"

    autoLoad: no
    autoSync: yes
    pageSize: AppConfig.getValue "pagesize"

    ### * Proxy Configuration
    ###
    proxy:
        type: "ploneproxy"
        api:
            read    : "#{AppConfig.plone_api_url}/search"
            create  : "#{AppConfig.plone_api_url}/create"
            update  : "#{AppConfig.plone_api_url}/update"
            destroy : "#{AppConfig.plone_api_url}/delete"
