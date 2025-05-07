load("kurtosis/module.lib.star", "plan", "ServiceConfig")

def run(plan: plan.Plan):
    # MQTT Broker
    mqtt_config = ServiceConfig(
        container_image="eclipse-mosquitto:2",
        ports={"1883": None}
    )
    plan.add_service(name="mqtt-broker", config=mqtt_config)

    # Ethereum Node (Geth)
    geth_config = ServiceConfig(
        container_image="ethereum/client-go:stable",
        entrypoint=["geth", "--http", "--http.addr", "0.0.0.0", "--dev"],
        ports={"8545": None}
    )
    plan.add_service(name="ethereum-node", config=geth_config)

    # MQTT to Ethereum Writer (ton bridge)
    writer_config = ServiceConfig(
        container_image="mqtt-to-eth-writer:latest",
        ports={"5000": None}
    )
    plan.add_service(name="mqtt-to-eth-writer", config=writer_config)
