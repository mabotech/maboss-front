
gulp = require("gulp")

uglify = require("gulp-uglify")
plumber = require("gulp-plumber")
coffee = require("gulp-coffee")
concat = require("gulp-concat")

sourcemaps = require('gulp-sourcemaps')

paths = {}
paths.app = "app/"
paths.dist = "dist/"

paths.tmp = "tmp/"

paths.coffee = [
    paths.app + "coffee/app.coffee",
    paths.app + "coffee/*.coffee" ]
    
gulp.task "coffee", ->
    gulp.src(paths.coffee)
        .pipe(plumber())
        .pipe(coffee())
        .pipe(concat("app.js"))
        .pipe(gulp.dest(paths.tmp))
        
gulp.task "app-copy", ["coffee"], ->
    gulp.src("tmp/*.js")
        .pipe(gulp.dest(paths.dist + "js/"))

        
gulp.task "app-deploy", ["coffee"], ->
    _paths = [
        paths.tmp + "app.js"
    ]

    gulp.src(_paths)
        .pipe(sourcemaps.init())
            .pipe(concat("app.js"))
            .pipe(uglify({mangle:false, preserveComments: false}))
        .pipe(sourcemaps.write('./'))
        .pipe(gulp.dest(paths.dist + "js/"))
        
gulp.task "default", [
    "app-copy"
]