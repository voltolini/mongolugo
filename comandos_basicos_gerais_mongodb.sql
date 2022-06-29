'-------------------------------------
--# Comandos basicos (geral) MongoDB
-------------------------------------'


--# Log do banco

/var/log/mongodb/mongod.log



--# Listar objetos com mais transações

mongotop --port 27017 -u root -p root  --authenticationDatabase admin




--# Conectar no banco de dados

mongo --port 27017 -u root -p root  --authenticationDatabase admin




--# Versão do banco

db.version()



--# Consultar databases

show dbs



--# Conectar no database desejado

use concreto


--# Exibir nome do database conectado

db


--# Listar tabelas do database

show collections


--# Status das conexões

db.serverStatus().connections


--# Consultar sessões bloqueadoras

db.adminCommand({
 "currentOp": true,
 "waitingForLock" : true,
 "$or": [
    { "op" : { "$in" : [ "insert", "update", "remove" ] } },
    { "query.findandmodify": { "$exists": true } }
  ]
})



--# Tamanho das tabelas do database

function getReadableFileSizeString(fileSizeInBytes) {
  var i = -1;
  var byteUnits = [' kB',' MB',' GB',' TB','PB','EB','ZB','YB'];
  do {
    fileSizeInBytes = fileSizeInBytes / 1024;
    i++;
  } while (fileSizeInBytes > 1024);
  return Math.max(fileSizeInBytes, 0.1).toFixed(1) + byteUnits[i];
};
var collectionNames = db.getCollectionNames(), stats = [];
collectionNames.forEach(function (n) { stats.push(db.getCollection(n).stats()); });
stats = stats.sort(function(a, b) { return b['size'] - a['size']; });
for (var c in stats) { print(stats[c]['ns'] + ": " + getReadableFileSizeString(stats[c]['size']) + " (" + getReadableFileSizeString(stats[c]['storageSize']) + ")"); }
