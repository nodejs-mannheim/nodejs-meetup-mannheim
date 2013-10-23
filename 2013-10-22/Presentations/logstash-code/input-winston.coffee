fs = require 'fs'
winston = require 'winston'
require 'winston-redis'
http = require 'http'

redisOptions =
  host: 'localhost'
  port: 6379
  container: 'logstash:winston'
  channel: 7

winston.add winston.transports.Redis, redisOptions

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
    winston.log 'info', 'response', response: (JSON.parse line)

req = http.get url, (res) ->
  console.log "requesting… #{url}"
  res.setEncoding 'utf8'
  res.on 'data', (chunk) ->
    console.log 'receiving data…'
    data += chunk
    checkData()
  res.on 'end', ->
    console.log 'end…'
