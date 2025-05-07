def run(plan):
    plan.add_container(
        name = "mqtt-broker",
        image = "eclipse-mosquitto:2",
        ports = {
            "1883/tcp": None,
        },
    )

    plan.add_container(
        name = "ethereum-node",
        image = "ethereum/client-go:stable",
        entrypoint = [
            "geth", "--http", "--http.addr", "0.0.0.0", "--dev",
        ],
        ports = {
            "8545/tcp": None,
        },
    )

    plan.add_container(
        name = "mqtt-to-eth-writer",
        image = "mqtt-to-eth-writer:latest",
        ports = {
            "5000/tcp": None,
        },
    )
