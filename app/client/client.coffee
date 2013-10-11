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

grid.addEventListener 'click', (e) ->
  console.log(e.toElement.id)
  target = document.getElementById e.toElement.id
  if target.className is 'grid-box'
    target.className = 'grid-box clicked'
  else target.className = 'grid-box'

socket = io.connect '//localhost:8888/tones'

socket.on 'connect', ->
  socket.on 'greeting', (data) ->
    console.log data
  socket.emit 'greeting', { greeting: 'Hi server!' }
