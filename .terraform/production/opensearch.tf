resource "aws_opensearch_domain" "opensearch-prod" {
  domain_name    = "opensearch-prod"
  engine_version = "Elasticsearch_7.10"

  cluster_config {
    instance_type = "r4.large.search"
  }

  tags = {
    Domain = "elasticsearchDomain"
  }
}