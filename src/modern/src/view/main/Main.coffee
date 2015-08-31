###*
# This class is the main view for the application. It is specified in app.js as the
# "mainView" property. That setting causes an instance of this class to be created and
# added to the Viewport container.
#
# TODO - Replace this content of this view to suite the needs of your application.
###

Ext.define 'App.view.main.Main',
    extend: 'Ext.tab.Panel'
    xtype: 'app-main'

    requires: [
        'Ext.MessageBox'
        'App.view.main.MainController'
        'App.view.main.MainModel'
        'App.view.main.List'

        "App.view.login.LoginController"
        'App.view.login.Login'
    ]

    controller: 'main'
    viewModel: 'main'
    defaults:
        tab: iconAlign: 'top'
        styleHtmlContent: true
    tabBarPosition: 'bottom'

    items: [
        title: 'Files'
        iconCls: 'x-fa fa-files-o'
        layout: 'fit'
        items: [
            xtype: 'mainlist'
        ]
    ,
        title: 'Login'
        iconCls: 'x-fa fa-users'
        items: [
            xtype: 'login'
        ]
    ]
