# Build the contents of grid - 16x16
grid = document.getElementById 'grid'
# Need 16 rows of boxes
for row in [0..15]
  grid_row = document.createElement 'div'
  grid_row.id = 'grid-row-' + row
  # Need 16 boxes per row
  for col in [0..15]
    grid_box = document.createElement 'div'
    grid_box.className = 'grid-box'
    grid_box.id = 'grid-row-' + row + '-col-' + col
    grid_row.appendChild grid_box
  grid.appendChild grid_row

# Boxes need visual feedback for on/off, done via class change
toggleGrid = (target_id) ->
  target = document.getElementById target_id
  if target.className is 'grid-box'
    target.className = 'grid-box clicked'
  else target.className = 'grid-box'

# Clicking on a box triggers a socket event and visual feedback
grid.addEventListener 'click', (e) ->
  socket.emit 'grid click', { element: e.toElement.id }
  toggleGrid e.toElement.id

socket = io.connect '//localhost:8888/tones'

socket.on 'connect', ->

  # TODO - refactor into useful connection event
  socket.on 'greeting', (data) ->
    console.log data
  socket.emit 'greeting', { greeting: 'Hi server!' }

  # Event for grid clicks from other clients
  socket.on 'grid click', (data) ->
    toggleGrid data.element
