name 'StatsEmitter'
maintainer 'nodejs-meetup-mannheim'
license 'Apache 2.0'
description 'Install a basic box that emits stats via statsd'
version '0.0.1'

%w{ apt basic-stats statsd }.each do |c|
  depends c
end
