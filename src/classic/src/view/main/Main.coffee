###*
# This class is the main view for the application. It is specified in app.js as the
# "mainView" property. That setting automatically applies the "viewport"
# plugin causing this view to become the body element (i.e., the viewport).
#
# TODO - Replace this content of this view to suite the needs of your application.
###

Ext.define 'App.view.main.Main',
    extend: 'Ext.tab.Panel'
    xtype: 'app-main'

    requires: [
        'Ext.plugin.Viewport'
        'Ext.panel.Panel'
        'Ext.window.MessageBox'

        'App.view.main.MainController'
        'App.view.main.MainModel'
        'App.view.main.List'

        'App.view.search.SearchController'
        'App.view.search.Search'

        'App.view.settings.SettingsController'
        'App.view.settings.Settings'

        "App.view.login.LoginController"
        "App.view.login.Login"
    ]

    controller: 'main'
    viewModel: 'main'
    ui: 'navigation'
    tabBarHeaderPosition: 1
    titleRotation: 0
    tabRotation: 0
    header:
        layout:
            align: 'stretchmax'
        title:
            bind:
                text: """Plone <br/> Commander<br/>
                    <span id="username" style="font-size:10px">
                        <span class="fa fa-arrow-circle-o-right"></span>
                        {username}
                    </span>
                """
            flex: 0
        iconCls: 'fa-space-shuttle'

    tabBar:
        flex: 1
        layout:
            align: 'stretch'
            overflowHandler: 'none'

    responsiveConfig:
        tall: headerPosition: 'top'
        wide: headerPosition: 'left'

    defaults:
        bodyPadding: 20
        tabConfig:
            plugins: 'responsive'
            responsiveConfig:
                wide:
                    iconAlign: 'left'
                    textAlign: 'left'
                tall:
                    iconAlign: 'top'
                    textAlign: 'center'
                    width: 120

    items: [
        title: 'Search'
        iconCls: 'fa-search'
        items: [
            xtype: 'searchwidget'
        ,
            reference: 'mainlist'
            xtype: 'mainlist'
        ]
    ,
        title: 'Settings'
        iconCls: 'fa-cog'
        items: [
            xtype: 'settings'
        ]
    ,
        title: 'Login'
        iconCls: 'fa-users'
        items: [
            xtype: "panel"
            layout:
                type: "vbox"
                align: "center"
            items: [
                width: 400
                margin: "50% auto"
                xtype: 'login'
            ]
        ]
    ]
