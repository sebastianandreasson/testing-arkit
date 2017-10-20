const express = require('express')
const app = express()
const http = require('http').Server(app)
const io = require('socket.io')(http)

http.listen(1339, () => {
  console.log(`Listening on port 1339`)
})


io.on('connection', socket => {
  console.log('socket connected', socket)

  socket.on('message', console.log)
})
