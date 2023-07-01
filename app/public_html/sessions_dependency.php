<?php

include '_dotenv.php'; 

 //sessions.php
 $dbh = null;
 $db_table = '';

 function open($savePath, $sessionName){
  global $dbh, $db_table;

  $db_name = 'mydatabase';
  $db_user = 'myuser';
  $db_pass = 'mypassword';
  $db_host = '192.168.44.30';
  $db_port = 5432;
  $db_table = 'data_table';
   
   
  try {
   $dbh = new PDO("pgsql:host=$db_host;port=$db_port;dbname=$db_name", $db_user, $db_pass);
  } catch (PDOException $e) {
   echo "Error: $e->getMessage()";
   exit;
  }
   return true;
 }

 function close(){
  global $dbh;
  $dbh = null;
  return true;
 }

 function read($id){
  global $dbh, $db_table;
  $q = $dbh->prepare("SELECT data FROM $db_table WHERE id=?");
  $q->bindParam(1, $id);
  if ( $q->execute() ) {
   if ($q->rowCount() == 0)
    return '';
   return $q->fetchColumn();
  }
  return false;
 }

 function write($id, $data) {
    global $dbh, $db_table;
    $ts = date('YmdHis');
    $q = $dbh->prepare("INSERT INTO $db_table (id, data, access) VALUES (?, ?, ?) ON CONFLICT (id) DO UPDATE SET data = EXCLUDED.data, access = EXCLUDED.access");
    $q->bindParam(1, $id);
    $q->bindParam(2, $data);
    $q->bindParam(3, $ts);

    return $q->execute();
}

 function destroy($id){
  global $dbh, $db_table;
  $q = $dbh->prepare("DELETE FROM $db_table WHERE id=?");
  $q->bindParam(1, $id);
  return $q->execute();
 }

 function gc($maxlifetime){
  global $dbh, $db_table;
  $ts = date('YmdHis', time() - $maxlifetime);
  $q = $dbh->prepare("DELETE FROM $db_table WHERE access < ?");
  $q->bindParam(1, $ts);
  $q->execute();
  if ( $q->execute() )
   return $q->rowCount();
  return false;
 }
 
 session_set_save_handler('open','close','read','write','destroy','gc');