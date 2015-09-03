Ext.define  "App.model.PloneSite",
    extend: "App.model.Node"
    childType: "App.model.Node"

    proxy:
        type: "ploneproxy"
        extraParams:
            children: yes
            typeProperty: "portal_type"
        api:
            read: "#{AppConfig.plone_api_url}/plonesites"
