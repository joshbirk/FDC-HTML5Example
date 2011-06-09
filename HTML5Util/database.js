var filesDB;

var workingRecords;
var workingRecordsComplete = false;
var completeCallback;

/*! Initialize the filesDB global variable. */
function initDB()
{
 if(window.openDatabase) {
		var shortName = 'apex_json_files';
        var version = '1.0';
        var displayName = 'JSON Offline Storage';
        var maxSize = 65536; // in bytes
        filesDB = openDatabase(shortName, version, displayName, maxSize);
 		createTable();
		}
}


/*! This creates the database tables. */
function createTable()
{
 
	filesDB.transaction(
    function (transaction) {
        transaction.executeSql('CREATE TABLE IF NOT EXISTS files(id VARCHAR NOT NULL PRIMARY KEY, LastModified TIMESTAMP NOT NULL, name TEXT NOT NULL, json BLOB NOT NULL DEFAULT "");', [], nullDataHandler, killTransaction);
    	}
	);
}

function saveRecords(name,records, callback) {
	workingRecords = records.length;
	workingRecordsComplete = false;
	if(callback != null) { completeCallback = callback; }
	for(var i = 0; i < records.length; i++) {
		saveJSON(records[i].Id,name,JSON.stringify(records[i]));
	}
}
 
function saveJSON(id,name,json) {
	if(!filesDB) { return false; }
    filesDB.transaction(function (tx) {
		tx.executeSql("SELECT id from files where id = ?",[id], function(tx,result) {
			if(result.rows.length > 0) {
				console.log('updating');
				updateJSON(id,name,json);
			} else {
				console.log('inserting');
				insertJSON(id,name,json);
			}
			
		}
		)
	}
	);
} 

function touchJSON(id,name) {
	if(!filesDB) { return false; }
	filesDB.transaction(function (tx) {
		tx.executeSql("SELECT id from files where id = ?",[id], function(tx,result) {
			if(result.rows.length == 0) { insertJSON(id,name,''); }
		}
		)
	}
	);
}
 
function insertJSON(id,name,json)
{ 
    if(!filesDB) { return false; }
    filesDB.transaction(function (tx) 
        {
            tx.executeSql("INSERT INTO files (id,name,LastModified,json) VALUES (?, ?, ?, ?)", [id,name,new Date().getTime(),json]);
         //   console.log("INSERT INTO files (id,name,LastModified,json) VALUES ('"+id+"', '"+name+"', "+new Date()+", '"+json+"')");
         	workingRecords--;
			if(workingRecords == 0) { 
				workingRecordsComplete = true; 
				if(completeCallback != null) {completeCallback();}
				completeCallback = null;
			}
        }); 
} 

function updateJSON(id,name,json)
{ 
    if(filesDB) {
    filesDB.transaction(function (tx) 
        {
            tx.executeSql("UPDATE files SET json = ?, LastModified = ? where id = ?", [json,new Date().getTime(),id]);
         //   console.log('updated '+id+' for '+name+' with '+json);
         	workingRecords--;
			if(workingRecords == 0) { 
				workingRecordsComplete = true; 
				if(completeCallback != null) {completeCallback();}
				completeCallback = null;
			}
        }); 
    }
}
 
 
/*! Mark a file as "deleted". */
function deleteJSON(id)
{
    filesDB.transaction(function (tx) 
        {
            tx.executeSql("DELETE FROM files where id = ?", [id]);
        });
 
}

function loadJSON(name, callback) {
	if(filesDB) {
	filesDB.transaction(function (tx) {
			tx.executeSql("SELECT id, name, json, LastModified from files where name = ?",[name], callback)
		}
	); 
	} else {callback(null,false);}
} 



 
/*! When passed as the error handler, this silently causes a transaction to fail. */
function killTransaction(transaction, error)
{
    return true; // fatal transaction error
}
 
/*! This is used as a data handler for a request that should return no data. */
function nullDataHandler(transaction, results)
{
}
 

initDB();