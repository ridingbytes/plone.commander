# This view uses the main model
Ext.define "App.view.login.Login",
    extend: "Ext.form.Panel"
    alias:  "widget.login"

    title: "Authenticate"
    bodyPadding: "10 0"

    controller: "login"

    defaults:
        anchor: "100%"

    items: [
        xtype: "textfield"
        name: "__ac_name"
        fieldLabel: "Username"
        allowBlank: false
        bind:
            value: "{__ac_name}"
            disabled: '{authenticated}'
    ,
        xtype: 'textfield'
        name: "__ac_password"
        inputType: 'password'
        fieldLabel: 'Password'
        allowBlank: false
        bind:
            value: "{__ac_password}"
            disabled: '{authenticated}'
    ,
        xtype: 'checkbox'
        boxLabel: "Remember my credentials"
        name: 'remember'
        reference: "doRemember"
        listeners:
            change: "onRemember"
        bind:
            disabled: '{authenticated}'
    ]

    buttons: [
        text: 'Login'
        formBind: yes
        listeners:
            click: 'onLoginClick'
        bind:
            hidden: '{authenticated}'
      ,
        text: 'Logout'
        listeners:
            click: 'onLogoutClick'
        bind:
            hidden: '{!authenticated}'
     ]
