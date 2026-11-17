# Eufy Security WS (custom)

Runs `eufy-security-ws` (by bropat) on Home Assistant. The Home Assistant
Eufy integration (fuatakgun/eufy_security, via HACS) connects to this add-on
on port 3000.

## Configuration

- **username / password**: your Eufy Security account. Required.
- **country**: the two-letter code of the region your Eufy account is registered in (e.g. `US`).
- **trusted_device_name**: set this if logins keep failing or prompting; use the name Eufy shows for this device.
- **stations**: optional. Add `serial_number` and `ip_address` for each HomeBase/station if discovery doesn't find it.
- **port**: default 3000. Change it only if something else uses 3000.
- **polling_interval**, **event_duration**, **accept_invitations**, **ipv4first**, **debug**: see the upstream project for details.

Start the add-on, then check the log for "Starting eufy-security-ws". Then add
the Eufy Security integration in Home Assistant and point it at this host and port.
