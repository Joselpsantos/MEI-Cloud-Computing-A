<?php
include '_dotenv.php'; 

// sessions.php
$dbh_read = null;
$dbh_write = null;
$db_table = '';

function open($savePath, $sessionName)
{
    global $dbh_read, $dbh_write, $db_table;

    $db_host = $_ENV['DB_HOST'];
    $db_port = $_ENV['DB_PORT'];
    $db_user_read = $_ENV['DB_USER_READ'];
    $db_pass_read = $_ENV['DB_PASS_READ'];
    $db_user_write = $_ENV['DB_USER_WRITE'];
    $db_pass_write = $_ENV['DB_PASS_WRITE'];
    $db_name = $_ENV['DB_NAME'];
    $db_table = 'data_table';

    try {
        $dbh_read = new PDO("pgsql:host=$db_host;port=$db_port;dbname=$db_name", $db_user_read, $db_pass_read);
        $dbh_write = new PDO("pgsql:host=$db_host;port=$db_port;dbname=$db_name", $db_user_write, $db_pass_write);
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
        exit;
    }

    return true;
}

function close(){
    global $dbh_read, $dbh_write;
    $dbh_read = null;
    $dbh_write = null;
    return true;
}

function read($id){
    global $dbh_read, $db_table;
    $q = $dbh_read->prepare("SELECT data FROM $db_table WHERE id=?");
    $q->bindParam(1, $id);
    if ( $q->execute() ) {
        if ($q->rowCount() == 0)
            return '';
        return $q->fetchColumn();
    }
    return false;
}

function write($id, $data) {
    global $dbh_write, $db_table;
    $ts = date('YmdHis');
    $q = $dbh_write->prepare("INSERT INTO $db_table (id, data, access) VALUES (?, ?, ?) ON CONFLICT (id) DO UPDATE SET data = EXCLUDED.data, access = EXCLUDED.access");
    $q->bindParam(1, $id);
    $q->bindParam(2, $data);
    $q->bindParam(3, $ts);

    return $q->execute();
}

function destroy($id){
    global $dbh_write, $db_table;
    $q = $dbh_write->prepare("DELETE FROM $db_table WHERE id=?");
    $q->bindParam(1, $id);
    return $q->execute();
}

function gc($maxlifetime){
    global $dbh_write, $db_table;
    $ts = date('YmdHis', time() - $maxlifetime);
    $q = $dbh_write->prepare("DELETE FROM $db_table WHERE access < ?");
    $q->bindParam(1, $ts);
    $q->execute();
    if ( $q->execute() )
        return $q->rowCount();
    return false;
}

session_set_save_handler('open','close','read','write','destroy','gc');
