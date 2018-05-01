
#Install Dependencies
#Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce

#JQ
sudo apt-get install -y jq


#Install Nano Node
sudo docker pull nanocurrency/nano:latest
Container=$(sudo docker run -d -p 7075:7075/udp -p 7075:7075 -p [::1]:7076:7076 -v ~:/root nanocurrency/nano)

#Configure Command Line Alias
echo '
#Rai/Nano Command Alias
alias rai="sudo docker exec '$Container' /usr/bin/rai_node"' >> ~/.bashrc
source ~/.bashrc

#Configure Nano wallet
WalletResponse=$(curl -d '{ "action" : "wallet_create" }' [::1]:7076)
Wallet=$(echo $WalletResponse  | jq '.wallet')

AccountResponse=$(curl -d '{ "action": "account_create", "wallet": '$Wallet' }' [::1]:7076)
Account=$(echo $AccountResponse | jq '.account')

HostName=$(hostname)


#Install Node Monitor
sudo docker pull nanotools/nanonodemonitor
sudo docker run -d -p 80:80 -v ~:/opt --restart=unless-stopped nanotools/nanonodemonitor

#Configure Node Monitor
cd nanoNodeMonitor
sudo cp config.php config.orig.php
sudo rm config.php
echo '<?php

// FIRST USE
// Please copy this file as config.php

// To edit a config uncomment the line, otherwise
// defaults will be used for each variable.

// ----------- General Variables -----------

// Theme of your Node Monitor (dark or light)
$themeChoice = "dark";

// autorefresh interval for the status webpage in seconds
$autoRefreshInSeconds = 30;

// Name of your node (default: your hostname)
$nanoNodeName = "'$HostName'";

// a welcome message shown on top
$welcomeMsg = "Welcome to Nano Node Monitor!";

// coinmarketcap widget
// market data base and second currency e.g. USD, EUR, BTC, ETH
$cmcBaseCurrency = "USD";
$cmcSecondaryCurrency = "BTC";

// other widget panels (TRUE / FALSE)
$cmcTicker = FALSE;
$cmcRank = TRUE;
$cmcMarketcap = TRUE;
$cmcVolume = TRUE;
$cmcStatsticker = FALSE;

// choice of Nano block explorer (''nanode', 'ninja', 'nanoexplorer', 'nano', 'nanowatch', 'meltingice'')
$blockExplorer = "nanode";

// ----------- Cache Engine -----------

// The cache engine allows for caching of RPC calls to reduce load on your Nano node.

// Duration in seconds between cache invalidation, i.e. RPC calls to the node
$cacheTimeToLive = 30;

// ----------- Nano Node Variables -----------

// ip address for RPC (default: [::1])
$nanoNodeRPCIP   = "[::1]";

// ip address for RPC (default: 7076)
$nanoNodeRPCPort = "7076";

// account of this node
$nanoNodeAccount = '$Account';

// donation account for maintaining this node
$nanoDonationAccount = '$Account';

// number of decimal places to display Nano balances, i.e.
$nanoNumDecimalPlaces = 2;

// ----------- Monitoring -----------

// Uptimerobot.com API key for external monitoring
// Tutorial: https://github.com/NanoTools/nanoNodeMonitor/wiki/Uptimerobot-Node-Monitoring
// If $uptimerobotApiKey is not set, monitoring via https://nanonode.ninja/ is used
// $uptimerobotApiKey = '';

// ----------- Social -----------

// Add your social accounts
// Tutorial: https://github.com/NanoTools/nanoNodeMonitor/wiki/Social-Accounts' | sudo tee config.php