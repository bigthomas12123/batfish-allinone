#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v java >/dev/null 2>&1; then
  echo "[ERROR] java not found in PATH. Please install JDK 21+." >&2
  exit 1
fi

echo "Starting Batfish allinone (API: http://127.0.0.1:9996) ..."
exec java -Xmx4g -jar allinone.jar -runclient false \
  -coordinatorargs "-templatedirs $(pwd)/questions -containerslocation $(pwd)/containers"
