module.exports = (grunt) ->
    grunt.initConfig
        coffee:
            main:
                expand: true
                flatten: false
                cwd: 'src'
                src: ['*.coffee']
                dest: 'js'
                ext: '.js'

        connect:
            server:
                options:
                    port: 8080
                    keepalive: true
                    base: './'

        watch:
            coffee:
                files: [
                    'src/**/*.coffee'
                ]
                tasks: ['coffee']

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-watch'
