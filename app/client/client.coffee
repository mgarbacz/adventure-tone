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
toggleGrid = (target_id, sender) ->
  # TODO - fix this messy logic
  proper_class = 'grid-box ' + sender + '-clicked'
  target = document.getElementById target_id
  if target.className is 'grid-box'
    target.className = proper_class
  else if target.className is proper_class
    target.className = 'grid-box'
  else if sender is 'client'
    if target.className is 'grid-box other-clicked client-clicked'
      target.className = 'grid-box other-clicked'
    else if target.className is 'grid-box other-clicked'
      target.className = 'grid-box other-clicked client-clicked'
    else
      target.className = 'grid-box client-clicked'
  else if sender is 'other'
    if target.className is 'grid-box client-clicked'
      target.className = 'grid-box other-clicked client-clicked'
    else if target.className is 'grid-box other-clicked client-clicked'
      target.className = 'grid-box client-clicked'
    else
      target.className = 'grid-box other-clicked'

# Clicking on a box triggers a socket event and visual feedback
grid.addEventListener 'click', (e) ->
  socket.emit 'grid click', { element: e.toElement.id, sender: 'other' }
  toggleGrid e.toElement.id, 'client'

socket = io.connect '//localhost:8888/tones'

socket.on 'connect', ->

  # TODO - refactor into useful connection event
  socket.on 'greeting', (data) ->
    console.log data
  socket.emit 'greeting', { greeting: 'Hi server!' }

  # Sync to current grid state
  socket.on 'grid status', (data) ->
    toggleGrid click.element, click.sender for click in data.clicks

  # Event for grid clicks from other clients
  socket.on 'grid click', (data) ->
    toggleGrid data.element, data.sender
