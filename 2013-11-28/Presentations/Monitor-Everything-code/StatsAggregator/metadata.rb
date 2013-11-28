name 'StatsAggregator'
maintainer 'nodejs-meetup-mannheim'
license 'Apache 2.0'
description 'Install a basic box with graphite/carbon to gather and display metrics'
version '0.0.1'

%w{ apt graphite }.each do |c|
  depends c
end
