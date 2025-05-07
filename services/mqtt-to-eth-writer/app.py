import paho.mqtt.client as mqtt
from web3 import Web3

# Connexions
mqtt_broker = "mqtt-broker"
eth_node = "http://ethereum-node:8545"

# Init Web3
web3 = Web3(Web3.HTTPProvider(eth_node))

# Crée un compte temporaire
acct = web3.eth.account.create()
web3.geth.personal.importRawKey(acct.key.hex(), "")
web3.geth.personal.unlock_account(acct.address, "", 0)

def on_message(client, userdata, msg):
    data = msg.payload.decode()
    tx_hash = web3.eth.send_transaction({
        'from': acct.address,
        'to': acct.address,
        'value': 0,
        'data': web3.to_bytes(text=data),
        'gas': 100000
    })
    print(f"Message écrit sur Ethereum: {tx_hash.hex()}")

# MQTT setup
client = mqtt.Client()
client.on_message = on_message
client.connect(mqtt_broker, 1883, 60)
client.subscribe("test/topic")
client.loop_forever()


