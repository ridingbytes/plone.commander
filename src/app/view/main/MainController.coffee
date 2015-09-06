Ext.define 'App.view.main.MainController',
    extend: 'Ext.app.ViewController'
    alias: 'controller.main'

    init: (view) ->
        console.debug "*** MainViewController::init"
        window.maincontroller = @

        # user changed
        Ext.on "userchange", @onUserChange, @

        @menu = Ext.create "Ext.menu.Menu",
            items: [
                text: 'Open in Explorer'
                iconCls: 'fa fa-external-link'
                handler: @onExpand
                scope: @
            ]

    control:
        mainlist:
            beforeedit: "onBeforeEdit"
            itemcontextmenu: "onItemContextMenu"
            select: "onSelect"

    ###** Methods
    ###
    getSelectedRecords: ->
        return @getGrid().getSelectionModel().getSelection()

    getGrid: ->
        grid = @lookupReference "mainlist"
        return grid

    getTreePanel: ->
        tree = @lookupReference "tree"
        return tree

    getTreeStore: ->
        return Ext.StoreManager.get "PloneTree"

    reloadTree: ->
        # reload the tree panel
        panel = @getTreePanel()
        store = @getTreeStore()
        store.load node:panel.getRootNode()
        console.debug "Reloaded Tree Panel"

    reloadGrid: ->
        # reload the grid panel
        grid = @getGrid()
        grid.store.reload()
        console.debug "Reloaded Grid Panel"

    expand: (record) ->
        @view.setActiveTab "explorer"
        treepanel = @getTreePanel()
        treepanel.getController().expandNode record

    ###** Event Handler
    ###

    onExpand: (record) ->
        console.debug "°°° MainController::onExpand"
        for rec in @getSelectedRecords()
            @expand rec

    onSelect: (grid, record, index, eOpts) ->
        console.debug "°°° MainController::onSelect: #{index}"
        window.current = record

    onItemContextMenu: (view, record, item, index, event, eOpts) ->
        console.debug "°°° MainController::onItemContextMenu: #{record.get 'id'}"
        view.select record
        @menu.showAt(event.getXY())
        event.stopEvent()

    onUserChange: (user) ->
        console.debug "°°° MainViewController::onUserChange: user=", user

        @reloadGrid()

        @reloadTree()

        # set the header
        vm = @getViewModel()
        vm.set "username", user.get "username"
        vm.set "authenticated", user.get "authenticated"
        console.debug ">>> Set data in MainModel"

    onBeforeEdit: (editor, e, eOpts) ->
        console.debug "°°° MainViewController::onBeforeEdit: Row #{e.rowIdx} will be edited"

        # not editable for anonymous users
        return no if UserService.isAnonymous()
