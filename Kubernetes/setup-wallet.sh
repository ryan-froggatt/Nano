#/bin/bash
echo "== Creating wallet"
  wallet=$(kubectl exec nano-1 -c nano-node -- /usr/bin/rai_node --wallet_create)

  echo "== Creating account"
  account=$(kubectl exec nano-1 -c nano-node -- /usr/bin/rai_node --account_create --wallet=$wallet | cut -d ' ' -f2)

echo "== Modifying the monitor config"

  # uncomment account
  kubectl exec nano-1 -c nano-monitor -- sed -i -e 's#// $nanoNodeAccount#$nanoNodeAccount#g' /opt/nanoNodeMonitor/config.php

  # replace account
  kubectl exec nano-1 -c nano-monitor -- sed -i -e "s/xrb_1f56swb9qtpy3yoxiscq9799nerek153w43yjc9atoaeg3e91cc9zfr89ehj/$account/g" /opt/nanoNodeMonitor/config.php

  # uncomment ip
  kubectl exec nano-1 -c nano-monitor -- sed -i -e 's#// $nanoNodeRPCIP#$nanoNodeRPCIP#g' /opt/nanoNodeMonitor/config.php

  # replace ip
  kubectl exec nano-1 -c nano-monitor -- sed -i -e 's#\[::1\]#nano-1.nano-svc.default.svc.cluster.local#g' /opt/nanoNodeMonitor/config.php

  echo "== Disabling RPC logging"
  kubectl exec nano-1 -c nano-node -- sed -i -e 's#"log_rpc": "true"#"log_rpc": "false"#g' /root/RaiBlocks/config.json

  echo "== Just some final magic..."
  # restart because we changed the config.json
  # and the node might be unresponsive at first
  sleep 5s

  echo ""

  echo -e "=== YOUR WALLET SEED ==="
  echo "Please write down your wallet seed to a piece of paper and store it safely!"
  kubectl exec nano-1 -c nano-node -- /usr/bin/rai_node --wallet_decrypt_unsafe --wallet=$wallet | grep "Seed: "
  echo -e "=== YOUR WALLET SEED ==="


  echo "== Restarting Nano node container"
  kubectl delete pod nano-1

  echo "== Just some final magic..."
  # restart because we changed the config.json
  # and the node might be unresponsive at first
  sleep 5s