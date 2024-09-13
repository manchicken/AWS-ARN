#!/usr/bin/perl
use strict;
use warnings;
use Test::More;

use AWS::ARN;

# Define a hash with ARNs as keys and expected resource IDs (suitable for Cost Explorer) as values
my %arn_tests = (

  # S3 bucket
  'arn:aws:s3:::my_bucket' => 'my_bucket',

  # Application Load Balancer (ALB)
'arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-alb/50dc6c495c0c9188'
    => '50dc6c495c0c9188',

  # Network Load Balancer (NLB)
'arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/net/my-nlb/30f1af6bf9193245'
    => '30f1af6bf9193245',

  # Classic Load Balancer (ELB)
'arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/my-classic-elb'
    => 'my-classic-elb',

  # EC2 instance
  'arn:aws:ec2:us-west-2:123456789012:instance/i-0abcd1234ef56789' =>
    'i-0abcd1234ef56789',

  # RDS instance
  'arn:aws:rds:us-west-2:123456789012:db:mysql-instance1' => 'mysql-instance1',

  # Lambda function
  'arn:aws:lambda:us-west-2:123456789012:function:my-function' => 'my-function',

  # DynamoDB table
  'arn:aws:dynamodb:us-west-2:123456789012:table/my-dynamodb-table' =>
    'my-dynamodb-table',

  # IAM Role
  'arn:aws:iam::123456789012:role/MyRole' => 'MyRole',

  # SNS topic
  'arn:aws:sns:us-west-2:123456789012:my-sns-topic' => 'my-sns-topic',

  # SQS queue
  'arn:aws:sqs:us-west-2:123456789012:my-queue' => 'my-queue',

  # ECS cluster
  'arn:aws:ecs:us-west-2:123456789012:cluster/my-ecs-cluster' =>
    'my-ecs-cluster',

  # ECS task definition
  'arn:aws:ecs:us-west-2:123456789012:task-definition/my-task-definition:1' =>
    'my-task-definition:1',

  # EFS file system
  'arn:aws:elasticfilesystem:us-west-2:123456789012:file-system/fs-12345678' =>
    'fs-12345678',

  # Kinesis stream
  'arn:aws:kinesis:us-west-2:123456789012:stream/my-kinesis-stream' =>
    'my-kinesis-stream',

  # CloudWatch Log Group
  'arn:aws:logs:us-west-2:123456789012:log-group:/aws/lambda/my-log-group' =>
    'my-log-group',

  # ECR Repository
  'arn:aws:ecr:us-west-2:123456789012:repository/my-repo' => 'my-repo',

  # CodeBuild project
  'arn:aws:codebuild:us-west-2:123456789012:project/my-build-project' =>
    'my-build-project',

  # Redshift cluster
  'arn:aws:redshift:us-west-2:123456789012:cluster/my-redshift-cluster' =>
    'my-redshift-cluster',
);

# Set the test plan based on the number of ARNs in the hash
plan tests => scalar keys %arn_tests;

# Function to extract resource ID (assumed behavior from AWS::ARN)
sub get_resource_id {
  my $arn        = shift;
  my $parsed_arn = AWS::ARN->new( arn => $arn );
  return
    $parsed_arn
    ->resource_id;    # Assuming this method returns the resource ID part
}

# Loop through each ARN in the hash and test the resource ID parsing
while ( my ( $arn, $expected_id ) = each %arn_tests ) {
  is( get_resource_id($arn), $expected_id,
    "Parsed resource ID correctly for ARN: $arn" );
}

done_testing();
