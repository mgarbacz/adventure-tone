env = switch window.location.hostname
  when "localhost", "127.0.0.1"
    "development"
  when "adventure-tone.michgarbacz.com"
    "production"

config =
  development:
    socket: 'localhost:8888'
  production:
    socket: 'adventure-tone.herokuapp.com'

module.exports = config[env]
