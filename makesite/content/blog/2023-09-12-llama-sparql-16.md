<!-- title: llama_index SPARQL Notes 16 -->

/opt/tljh/hub/lib/python3.10/site-packages/tljh/jupyterhub_config.py

is called from

jupyterhub.service

```
# Template file for JupyterHub systemd service
# Uses simple string.format() for 'templating'
[Unit]
# Traefik must have successfully started *before* we launch JupyterHub
Requires=traefik.service
After=traefik.service

[Service]
User=root
Restart=always
WorkingDirectory=/opt/tljh/state
# Protect bits that are normally shared across the system
PrivateTmp=yes
PrivateDevices=yes
ProtectKernelTunables=yes
ProtectKernelModules=yes
Environment=TLJH_INSTALL_PREFIX=/opt/tljh
Environment=PATH=/opt/tljh/hub/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# Run upgrade-db before starting, in case Hub version has changed
# This is a no-op when no db exists or no upgrades are needed
ExecStart=/opt/tljh/hub/bin/python3 -m jupyterhub.app -f /opt/tljh/hub/lib/python3.10/site-packages/tljh/jupyterhub_config.py

[Install]
# Start service when system boots
WantedBy=multi-user.target
```
