const { PrismaClient } = require("@prisma/client");

class Database {
    constructor() {
        this.prisma = new PrismaClient();
    }


    // получения информации о факультетах и связанных с ними кафедрами и преподавателями
    async getFluent(request, response) {
        try {
            const faculties = await this.prisma.fACULTY.findMany({
                include: {
                    PULPIT_PULPIT_FACULTYToFACULTY: {
                        include: {
                            TEACHER_TEACHER_PULPITToPULPIT: true,
                        },
                    },
                },
            });
        
            response.json(faculties);
        } catch (error) {
            response.status(500).json({ error: "An error occurred" });
        }
    }

    async transaction(request, response) {
        try {
            await this.prisma.$transaction(async (prisma) => {
                await prisma.aUDITORIUM.updateMany({
                    data: {
                        AUDITORIUM_CAPACITY: {
                            increment: 100,
                        },
                    },
                });

                throw new Error("Rollback");
            });
        } catch (err) {
            response.json(err);
        }
    }

    async getTask4(request, response) {
        const page = request.query.page ? parseInt(request.query.page) : 1;
        const perPage = 10;

        try {
            const skip = (page - 1) * perPage;
            const pulpits = await this.prisma.pULPIT.findMany({
                include: {
                    _count: {
                        select: { TEACHER_TEACHER_PULPITToPULPIT: true },
                    },
                },
                skip: skip,
                take: perPage,
            });

            response.status(200).json(pulpits);
        } catch (e) {
            console.error("Error executing query", e);
            response.status(500).json({ error: "Internal Server Error" });
        }
    }

    async allFaculties(request, response) {
        try {
            const all = await this.prisma.fACULTY.findMany();
            response.json(all);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async allPulpits(request, response) {
        try {
            const all = await this.prisma.pULPIT.findMany();
            response.json(all);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async allSubjects(request, response) {
        try {
            const all = await this.prisma.sUBJECT.findMany();
            response.json(all);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async allTeachers(request, response) {
        try {
            const all = await this.prisma.tEACHER.findMany();
            response.json(all);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async allAuditorium(request, response) {
        try {
            const all = await this.prisma.aUDITORIUM.findMany();
            response.json(all);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async allAuditoriumType(request, response) {
        try {
            const all = await this.prisma.aUDITORIUM_TYPE.findMany();
            response.json(all);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async getFacultyXYZ(request, response) {
        try {
            const code = request.params.value;

            const faculties = await this.prisma.fACULTY.findMany({
                where: {
                    FACULTY: code,
                },
                include: {
                    PULPIT_PULPIT_FACULTYToFACULTY: {
                        select: {
                            PULPIT: true,
                            SUBJECT_SUBJECT_PULPITToPULPIT: {
                                select: {
                                    SUBJECT_NAME: true,
                                },
                            },
                        },
                    },
                },
            });

            response.json(faculties);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async getAuditTypesXYZ(request, response) {
        try {
            const code = request.params.value;

            const types = await this.prisma.aUDITORIUM_TYPE.findMany({
                where: {
                    AUDITORIUM_TYPE: code,
                },
                include: {
                    AUDITORIUM_AUDITORIUM_AUDITORIUM_TYPEToAUDITORIUM_TYPE: {
                        select: {
                            AUDITORIUM: true,
                        },
                    },
                },
            });

            response.json(types);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async getAuditWithComp1(request, response) {
        try {
            const types = await this.prisma.aUDITORIUM.findMany({
                where: {
                    AUDITORIUM: {
                        contains: "-1",
                    },
                },
            });

            response.json(types);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async getPulpitsWithoutTeachers(request, response) {
        try {
            const teachers = await this.prisma.pULPIT.findMany({
                where: {
                    TEACHER_TEACHER_PULPITToPULPIT: {
                        none: {},
                    },
                },
            });

            response.json(teachers);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async getPulpitsWithVladimir(request, response) {
        try {
            const vladimirs = await this.prisma.pULPIT.findMany({
                where: {
                    TEACHER_TEACHER_PULPITToPULPIT: {
                        some: {
                            TEACHER_NAME: {
                                contains: "Владимир",
                            },
                        },
                    },
                },
            });

            response.json(vladimirs);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async getAuditSameCount(request, response) {
        try {
            const audits = await this.prisma.aUDITORIUM.groupBy({
                by: ["AUDITORIUM_TYPE", "AUDITORIUM_CAPACITY"],
                _count: true,
            });

            response.json(audits);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async postFaculty(request, response) {
        try {
            const { FACULTY, FACULTY_NAME, PULPITS } = request.body;

            let faculty;

            if (PULPITS != null && PULPITS.length > 0) {
                faculty = await this.prisma.fACULTY.create({
                    data: {
                        FACULTY: FACULTY,
                        FACULTY_NAME: FACULTY_NAME,
                        PULPIT_PULPIT_FACULTYToFACULTY: {
                            create: PULPITS.map((pulpit) => ({
                                PULPIT: pulpit.PULPIT,
                                PULPIT_NAME: pulpit.PULPIT_NAME,
                            })),
                        },
                    },
                    include: {
                        PULPIT_PULPIT_FACULTYToFACULTY: true,
                    },
                });
            } else {
                faculty = await this.prisma.fACULTY.create({
                    data: {
                        FACULTY: FACULTY,
                        FACULTY_NAME: FACULTY_NAME,
                    },
                });
            }
            response.json(faculty);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async postPulpit(request, response) {
        try {
            const { FACULTY, FACULTY_NAME, PULPIT, PULPIT_NAME } = request.body;

            let faculty = await this.prisma.fACULTY.findUnique({
                where: { FACULTY },
            });

            if (!faculty) {
                faculty = await this.prisma.fACULTY.create({
                    data: {
                        FACULTY,
                        FACULTY_NAME,
                    },
                });
            }

            const pulpit = await this.prisma.pULPIT.create({
                data: {
                    PULPIT,
                    PULPIT_NAME,
                    FACULTY: faculty.FACULTY,
                },
            });

            response.json(pulpit);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async postSubject(request, response) {
        try {
            const { SUBJECT, SUBJECT_NAME, PULPIT } = request.body;

            let pulpit = await this.prisma.pULPIT.findUnique({
                where: { PULPIT },
            });

            if (!pulpit) {
                response.json("PULPIT does not exist!");
                return;
            }

            const subject = await this.prisma.sUBJECT.create({
                data: {
                    SUBJECT,
                    SUBJECT_NAME,
                    PULPIT: pulpit.PULPIT,
                },
            });

            response.json(subject);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async postTeacher(request, response) {
        try {
            const { TEACHER, TEACHER_NAME, PULPIT } = request.body;

            let pulpit = await this.prisma.pULPIT.findUnique({
                where: { PULPIT },
            });

            if (!pulpit) {
                response.json("PULPIT does not exist!");
                return;
            }

            const teacher = await this.prisma.tEACHER.create({
                data: {
                    TEACHER,
                    TEACHER_NAME,
                    PULPIT: pulpit.PULPIT,
                },
            });
            response.json(teacher);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async postAuditTypes(request, response) {
        try {
            const { AUDITORIUM_TYPE, AUDITORIUM_TYPENAME } = request.body;

            const type = await this.prisma.aUDITORIUM_TYPE.create({
                data: {
                    AUDITORIUM_TYPE,
                    AUDITORIUM_TYPENAME,
                },
            });

            response.json(type);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async postAudit(request, response) {
        try {
            const {
                AUDITORIUM,
                AUDITORIUM_NAME,
                AUDITORIUM_CAPACITY,
                AUDITORIUM_TYPE,
            } = request.body;

            let type = await this.prisma.aUDITORIUM_TYPE.findUnique({
                where: { AUDITORIUM_TYPE },
            });

            if (!type) {
                response.json("AUDITORIUM_TYPE does not exist!");
                return;
            }

            const audit = await this.prisma.aUDITORIUM.create({
                data: {
                    AUDITORIUM,
                    AUDITORIUM_NAME,
                    AUDITORIUM_CAPACITY,
                    AUDITORIUM_TYPE: type.AUDITORIUM_TYPE,
                },
            });

            response.json(audit);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async putFaculty(request, response) {
        try {
            const { FACULTY, FACULTY_NAME } = request.body;

            const faculty = await this.prisma.fACULTY.update({
                where: {
                    FACULTY,
                },
                data: { FACULTY_NAME },
            });

            response.json(faculty);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async putPulpit(request, response) {
        try {
            const { PULPIT, PULPIT_NAME, FACULTY } = request.body;

            const pulpit = await this.prisma.pULPIT.update({
                where: {
                    PULPIT,
                },
                data: {
                    PULPIT_NAME,
                    FACULTY,
                },
            });

            response.json(pulpit);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async putSubject(request, response) {
        try {
            const { SUBJECT, SUBJECT_NAME, PULPIT } = request.body;

            const subject = await this.prisma.sUBJECT.update({
                where: {
                    SUBJECT: SUBJECT,
                },
                data: {
                    SUBJECT_NAME,
                    PULPIT,
                },
            });

            response.json(subject);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async putTeacher(request, response) {
        try {
            const { TEACHER, TEACHER_NAME, PULPIT } = request.body;

            const teacher = await this.prisma.tEACHER.update({
                where: {
                    TEACHER,
                },
                data: {
                    TEACHER_NAME,
                    PULPIT,
                },
            });

            response.json(teacher);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async putAuditType(request, response) {
        try {
            const { AUDITORIUM_TYPE, AUDITORIUM_TYPENAME } = request.body;

            const type = await this.prisma.aUDITORIUM_TYPE.update({
                where: { AUDITORIUM_TYPE },
                data: {
                    AUDITORIUM_TYPENAME,
                },
            });

            response.json(type);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async putAudit(request, response) {
        try {
            const {
                AUDITORIUM,
                AUDITORIUM_NAME,
                AUDITORIUM_CAPACITY,
                AUDITORIUM_TYPE,
            } = request.body;
            console.log(AUDITORIUM);
            const audit = await this.prisma.aUDITORIUM.update({
                where: { AUDITORIUM },
                data: {
                    AUDITORIUM_NAME,
                    AUDITORIUM_CAPACITY,
                    AUDITORIUM_TYPE,
                },
            });

            response.json(audit);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async deleteFaculty(request, response) {
        try {
            const code = request.params.value;

            const faculty = await this.prisma.fACULTY.delete({
                where: {
                    FACULTY: code,
                },
            });

            response.json(faculty);
        } catch (err) {
            response.status(500).json(err);
        }
    }

    async deletePulpit(request, response) {
        try {
            const code = request.params.value;

            const pulpit = await this.prisma.pULPIT.delete({
                where: {
                    PULPIT: code,
                },
            });

            response.json(pulpit);
        } catch (err) {
            response.status(500).json(err);
        }
    }
    async deleteSubject(request, response) {
        try {
            const code = request.params.value;

            const subject = await this.prisma.sUBJECT.delete({
                where: {
                    SUBJECT: code,
                },
            });

            response.json(subject);
        } catch (err) {
            response.status(500).json(err);
        }
    }
    async deleteTeacher(request, response) {
        try {
            const code = request.params.value;

            const teacher = await this.prisma.tEACHER.delete({
                where: {
                    TEACHER: code,
                },
            });

            response.json(teacher);
        } catch (err) {
            response.status(500).json(err);
        }
    }
    async deleteAuditType(request, response) {
        try {
            const code = request.params.value;

            const type = await this.prisma.aUDITORIUM_TYPE.delete({
                where: {
                    AUDITORIUM_TYPE: code,
                },
            });

            response.json(type);
        } catch (err) {
            response.status(500).json(err);
        }
    }
    async deleteAudit(request, response) {
        try {
            const code = request.params.value;

            const audit = await this.prisma.aUDITORIUM.delete({
                where: {
                    AUDITORIUM: code,
                },
            });

            response.json(audit);
        } catch (err) {
            response.status(500).json(err);
        }
    }
}

module.exports = Database;
