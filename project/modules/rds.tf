module "db_secret" {
    source = "git@github.com:project/aws-tf-lib.git//modules/security/sm?ref=v2.10.1"

    tagmap=local.tagmap
    regional_prefix=local.regional_prefix
    service_target="rds"
    name_suffix=var.purpose
    key_arn=local.key_arn
}

module "db_cluster" {
    source = "git@github.com:project/aws-tf-lib.git//modules/database/rds-aurora?ref=v2.10.1"
    envcode=module.envcode.envcode
    regcode=module.envcode.regcode
    regional_prefix=local.regional_prefix
    purpose="nexus"
    db_password=module.db_secret.password
    engine=var.db_engine
    port=var.db_port
    storage_key=local.key_arn
    instance_class=var.db_instance_class
    aws_ssdev_profile_name=var.aws_ssdev_profile_name
    engine_version=var.db_engine_version
    performance_insight_enabled=var.db_performance_insight_enabled
    instance_count=var.db_instance_count
    skip_final_snapshot=var.skip_final_snapshot
    backup_retention_period=var.backup_retention_period
    auto_minor_version_upgrade=var.auto_minor_version_upgrade
}

