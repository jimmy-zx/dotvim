# dotvim

Pluggable vim configurations.

## Project structure

```
dotvim
| vimrc  <-- the main configuration file
| pack   <-- pluggable packages, one can choose any subset
| | dvim <-- the basic plugin pack
| | ...
| `
`
```

## Setup

```bash
cd dotvim
mkdir ~/.vim
ln -s $PWD/vimrc ~/.vim/vimrc
```

### Packages

```bash
mkdir -p ~/.vim/pack
ln -s $PWD/pack/dvim ~/.vim/pack/dvim
```
