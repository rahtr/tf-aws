
resource "aws_key_pair" "app" {
  key_name = "app-prod"
  public_key = "${file("${var.SSH_PUBLIC_KEY}")}"
}

resource "aws_s3_bucket" "default" {
  bucket = var.S3BUCKET
}

resource "aws_s3_bucket_object" "default" {
  bucket = aws_s3_bucket.default.id
  key    = "secret-message-api-0.0.1-SNAPSHOT.jar"
  source = "target/secret-message-api-0.0.1-SNAPSHOT.jar"
}

# Set up the security groups
resource "aws_security_group" "app-prod" {
  vpc_id = aws_vpc.main.id
  name = "app-prod"
  description = "App prod security group"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "app-prod"
  }
}

# app

resource "aws_elastic_beanstalk_application" "app" {
  name        = "tf-test-name"
  description = "tf-test-desc"
}

resource "aws_elastic_beanstalk_application_version" "default" {
  name        = "tf-test-version-label"
  application = "tf-test-name"
  description = "application version created by terraform"
  bucket      = aws_s3_bucket.default.id
  key         = aws_s3_bucket_object.default.id
}

resource "aws_elastic_beanstalk_environment" "app-prod" {
  name = "app-prod"
  application = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.7 running Java 8"
  cname_prefix = "app-prod-a2b6d0"
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.main.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = aws_subnet.vpc-private-1.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = aws_subnet.vpc-private-2.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "app-ec2-role"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = aws_security_group.app-prod.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "EC2KeyName"
    value = aws_key_pair.app.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.micro"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "public"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = aws_subnet.vpc-public-1.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = aws_subnet.vpc-public-2.id
  }
  setting {
    namespace = "aws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "30"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Percentage"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any 2"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_USERNAME"
    value = aws_db_instance.rds-app-prod.username
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_PASSWORD"
    value = aws_db_instance.rds-app-prod.password
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_DATABASE"
    //value = "mydb"
    value = aws_db_instance.rds-app-prod.name
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "RDS_HOSTNAME"
    value = aws_db_instance.rds-app-prod.endpoint
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "SERVER_PORT"
    value = "5000"
  }
}
