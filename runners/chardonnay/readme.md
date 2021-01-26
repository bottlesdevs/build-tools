# Chardonnay build

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
- `./build64.sh`
- `./build.sh`
