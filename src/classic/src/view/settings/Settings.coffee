Ext.define  "App.view.settings.Settings",
    extend: "Ext.grid.Panel"
    alias:  "widget.settings"

    store:  "Settings"
    controller: "settings"

    title: "Global Application Settings"
    emptyText: "No Settings"
    bodyPadding: "10 0"

    selType: 'rowmodel'
    plugins: [
        ptype: "cellediting"
        clicksToEdit: 1
    ]

    tools:[
        type:'refresh'
        tooltip: 'Refresh Application'
        handler: "onRefresh"
    ]

    initComponent: ->
        console.debug "*** Settings::initComponent"
        @callParent arguments

    columns: [
        text:      "Key"
        dataIndex: "key"
        flex: 2
    ,
        text:      "Value"
        dataIndex: "value"
        flex: 4
        getEditor: (record) ->
            field = null
            switch Ext.typeOf record.get "value"
                when "number"  then field = Ext.create "Ext.form.field.Number"
                when "date"    then field = Ext.create "Ext.form.field.Date"
                when "boolean" then field = Ext.create "Ext.form.field.Checkbox"
                when "string"  then field = Ext.create "Ext.form.field.Text"
                else field = Ext.create "Ext.form.field.Display"
            return Ext.create 'Ext.grid.CellEditor',
                field: field
    ,
        text:      "Description"
        dataIndex: "description"
        flex: 4
    ]

    buttons: [
        xtype: "button"
        text:   "Reset default Settings"
        action: "reset"
        tooltip: "Reset to default Settings"
        listeners:
            click: "onReset"
    ]
