const redis = require("redis");

async function start() {
        const client = await redis.createClient()
            .on("error", (err) => console.log("Redis Client Error", err))
            .connect();

    console.log("Success");
}

start();