<?php
/**
 * Created by PhpStorm.
 * User: scjtqs
 * Date: 2020/3/6
 * Time: 01:33
 */
$PublicIp=$_SERVER['PublicIp'];
$cmd1=<<<EOL
    sed -i "s/Public_Ip/{$PublicIp}/g" `find /home/neople/ -type f -name "*.tbl"`
EOL;
$cmd2=<<<EOL
    sed -i "s/Public_Ip/{$PublicIp}/g" `find /home/neople/ -type f -name "*.cfg"`
EOL;
exec($cmd1);
exec($cmd2);

#修改mysql中的ip TODO
