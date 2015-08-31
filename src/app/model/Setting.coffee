Ext.define 'App.model.Setting',
    extend: 'Ext.data.Model'
    alias:  'model.setting'

    idProperty: "key"

    fields: [
        name: "key"
        type: "string"
    ,
        name: "value"
        type: "auto"
    ,
        name: "description"
        type: "string"
    ,
        name: "description"
        type: "string"
    ,
        name: "type"
        type: "string"
    ]
