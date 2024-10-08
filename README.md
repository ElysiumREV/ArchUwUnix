# ArchUwUnix
pt-BR: Sistema Operacional básico feito a partir do trabalho semestral da matéria de Sistemas Operacionais no curso de ciência da computação na Unisagrado.<br/>
en-US: A basic Operating System made as part of the semester project for the Operating Systems course in the Computer Science program at Unisagrado.

## Dependencias
Debian based
<ul>
  <li>build-essential</li>
  <li>gcc</li>
  <li>make</li>
  <li>grub-pc-bin</li>
  <li>xorriso</li>
  <li>nasm</li>
</ul>
Arch Linux based
<ul>
  <li>base-devel</li>
  <li>gcc</li>
  <li>make</li>
  <li>grub-pc-bin</li>
  <li>xorriso</li>
  <li>nasm</li>
</ul>

## Usage
Having all the dependencies installed and the repository cloned at your local machine

### Make ISO
```
make
```

If you plan to modify anything you'll have to clean the iso folder and some files, just run the command
### Clean ISO 
```
make clean
```

## Warning
If the iso directory is not created for some reason the command make will fail, so just make sure to create it

# Disclaimer

Arch UWUnix is an independent project created as part of a semester project and is not affiliated with or endorsed by the official Arch Linux distribution. The name "Arch" in this context is used purely for fun and educational purposes, with no intention of associating with or replicating Arch Linux in any form.

We are not even using the Linux kernel xd.
