Ext.define 'App.view.main.MainController',
    extend: 'Ext.app.ViewController'
    alias: 'controller.main'

    init: (view) ->
        console.debug "*** MainViewController::init"
        window.maincontroller = @
        Ext.on "userchange", @onUserChange, @

    control:
        mainlist:
            beforeedit: "onBeforeEdit"

    ###** Methods
    ###

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

    ###** Event Handler
    ###

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
        console.log "°°° MainViewController::onBeforeEdit: Row #{e.rowIdx} will be edited"

        # not editable for anonymous users
        return no if UserService.isAnonymous()
