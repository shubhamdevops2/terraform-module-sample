data "aws_vpc" "az_vpc" {
    tags = {
        env="dev"
    }
}

data "aws_security_groups" "az_sg_database" {
    filter {
        name="vpc-id"
        values=[data.aws_vpc.az_vpc]      
    }  
}

resource "aws_rds_cluster" "aurora-cluster" {
    count=var.create ? 1: 0
    cluster_identifier=local.cluster_name
    database_name=local.database_name
    master_username=local.master_username
    master_password=var.db_password
    final_snapshot_identifier = var.final_snapshot_identifier
    skip_final_snapshot = var.skip_final_snapshot  
    deletion_protection = var.deletion_protection
    backup_retention_period = var.backup_retention_period
    preferred_backup_window = var.preferred_backup_window
    preferred_maintenance_window = var.preferred_maintenance_window
    copy_tags_to_snapshot = true
    port=var.port

    vpc_security_group_ids = setunion(var.vpc_security_group_ids,data.aws_security_groups.az_sg_database.ids)
    snapshot_identifier = var.snapshot_identifier
    storage_encrypted = true
    kms_key_id = var.storage_key
    replication_source_identifier = var.replication_source_db
    apply_immediately = var.apply_immediately
    db_subnet_group_name = local.rds_subnet_group
    db_cluster_parameter_group_name = var.db_cluster_parameter_group_name
    iam_roles = var.iam_roles
    iam_database_authentication_enabled = var.iam_database_authentication_enabled
    engine = var.engine
    engine_mode = var.engine_mode
    engine_version = var.engine_version
    source_region = var.source_db_region
    enabled_cloudwatch_logs_exports = var.log_exports
    tags = merge(
        var.tagmap,
        {
            "name" = local.cluster_name
        }
    )
}



