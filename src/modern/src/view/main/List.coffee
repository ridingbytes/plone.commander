###*
# This view is an example list of people.
###

Ext.define 'App.view.main.List',
    extend: 'Ext.grid.Grid'
    xtype: 'mainlist'
    requires: [
        'App.store.Contents'
    ]

    store: "Contents"

    columns: [
        text: 'ID'
        dataIndex: 'id'
        flex: 1
        hidden:yes
    ,
        text: 'Title'
        dataIndex: 'title'
        flex: 1
        editor:
            xtype: 'textfield'
    ,
        text: 'Description'
        dataIndex: 'title'
        flex: 1
        hidden: yes
        editor:
            xtype: 'textfield'
    ,
        dataIndex: 'url'
        width: 25
        renderer: (value, meta, record, rowIndex, colIndex, store, view) ->
            meta.tdAttr = 'data-qtip="Open in DMS"'
            return """
              <a href="#{value}" style="color:grey;" target="_blank">
                  <span class="fa fa-info-circle"></span>
              </a>
            """
    ,
        text: 'Created'
        dataIndex: 'created'
        width: 100
        renderer : (value, metaData, record, rowIdx, colIdx, store, view) ->
            renderer = Ext.util.Format.dateRenderer 'd-m-Y'
            return renderer value
    ]
