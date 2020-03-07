<?php
/**
 * Created by PhpStorm.
 * User: scjtqs
 * Date: 2020/3/6
 * Time: 01:33
 */
$PublicIp=$_SERVER['PublicIp'];
$cmd1=<<<EOL
    sed -i "s/Public IP/{$PublicIp}/g" `find /home/neople/ -type f -name "*.cfg"`
EOL;
exec($cmd1);

#修改mysql中的ip TODO
