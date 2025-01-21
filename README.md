# Deploy Strapi on Clever Cloud

This project is a Strapi application already configured to be deployed on [Clever Cloud](https://www.clever-cloud.com) and use use object storage with [Cellar](https://developers.clever-cloud.com/doc/addons/cellar/). It's a full configuration demo to complete [this great article from Pierre Guézennec](https://www.camino.dev/blog/deployer-cms-strapi-clever-cloud)

## 🚀 Getting started with Strapi

Strapi comes with a full featured [Command Line Interface](https://docs.strapi.io/dev-docs/cli) (CLI) which lets you scaffold and manage your project in seconds.

### `develop`

Start your Strapi application with autoReload enabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-develop)

```
npm run develop
# or
yarn develop
```

### `start`

Start your Strapi application with autoReload disabled. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-start)

```
npm run start
# or
yarn start
```

### `build`

Build your admin panel. [Learn more](https://docs.strapi.io/dev-docs/cli#strapi-build)

```
npm run build
# or
yarn build
```

## ⚙️ Deployment

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

#### A PostgreSQL add-on

Environment variables have already been set in the code.

#### A Cellar add-on

This project uses [@strapi/provider-upload-aws-s3](https://www.npmjs.com/package/@strapi/provider-upload-aws-s3) to store assets and has already been set up.

Don't forget to connect your add-ons to the application (**Service dependencies** option from your app menu in Clever Cloud Console).

Cellar bucket need to be public. Follow this [documentation](https://www.clever-cloud.com/developers/doc/addons/cellar/#public-bucket-policy).

#### Dedicated build instance

Strapi can run on a small instance like the `XS` plan, but the build process can take more RAM and CPU. Enable a dedicated build instance from your app menu **Information** option in Clever Cloud Console.

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

---

<sub>🤫 Psst! [Strapi is hiring](https://strapi.io/careers).</sub>
