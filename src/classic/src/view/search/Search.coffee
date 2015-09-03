Ext.define 'App.view.search.Search',
    extend: 'Ext.panel.Panel'
    xtype: 'searchwidget'

    layout:
        type: 'hbox'

    bodyPadding: 10

    controller: 'searchcontroller'

    initComponent: ->
        console.debug '*** SearchWidget::initComponent'
        @callParent arguments

    items: [
        xtype: 'textfield'
        fieldLabel: 'Live Search'
        emptyText: 'Type to search ...'
        enableKeyEvents: yes
        width: 500
        anchor: '100%'
        listeners:
            keyup: 'onKeyUp'
            buffer: 250
    ,
        xtype: 'button'
        text:  'Clear'
        listeners:
            click: 'onClearClick'
    ]
