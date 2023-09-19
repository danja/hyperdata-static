<!-- title: HKMS Desktop -->

An immediate irritation I have is that I'm coding in VSCode and also writing notes in it. Navigating between the two activities is a pain.

The problem is broader still because during the coding I have to do other bits of context-switch to look at/edit data, project management, bookmarks...

I've got most of these things at various stages of dev in HKMS, but accessing these via a browser bypasses my local FS, access there is desirable.

So I've been looking at Pulsar, a fork of the discontinued Atom editor. Plan is to tweak it to fit my needs.

I did like Atom as an editor, and hopefully as it's built on Electron it'll make a convenient local host for the HKMS apps.

Set up a repo : [hkms-desktop](https://github.com/danja/hkms-desktop)

I'm having a few teething problems with Pulsar.

The ppm package manager it uses is in a different repo. The install instructions didn't work for me, so playing it by ear.

- danny@danny-desktop:~/HKMS/hkms-desktop$ ln -s ../ppm ./ppm

hmm, lost the paths

```
export ATOM_HOME=/home/danny/.pulsar
export APM_PATH=/home/danny/HKMS/hkms-desktop/ppm/bin/apm
export ATOM_ELECTRON_VERSION=12.2.3
```

ok, now packages seem to work.

Added https://github.com/denieler/save-workspace-atom-plugin
not sure it's gonna be useful...

Added PlatformIO IDE Terminal

https://www.electronjs.org/docs/latest/tutorial/using-native-node-modules
