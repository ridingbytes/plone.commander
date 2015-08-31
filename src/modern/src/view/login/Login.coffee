Ext.define "App.view.login.Login",
    extend: "Ext.form.Panel"
    alias:  "widget.login"


    controller: "login"
    #viewModel:
    #    type: "login"

    config:
        title: "Authenticate"
        scrollable: null

        items: [
            xtype: "fieldset"
            items: [
                xtype: "textfield"
                name: "__ac_name"
                label: "Username"
                allowBlank: false
                bind:
                    value: "{__ac_name}"
            ,
                xtype: 'textfield'
                name: "__ac_password"
                inputType: 'password'
                label: 'Password'
                allowBlank: false
                bind:
                    value: "{__ac_password}"
            ,
                xtype: 'checkboxfield'
                label: "Remember my credentials"
                name: 'remember'
                reference: "doRemember"
                listeners:
                    change: "onRemember"
            ]
        ]

#    buttons: [
#        text: 'Login'
#        formBind: yes
#        listeners:
#            click: 'onLoginClick'
#     ]
