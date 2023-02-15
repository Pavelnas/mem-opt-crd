resource "aws_cloudwatch_log_group" "redis-elasticache-log-group" {
  name              = "/aws/elasticache/prod/cluster/redis"
  retention_in_days = 7
}

resource "aws_elasticache_cluster" "elasticache-production" {
  cluster_id           = "elasticache-production-cluster"
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.4"
  port                 = 11211
}

resource "aws_elasticache_cluster" "redis-elasticache-production" {
  cluster_id           = "elasticache-production-cluster"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis-elasticache-log-group.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
}