const express = require("express");
const Database = require("./db");

const app = express();
const db = new Database();
const PORT = 3000;

app.use(express.json());
app.use(express.static(__dirname));

app.get("/transaction", db.transaction.bind(db));
app.get("/fluent", db.getFluent.bind(db));
app.get("/task4", db.getTask4.bind(db))
app.get("/api/faculties", db.allFaculties.bind(db));
app.get("/api/pulpits", db.allPulpits.bind(db));
app.get("/api/subjects", db.allSubjects.bind(db));
app.get("/api/teachers", db.allTeachers.bind(db));
app.get("/api/auditoriumstypes", db.allAuditoriumType.bind(db));
app.get("/api/auditoriums", db.allAuditorium.bind(db));
app.get("/api/faculties/:value/subjects", db.getFacultyXYZ.bind(db));
app.get("/api/auditoriumtypes/:value/auditoriums", db.getAuditTypesXYZ.bind(db));
app.get("/api/auditoriumsWithComp1", db.getAuditWithComp1.bind(db));
app.get("/api/puplitsWithoutTeachers", db.getPulpitsWithoutTeachers.bind(db));
app.get("/api/pulpitsWithVladimir", db.getPulpitsWithVladimir.bind(db));
app.get("/api/auditoriumsSameCount", db.getAuditSameCount.bind(db));


app.post("/api/faculties", db.postFaculty.bind(db));
app.post("/api/pulpits", db.postPulpit.bind(db));
app.post("/api/subjects", db.postSubject.bind(db));
app.post("/api/teachers", db.postTeacher.bind(db));
app.post("/api/auditoriumstypes", db.postAuditTypes.bind(db));
app.post("/api/auditoriums", db.postAudit.bind(db));


app.put("/api/faculties", db.putFaculty.bind(db));
app.put("/api/pulpits", db.putPulpit.bind(db));
app.put("/api/subjects", db.putSubject.bind(db));
app.put("/api/teachers", db.putTeacher.bind(db));
app.put("/api/auditoriumstypes", db.putAuditType.bind(db));
app.put("/api/auditoriums", db.putAudit.bind(db));


app.delete("/api/faculties/:value", db.deleteFaculty.bind(db));
app.delete("/api/pulpits/:value", db.deletePulpit.bind(db));
app.delete("/api/subjects/:value", db.deleteSubject.bind(db));
app.delete("/api/teachers/:value", db.deleteTeacher.bind(db));
app.delete("/api/auditoriumstypes/:value", db.deleteAuditType.bind(db));
app.delete("/api/auditoriums/:value", db.deleteAudit.bind(db));



async function start() {
    await db.prisma.$connect();
    app.listen(PORT, () => {
        console.log(`Server is running on port ${PORT}...`);
    });
}

start();