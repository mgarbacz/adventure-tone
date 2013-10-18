exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  paths:
    public: 'public/client'
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app\/client/

    stylesheets:
      joinTo:
        'ss/app.css': /^app\/styles/

  plugins:
    sass:
      debug: 'comments'
      
  sourceMaps: false

