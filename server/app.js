const http = require('http').Server(app)
const io = require('socket.io')(http)
routes(app, io)

http.listen(1339, () => {
  console.log(`Listening on port ${port}`)
})


io.on('connection', socket => {
  socket.on('message', console.log)
})
