grid = document.getElementById 'grid'
for row in [0..15]
  grid_row = document.createElement 'div'
  grid_row.id = 'grid-row-' + row
  for col in [0..15]
    grid_box = document.createElement 'div'
    grid_box.className = 'grid-box'
    grid_box.id = 'grid-row-' + row + '-col-' + col
    grid_row.appendChild grid_box
  grid.appendChild grid_row

toggleGrid = (target_id) ->
  target = document.getElementById target_id
  if target.className is 'grid-box'
    target.className = 'grid-box clicked'
  else target.className = 'grid-box'

grid.addEventListener 'click', (e) ->
  socket.emit 'grid click', { element: e.toElement.id }
  toggleGrid e.toElement.id

socket = io.connect '//71.229.75.163:8888/tones'

socket.on 'connect', ->
  socket.on 'greeting', (data) ->
    console.log data
  socket.emit 'greeting', { greeting: 'Hi server!' }
  socket.on 'grid click', (data) ->
    toggleGrid data.element
