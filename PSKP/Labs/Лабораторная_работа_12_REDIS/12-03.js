const redis = require("redis");

const numRequest = 10000;

async function start() {
    const client = await redis
        .createClient()
        .on("error", (err) => console.log("Redis Client Error", err))
        .connect();

    console.log("Success");

    start = new Date().getTime();
    for (let i = 0; i < numRequest; i++) {
        await client.incr(`incr`);
    }
    end = new Date().getTime();

    console.log(`Incr: ${end - start}ms`);

    start = new Date().getTime();
    for (let i = 0; i < numRequest; i++) {
        await client.decr(`decr`);
    }
    end = new Date().getTime();
    console.log(`Decr: ${end - start}ms`);
}

start();
