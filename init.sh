#!/bin/sh

set -e

echo "☁️ دریافت فایل از S3..."
aws --endpoint-url=http://localstack:4566 s3 cp s3://local-bucket/index.html  /usr/share/nginx/html/index.html

echo "🚀 اجرای nginx"
nginx -g 'daemon off;'