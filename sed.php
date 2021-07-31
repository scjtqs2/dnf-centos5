<?php
/**
 * Created by PhpStorm.
 * User: scjtqs
 * Date: 2020/3/6
 * Time: 01:33
 */

#修改mysql中的ip
$DB_HOST=$_SERVER['DB_HOST'];
$DB_KEY=$_SERVER['DB_KEY'];
$DB_NAME=$_SERVER['DB_USER'];
$DB_PASS=$_SERVER['DB_PASS'];

//php5.3，使用mysql_connect方法。
$time=time();
//$con = mysql_connect($DB_HOST,"game","uu5!^%jg");
$con = mysql_connect($DB_HOST,$DB_NAME,$DB_PASS);
while (!$con)
{
    $con = mysql_connect($DB_HOST,$DB_NAME,$DB_PASS);
    sleep(2);
    $now=time();
    //10分钟连不上就断掉
    if($now-$time>=600){
        break;
    }
}
if (!$con)
{
    die('Could not connect: ' . mysql_error());
}
//选择db
mysql_select_db("d_taiwan", $con);
//更新db中的db_host地址
$sql="UPDATE db_connect SET host_name='{$DB_HOST}'";
mysql_query($sql);
//更新db中的db_key
$sql="UPDATE db_connect SET db_passwd='{$DB_KEY}'";
mysql_query($sql);
//更新db中的db_name
$sql="UPDATE db_connect SET db_name='{$DB_NAME}'";

mysql_close($con);