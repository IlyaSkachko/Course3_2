const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('TEACHERS', {
    TEACHER: {
      type: DataTypes.STRING(10),
      allowNull: false,
      primaryKey: true
    },
    TEACHER_NAME: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    PULPIT: {
      type: DataTypes.STRING(10),
      allowNull: false,
      references: {
        model: 'PULPIT',
        key: 'PULPIT'
      }
    }
  }, {
    sequelize,
    tableName: 'TEACHER',
    schema: 'dbo',
    timestamps: false,
    indexes: [
      {
        name: "PK_TEACHER",
        unique: true,
        fields: [
          { name: "TEACHER" },
        ]
      },
    ]
  });
};
