# Validation Checklist

## Node.js / TypeScript

- [x] `npm ci` succeeds.
- [x] lint/type checking succeeds.
- [x] tests pass.
- [x] TypeScript build creates `dist/`.
- [x] compiled application starts successfully.
- [x] health endpoint works.

## Docker

- [ ] multi-stage Dockerfile is implemented.
- [ ] runtime image is minimized.
- [ ] container runs as non-root.
- [ ] application responds on port 3000.
- [ ] image is tagged immutably.

## Terraform / AWS

- [ ] remote state is used.
- [ ] VPC spans multiple AZs.
- [ ] EKS nodes are private.
- [ ] ECR is configured.
- [ ] EKS nodes join successfully.
- [ ] GitHub AWS authentication uses OIDC.
- [ ] trust policy is repository/environment restricted.
- [ ] workload AWS permissions do not use static keys.
- [ ] Terraform plan is reviewed before apply.

## Kubernetes / Helm

- [ ] Helm lint succeeds.
- [ ] multiple replicas run.
- [ ] requests and limits exist.
- [ ] liveness works.
- [ ] readiness works.
- [ ] HPA works.
- [ ] PDB exists.
- [ ] rolling update succeeds.
- [ ] security context is configured.
- [ ] workload is distributed appropriately for availability.

## Networking

- [ ] AWS Load Balancer Controller works.
- [ ] ALB is created from Ingress.
- [ ] targets are healthy.
- [ ] HTTPS works.
- [ ] DNS works when configured.
- [ ] HTTP redirects to HTTPS.

## GitHub Actions

- [ ] PR pipeline runs `npm ci`.
- [ ] lint runs.
- [ ] tests run.
- [ ] TypeScript build runs.
- [ ] security gates run.
- [ ] Docker build runs.
- [ ] image scan runs.
- [ ] OIDC authentication succeeds.
- [ ] commit-SHA image is pushed to ECR.
- [ ] no long-lived AWS credentials are stored.

## GitOps / Argo CD

- [ ] Argo CD is operational.
- [ ] dev desired state is stored in Git.
- [ ] prod desired state is stored in Git.
- [ ] exact image version is declared.
- [ ] Argo CD syncs the application.
- [ ] drift can be detected.
- [ ] rollback procedure is demonstrated.
- [ ] production promotion has a control/approval mechanism.
- [ ] GitHub Actions and Argo CD do not compete for deployment ownership.

## Observability

- [ ] Prometheus is operational.
- [ ] Grafana is operational.
- [ ] useful dashboard exists.
- [ ] alert rules exist.
- [ ] pod/node/application symptoms can be investigated.

## Security

- [ ] dependency scanning exists.
- [ ] image scanning exists.
- [ ] IaC scanning exists.
- [ ] Kubernetes configuration scanning exists.
- [ ] secrets are not committed.
- [ ] IAM follows least privilege.

## End-to-end proof

Demonstrate:

```text
code change
   ↓
pull request CI
   ↓
merge
   ↓
npm build
   ↓
Docker image
   ↓
ECR SHA tag
   ↓
GitOps desired-state update
   ↓
Argo CD sync
   ↓
EKS rolling deployment
   ↓
ALB / HTTPS
   ↓
metrics visible
```

Then identify the exact Git commit running in the cluster.
