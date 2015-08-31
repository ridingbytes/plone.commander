module.exports = (grunt) ->

    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'

        "build-atom-shell":
            tag: 'v0.30.0'
            buildDir: 'electron'
            projectName: 'dms.webapp'
            productName: 'DMS'

        connect:
            server:
                options:
                    port: 8000
                    hostname: '*'
                    base: 'static'
                    livereload: yes

        coffee:
            compile:
                expand: yes
                cwd: "src"
                src:  ["**/*.coffee"]
                dest: "static"
                ext: ".js"

        #sass:
        #    dev:
        #        options:
        #            style: "expanded"
        #        files:
        #            # 'destination': 'source'
        #            "static/classic/sass/**/*": "src/classic/sass/**/*"

        copy:
            sass_classic:
                expand: yes
                cwd: "src/classic/sass"
                src: ["**"]
                dest: "static/classic/sass"

            sass_modern:
                expand: yes
                cwd: "src/modern/sass"
                src: ["**"]
                dest: "static/modern/sass"

        watch:
            src:
                files: ["src/**/*.coffee"]
                tasks: ["coffee"]
                options:
                    livereload: yes

            sass:
                files: ["src/**/*.scss"]
                tasks: ['copy:sass_classic', 'copy:sass_modern']
                options:
                    livereload: yes

    # dependencies
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-build-atom-shell'

    # tasks
    grunt.registerTask 'default', ["coffee", "copy", "watch"]
