Ext.define  "App.store.PloneTree",
    extend: "Ext.data.TreeStore"
    model:  "App.model.Node"

    autoLoad: no
    autoSync: yes

    constructor: (config) ->
        @callParent arguments
        root = Ext.create "App.model.PloneSite",
            uid: 0
            loaded: yes
        root.load()
        @setRoot root
