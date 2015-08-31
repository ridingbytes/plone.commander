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

    ###** Getter
    ###

    getGrid: ->
        grid = @lookupReference "mainlist"
        return grid

    ###** Even Handler
    ###

    onUserChange: (user) ->
        console.debug "°°° MainViewController::onUserChange: user=", user

        # reload the grid
        grid = @getGrid()
        grid.store.reload()
        console.debug ">>> Reload the grid store"

        # set the header
        vm = @getViewModel()
        vm.set "username", user.get "username"
        vm.set "authenticated", user.get "authenticated"
        console.debug ">>> Set data in MainModel"
        window.vm = vm

    onBeforeEdit: (editor, e, eOpts) ->
        console.log "°°° MainViewController::onBeforeEdit: Row #{e.rowIdx} will be edited"
        model = e.record
        user = UserService.get_user()

        if not user then return no
        if not user.get "authenticated" then return no
        #if "Manager" not in user.get "roles" then return no

