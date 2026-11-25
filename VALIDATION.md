# Validation Checklist

## Node.js / TypeScript

- [x] `npm ci` succeeds.
- [x] lint/type checking succeeds.
- [x] tests pass.
- [x] TypeScript build creates `dist/`.
- [x] compiled application starts successfully.
- [x] health endpoint works.

## Docker

- [x] multi-stage Dockerfile is implemented.
- [x] runtime image is minimized.
- [x] container runs as non-root.
- [x] application responds on port 3000.
- [x] image is tagged immutably.

## Terraform / AWS

- [x] remote state is used.
- [x] VPC spans multiple AZs.
- [x] EKS nodes are private.
- [x] ECR is configured.
- [x] EKS nodes join successfully.
- [x] GitHub AWS authentication uses OIDC.
- [x] trust policy is repository/environment restricted.
- [x] workload AWS permissions do not use static keys.
- [x] Terraform plan is reviewed before apply.

## Kubernetes / Helm

- [x] Helm lint succeeds.
- [x] multiple replicas run.
- [x] requests and limits exist.
- [ ] liveness works.
- [x] readiness works.
- [x] HPA works.
- [x] PDB exists.
- [x] rolling update succeeds.
- [x] security context is configured.
- [x] workload is distributed appropriately for availability.

## Networking

- [ ] AWS Load Balancer Controller works.
- [x] ALB is created from Ingress.
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

- [x] Argo CD is operational.
- [x] dev desired state is stored in Git.
- [ ] prod desired state is stored in Git.
- [x] exact image version is declared.
- [x] Argo CD syncs the application.
- [x] drift can be detected.
- [x] rollback procedure is demonstrated.
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
