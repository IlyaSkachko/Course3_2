const { PrismaClient } = require("@prisma/client");

class Database {
    constructor() {
        this.prisma = new PrismaClient();
    }

    async task4(request, response) {
        response.sendFile(__dirname + "/index.html");
    }
    async allFaculties(request, response) {
        const all = await this.prisma.fACULTY.findMany();
        response.json(all);
    }

    async allPulpits(request, response) {
        const all = await this.prisma.pULPIT.findMany();
        response.json(all);
    }
    async allSubjects(request, response) {
        const all = await this.prisma.sUBJECT.findMany();
        response.json(all);
    }
    async allTeachers(request, response) {
        const all = await this.prisma.tEACHER.findMany();
        response.json(all);
    }
    async allAuditorium(request, response) {
        const all = await this.prisma.aUDITORIUM.findMany();
        response.json(all);
    }
    async allAuditoriumType(request, response) {
        const all = await this.prisma.aUDITORIUM_TYPE.findMany();
        response.json(all);
    }
    async getFacultyXYZ(request, response) {
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
    }

    async getAuditTypesXYZ(request, response) {
        const code = request.params.value;

        const types = await this.prisma.aUDITORIUM_TYPE.findMany({
            where: {
                AUDITORIUM_TYPE: code,
            },
            include: {
                AUDITORIUM_AUDITORIUM_AUDITORIUM_TYPEToAUDITORIUM_TYPE: {
                    select: {
                        AUDITORIUM: true
                    },
                },
            },
        });
        
        response.json(types);
    }
}

module.exports = Database;
