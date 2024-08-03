module "rds" {
    source = "../../modules/rds"

    aws_ssdev_profile_name="ssdev"
    db_engine="aurora-postgres"
    db_instance_class="db.r5.large"
    db_instance_version=11.9
    db_port=5432
    db_instance_count=2
    backup_retention_period=15
}