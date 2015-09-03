Ext.define 'App.view.main.List',
    extend: 'Ext.grid.Panel'
    xtype: 'mainlist'

    store: "Search"
    reference: 'contentgrid'

    dockedItems: [
        xtype: 'pagingtoolbar'
        store: 'Search'
        dock: 'bottom'
        displayInfo: true
    ]

    stateId: "plone-contents-grid"
    stateful: yes

    selType: 'rowmodel'
    plugins: [
        ptype: "cellediting"
        clicksToEdit: 1
    ]

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
    ,
        text: 'Created'
        dataIndex: 'created'
        width: 100
        renderer : (value, metaData, record, rowIdx, colIdx, store, view) ->
            renderer = Ext.util.Format.dateRenderer 'd-m-Y'
            return renderer value
    ]
