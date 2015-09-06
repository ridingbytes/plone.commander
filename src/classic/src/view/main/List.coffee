Ext.define 'App.view.main.List',
    extend: 'Ext.grid.Panel'
    xtype: 'mainlist'

    store: "Search"
    reference: 'contentgrid'
    controller: 'searchcontroller'
    title: "Live Search"

    stateId: "plone-contents-grid"
    stateful: yes

    selType: 'rowmodel'
    plugins: [
        ptype: "cellediting"
        clicksToEdit: 1
    ]

    initComponent: ->
        console.debug "*** List::initComponent"

        @tools = [
            type: 'refresh'
            tooltip: 'Refresh'
            callback: (panel) ->
                console.debug "REFRESH"
                panel.store.reload()
        ]

        @dockedItems = [
            xtype: 'searchwidget'
            dock: 'top'
        ,
            xtype: 'pagingtoolbar'
            store: 'Search'
            dock: 'bottom'
            displayInfo: true
        ]

        Ext.applyIf @,
            columns: [
                text: 'ID'
                dataIndex: 'id'
                flex: 1
                editor:
                    xtype: 'textfield'
            ,
                text: 'Title'
                dataIndex: 'title'
                flex: 1
                editor:
                    xtype: 'textfield'
            ,
                text: 'Description'
                dataIndex: 'description'
                flex: 2
                editor:
                    xtype: 'textfield'
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
                text: 'Type'
                dataIndex: 'portal_type'
                width: 100
            ]

        @callParent arguments
