load("kurtosis/module.lib.star", "ServiceConfig", "PortSpec")

MQTT_PORT_ID = "mqtt"
GETH_PORT_ID = "rpc"
WRITER_PORT_ID = "api"

def run(plan, args):
    # Broker MQTT (Mosquitto)
    mqtt_config = ServiceConfig(
        image = "eclipse-mosquitto:2",
        ports = {
            MQTT_PORT_ID: PortSpec(number = 1883),
        },
    )
    plan.add_service(name = "mqtt-broker", config = mqtt_config)

    # Nœud Ethereum Geth
    geth_config = ServiceConfig(
        image = "ethereum/client-go:stable",
        entrypoint = ["geth", "--http", "--http.addr", "0.0.0.0", "--dev"],
        ports = {
            GETH_PORT_ID: PortSpec(number = 8545),
        },
    )
    plan.add_service(name = "ethereum-node", config = geth_config)

    # Service MQTT → Ethereum
    writer_config = ServiceConfig(
        image = "mqtt-to-eth-writer:latest",
        ports = {
            WRITER_PORT_ID: PortSpec(number = 5000),
        },
    )
    plan.add_service(name = "mqtt-to-eth-writer", config = writer_config)
