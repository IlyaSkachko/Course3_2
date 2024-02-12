const redis = require("redis");

async function start() {
    const subscribe = await redis
        .createClient()
        .on("error", (err) => console.log("Redis Client Error", err));

    console.log("START");

    const oneChannelSub = subscribe.duplicate();

    await oneChannelSub.connect();

    await oneChannelSub.subscribe("channel1", (message) => {
        console.log(`Channel1 sent message: ${message}`);
    })

    oneChannelSub.on("error", (err) => {
        console.log(err);
    });

    setTimeout(async () => {
        await oneChannelSub.unsubscribe();
        await oneChannelSub.quit();
    }, 15000)

    oneChannelSub.on("end", () => {console.log("END");});
}

start();
