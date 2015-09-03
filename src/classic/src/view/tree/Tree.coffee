Ext.define  "App.view.tree.Tree",
    extend: "Ext.tree.Panel"
    alias:  "widget.tree"

    store: "PloneTree"
    controller: "tree"
    rootVisible: yes
    useArrows: yes
    animate: no

    selModel:
        mode: "SINGLE"

    selType: 'rowmodel'
    plugins: [
        ptype: "cellediting"
        clicksToEdit: 1
    #,
        #ptype: 'bufferedrenderer'
        #trailingBufferZone: 30
        #leadingBufferZone: 50
    ]

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
                    text: 'State'
                    dataIndex: 'state'
                ]

        @callParent arguments
