const http = require("http");
const fs = require("fs");
const sequelize = require("sequelize");
const models = require("./Models/init");
const qs = require("querystring");
const url = require("url");
const SUBJECT = require("./Models/SUBJECT");
const FACULTY = require("./Models/FACULTY");
const PULPIT = require("./Models/PULPIT");
const AUDITORIUM = require("./Models/AUDITORIUM");
const AUDITORIUM_TYPE = require("./Models/AUDITORIUM_TYPE");
const TEACHERS = require("./Models/TEACHERS");

const seq = new sequelize("SIA", "Ilya", "123", {
    dialect: "mssql",
    port: 1433,
    hooks: {
        beforeBulkDestroy: (options) => {
            console.log("BEFORE DESTROY");
        },
    },
    dialectOptions: {
        options: {
            useUTC: false,
            dateFirst: 1,
        },
        pool: {
            max: 5,
            min: 1,
            idle: 10000,
        },
    },
});

http.createServer(function (request, response) {
    if (request.method == "GET") {
        if (request.url == "/") {
            fs.readFile("index.html", (err, data) => {
                response.end(data);
            });
        }
        if (request.url == "/api/teachers") {
            response.setHeader(
                "Content-Type",
                "application/json; charset=utf-8;"
            );
            models
                .initModels(seq)
                .teachers.findAll()
                .then((x) => {
                    response.end(JSON.stringify(x));
                });
        }
        if (request.url == "/api/pulpits") {
            response.setHeader(
                "Content-Type",
                "application/json; charset=utf-8;"
            );
            models
                .initModels(seq)
                .pulpit.findAll()
                .then((x) => {
                    response.end(JSON.stringify(x));
                });
        }
        if (request.url == "/api/auditoriums") {
            response.setHeader(
                "Content-Type",
                "application/json; charset=utf-8;"
            );
            models
                .initModels(seq)
                .auditorium.scope("Capacity")
                .findAll()
                .then((x) => {
                    response.end(JSON.stringify(x));
                });
        }
        if (request.url == "/api/subjects") {
            response.setHeader(
                "Content-Type",
                "application/json; charset=utf-8;"
            );
            models
                .initModels(seq)
                .subject.findAll()
                .then((x) => {
                    response.end(JSON.stringify(x));
                });
        }
        if (request.url.startsWith("/api/faculties")) {
            const facultiesUrl = url.parse(request.url).pathname.split("/");
            console.log(facultiesUrl.length);
            if (facultiesUrl.length == 3) {
                response.setHeader(
                    "Content-Type",
                    "application/json; charset=utf-8;"
                );
                models
                    .initModels(seq)
                    .faculty.findAll()
                    .then((x) => {
                        response.end(JSON.stringify(x));
                    });
            } else if (
                facultiesUrl.length == 5 &&
                request.url.endsWith("subjects")
            ) {
                response.setHeader(
                    "Content-Type",
                    "application/json; charset=utf-8;"
                );
                const faculty = decodeURIComponent(facultiesUrl[3]);
                seq.authenticate().then(() => {
                    models
                        .initModels(seq)
                        .subject.findAll({
                            include: {
                                association: "PULPIT_PULPIT",
                                where: { FACULTY: faculty },
                                attributes: [["FACULTY", "Факультет"]],
                                include: {
                                    association: "FACULTY_FACULTY",
                                    attributes: [],
                                },
                            },
                            attributes: [["SUBJECT_NAME", "Название предмета"]],
                        })
                        .then((x) => {
                            response.end(JSON.stringify(x));
                        });
                });
            }
        }
        if (request.url.startsWith("/api/auditoriumstypes")) {
            const auditoriumsUrl = url.parse(request.url).pathname.split("/");
            console.log(auditoriumsUrl.length);
            if (auditoriumsUrl.length == 3) {
                response.setHeader(
                    "Content-Type",
                    "application/json; charset=utf-8;"
                );
                models
                    .initModels(seq)
                    .auditorium_type.findAll()
                    .then((x) => {
                        response.end(JSON.stringify(x));
                    });
            } else if (
                auditoriumsUrl.length == 5 &&
                request.url.endsWith("auditoriums")
            ) {
                response.setHeader(
                    "Content-Type",
                    "application/json; charset=utf-8;"
                );
                const auditorium = decodeURIComponent(auditoriumsUrl[3]);
                models
                    .initModels(seq)
                    .auditorium.findAll({
                        include: {
                            association: "AUDITORIUM_TYPE_AUDITORIUM_TYPE",
                            attributes: [["AUDITORIUM_TYPE", "Тип аудитории"]],
                            where: { AUDITORIUM_TYPE: auditorium },
                        },
                        attributes: [["AUDITORIUM", "Номер аудитории"]],
                    })
                    .then((x) => {
                        response.end(JSON.stringify(x));
                    });
            }
        }
    }
    if (request.method == "POST") {
        const urlMethod = url.parse(request.url).pathname;
        if (
            urlMethod == "/api/faculties" ||
            urlMethod == "/api/auditoriums" ||
            urlMethod == "/api/pulpits" ||
            urlMethod == "/api/subjects" ||
            urlMethod == "/api/teachers" ||
            urlMethod == "/api/auditoriumstypes"
        ) {
            const table = urlMethod.split("/");
            request.on("data", (chunk) => {
                var value = "";
                value += chunk;
                console.log(value);
                switch (table[2]) {
                    case "faculties":
                        models
                            .initModels(seq)
                            .faculty.create(JSON.parse(value))
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "auditoriums":
                        models
                            .initModels(seq)
                            .auditorium.create(JSON.parse(value))
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "auditoriumstypes":
                        models
                            .initModels(seq)
                            .auditorium_type.create(JSON.parse(value))
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "subjects":
                        models
                            .initModels(seq)
                            .subject.create(JSON.parse(value))
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "teachers":
                        models
                            .initModels(seq)
                            .teachers.create(JSON.parse(value))
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "pulpits":
                        models
                            .initModels(seq)
                            .pulpit.create(JSON.parse(value))
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                }
            });
        }
    }
    if (request.method == "PUT") {
        if (request.url == "/api/transaction") {
            seq.transaction({
                isolationLevel:
                    sequelize.Transaction.ISOLATION_LEVELS.READ_UNCOMMITTED,
            })
                .then((t) => {
                    return models
                        .initModels(seq)
                        .auditorium.update(
                            { AUDITORIUM_CAPACITY: 20 },
                            {
                                where: {
                                    AUDITORIUM_CAPACITY: {
                                        [sequelize.Op.gte]: 0,
                                    },
                                },
                                transaction: t,
                            }
                        )
                        .then((r) => {
                            console.log(r);
                            setTimeout(() => {
                                return t.rollback();
                            }, 10000);
                        })
                        .catch((e) => {
                            console.log(e.message);
                            return t.rollback();
                        });
                })
                .catch((error) => {
                    console.error("Unable to connect to the database:", error);
                });
        }

        const urlMethod = url.parse(request.url).pathname;

        if (
            urlMethod == "/api/faculties" ||
            urlMethod == "/api/auditoriums" ||
            urlMethod == "/api/pulpits" ||
            urlMethod == "/api/subjects" ||
            urlMethod == "/api/teachers" ||
            urlMethod == "/api/auditoriumstypes"
        ) {
            const table = urlMethod.split("/");
            request.on("data", (chunk) => {
                var value = "";
                value += chunk;
                value = JSON.parse(value);
                switch (table[2]) {
                    case "faculties":
                        models
                            .initModels(seq)
                            .faculty.update(
                                { FACULTY_NAME: value.FACULTY_NAME },
                                { where: { FACULTY: value.FACULTY } }
                            )
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "auditoriums":
                        models
                            .initModels(seq)
                            .auditorium.update(
                                {
                                    AUDITORIUM_NAME: value.AUDITORIUM_NAME,
                                    AUDITORIUM_CAPACITY:
                                        value.AUDITORIUM_CAPACITY,
                                    AUDITORIUM_TYPE: value.AUDITORIUM_TYPE,
                                },
                                { where: { AUDITORIUM: value.AUDITORIUM } }
                            )
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "auditoriumstypes":
                        models
                            .initModels(seq)
                            .auditorium_type.update(
                                {
                                    AUDITORIUM_TYPENAME:
                                        value.AUDITORIUM_TYPENAME,
                                },
                                {
                                    where: {
                                        AUDITORIUM_TYPE: value.AUDITORIUM_TYPE,
                                    },
                                }
                            )
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "subjects":
                        models
                            .initModels(seq)
                            .subject.update(
                                {
                                    SUBJECT_NAME: value.SUBJECT_NAME,
                                    PULPIT: value.PULPIT,
                                },
                                { where: { SUBJECT: value.SUBJECT } }
                            )
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "teachers":
                        models
                            .initModels(seq)
                            .teachers.update(
                                {
                                    TEACHER_NAME: value.TEACHER_NAME,
                                    PULPIT: value.PULPIT,
                                },
                                { where: { TEACHER: value.TEACHER } }
                            )
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                    case "pulpits":
                        models
                            .initModels(seq)
                            .pulpit.update(
                                { PULPIT_NAME: value.PULPIT_NAME },
                                { where: { PULPIT: value.PULPIT } }
                            )
                            .then(() => {
                                response.end(JSON.stringify(value));
                            })
                            .catch((err) => response.end(JSON.stringify(err)));
                        break;
                }
            });
        }
    }
    if (request.method == "DELETE") {
        const urlMethod = url.parse(request.url).pathname;
        const table = urlMethod.split("/");
        let value = null;
        if (request.url.startsWith("/api") && table.length == 4) {
            switch (table[2]) {
                case "faculties":
                    models
                        .initModels(seq)
                        .faculty.findOne({
                            where: { FACULTY: table[3] },
                        })
                        .then((value) => {
                            models
                                .initModels(seq)
                                .faculty.destroy({
                                    where: {
                                        FACULTY: decodeURIComponent(table[3]),
                                    },
                                })
                                .then(() => {
                                    response.end(JSON.stringify(value));
                                })
                                .catch((err) =>
                                    response.end(JSON.stringify(err))
                                );
                        })
                        .catch((err) => response.end(JSON.stringify(err)));
                    break;
                case "auditoriums":
                    models
                        .initModels(seq)
                        .auditorium.findOne({
                            where: { AUDITORIUM: table[3] },
                        })
                        .then((value) => {
                            models
                                .initModels(seq)
                                .auditorium.destroy({
                                    where: {
                                        AUDITORIUM: decodeURIComponent(
                                            table[3]
                                        ),
                                    },
                                })
                                .then(() => {
                                    response.end(JSON.stringify(value));
                                })
                                .catch((err) =>
                                    response.end(JSON.stringify(err))
                                );
                        })
                        .catch((err) => response.end(JSON.stringify(err)));
                    break;
                case "auditoriumstypes":
                    models
                        .initModels(seq)
                        .auditorium_type.findOne({
                            where: { AUDITORIUM_TYPE: table[3] },
                        })
                        .then((value) => {
                            models
                                .initModels(seq)
                                .auditorium_type.destroy({
                                    where: {
                                        AUDITORIUM_TYPE: decodeURIComponent(
                                            table[3]
                                        ),
                                    },
                                })
                                .then(() => {
                                    response.end(JSON.stringify(value));
                                })
                                .catch((err) =>
                                    response.end(JSON.stringify(err))
                                );
                        })
                        .catch((err) => response.end(JSON.stringify(err)));
                    break;
                case "subjects":
                    models
                        .initModels(seq)
                        .subject.findOne({
                            where: { SUBJECT: table[3] },
                        })
                        .then((value) => {
                            models
                                .initModels(seq)
                                .subject.destroy({
                                    where: {
                                        SUBJECT: decodeURIComponent(table[3]),
                                    },
                                })
                                .then(() => {
                                    response.end(JSON.stringify(value));
                                })
                                .catch((err) =>
                                    response.end(JSON.stringify(err))
                                );
                        })
                        .catch((err) => response.end(JSON.stringify(err)));
                    break;
                case "teachers":
                    models
                        .initModels(seq)
                        .teachers.findOne({
                            where: { TEACHER: table[3] },
                        })
                        .then((value) => {
                            models
                                .initModels(seq)
                                .teachers.destroy({
                                    where: {
                                        TEACHER: decodeURIComponent(table[3]),
                                    },
                                })
                                .then(() => {
                                    response.end(JSON.stringify(value));
                                })
                                .catch((err) =>
                                    response.end(JSON.stringify(err))
                                );
                        })
                        .catch((err) => response.end(JSON.stringify(err)));
                    break;
                case "pulpits":
                    models
                        .initModels(seq)
                        .pulpit.findOne({
                            where: { PULPIT: table[3] },
                        })
                        .then((value) => {
                            models
                                .initModels(seq)
                                .pulpit.destroy({
                                    where: {
                                        PULPIT: decodeURIComponent(table[3]),
                                    },
                                })
                                .then(() => {
                                    response.end(JSON.stringify(value));
                                })
                                .catch((err) =>
                                    response.end(JSON.stringify(err))
                                );
                        })
                        .catch((err) => response.end(JSON.stringify(err)));
                    break;
            }
        }
    }
}).listen(3000, () => {
    console.log("Server running port 3000...");
});
