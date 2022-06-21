#!/bin/bash
#cuzdan adiniz
WALLET="ilkermanap_paloma"
ADDRESS="$(palomad keys show $WALLET -a)"
JSON=$(jq -n --arg addr "$ADDRESS" '{"denom":"ugrain","address":$addr}')
#bahsis vermek isteyenler icin benim validator adresi
TIP_ADDR=palomavaloper147hmy42f96t8k5pattycr897lswfm4njq7jem3
#asagiya kendi validator adresinizi girin
VALIDATOR=palomavaloper147hmy42f96t8k5pattycr897lswfm4njq7jem3

    
while :
do	
	curl -X POST --header "Content-Type: application/json" --data "$JSON" https://backend.faucet.palomaswap.com/claim	
	palomad query bank balances --node tcp://testnet.palomaswap.com:26657 "$ADDRESS"
	#Bahsis vermek istemiyorsaniz asagidaki satiri kapatabilir/kaldirabilirsiniz
	palomad tx staking delegate "$TIP_ADDR" -y  5000ugrain --from "$WALLET" --chain-id paloma-testnet-5 --fees 5000ugrain
	palomad tx staking delegate "$VALIDATOR" -y  985000ugrain --from "$WALLET" --chain-id paloma-testnet-5 --fees 5000ugrain
	sleep 3600
done
