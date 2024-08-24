# Magento2 Docker

A lightweight, open-source Docker container for Magento2, tailored for a standard setup.

![Magento Version Support](https://img.shields.io/badge/magento-2.4.X-brightgreen.svg?logo=magento&longCache=true)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

## Disclaimer
- This container provides a minimal setup using `alpine` Linux and the `sh` shell, rather than `bash`.
- It is designed for Magento Open Source projects and might conflict with [Magento ECE Tools](https://github.com/magento/ece-tools/), which also offers Docker Compose files.

## Requirements
- Installed `magento2-base` (or an existing Magento2 project)
- PHP version 8.2

## Installation
- Via Composer
  ```
  composer require awesoft/magento-docker:^8.2
  ```

## Usage
- The setup is designed to be straightforward. Additional configurations are optional and based on your specific needs.
- After installation via Composer, simply run `docker compose up` to start all necessary services automatically. Refer to `docker-compose.yml` for details.

## Files Created
- `docker-compose.yml` - Specifies the services, volumes, and configurations to initiate your Magento2 instance.
- `.docker/mariadb` - Includes configuration files for a MariaDB database instance.
- `.docker/nginx` - Contains the Nginx server template configuration.

## Access & Services
- Your Magento website will be accessible by default at [http://magento.local/](http://magento.local/):
    - Add `127.0.0.1 magento.local` to your `/etc/hosts` file manually.
    - Change the domain in `.docker/nginx/templates/default.conf.template` if needed.
- Mailcatcher: [http://127.0.0.1:1080](http://127.0.0.1:1080)
- Opensearch: [http://127.0.0.1:9200](http://127.0.0.1:9200)
- Redis: [http://127.0.0.1:6379](http://127.0.0.1:6379)
- Check `docker-compose.yml` for more information.

## Additional Command
- Use the `run-install` command to execute `setup:install` with default options, ideal for a fresh Magento project.
  ```
  docker compose exec -it php run-install
  ```
- If successful, you can access the admin page with the following credentials:
    - [http://magento.local/admin/](http://magento.local/admin/)
    - Username: `admin`
    - Password: `P@ssw0rd`
