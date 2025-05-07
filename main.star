kurtosis_module = import("kurtosis/module.lib.star")

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
    plan.add_service(name="ethereum-node", config=geth_c
