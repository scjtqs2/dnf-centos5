<?php
/**
 *  数据库密码加密后的key的算法。
 */

// 自定义的 8 位数据库密码

$pwd1 = 'uu5!^%jg';

// 加密后的数据库密码

$pwd2 = '4ae98a7fa5e08783e8b10c1f8bc3595be8b10c1f8bc3595b';

// 以下无需改

$key = '74726f716b64646d74726f716b63646d';

$postfix = 'e8b10c1f8bc3595be8b10c1f8bc3595b';

$res1 = encrypt($pwd1, $key);

$res2 = decrypt(substr($pwd2, 0, 16), $key);

echo '加密：';

echo '
';

echo '明文：' . $pwd1;

echo '
';

echo '密文：' . $res1 . $postfix;

echo '
';

echo '
';

echo '解密：';

echo '
';

echo '密文：' . $pwd2;

echo '
';

echo '明文：' . $res2;

function encrypt($v, $k)

{
// $v0 = bytes_to_long(substr($v, 0, 4));

    $v0 = _str2long(substr($v, 0, 4))[1];

// $v1 = bytes_to_long(substr($v, 4));

    $v1 = _str2long(substr($v, 4))[1];

    $sum = 0;

    for ($i = 0; $i < 32; ++$i) {
// $tv1 = toUInt32(toUInt32($v1 << 4)) ^ toUInt32(($v1 >> 5 & 0x07FFFFFF));

        $tv1 = ($v1 << 4) ^ ($v1 >> 5 & 0x07FFFFFF);

        $tv2 = unpack('V', substr(hex2bin($k), ($sum & 3) * 4, 4))[1];

// $v0 = toUInt32($v0 + (toUInt32($tv1 + $v1) ^ toUInt32($tv2 + $sum)));

        $v0 = (int)($v0 + (($tv1 + $v1) ^ ($tv2 + $sum)));

// $sum = toUInt32($sum + 0x9E3779B9);

        $sum += 0x9E3779B9;

// $tv1 = toUInt32(toUInt32(toUInt32($v0 << 4)) ^ toUInt32(($v0 >> 5 & 0x07FFFFFF)));

        $tv1 = ($v0 << 4) ^ ($v0 >> 5 & 0x07FFFFFF);

// $tv2 = unpack ('V', substr(hex2bin($k), (toUInt32($sum >> 11) & 3) * 4, 4))[1];

        $tv2 = unpack('V', substr(hex2bin($k), (($sum >> 11) & 3) * 4, 4))[1];

// $v1 = toUInt32($v1 + (toUInt32($tv1 + $v0) ^ toUInt32($tv2 + $sum)));

        $v1 += (int)(($tv1 + $v0) ^ ($tv2 + $sum));

    }

// return bin2hex(long_to_bytes($v0, 4)) . bin2hex(long_to_bytes($v1, 4));

    return bin2hex(_long2str($v0)) . bin2hex(_long2str($v1));

}

function decrypt($v, $k)

{
// $v0 = bytes_to_long(hex2bin(substr($v, 0, 8)));

    $v0 = _str2long(hex2bin(substr($v, 0, 8)))[1];

// $v1 = bytes_to_long(hex2bin(substr($v, 8)));

    $v1 = _str2long(hex2bin(substr($v, 8)))[1];

    $sum = 0xC6EF3720;

    for ($i = 0; $i < 32; ++$i) {
// $tv1 = toUInt32(toUInt32(toUInt32($v0 << 4)) ^ toUInt32(($v0 >> 5 & 0x07FFFFFF)));

        $tv1 = ($v0 << 4) ^ ($v0 >> 5 & 0x07FFFFFF);

// $tv2 = unpack ('V', substr(hex2bin($k), (toUInt32($sum >> 11) & 3) * 4, 4))[1];

        $tv2 = unpack('V', substr(hex2bin($k), (($sum >> 11) & 3) * 4, 4))[1];

// $v1 = toUInt32($v1 - (toUInt32($tv1 + $v0) ^ toUInt32($tv2 + $sum)));

        $v1 -= (int)(($tv1 + $v0) ^ ($tv2 + $sum));

// $sum = toUInt32($sum - 0x9E3779B9);

        $sum -= 0x9E3779B9;

// $tv1 = toUInt32(toUInt32($v1 << 4)) ^ toUInt32(($v1 >> 5 & 0x07FFFFFF));

        $tv1 = ($v1 << 4) ^ ($v1 >> 5 & 0x07FFFFFF);

        $tv2 = unpack('V', substr(hex2bin($k), ($sum & 3) * 4, 4))[1];

// $v0 = toUInt32($v0 - (toUInt32($tv1 + $v1) ^ toUInt32($tv2 + $sum)));

        $v0 = (int)($v0 - (($tv1 + $v1) ^ ($tv2 + $sum)));

    }

// return long_to_bytes($v0, 4) . long_to_bytes($v1, 4);

    return _long2str($v0) . _long2str($v1);

}

function _str2long($v)

{
    return unpack('N', $v);

}

function _long2str($v)

{
    return pack('N', $v);

}

function bytes_to_long($v)

{
    $a = (0xFFFFFFFF & ord($v{0})) << 24;

    $b = (0xFFFFFFFF & ord($v{1})) << 16;

    $c = (0xFFFFFFFF & ord($v{2})) << 8;

    $d = ord($v{3});

    return $a + $b + $c + $d;

}

function long_to_bytes($v)

{
    $a = (0xFF000000 & $v) >> 24;

    $b = (0xFF0000 & $v) >> 16;

    $c = (0xFF00 & $v) >> 8;

    $d = 0xFF & $v;

    $tmp = pack('CCCC', $a, $b, $c, $d);

    return $tmp;

}
