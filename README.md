# Multi-platform PHP Static CLI Builder

This repository builds a fully static PHP CLI binary (Linux) with PostgreSQL and all common Laravel extensions included.

## Features

- Custom PHP version selectable via git tag or `.env`
- Builds PHP static binary using Alpine musl in Docker
- Includes pgsql, pdo_pgsql, mbstring, curl, bcmath, xml, json, openssl, and more
- GitHub Actions CI builds and creates a GitHub Release for easy download

## How to build locally

1. Clone the repo
2. (Optional) Set PHP version in `php-version.env`:

3. Run:
```bash
./build-linux.sh
```