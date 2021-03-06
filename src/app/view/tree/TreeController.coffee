Ext.define "App.view.tree.TreeController",
    extend: "Ext.app.ViewController"
    alias: "controller.tree"

    init: (view) ->
        console.debug "*** TreeController::init"

        window.treecontroller = @

        # view events
        view.on "nodeopen", @onOpen, @
        view.on "nodeselect", @onSelect, @
        view.on "itemcontextmenu", @onItemContextMenu, @
        view.on "beforeedit", @onBeforeEdit, @

        # store events
        view.store.on "write", @onWrite, @

        @menu = Ext.create "Ext.menu.Menu",
            items: [
                #text: 'Refresh'
                #iconCls: 'fa fa-refresh'
                #handler: @onRefresh
                #scope: @
            #,
                text: 'View'
                iconCls: 'fa fa-eye'
                handler: @onView
                scope: @
            ,
                text: 'New Folder'
                iconCls: 'fa fa-folder'
                handler: @onNewFolder
                scope: @
            ,
                text: 'Cut'
                iconCls: 'fa fa-scissors'
                handler: @onCut
                scope: @
            ,
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

    expandNode: (record) ->
        # Expand the given record by the physical path
        path = record.getPath()
        @view.expandPath path,
            field: "id"
            select: yes

    getSelectedRecords: ->
        return @view.getSelectionModel().getSelection()

    getRootNode: ->
        return @view.getRootNode()

    cut: (record) ->
        Ext.Ajax.request
            url: "#{AppConfig.plone_api_url}/cut/#{record.get 'uid'}"
            scope: @
            method: "GET"
            callback: (options, success, response) ->
                console.debug "cutted..."

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
                @refresh record

    refresh: (record) ->
        store = @view.store

        parent = record.parentNode
        if parent is null
            parent = record

        # refresh the node
        store.load
            node: parent
            callback: (loadedNodes, operation, success) ->
                console.debug "*node refreshed*"
                parent.expand()
                #for node in loadedNodes
                    #node.expand()

    viewInPlone: (record) ->
        url = record.data.url
        window.open url

    newFolder: (record) ->
        folder = Ext.create "App.model.Folder",
            id: "New Folder"
            parent_uid: record.get "uid"
        folder.save
            success: (rec, operation) ->
                record.appendChild rec

    delete: (record) ->
        Ext.MessageBox.show
            title: "Confirm Delete"
            msg: "Are you sure you want to delete #{record.get('title')}?"
            buttons: Ext.MessageBox.YESNO
            fn: (btn) ->
                if btn is "yes"
                    # avoid delete requests for contained childnodes,
                    # since these contained items are deleted by Plone anyway
                    record.childNodes = []
                    record.remove()

            icon: Ext.MessageBox.QUESTION
            scope: @

    ### * Event handlers
    ###

    onWrite: (store, operation, eOpts) ->
        console.debug "°°° TreeController::onWrite: sync ..."
        if operation.action is "destroy"
            return
        for record in operation.getRecords()
            console.debug "Refreshing node #{record.data.id}"
            @refresh record

    onOpen: (record) ->
        console.debug "°°° TreeController::onOpen: #{record.get 'id'}"
        #console.debug "portal_type=#{record.get 'portal_type'}"
        #console.debug "class=#{record.$className}"

    onSelect: (record) ->
        console.debug "°°° TreeController::onSelect: #{record.get 'id'}"
        #console.debug "portal_type=#{record.get 'portal_type'}"
        #console.debug "class=#{record.$className}"
        window.current = record

    onItemContextMenu: (view, record, item, index, event) ->
        console.debug "°°° TreeController::onItemContextMenu: #{record.get 'id'}"
        view.select record
        @menu.showAt(event.getXY())
        event.stopEvent()

    onBeforeEdit: (editor, e, eOpts) ->
        console.debug "°°° TreeController::onBeforeEdit"

        # not editable for anonymous users
        return no if UserService.isAnonymous()

        record = e.record

        # root is read only
        if record.isRoot()
            return no

        # inject transitions for this specific record
        if e.field == "transition"
            combo = e.column.getEditor()
            record = e.record
            transitions = record.getTransitions()
            return no unless transitions
            combo.store.loadData transitions


    onCut: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onCut"

        for rec in @getSelectedRecords()
            return no if rec.isRoot()
            @cut rec

    onCopy: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onCopy"

        for rec in @getSelectedRecords()
            return no if rec.isRoot()
            @copy rec

    onPaste: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onPaste"

        for rec in @getSelectedRecords()
            #return no if rec.isRoot()
            @paste rec

    onRefresh: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onRefresh"

        for rec in @getSelectedRecords()
            console.debug "Refreshing node index #{rec.data.index}"
            @refresh rec

    onView: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onView"

        for rec in @getSelectedRecords()
            @viewInPlone rec

    onNewFolder: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onNewFolder"

        for rec in @getSelectedRecords()
            @newFolder rec

    onDelete: (btn, evt, eOpts)  ->
        console.debug "°°° TreeController::onDelete"

        for rec in @getSelectedRecords()
            if rec.isRoot()
                console.warn "Can not delete root node"
                return no
            @delete rec
