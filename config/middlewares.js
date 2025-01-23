export default ({ env }) => [
  'strapi::logger',
  'strapi::errors',
  {
    name: 'strapi::security',
    config: {
      contentSecurityPolicy: {
        useDefaults: true,
        directives: {
          'connect-src': ["'self'"],
          'img-src': [
            "'self'",
            'data:',
            'blob:',
            'https://' + env('CELLAR_BUCKET') + '.' + env('CELLAR_ADDON_HOST')
          ],
          'media-src': ["'self'", 'data:', 'blob:', 'https://' + env('CELLAR_BUCKET') + '.' + env('CELLAR_ADDON_HOST')],
          upgradeInsecureRequests: null,
        },
      },
    },
  },
  'strapi::poweredBy',
  'strapi::query',
  'strapi::body',
  'strapi::session',
  'strapi::favicon',
  'strapi::public',
  {
    name: 'strapi::cors',
    config: {
      enabled: true,
      origin: ['https://' + env("APP_ID") + '.cleverapps.io'], //change if you use your own DNS
      methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'HEAD'],
      headers: ['*'],
      credentials: true,
    },
  }  
];
