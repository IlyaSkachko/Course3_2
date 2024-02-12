const redis = require("redis");

async function start() {
    const publisher = await redis
        .createClient()
        .on("error", (err) => console.log("Redis Client Error", err))
        .connect();

    console.log("START");
    const intervalId = setInterval(async () => {
        await publisher.publish("channel1", "Hello world!");
    }, 3000);


    setTimeout(async () => {
        clearInterval(intervalId);
        await publisher.quit();
    }, 15000);

    publisher.on("end", () => {console.log("END");});
}

start();
