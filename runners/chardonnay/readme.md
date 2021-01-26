# Chardonnay build
Chardonnay is a Wine build that supports both 64 and 32 Bit and includes Staging patches.

## System requirements
- Ubuntu LTS

### Tested
- Ubuntu 18.04 LTS

## Preparation
```bash
mkdir -p ~/runner/work/wine
cd ~/runner/work/wine && git clone https://github.com/bottlesdevs/wine
cd ~ && git clone https://github.com/bottlesdevs/build-tools
cd build-tools
```

## Steps
- `./environment.sh`
- `./patch-staging.sh`
- `./wine-tools.sh`
- `./build64.sh`
- `./build.sh`

## Notes
The `build32.sh` script build a 32 Bit only wine.
