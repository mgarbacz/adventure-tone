exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  paths:
    public: 'public'
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app/

    stylesheets:
      joinTo:
        'ss/app.css': /^app\/styles/

  plugins:
    sass:
      debug: 'comments'
      
  sourceMaps: false

