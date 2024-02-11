const redis = require("redis");

async function start() {
    const subscriber = await redis
        .createClient()
        .on("error", (err) => console.log("Redis Client Error", err))
        .connect();
    subscriber.on("message", function (channel, message) {
        console.log(
            "Message: " + message + "on channel: " + channel + " is arrive!"
        );
    });
}

start();
