#!/usr/bin/env bash
# Verify no billable resources are left running after a teardown
set -euo pipefail

REGION="${AWS_REGION:-us-east-1}"
PROJECT_TAG="devops-capstone"
leftovers=0

# Print the result of one check and record any leftovers
report() {
  local name="$1"
  local result="$2"
  if [ -n "$result" ]; then
    echo "FAIL  ${name}: ${result}"
    leftovers=1
  else
    echo "OK    ${name}"
  fi
}

echo "Checking ${REGION} for billable resources..."

# EKS clusters
clusters=$(aws eks list-clusters --region "$REGION" --query "clusters[]" --output text)
report "EKS clusters" "$clusters"

# EC2 instances
instances=$(aws ec2 describe-instances --region "$REGION" \
  --filters Name=instance-state-name,Values=pending,running,stopping \
  --query "Reservations[].Instances[].InstanceId" --output text)
report "EC2 instances" "$instances"

# NAT gateways
nat_gateways=$(aws ec2 describe-nat-gateways --region "$REGION" \
  --filter Name=state,Values=pending,available \
  --query "NatGateways[].NatGatewayId" --output text)
report "NAT gateways" "$nat_gateways"

# Load balancers
load_balancers=$(aws elbv2 describe-load-balancers --region "$REGION" \
  --query "LoadBalancers[].LoadBalancerName" --output text)
report "Load balancers" "$load_balancers"

# Elastic IPs
elastic_ips=$(aws ec2 describe-addresses --region "$REGION" \
  --query "Addresses[].AllocationId" --output text)
report "Elastic IPs" "$elastic_ips"

# Unattached EBS volumes
volumes=$(aws ec2 describe-volumes --region "$REGION" \
  --filters Name=status,Values=available \
  --query "Volumes[].VolumeId" --output text)
report "Unattached EBS volumes" "$volumes"

# Project VPCs
vpcs=$(aws ec2 describe-vpcs --region "$REGION" \
  --filters "Name=tag:Project,Values=${PROJECT_TAG}" \
  --query "Vpcs[].VpcId" --output text)
report "Project VPCs" "$vpcs"

# Overall result
if [ "$leftovers" -ne 0 ]; then
  echo "RESULT: billable resources are still running"
  exit 1
fi
echo "RESULT: nothing billable is running"
