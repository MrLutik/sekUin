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
docker run --rm -it -v $(pwd)/sekai:/sekai sekin-sekaid:latest init --overwrite --chain-id=testnet-1 "KIRA TEST LOCAL VALIDATOR NODE" --home=/sekai
```

2. Add genesis keys

```bash
docker run --rm -it -v $(pwd)/sekai:/sekai sekin-sekaid:latest keys add genesis --keyring-backend=test --home=/sekai --output=json | jq .mnemonic>./sekai/genesis.mnemonic
```

3. Add interx keys
```bash
docker run --rm -it -v $(pwd)/sekai:/sekai sekin-sekaid:latest keys add interx --keyring-backend=test --home=/sekai --output=json | jq .mnemonic>./interx/interx.mnemonic
```

4. Add account "genesis" to genesis file
```bash
docker run --rm -it -v $(pwd)/sekai:/sekai sekin-sekaid:latest add-genesis-account genesis 300000000000000ukex --keyring-backend=test --home=/sekai
```

5. Start container
```bash
docker run -d \
  -p 26657:26657 \
  -p 26656:26656 \
  -p 26660:26660 \
  -h sekai.local \
  --network kiranet \
  -v $(pwd)/sekai:/sekai \
  --restart always \
  sekin-sekaid:latest start --home=/sekai --trace --rpc.laddr "tcp://0.0.0.0:26657"
```







