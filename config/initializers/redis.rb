require 'redis'
require 'connection_pool'

# TODO: use environment variables or secrets store for the following magic numbers:
redis_host = 'localhost'
redis_port = 6379

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) { Redis.new(:host => redis_host, :port => redis_port) }

# appendonly 'yes' will persist changes after every second, making our redis instance more like a sql db:
# TODO: discover how to set this on our redis instance so we don't have to do it here.
Redis.new(host: redis_host, port: redis_port).config(:set, {'appendonly':'yes'})
