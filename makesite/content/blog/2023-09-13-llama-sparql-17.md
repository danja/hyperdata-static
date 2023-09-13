<!-- title: llama_index SPARQL Notes 17 -->

I've got a bit distracted trying to set up good Jupyter Notebook hosting on my server. After going round in circles a _lot_ have settled on using JupyterHub, specifically :

https://github.com/jupyterhub/the-littlest-jupyterhub

It's now running at http://hyperdata.it:8484/user/admin/lab

This provides a lot more than I need for this, is multi-user, but doesn't appear to make much demand on resources (assuming very few users).

Looking around this took me into auth territory a bit. I do want this set up for other services on my site, so I'm biting the bullet a bit.

LDAP seems the best base for me, JupyterHub has a plugin. More generally, an LDAP-based identity provider would be nice to have.

But before that - how to add the path of my in-progress LlamaIndex bits so the Notebook can see it. PYTHONPATH isn't working. Virtual envs were mention in the (quick) install procedure, so probe time -

```
import sys
import os

print('sys.prefix = '+sys.prefix)
print('\nos.environ = '+str(os.environ))
print('\nVIRTUAL_ENV = '+str(os.environ.get('VIRTUAL_ENV')))
print('\nsys.executable = '+sys.executable)
print('\nsys.path = ')
print(sys.path)

```

gives

```
sys.prefix = /opt/tljh/user

os.environ = environ({'LANG': 'en_US.UTF-8', 'PATH': '/opt/tljh/user/bin:/opt/tljh/hub/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', '_WSREP_START_POSITION': '', 'HOME': '/home/jupyter-admin', 'LOGNAME': 'jupyter-admin', 'USER': 'jupyter-admin', 'SHELL': '/bin/bash', 'INVOCATION_ID': '0f6f2c87ddd84b6580a092738a5f2828', 'JOURNAL_STREAM': '8:13724686', 'RUNTIME_DIRECTORY': '/run/jupyter-admin', 'SYSTEMD_EXEC_PID': '89780', 'JPY_API_TOKEN': 'a0b308207fff4b1ba0d634c490dd3f33', 'JUPYTERHUB_ACTIVITY_URL': 'http://127.0.0.1:15001/hub/api/users/admin/activity', 'JUPYTERHUB_API_TOKEN': 'a0b308207fff4b1ba0d634c490dd3f33', 'JUPYTERHUB_API_URL': 'http://127.0.0.1:15001/hub/api', 'JUPYTERHUB_BASE_URL': '/', 'JUPYTERHUB_CLIENT_ID': 'jupyterhub-user-admin', 'JUPYTERHUB_DEFAULT_URL': '/lab', 'JUPYTERHUB_HOST': '', 'JUPYTERHUB_OAUTH_ACCESS_SCOPES': '["access:servers!server=admin/", "access:servers!user=admin"]', 'JUPYTERHUB_OAUTH_CALLBACK_URL': '/user/admin/oauth_callback', 'JUPYTERHUB_OAUTH_CLIENT_ALLOWED_SCOPES': '[]', 'JUPYTERHUB_OAUTH_SCOPES': '["access:servers!server=admin/", "access:servers!user=admin"]', 'JUPYTERHUB_SERVER_NAME': '', 'JUPYTERHUB_SERVICE_PREFIX': '/user/admin/', 'JUPYTERHUB_SERVICE_URL': 'http://127.0.0.1:35051/user/admin/', 'JUPYTERHUB_USER': 'admin', 'PYDEVD_USE_FRAME_EVAL': 'NO', 'JPY_SESSION_NAME': '/home/jupyter-admin/graph-rag-sparql-mini.ipynb', 'JPY_PARENT_PID': '89780', 'TERM': 'xterm-color', 'CLICOLOR': '1', 'FORCE_COLOR': '1', 'CLICOLOR_FORCE': '1', 'PAGER': 'cat', 'GIT_PAGER': 'cat', 'MPLBACKEND': 'module://matplotlib_inline.backend_inline'})

VIRTUAL_ENV = None

sys.executable = /opt/tljh/user/bin/python

sys.path =
['/home/jupyter-admin', '/opt/tljh/user/lib/python310.zip', '/opt/tljh/user/lib/python3.10', '/opt/tljh/user/lib/python3.10/lib-dynload', '', '/opt/tljh/user/lib/python3.10/site-packages']

```

root@localhost:/opt/tljh# grep -r sys.path

...

/opt/tljh/hub/lib/python3.10/site-packages/tljh/jupyterhub_config.py
contains

```
# Load arbitrary .py config files if they exist.
# This is our escape hatch
extra_configs = sorted(glob(os.path.join(CONFIG_DIR, "jupyterhub_config.d", "*.py")))
for ec in extra_configs:
    load_subconfig(ec)

```

so...

nano /opt/tljh/config/jupyterhub_config.d/extra-path.py

```
import sys
sys.path.append("/home/hkms-apps/llama_index")
```

systemctl restart jupyterhub

**No change.**

Oh, rights. chmod on that ^, no change.

Runs at another point?

I don't need to check everything starts ok on reboot on this server, so reboot time.
