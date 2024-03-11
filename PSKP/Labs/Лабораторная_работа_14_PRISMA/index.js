const express = require("express");
const Database = require("./db");

const app = express();
const db = new Database();
const PORT = 3000;

app.get("/", db.task4.bind(db))
app.get("/api/faculties", db.allFaculties.bind(db));
app.get("/api/pulpits", db.allPulpits.bind(db));
app.get("/api/subjects", db.allSubjects.bind(db));
app.get("/api/teachers", db.allTeachers.bind(db));
app.get("/api/auditoriumstypes", db.allAuditoriumType.bind(db));
app.get("/api/auditoriums", db.allAuditorium.bind(db));


app.get("/api/faculties/:value/subjects", db.getFacultyXYZ.bind(db));
app.get("/api/auditoriumtypes/:value/auditoriums", db.getAuditTypesXYZ.bind(db));

async function start() {
    await db.prisma.$connect();
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT}...`);
    });
}

start();