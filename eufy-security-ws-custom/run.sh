#!/usr/bin/with-contenv bashio
# Reads the add-on options from /data/options.json, writes the eufy-security-ws
# config file, then starts the server in the foreground.
set -euo pipefail

OPTIONS=/data/options.json
CONFIG_PATH=/data/eufy-security-ws-config.json
SERVER=/usr/src/app/node_modules/eufy-security-ws/dist/bin/server.js

USERNAME=$(jq -r '.username // empty' "$OPTIONS")
PASSWORD=$(jq -r '.password // empty' "$OPTIONS")

if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
    bashio::log.fatal "Set both 'username' and 'password' in the add-on configuration, then restart."
    exit 1
fi

# Build the config. Empty/null options are dropped so the library uses its defaults.
jq '
  {
    persistentDir: "/data",
    username: .username,
    password: .password,
    country: .country,
    eventDurationSeconds: .event_duration,
    pollingIntervalMinutes: .polling_interval,
    trustedDeviceName: .trusted_device_name,
    acceptInvitations: .accept_invitations,
    stationIPAddresses: (
      if (.stations | length) > 0
      then (.stations | map({(.serial_number): .ip_address}) | add)
      else null end
    )
  }
  | with_entries(select(.value != null and .value != ""))
' "$OPTIONS" > "$CONFIG_PATH"

PORT=$(jq -r '.port // 3000' "$OPTIONS")
ARGS=(--host 0.0.0.0 --port "$PORT" --config "$CONFIG_PATH")

if [ "$(jq -r '.debug // false' "$OPTIONS")" = "true" ]; then
    ARGS+=(-v)
fi

NODE_OPTS=()
if [ "$(jq -r '.ipv4first // false' "$OPTIONS")" = "true" ]; then
    NODE_OPTS+=(--dns-result-order=ipv4first)
fi

bashio::log.info "Starting eufy-security-ws on port ${PORT}"
exec /usr/bin/node "${NODE_OPTS[@]}" "$SERVER" "${ARGS[@]}"
