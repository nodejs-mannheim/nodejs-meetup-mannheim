# How to run?

## Required

It's required to have a working
[vagrant installation](http://www.vagrantup.com)
either with vmware or virtualbox (I only tested it with vmware,
but getting it to run with virtualbox should be easy enough).

You also need [berkshelf](http://berkshelf.com) to get your
cookbooks from.

## Ok, let's run it

1) Go to `StatsAggregator/` and type `vagrant up --provision`
and wait for a line like `INFO: Chef Run complete`

2) Go to `StatsEmitter/` and type `vagrant up --provision`
and wait for a line like `INFO: Chef Run complete`

3) If you made it this far, it's actually easy. Access the
StatsEmitter Website on [localhost:8098](http://127.0.0.1/8098).

4) Now open the graphite dashboard on
[localhost:8099](http://localhost:8099/dashboard/) and configure
the stats you want to see.

## Generate traffic

If you need more traffic to see some more graphed data, you can
hop into `TrafficGenerator` and fire up gatling there.
