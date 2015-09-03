Ext.define  "App.view.tree.Tree",
    extend: "Ext.tree.Panel"
    alias:  "widget.tree"

    store: "PloneTree"
    controller: "tree"
    rootVisible: yes
    useArrows: yes
    animate: no

    layout:
        type: "fit"

    selModel:
        mode: "SINGLE"

    selType: 'rowmodel'
    plugins: [
        ptype: "cellediting"
        clicksToEdit: 1
    ]

    viewConfig:
        listeners:
            cellclick: (table, td, cellIndex, record, tr, rowIndex, e, eOpts) ->
                @ownerCt.fireEvent "nodeselect", record
            celldblclick: (table, td, cellIndex, record, tr, rowIndex, e, eOpts) ->
                @ownerCt.fireEvent "nodeopen", record


    initComponent: ->
        console.debug "*** Tree::initComponent"

        @dockedItems = [
            xtype: 'toolbar'
            dock:  'top'

            items: [
                text: 'Expand All'
                handler: ->
                    @expandAll()
                scope: @
            ,
                text: 'Collapse All'
                handler: ->
                    @collapseAll()
                scope: @
            ]
        ]

        Ext.applyIf @,
            columns:
                defaults:
                    sortable: no
                items: [
                    xtype: 'treecolumn'
                    text: 'ID'
                    flex: 1
                    dataIndex: 'id'
                    editor:
                        xtype: 'textfield'
                        validator: (value) ->
                            rx = new RegExp /[A-Za-z0-9]/g
                            if rx.test value
                                return yes
                            return "Only ASCII characters are allowed for the ID"
                ,
                    dataIndex: 'url'
                    width: 25
                    renderer: (value, meta, record, rowIndex, colIndex, store, view) ->
                        meta.tdAttr = 'data-qtip="Open in Plone"'
                        return """
                          <a href="#{value}" style="color:grey;" target="_blank">
                              <span class="fa fa-info-circle"></span>
                          </a>
                        """
                ,
                    text: 'Title'
                    dataIndex: 'title'
                    editor:
                        xtype: 'textfield'
                ,
                    text: "Status"
                    tooltip: "Click on a cell to change the current status"
                    dataIndex: 'transition'
                    getSortParam: ->
                        return "state"
                    renderer: (value, meta, record, rowIndex, colIndex, store, view) ->
                        status = record.data.state
                        if not status? then return
                        if UserService.isAnonymous() then return status
                        meta.tdAttr = 'data-qtip="Click to change the status"'
                        return """
                          <span class="fa fa-pencil"></span>
                          &nbsp;
                          #{status}
                        """
                    editor:
                        xtype: 'combo'
                        displayField: "value"
                        valueField: "value"
                        queryMode: "local"
                        typeAhead: yes
                        editable: yes
                        forceSelection: yes
                        store: Ext.create "Ext.data.Store",
                            fields: ["value", "value"]
                            data: []
                        listeners:
                            select: (combo, records, eOpts) ->
                                console.debug "Do Transition #{combo.getValue()}"
                                col = @up()
                                col.editingPlugin.completeEdit()
                ]

        @callParent arguments