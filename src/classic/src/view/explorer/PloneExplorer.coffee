Ext.define  "App.view.explorer.PloneExplorer",
    extend: "Ext.tree.Panel"
    alias:  "widget.plone-explorer"

    store: "PloneTree"
    controller: "plone-explorer"
    rootVisible: no
    useArrows: true

    selModel:
        mode: "SINGLE"

    viewConfig:
        listeners:
            cellclick: (table, td, cellIndex, record, tr, rowIndex, e, eOpts) ->
                debugger
                @ownerCt.fireEvent "nodeselect", record
            celldblclick: (table, td, cellIndex, record, tr, rowIndex, e, eOpts) ->
                @ownerCt.fireEvent "nodeopen", record

    initComponent: ->
        console.debug "*** PloneExplorerView::initComponent"

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
