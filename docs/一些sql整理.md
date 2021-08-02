# 一些自己使用的sql整理
持续补充中。

## 获取在线用户
```sql
set names utf8;
-- 获取对应的mid列表 
SELECT m_id FROM `taiwan_login`.`login_account_3` WHERE login_status=1;
-- 拿到m_id 拼装一下。如： ids=1,2,3,4,5。也就是下一条的UID
SELECT * FROM `d_taiwan`.`accounts` WHERE UID IN(1,2,3,4,5)
```

## 账号登录
```sql
set names utf8;
-- 栗子。账号 test 密码 123456 密码的md5 e10adc3949ba59abbe56e057f20f883e
SELECT * FROM `d_taiwan`.`accounts` WHERE `accountname`="test" and `password`="e10adc3949ba59abbe56e057f20f883e";
-- 能查询到结果，那就是账号密码正确
```

## 发送邮件（附件内容)
```injectablephp
<?php
    protected $connection = [
        // 数据库类型
        'type'        => 'mysql',
        // 数据库连接DSN配置
        'dsn'         => '',
        // 服务器地址
        'hostname'    => '10.0.0.4',
        // 数据库名
        'database'    => 'taiwan_cain_2nd',
        // 数据库用户名
        'username'    => 'game',
        // 数据库密码
        'password'    => 'uu5!^%jg',
        // 数据库连接端口
        'hostport'    => '3306',
        // 数据库连接参数
        'params'      => [],
        // 数据库编码默认采用utf8
        'charset'     => 'utf8',
        // 数据库表前缀
        'prefix'      => '',
    ];
    protected $table="postal";

    /**
     * 发送邮件（附件内容）
     * Postal_id=邮件的ID 和letter_id一样自动递增
    Occ_time=发送时间
    Send_charac_no=发件人ID
    Send_charac_name=发件人名字
    发件人的ID和名字最好和letter的同步，没有同步大概也就是不会显示，具体后果怎么样我忘记了
    Receive_charac_no=收件人角色ID
    Item_id=物品代码
    Add_info=物品数量，装备的品级（最下级 下级 中级 上级 最上级）
    Endurance=装备的耐久度 物品的话不知道有什么用写0即可 装扮要写1
    Upgrade=装备的强化数值
    amplify_option=装备附加的红字属性 （力量 智力 体力 精神 ）
    amplify_value=装备附加的红字数值 最大65535
    （发送+31红字这个再写65535就是传说中的红字六万八）
    Gold=邮件附带的金币数量
    receive_time=邮件发送时间
    delete_flag=这个是删除状态 发送写0即可 角色领取了这个物品后就会自动变成1
    seal_flag=装备是否封装 0不封1封装 物品不知道什么用（SS切勿封装）
    发送宠物蛋的话也要写1封装一下
    creature_flag=这个可能是邮件类型吧，反正要发送宠物的话 这个要写1 其余写0即可
    letter_id=这个就是对应的邮件编号了，可以通过select语句来获得letter_id的最大值
    seperate_upgrade=装备的锻造等级
    unlimit_flag=装扮写1 宠物或物品或装备写0
     *
     * @param $charac_no int 角色id
     * @param $item_id int 物品代码
     * @param $add_info int 数量
     * @param $endurance string 装备耐久
     * @param $upgrade int 装备的强化数值
     * @param $gold integer 金币
     * @param $amplify_option integer 装备附加的红字属性
     * @param $amplify_value integer  装备附加的红字数值,最大65535
     * @param $seal_flag integer 是否封装
     * @param $creature_flag int 这个可能是邮件类型吧，反正要发送宠物的话 这个要写1 其余写0即可
     * @param $seperate_upgrade int 装备的锻造等级
     */
    public function sendPost($charac_no, $item_id, $add_info, $upgrade, $gold, $amplify_option, $amplify_value, $seal_flag, $seperate_upgrade,$endurance=0,$creature_flag=0,$unlimit_flag=0)
    {

        $litter_id=$this->sendLetter($charac_no);
        $data=[
            'occ_time'=>date('Y-m-d H:i:s'),
            'send_charac_no'=>0,
            'send_charac_name'=>'scjtqs Admin',
            'receive_charac_no'=>$charac_no,
            'item_id'=>$item_id,
            'add_info'=>$add_info,
            'endurance'=>$endurance,//装备耐久
            'upgrade'=>$upgrade,//装备的强化数值
            'amplify_option'=>$amplify_option,//装备附加的红字属性 （力量 智力 体力 精神 ）
            'amplify_value'=>$amplify_value,//装备附加的红字数值 最大65535
            'gold'=>$gold,
            'receive_time'=>date('Y-m-d H:i:s'),
            'delete_flag'=>0,
            'avata_flag'=>0,
            'unlimit_flag'=>$unlimit_flag,
            'seal_flag'=>$seal_flag,
            'creature_flag'=>$creature_flag,
            'postal'=>0,
            'letter_id'=>$litter_id,
            'extend_info'=>0,
            'ipg_db_id'=>0,
            'ipg_transaction_id'=>0,
            'ipg_nexon_id'=>0,
            'auction_id'=>0,
            'random_option'=>'',
            'seperate_upgrade'=>$seperate_upgrade,
            'type'=>0,
            'item_guid'=>''
        ];
        return $this->insertGetId($data);
    }

    /** 发送邮件
     * @param $charac_no
     * @param string $letter_text
     * @return int|string
     */
    public function sendLetter($charac_no, $letter_text='你好啊勇士,欢迎来到本服，这是为您送上的礼包。感谢您的到来。')
    {
        $data=[
            'charac_no'=>$charac_no,
            'send_charac_no'=>0,
            'send_charac_name'=>'scjtqs Admin',
            'letter_text'=>$letter_text,
            'reg_date'=>date('Y-m-d H:i:s'),
        ];
        return $this->table('letter')->insertGetId($data);
    }
```

## 充值
```js
// 待:查询uid是否存在，存在则update，不存在则insert
// 充值D币
function Dcoin(params) {
  let sql = `update taiwan_billing.cash_cera set cera=(cera+${params.num}) where account='${params.uid}'`;
  // let sql = `insert into taiwan_billing.cash_cera values ('$uid',$cz_num,0,'$datetime','$datetime')`;
  
  return sql;
}

// 充值D点
function DSmallcoin(params) {
  let sql = `update taiwan_billing.cash_cera_point set cera_point=(cera_point+${params.num}) where account='${params.uid}'`;
  // let sql = `insert into taiwan_billing.cash_cera_point values ('$uid',$cz_num,'$datetime','$datetime')`;
  return sql;
}

// 充值游戏币
function Goldcoin(params) {
  let sql = `update taiwan_cain_2nd.inventory set money=(money+${params.num}) where charac_no=${params.mid}`
  return sql;
}

// 充值时装点
function fashion(params) {
  let sql = `update taiwan_cain_2nd.member_avatar_coin  set avatar_coin=(avatar_coin+${params.num}) where m_id=${params.uid}`
  return sql;
}

// 充值SP
function SP(params) {
  let sql = `update taiwan_cain_2nd.skill set remain_sp=(remain_sp+${params.num}) where charac_no=${params.mid}`;
  return sql;
}

// 充值TP
function TP(params) {
  let sql = `update taiwan_cain_2nd.skill set remain_sfp_2nd=(remain_sfp_2nd+${params.num}) where charac_no=${params.mid}`
  return sql;
}

// 充值QP
function QP(params) {
  let sql = `update taiwan_cain.charac_quest_shop set qp=(qp+${params.num}) where charac_no=${params.mid}`
  return sql;
}
```

## 一些常用操作
```js
    switch (type) {
      // 清空邮件
      case 0:
        sql.push(db(`delete  from taiwan_cain_2nd.letter where charac_no=${mid} and send_charac_no=0 and send_charac_name like '%GM%'`))
        sql.push(db(`delete from taiwan_cain_2nd.postal where receive_charac_no=${mid} and send_charac_no=0 and delete_flag=0`))
        break;
      // 清空时装
      case 1:
        sql.push(db(`delete from taiwan_cain_2nd.user_items where slot>9 and charac_no=${mid}`))
        break;
      // 清空宠物
      case 2:
        sql.push(db(`delete from taiwan_cain_2nd.creature_items where slot<>238 and charac_no=${mid}`))
        break;
      // 解除创建角色限制
      case 3:
        sql.push(db(`update d_taiwan.limit_create_character set count=0 where m_id=${uid}`))
      break;
    }
```

## 统一登录器的一些db
> 库名：`taiwan_siroco`
>
```
MySQL [taiwan_siroco]> show tables;
+-------------------------+
| Tables_in_taiwan_siroco |
+-------------------------+
| blacklist               |
| member_play_info        |
| new_cdk                 |
| waigua_feature          |
+-------------------------+
4 rows in set (0.03 sec)
```
+ `new_cdk` ckd工具对应的库
+ `member_play_info` 可以用来查询在线用户和在线角色,等信息。