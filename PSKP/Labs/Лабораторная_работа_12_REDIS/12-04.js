const redis = require("redis");

const numRequest = 10000;

async function start() {
    const client = await redis
        .createClient()
        .on("error", (err) => console.log("Redis Client Error", err))
        .connect();

    console.log("Success");

    let start = new Date().getTime();
    for (let i = 0; i < numRequest; i++) {
        await client.hSet("key", `${i}`, JSON.stringify({"id": i, "val": `val-${i}`}));
    }
    let end = new Date().getTime();
    console.log(`Hset: ${end - start}ms`);

    start = new Date().getTime();
    for (let i = 0; i < numRequest; i++) {
        await client.hGet("key", `${i}`);
    }
    end = new Date().getTime();

    console.log(`Hget: ${end - start}ms`);
}

start();
