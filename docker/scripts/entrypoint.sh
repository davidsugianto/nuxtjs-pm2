#!/bin/sh
# set -e

set -o errexit
set -o nounset
set -o pipefail

apk add --no-cache curl && cd /tmp && \
curl -#L https://github.com/tj/node-prune/releases/download/v1.0.1/node-prune_1.0.1_linux_amd64.tar.gz | tar -xvzf- && \
mv -v node-prune /usr/local/bin && rm -rvf * && \
echo "yarn cache clean && node-prune" > /usr/local/bin/node-clean && chmod +x /usr/local/bin/node-clean

echo "Install PM2 globaly"
npm install pm2@latest -g

tee /app/${PROJECT_DIR}/ecosystem.config.js << EOF
module.exports = {
  apps : [
    {
      name : "${PRODUCTION_APP}",
      exec_mode : "cluster",
      instances : 2,
      script: "${SERVER_PATH_PRODUCTION}",
      watch: true,
      out_file: "/dev/null",
      error_file: "/dev/null",
      env: {
        "HOST": "0.0.0.0",
        "PORT": ${NODE_PORT},
        "NODE_ENV": "production"
      }
    },
    {
      name : "${STAGING_APP}",
      exec_mode : "cluster",
      instances : 2,
      script: "${SERVER_PATH_STAGING}",
      watch: true,
      out_file: "/dev/null",
      error_file: "/dev/null",
      env: {
        "HOST": "0.0.0.0",
        "PORT": ${NODE_PORT},
        "NODE_ENV": "production"
      }
    }
  ]
};
EOF

### Check if a directory exist ###
if [[ -d "/app/${PROJECT_DIR}" ]]
then

  if [[ -d "/app/${PROJECT_DIR}/.nuxt" && -d "/app/${PROJECT_DIR}/node_modules" \
    && -e "/app/${PROJECT_DIR}/package.json" && -e "/app/${PROJECT_DIR}/nuxt.config.js" ]]
  then
    echo "Project ready for starting, please wait a moment set back and relax!"
    cd /app/${PROJECT_DIR}
    ls -al
    npm install
    npm run start:${BUILD_FLAG}
  else
    echo "Project not ready for starting, please check your project structure!"
    echo "Change directory to ${PROJECT_DIR}"
    cd /app/${PROJECT_DIR}
    echo "npm install"
    npm install
    # npm run build-${BUILD_FLAG}
    ls -al
    npm run start:${BUILD_FLAG}
  fi

else 
  echo "Directory project not found."
  exit 1
fi

# Call command issued to the docker service
exec "$@"
