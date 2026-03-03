#!/bin/bash

echo "Generate secrets for Strapi..."
echo ""

echo "ADMIN_JWT_SECRET=\"$(openssl rand -hex 32)\""
echo "API_TOKEN_SALT=\"$(openssl rand -hex 32)\""
echo "APP_KEYS=\"$(openssl rand -hex 32),$(openssl rand -hex 32),$(openssl rand -hex 32),$(openssl rand -hex 32)\""
echo "JWT_SECRET=\"$(openssl rand -hex 32)\""
echo "TRANSFER_TOKEN_SALT=\"$(openssl rand -hex 32)\""
