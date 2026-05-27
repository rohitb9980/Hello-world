# Hello World CI/CD with GitHub Actions and Kubernetes

This sample repository demonstrates a complete GitHub Actions CI/CD pipeline for a Node.js + TypeScript application that builds, tests, packages, builds a Docker image, and deploys to a Kubernetes cluster using Kind.

## What is included

- `build` job: installs dependencies, compiles TypeScript, and packages an artifact
- `unit-test` job: runs Jest unit tests
- `docker-build` job: builds a Docker image for the application
- `deploy` job: creates a local Kind cluster and deploys the image with Kubernetes manifests

## Local setup

```powershell
npm install
npm run build
npm test
npm run package
```

## Kubernetes deployment

The manifest is defined in `k8s/hello-world.yaml` and deploys the application to port `3000` behind a `ClusterIP` service.

## GitHub Actions

The workflow is located at `.github/workflows/ci-cd.yml` and runs on pushes and pull requests to `main`.
