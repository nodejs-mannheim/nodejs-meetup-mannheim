redis = require 'redis'
stream = require 'stream'

module.exports = class RedisStream extends stream.Writable

  redisClient: null

  constructor: ->
    console.log 'initialize RedisStream'
    @writable = true
    @redisClient = redis.createClient()

  write: (chunk, encoding, cb) ->
    @logToRedis chunk
    cb() if cb?
    true
  
  logToRedis: (msg) ->
    @redisClient.select 6, =>
      @redisClient.rpush 'logstash:bunyan', msg
