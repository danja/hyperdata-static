downgraded from node 21 to recommended 11

github comaplaing about keys. Removed old one.

ssh-keygen -t ed25519 -C "danny.ayers@gmail.com"

cladio_good_321

npm install webpack-dev-server

needing...

npm install fsevents
etc etc

npm install npm-install-peers

webpack-dev-server@3.11.3

---

danny@danny-desktop:~/VR/moonrider$ webpack-dev-server --host 0.0.0.0 --progress --colors --hot-only --inline --port 3033
CLI for webpack must be installed.
webpack-cli (https://github.com/webpack/webpack-cli)node

npm install -g webpack-cli

edit package.json

    "start": "webpack-dev-server --host 0.0.0.0 --progress --colors --hot-only --inline --port 3000"

        "start": "webpack serve --host 0.0.0.0 --progress --colors --hot-only --inline --port 3303"

        nope

        sudo apt install webpack

nope

reverted similar

"start": "webpack-dev-server --host 0.0.0.0 --progress --colors --hot-only --inline --port 3033"

googled...tried yarn install, nope

error webpack-cli@5.1.4: The engine "node" is incompatible with this module. Expected version ">=14.15.0". Got "11.0.0"
error Found incompatible module.

sudo npm cache clean -f
