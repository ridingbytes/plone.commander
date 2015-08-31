Ext.define  "App.store.Contents",
    extend: "Ext.data.Store"
    alias:  "store.contents"
    model:  "App.model.Content"

    autoLoad: yes
    autoSync: yes
    pageSize: AppConfig.getValue "pagesize"
