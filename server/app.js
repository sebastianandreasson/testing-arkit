const express = require('express')
const app = express()
const http = require('http').Server(app)
const io = require('socket.io')(http)

http.listen(1339, () => {
  console.log(`Listening on port 1339`)
})

let sockets = []

io.on('connection', socket => {
  sockets.push(socket)

  console.log('socket connected', sockets.length)

  socket.on('message', console.log)
  socket.on('object', data => {
    console.log('socket.on', data)
    sockets.forEach(s => {
      if (s !== socket) {
        s.emit('object', data)
      }
    })
  })

  socket.on('disconnect', () => {
    sockets = sockets.filter(s => {
      return s !== socket
    })
    console.log('socket disconnected', sockets.length)
  })
})
