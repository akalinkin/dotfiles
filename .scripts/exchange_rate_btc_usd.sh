#!/bin/sh

RESPONSE=$(curl -s 'https://api.coinmarketcap.com/v2/ticker/' | jq -r '.data ."1" .quotes .USD .price')
printf "%0.0f\n" $RESPONSE
