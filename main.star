def run(plan, args):
    # Add a Postgres server
    mqtt = plan.add_service(
        name = "mqtt",
        config = ServiceConfig(
            image = "eclipse-mosquitto:2",
            ports = {
                mqtt: PortSpec(number = 1883),
            }
        ),
    )