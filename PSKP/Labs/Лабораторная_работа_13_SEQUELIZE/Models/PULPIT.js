const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PULPIT', {
    PULPIT: {
      type: DataTypes.STRING(10),
      allowNull: false,
      primaryKey: true
    },
    PULPIT_NAME: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    FACULTY: {
      type: DataTypes.STRING(10),
      allowNull: false,
      references: {
        model: 'FACULTY',
        key: 'FACULTY'
      }
    }
  }, {
    sequelize,
    tableName: 'PULPIT',
    schema: 'dbo',
    timestamps: false,
    indexes: [
      {
        name: "PK_PULPIT",
        unique: true,
        fields: [
          { name: "PULPIT" },
        ]
      },
    ]
  });
};
