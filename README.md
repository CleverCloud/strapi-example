# Deploy Strapi on Clever Cloud

This project is a Strapi application already configured to be deployed on [Clever Cloud](https://www.clever-cloud.com) and to use object storage with [Cellar](https://developers.clever-cloud.com/doc/addons/cellar/). It complements the walkthrough from Pierre Guézennec: https://www.camino.dev/blog/deployer-cms-strapi-clever-cloud

This README contains two sections:

1. Initial/manual deployment (quickstart and Clever Cloud-specific setup)
2. Terraform automation (infrastructure + app provisioning)

---

## Part 1 — Initial / Manual Deployment

### 🚀 Getting started with Strapi

Strapi comes with a full featured [Command Line Interface](https://docs.strapi.io/dev-docs/cli) (CLI) which lets you scaffold and manage your project in seconds.

#### `develop`

Start Strapi with auto-reload enabled:

```bash
npm run develop
# or
yarn develop
```

#### `start`

Start Strapi with auto-reload disabled (production-like):

```bash
npm run start
# or
yarn start
```

#### `build`

Build the admin panel:

```bash
npm run build
# or
yarn build
```

### ⚙️ Deploy on Clever Cloud (manual)

Strapi gives you many possible deployment options for your project including [Strapi Cloud](https://cloud.strapi.io). Browse the [deployment section of the documentation](https://docs.strapi.io/dev-docs/deployment) to find the best solution for your use case.

### 💡 Deploy on Clever Cloud ☁️

Deploy this app with the following tools:

#### A Node.js application

Inject the following environment variables:

```bas
ADMIN_JWT_SECRET="<your-token>"
API_TOKEN_SALT="<your-token>"
APP_KEYS="<your-token>,<your-token>,<your-token>,<your-token>"
CC_NODE_BUILD_TOOL="yarn"
CELLAR_ADDON_REGION="fr-par"
CELLAR_BUCKET="<your-bucket-name>"
DATABASE_CLIENT="postgres"
HOST="0.0.0.0"
JWT_SECRET="<your-token>"
NODE_ENV="production"
TRANSFER_TOKEN_SALT="<your-token>"
```

Run `openssl rand -hex 32` for each value and replace `<your-token>` with the result.

#### Custom domain

If you use custom domain, change `origin:` on `middlewares.js`

#### A PostgreSQL add-on

Environment variables have already been set in the code.

#### A Cellar add-on

This project uses [@strapi/provider-upload-aws-s3](https://www.npmjs.com/package/@strapi/provider-upload-aws-s3) to store assets and has already been set up.

Don't forget to connect your add-ons to the application (**Service dependencies** option from your app menu in Clever Cloud Console).

Cellar policies need to be public. Follow this [documentation](https://www.clever-cloud.com/developers/doc/addons/cellar/#public-bucket-policy).

#### Dedicated build instance

Strapi can run on a small instance like the `XS` plan, but the build process can take more RAM and CPU. Enable a dedicated build instance from your app menu **Information** option in Clever Cloud Console.

---

## Part 2 — Deploy with Terraform (automated)

This repository includes Terraform configuration to provision the Clever Cloud application, add-ons, and related resources.

### Prerequisites

1. Install Terraform: https://www.terraform.io/downloads
2. A Clever Cloud account: https://console.clever-cloud.com
3. Clever Cloud credentials (create a token in the Clever Cloud console or with `clever login`). Get tokens from: https://console.clever-cloud.com/users/me/tokens

### Deployment Steps

1. Clone the repository

```bash
git clone https://github.com/CleverCloud/strapi-example.git
cd strapi-example
```

2. Generate secrets

```bash
cd terraform
./generate-secrets.sh > secrets.txt
```

3. Configure Terraform variables

```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform/terraform.tfvars with your values, Clever Cloud tokens and the generated secrets
```

4. Initialize Terraform

```bash
terraform init
```

5. Review the plan

```bash
terraform plan
```

6. Deploy

```bash
terraform apply
```

7. Retrieve the application URL

```bash
terraform output app_url
```

### A Cellar add-on

This project uses [@strapi/provider-upload-aws-s3](https://www.npmjs.com/package/@strapi/provider-upload-aws-s3) to store assets and has already been set up.

Don't forget to connect your add-ons to the application (**Service dependencies** option from your app menu in Clever Cloud Console).

Cellar policies need to be public. Follow this [documentation](https://www.clever-cloud.com/developers/doc/addons/cellar/#public-bucket-policy).

### Customization

- Change instance sizes in `terraform/terraform.tfvars`:

```hcl
instance_type = "S"      # Options: XS, S, M, L, XL
build_instance_type = "L" # Larger build instance for faster builds
```

- Add a custom domain in `terraform/terraform.tfvars`:

```hcl
custom_domain = "strapi.yourdomain.com"
```

- Scale the number of instances:

```hcl
instance_count = 2
```

### Security

- Never commit `terraform/terraform.tfvars` containing secrets.
- Add the following (recommended) entries to your repository `.gitignore`.

### Recommended `.gitignore` entries

```gitignore
############################
# Terraform
############################
terraform/.terraform/
terraform/*.tfstate
terraform/*.tfstate.backup
terraform/*.tfstate.*.backup
terraform/.terraform.lock.hcl
terraform/terraform.tfvars
terraform/secrets.txt
terraform.tfstate

############################
# Strapi
############################
.env
.cache
license.txt
exports
.strapi
dist
build
.strapi-updater.json
```

### Useful Terraform Commands

```bash
# Destroy infrastructure
terraform destroy

# Show outputs
terraform output

# Inspect state
terraform show
```

### Usage Summary

1. `cd terraform`
2. `./generate-secrets.sh > secrets.txt`
3. `cp terraform.tfvars.example terraform.tfvars` and edit with your values and secrets
4. `terraform init`
5. `terraform plan && terraform apply`

## Resources

- [Terraform Provider — Clever Cloud](https://registry.terraform.io/providers/CleverCloud/clevercloud/latest/docs)
- [Clever Cloud Documentation](https://www.clever.cloud/developers/doc/)

## 📚 Learn more

- [Resource center](https://strapi.io/resource-center) - Strapi resource center.
- [Strapi documentation](https://docs.strapi.io) - Official Strapi documentation.
- [Strapi tutorials](https://strapi.io/tutorials) - List of tutorials made by the core team and the community.
- [Strapi blog](https://strapi.io/blog) - Official Strapi blog containing articles made by the Strapi team and the community.
- [Changelog](https://strapi.io/changelog) - Find out about the Strapi product updates, new features and general improvements.

Feel free to check out the [Strapi GitHub repository](https://github.com/strapi/strapi). Your feedback and contributions are welcome!

## ✨ Community

- [Discord](https://discord.strapi.io) - Come chat with the Strapi community including the core team.
- [Forum](https://forum.strapi.io/) - Place to discuss, ask questions and find answers, show your Strapi project and get feedback or just talk with other Community members.
- [Awesome Strapi](https://github.com/strapi/awesome-strapi) - A curated list of awesome things related to Strapi.