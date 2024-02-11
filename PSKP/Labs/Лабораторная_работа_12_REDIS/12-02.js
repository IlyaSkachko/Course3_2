const redis = require("redis");

const numRequest = 10000;


async function start() {
        const client = await redis.createClient()
            .on("error", (err) => console.log("Redis Client Error", err))
            .connect();

    console.log("Success");
    
    let start = new Date().getTime();
    for (i = 0; i < numRequest; i++) {
        await client.set(`${i}`, `set${i}`);
    }
    let end = new Date().getTime();

    console.log(`Set: ${end - start}ms`);


    start = new Date().getTime();
    for (i = 0; i < numRequest; i++) {
        await client.get(`${i}`);
    }
    end = new Date().getTime();

    console.log(`Get: ${end - start}ms`);


    start = new Date().getTime();
    for (i = 0; i < numRequest; i++) {
        await client.del(`${i}`);
    }
    end = new Date().getTime();

    console.log(`Del: ${(end - start)}ms`);

}

start();