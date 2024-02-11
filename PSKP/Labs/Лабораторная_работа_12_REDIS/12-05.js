const redis = require("redis");

async function start() {
    const publisher = await redis
        .createClient()
        .on("error", (err) => console.log("Redis Client Error", err))
        .connect();

    console.log("Success");

    publisher.publish(
        "notification",
        '{"message":"Hello world from Asgardian!"',
        function () {
            process.exit(0);
        }
    );

}

start();
