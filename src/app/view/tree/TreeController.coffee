Ext.define "App.view.tree.TreeController",
    extend: "Ext.app.ViewController"
    alias: "controller.tree"

    init: (view) ->
        console.debug "*** TreeController::init"

        # custom events fired by the tree panel
        view.on "nodeopen", @onOpen
        view.on "nodeselect", @onSelect
        view.on "itemcontextmenu", @onItemContextMenu, @

        @menu = Ext.create "Ext.menu.Menu",
            items: [
                text: 'Copy'
                iconCls: 'fa fa-files-o'
                handler: @onCopy
                scope: @
            ,
                text: 'Paste'
                iconCls: 'fa fa-clipboard'
                handler: @onPaste
                scope: @
            ,
                scope: @
                text: 'Delete'
                iconCls: 'fa fa-trash-o'
                handler: @onDelete
                scope: @
            ]


    ### * Methods
    ###

    copy: (record) ->
        Ext.Ajax.request
            url: "#{AppConfig.plone_api_url}/copy/#{record.get 'uid'}"
            scope: @
            method: "GET"
            callback: (options, success, response) ->
                console.debug "copied..."

    paste: (record) ->
        Ext.Ajax.request
            url: "#{AppConfig.plone_api_url}/paste/#{record.get 'uid'}"
            scope: @
            method: "GET"
            callback: (options, success, response) ->
                console.debug "pasted..."
                store = record.getTreeStore()
                store.reload()

    getSelectedRecords: ->
        return @view.getSelectionModel().getSelection()

    confirmAndDelete: (record) ->

        Ext.MessageBox.show
            title: "Confirm Delete"
            msg: "Are you sure you want to delete #{record.get('title')}?"
            buttons: Ext.MessageBox.YESNO
            fn: (btn) ->
                if btn is "yes"
                    store = record.getTreeStore()
                    record.remove()
                    store.sync()
            icon: Ext.MessageBox.QUESTION
            scope: @


    ### * Event handlers
    ###

    onOpen: (record) ->
        console.debug "°°° TreeController::onOpen: #{record.get 'id'}"
        console.debug "portal_type=#{record.get 'portal_type'}"
        console.debug "class=#{record.$className}"

    onSelect: (record) ->
        console.debug "°°° TreeController::onSelect: #{record.get 'id'}"
        console.debug "portal_type=#{record.get 'portal_type'}"
        console.debug "class=#{record.$className}"

    onItemContextMenu: (view, record, item, index, event) ->
        console.debug "°°° TreeController::onItemContextMenu: #{record.get 'id'}"
        view.select record
        @menu.showAt(event.getXY())
        event.stopEvent()

    onCopy: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onCopy"

        for rec in @getSelectedRecords()
            return no if rec.isRoot()
            @copy rec

    onPaste: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onPaste"

        for rec in @getSelectedRecords()
            return no if rec.isRoot()
            @paste rec

    onDelete: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onDelete"

        for rec in @getSelectedRecords()
            return no if rec.isRoot()
            @confirmAndDelete rec
