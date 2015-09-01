Ext.define  "App.view.statusbar.StatusBar",
    extend: "Ext.ux.statusbar.StatusBar"
    alias:  "widget.app-statusbar"

    initComponent: ->
        console.debug "*** StatusBar::initComponent"
        @date = new Date()

        @items = [
            '->'
        ,
            xtype: "component"
            tpl: "API v{version} - build {build} date {date}"
            cls: "x-toolbar-text"
            data:
                version: "-"
                build: "-"
                date: "-"
            loader:
                url: "#{AppConfig.plone_api_url}/version"
                renderer: "data"
                autoLoad: yes
        ,
            "-"
        ,
            xtype: "component"
            tpl: "APP v{version}"
            cls: "x-toolbar-text"
            data:
                version: AppConfig.config.version
        ,
            "-"
        ,
            "&copy; <a href='http://www.ridingbytes.com' target='_blank'>RIDING BYTES</a> #{@date.getFullYear()}"
        ]

        @callParent arguments
