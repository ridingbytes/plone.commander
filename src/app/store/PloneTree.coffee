Ext.define  "App.store.PloneTree",
    extend: "Ext.data.TreeStore"
    model:  "App.model.Node"

    autoLoad: yes
    autoSync: yes
    defaultRootId: "Plone"
