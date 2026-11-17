# Eufy add-on repository

Custom Home Assistant add-on that runs `eufy-security-ws` 3.1.0.

## Install

1. Push this folder to a GitHub repo. Edit `url:` in `repository.yaml` to point to it.
2. In Home Assistant: Settings → Add-ons → Add-on Store → ⋮ → Repositories → add the repo URL.
3. Install "Eufy Security WS (custom)", set username and password, then start it.
4. Add the Eufy Security integration (HACS: fuatakgun/eufy_security) and enter this host and port 3000.

The add-on builds locally on your device from the Dockerfile.
