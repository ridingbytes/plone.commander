Ext.define  "App.lib.Proxy",
    # note: we extend from the `Ext.data.proxy.Rest` so that we can use the
    # static `load` method of the models. This ensures to build the url
    # correct - see `buildUrl` http://docs.sencha.com/extjs/4.2.2/source/Rest.html#Ext-data-proxy-Rest
    extend: "Ext.data.proxy.Rest"
    alias:  "proxy.ploneproxy"

    url: "#{AppConfig.plone_api_url}"

    # set global timeout to 5 minutes
    timeout: 300000

    # only one `sort` and on `dir` parameter in request
    simpleSortMode: yes

    startParam: "b_start"
    extraParams:
        complete: yes

    actionMethods:
        read   : 'GET'
        create : 'POST'
        update : 'POST'
        destroy: 'POST'

    buildRequest: (operation) ->
        request = @callParent arguments
        if operation.sorters and operation.sorters.length > 0
            # we need to map the sorters to the Plone index names
            sorter = operation.sorters[0]
        return request

    reader:
        type: "json"
        rootProperty: "items"
        totalProperty: "count"
        messageProperty: "message"
