<p align="center">
  <a href="https://archcraft.io"><img src="https://raw.githubusercontent.com/archcraft-os/archcraft-packages/main/archcraft-artworks/files/logo/png/logo-circle/logo-circle-1.png" height="100" width="100" alt="Archcraft"></a>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Maintained%3F-Yes-green?style=flat-square">
  <img src="https://img.shields.io/github/downloads/archcraft-os/archcraft-xfce/total?label=downloads&logo=github&color=blue&style=flat-square">
  <img src="https://img.shields.io/github/issues/archcraft-os/archcraft-xfce?color=violet&style=flat-square">
  <img src="https://img.shields.io/github/license/archcraft-os/archcraft-xfce?color=orange&style=flat-square">
</p>

<p align="center">
Yet another minimal linux distribution, based on <a href="https://www.archlinux.org">Arch Linux</a>.
</p>

<p align="center">
  <a href="https://archcraft.io" target="_blank"><img alt="home" src="https://img.shields.io/badge/HOME-blue?style=flat-square"></a>
  <a href="https://wiki.archcraft.io" target="_blank"><img alt="wiki" src="https://img.shields.io/badge/WIKI-blue?style=flat-square"></a>
  <a href="https://archcraft.io/gallery" target="_blank"><img alt="screenshots" src="https://img.shields.io/badge/SCREENSHOTS-blue?style=flat-square"></a>
  <a href="https://www.reddit.com/r/archcraft" target="_blank"><img alt="reddit" src="https://img.shields.io/badge/REDDIT-blue?style=flat-square"></a>
  <a href="https://discord.gg/3PzeJ5S7Pu" target="_blank"><img alt="discord" src="https://img.shields.io/badge/DISCORD-blue?style=flat-square"></a>
  <a href="https://t.me/archcraftos" target="_blank"><img alt="telegram" src="https://img.shields.io/badge/TELEGRAM-blue?style=flat-square"></a>
  <a href="https://matrix.to/#/#archcraft:matrix.org" target="_blank"><img alt="matrix" src="https://img.shields.io/badge/MATRIX-blue?style=flat-square"></a>
</p>

![img](./xfce.gif)

#

### Latest Release

- **`ISO`** : [archcraft-xfce-2023.01.20-x86_64.iso](https://github.com/archcraft-os/archcraft-xfce/releases/download/v23.01/archcraft-xfce-2023.01.20-x86_64.iso)
- **`SIG`** : [archcraft-xfce-2023.01.20-x86_64.iso.sig](https://github.com/archcraft-os/archcraft-xfce/releases/download/v23.01/archcraft-xfce-2023.01.20-x86_64.iso.sig)
- **`SHA`** : [archcraft-xfce-2023.01.20-x86_64.iso.sha256sum](https://github.com/archcraft-os/archcraft-xfce/releases/download/v23.01/archcraft-xfce-2023.01.20-x86_64.iso.sha256sum)
`6dda9958dfef19500db658b955b0519f14a92abeff4aeaf76a7e263c405bcfc2`
- **`TORRENT`** : [archcraft-xfce-2023.01.20-x86_64.iso.torrent](https://github.com/archcraft-os/archcraft-xfce/releases/download/v23.01/archcraft-xfce-2023.01.20-x86_64.iso.torrent)

### Verify the authenticity of the ISO

- Download the **`ISO`**, **`gpg signature`** and **`sha256sum`** files
- Make sure all the files are present in the same directory (Assuming `~/Downloads`)
- First, Verify the details of the key on keyserver, Open a terminal and run (any one):
```
$ gpg --keyserver hkps://keys.gnupg.net --recv-keys 7DC81F73
$ gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 7DC81F73
$ gpg --keyserver hkp://pgp.mit.edu --recv-keys 7DC81F73
```

- Then, Open `terminal` in the `~/Downloads` folder and run following command :
```
$ gpg --verify archcraft-xfce-2023.01.20-x86_64.iso.sig
```

- Finally, Verify the `sha256sum` by running :
```
$ sha256sum -c archcraft-xfce-2023.01.20-x86_64.iso.sha256sum
```
