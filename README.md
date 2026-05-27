# Sample CI/CD Project Overview

This repository contains a sample Node.js application and a GitHub Actions CI/CD pipeline that builds, tests, containers, and deploys the app to Kubernetes.

The `check/` folder includes the app source, Dockerfile, Kubernetes manifests, and tests.

## File structure under `check/`

- `check/app.js` - Express server application
- `check/package.json` - Node project metadata and scripts
- `check/Dockerfile` - Container image definition
- `check/README.md` - Project documentation for the `check/` directory
- `check/tsconfig.json` - TypeScript configuration file
- `check/k8s/deployment.yml` - Kubernetes Deployment manifest
- `check/k8s/service.yml` - Kubernetes Service manifest
- `check/tests/app.test.ts` - Simple Node.js test file

---

## 1) `check/app.js`

This file defines a small Express server.

```js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello World from Kubernetes!');
});

if (require.main === module) {
  app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
  });
}

module.exports = app;
```

- `express` is loaded.
- `app` is created as an Express instance.
- The `/` route returns a greeting.
- The server starts only when the file runs directly.
- The app is exported for reusable testing.

---

## 2) `check/package.json`

This file describes the Node.js project and its dependencies.

Key fields:

- `name`, `version`, `description` — basic metadata.
- `main: "app.js"` — entry point for the app.
- `scripts`:
  - `start`: runs `node app.js`
  - `test`: runs Node’s built-in test runner
- `dependencies`:
  - `express`: runtime web server dependency

---

## 3) `check/Dockerfile`

This Dockerfile builds a container image for the app.

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

- Uses a lightweight Node.js Alpine image.
- Copies package metadata and installs dependencies first.
- Copies application files afterward.
- Exposes port `3000`.
- Starts the app with `npm start`.

---

## 4) `check/README.md`

This file contains documentation for the sample repo, including the CI/CD workflow and Kubernetes deployment details.

It explains how the repository demonstrates:

- GitHub Actions automation
- Docker image build
- Kubernetes deployment using Kind (local cluster)

It also lists common local commands such as:

- `npm install`
- `npm test`
- `npm run build` (if present)
- `npm run package` (if present)

---

## 5) `check/tsconfig.json`

TypeScript configuration for the project.

Important settings include:

- `target: "ES2020"` — modern JavaScript output
- `module: "ESNext"` — ES module format
- `moduleResolution: "node"` — Node import resolution
- `types: ["node"]` — include Node.js type definitions

Even though the main app file is JavaScript, this config makes the project compatible with TypeScript tooling.

---

## 6) `check/k8s/deployment.yml`

Kubernetes Deployment manifest for the app.

Key configuration:

- `apiVersion: apps/v1`
- `kind: Deployment`
- `metadata.name: hello-node-app`
- `spec.replicas: 2`
- `selector.matchLabels.app: hello-node-app`
- `template.spec.containers[0].image: hello-node-app:latest`
- `containerPort: 3000`

This creates two pod replicas running the app image.

---

## 7) `check/k8s/service.yml`

Kubernetes Service manifest to expose the app.

Key configuration:

- `apiVersion: v1`
- `kind: Service`
- `metadata.name: hello-node-app-service`
- `spec.type: NodePort`
- `selector.app: hello-node-app`
- `ports`:
  - `port: 80`
  - `targetPort: 3000`
  - `nodePort: 30080`

This exposes the app through Kubernetes node port `30080`.

---

## 8) `check/tests/app.test.ts`

A simple Node.js test using the built-in test runner.

```js
import { test } from 'node:test';
import assert from 'node:assert';

test('sample test', () => {
  assert.strictEqual(1 + 1, 2);
});
```

- Uses Node’s built-in `node:test` framework.
- Verifies a basic assertion.
- Confirms the test system runs successfully.

---

## Summary

- `check/app.js` runs an Express server.
- `check/Dockerfile` builds a container image.
- `check/k8s/deployment.yml` deploys the app to Kubernetes.
- `check/k8s/service.yml` exposes the deployment via NodePort.
- `check/tests/app.test.ts` provides a simple validation test.

