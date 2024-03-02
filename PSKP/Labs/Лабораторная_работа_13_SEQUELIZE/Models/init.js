const {Op} = require('sequelize');


const DataTypes = require("sequelize").DataTypes;
const AUDITORIUM = require("./AUDITORIUM");
const AUDITORIUM_TYPE = require("./AUDITORIUM_TYPE");
const FACULTY = require("./FACULTY");
const PULPIT = require("./PULPIT");
const SUBJECT = require("./SUBJECT");
const TEACHERS = require("./TEACHERS");

function initModels(sequelize) {
  let auditorium = AUDITORIUM(sequelize, DataTypes);
  let auditorium_type = AUDITORIUM_TYPE(sequelize, DataTypes);
  let faculty = FACULTY(sequelize, DataTypes);
  let pulpit = PULPIT(sequelize, DataTypes);
  let subject = SUBJECT(sequelize, DataTypes);
  let teachers = TEACHERS(sequelize, DataTypes);

  auditorium.belongsTo(auditorium_type, { as: "AUDITORIUM_TYPE_AUDITORIUM_TYPE", foreignKey: "AUDITORIUM_TYPE"});
  auditorium_type.hasMany(auditorium, { as: "AUDITORIa", foreignKey: "AUDITORIUM_TYPE"});
  pulpit.belongsTo(faculty, { as: "FACULTY_FACULTY", foreignKey: "FACULTY"});
  faculty.hasMany(pulpit, { as: "PULPITs", foreignKey: "FACULTY"});
  subject.belongsTo(pulpit, { as: "PULPIT_PULPIT", foreignKey: "PULPIT"});
  pulpit.hasMany(subject, { as: "SUBJECTs", foreignKey: "PULPIT"});
  teachers.belongsTo(pulpit, { as: "PULPIT_PULPIT", foreignKey: "PULPIT"});
  pulpit.hasMany(teachers, { as: "TEACHERs", foreignKey: "PULPIT"});

  faculty.beforeCreate((faculty, options) => {
    console.log('BEFORE CREATE')
  })
  
  faculty.afterCreate((faculty, options) => {
    console.log('AFTER CREATE')
  })

  auditorium.addScope("Capacity",{
    where:{
      AUDITORIUM_CAPACITY:{
      [Op.between]:[10,60]
      }
    }
  })

  return {
    auditorium,
    auditorium_type,
    faculty,
    pulpit,
    subject,
    teachers,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;

