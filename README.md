# SEKIN
Simplified interx and sekai deployment and setup

## Installation

1. Clone repo
```bash
git clone https://github.com/MrLutik/sekin.git
```

2. Make bootstrap executable
```bash
cd sekin \
&& sudo chmod +x ./bootstrap.sh
```

3. Launch bootstrap
```bash
sudo ./bootstrap.sh
```

4. Build images
```bash
sudo docker-compose build
```

## Initialize new network

1. Init sekai. Available flags [here](https://github.com/MrLutik/kira2.0/blob/development/docs/sekai.md#11-init)

```bash
sekaid init --overwrite --chain-id=testnet-1 "KIRA TEST LOCAL VALIDATOR NODE" --home=/sekai
```
