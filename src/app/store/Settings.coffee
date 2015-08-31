Ext.define  "App.store.Settings",
    extend: "Ext.data.Store"
    model:  "App.model.Setting"

    autoLoad: no
    autoSync: yes

    data:
        items: AppConfig.getSettings()

    reset: ->
        AppConfig.reset()
        @loadRawData {items: AppConfig.getSettings()}

    proxy:
        type: 'memory'
        reader:
            type: 'json'
            rootProperty: 'items'
