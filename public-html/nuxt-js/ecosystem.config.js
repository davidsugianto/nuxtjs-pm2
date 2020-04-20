module.exports = {
  apps : [
    {
      name : "nuxt-app",
      exec_mode : "cluster",
      instances : 2,
      script: "nuxt-start",
      watch: true,
      out_file: "/dev/null",
      error_file: "/dev/null",
      env: {
        "HOST": "0.0.0.0",
        "PORT": 3000,
        "NODE_ENV": "production"
      }
    },
    {
      name : "nuxt-staging-app",
      exec_mode : "cluster",
      instances : 2,
      script: "nuxt-start",
      watch: true,
      out_file: "/dev/null",
      error_file: "/dev/null",
      env: {
        "HOST": "0.0.0.0",
        "PORT": 3000,
        "NODE_ENV": "production"
      }
    }
  ]
};
