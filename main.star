import "kurtosis/module.lib.star" as kurtosis_module

def run(plan):
    mqtt_config = kurtosis_module.ServiceConfig(
        container_image="eclipse-mosquitto:2",
        ports={"1883": None}
    )
    plan.add_service(name="mqtt-broker", config=mqtt_config)

    geth_config = kurtosis_module.ServiceConfig(
        container_image="ethereum/client-go:stable",
        entrypoint=["geth", "--http", "--http.addr", "0.0.0.0", "--dev"],
        ports={"8545": None}
    )
    plan.add_service(name="ethereum-node", config=geth_config)

    writer_config = kurtosis_module.ServiceConfig(
        container_image="mqtt-to-eth-writer:latest",
        ports={"5000": None}
    )
    plan.add_service(name="mqtt-to-eth-writer", config=writer_config)
