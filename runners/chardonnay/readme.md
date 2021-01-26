# Chardonnay build

## System requirements
- Ubuntu LTS

## Preparation
```bash
mkdir -p ~/runner/work/wine && cd ~/runner/work/wine
git clone https://github.com/bottlesdevs/wine
```

## Steps
- `./environment.sh`
- `./patch-staging.sh`
- `./build32.sh`
- `./build64.sh`
- `./build.sh`
