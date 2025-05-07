def run(plan):
    # Broker MQTT (Mosquitto)
    plan.add_service(
        name="mqtt-broker",
        image="eclipse-mosquitto:2",
        ports={"1883/tcp": 1883}
    )

    # Nœud Ethereum (Geth en mode dev ou PoA)
    plan.add_service(
        name="ethereum-node",
        image="ethereum/client-go:stable",
        entrypoint=["geth", "--http", "--http.addr", "0.0.0.0", "--dev"],
        ports={"8545/tcp": 8545}
    )

    # Bridge MQTT vers Ethereum
    plan.add_service(
        name="mqtt-to-eth-writer",
        image="mqtt-to-eth-writer:latest",
        ports={"5000/tcp": 5000},
        files={
            "/app": plan.read_dir("services/mqtt-to-eth-writer")
        }
    )
