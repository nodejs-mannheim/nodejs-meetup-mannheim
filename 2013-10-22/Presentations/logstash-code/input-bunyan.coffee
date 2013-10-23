fs = require 'fs'
bunyan = require 'bunyan'
RedisStream = require "./RedisStream"
redisStream = new RedisStream()
http = require 'http'

log = bunyan.createLogger
  name: 'input-bunyan'
  streams: [
    stream: redisStream
    type: 'stream'
    level: 'info'
  ]

url = 'http://developer.usa.gov/1usagov'

data = ''

checkData = ->
  while ((pos = data.indexOf '\n') >= 0)
    if pos is 0
      data = data.slice 1
      continue
    process data.slice 0, pos
    data = data.slice (pos+1)

process = (line) ->
  if line.length > 1
    log.info
      message: 'response'
      response: (JSON.parse line)

req = http.get url, (res) ->
  console.log "requesting… #{url}"
  res.setEncoding 'utf8'
  res.on 'data', (chunk) ->
    console.log 'receiving data…'
    data += chunk
    checkData()
  res.on 'end', ->
    console.log 'end…'
