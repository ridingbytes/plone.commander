Ext.define  "App.view.tree.Tree",
    extend: "Ext.tree.Panel"
    alias:  "widget.tree"

    store: "PloneTree"
    controller: "tree"
    rootVisible: no
    useArrows: true

    selModel:
        mode: "SINGLE"

    viewConfig:
        listeners:
            cellclick: (table, td, cellIndex, record, tr, rowIndex, e, eOpts) ->
                @ownerCt.fireEvent "nodeselect", record
            celldblclick: (table, td, cellIndex, record, tr, rowIndex, e, eOpts) ->
                @ownerCt.fireEvent "nodeopen", record

    initComponent: ->
        console.debug "*** Tree::initComponent"

        Ext.applyIf @,
            columns:
                defaults:
                    sortable: no
                items: [
                    xtype: 'treecolumn'
                    text: 'ID'
                    flex: 1
                    dataIndex: 'id'
                ,
                    text: 'Title'
                    dataIndex: 'title'
                ,
                    text: 'State'
                    dataIndex: 'state'
                ]

        @callParent arguments
