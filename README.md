<h1 align="center">
  <!--<a name="logo" href=""><img src="" alt="Logo" width="200"></a>-->
  <br>
  Dotfiles

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

</h1>

## Overview

Personal dotfiles for arch linux, ubuntu and windows.

## Installation

Linux:

Run the `./setup.sh` script

```bash
git clone https://github.com/AndreasRoither/dotfiles && cd dotfiles && bash ./setup.sh
```

Windows:

Setting windows execution policy:

```
set-executionpolicy remotesigned
set-executionpolicy restricted
```

Then start powershell in admin and run install.ps1.

For ssh key pre script run:

```bash
ssh-copy-id -i ~/.ssh/id_rsa.pub pi@192.168.8.50
```

## Inspired / Code copied from

[alrra](https://github.com/alrra/dotfiles)

## Technology / Stuff used

[Winget](https://www.microsoft.com/en-us/p/app-installer/9nblggh4nns1)  
[Dotbot](https://github.com/anishathalye/dotbot)
