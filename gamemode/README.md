# Gamemode build
Gamemode is a tool that optimise Linux system performance on demand.

## System requirements
- Ubuntu LTS

### Tested
- Ubuntu 18.04 LTS

## Preparation
```bash
mkdir -p ~/runner/work/gamemode/gamemode
cd ~ && git clone https://github.com/bottlesdevs/build-tools
cd build-tools
```

## Steps
- `./environment.sh`
- `./build.sh -r [version] (e.g. -r 1.6.1)` (optional)
- `./package.sh -r [version] (e.g. -r 1.6.1)` (optional)
