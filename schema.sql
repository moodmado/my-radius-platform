-- جدول الحسابات والمستخدمين (الكروت واشتراكات PPPoE/Hotspot)
CREATE TABLE radcheck (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(64) NOT NULL DEFAULT '',
    attribute VARCHAR(64) NOT NULL DEFAULT 'Cleartext-Password',
    op VARCHAR(2) NOT NULL DEFAULT '==',
    value VARCHAR(64) NOT NULL DEFAULT '',
    INDEX (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- جدول تحديد الصلاحيات والسرعات (تحديد المايكروتك ريت والتحميل)
CREATE TABLE radreply (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(64) NOT NULL DEFAULT '',
    attribute VARCHAR(64) NOT NULL DEFAULT '',
    op VARCHAR(2) NOT NULL DEFAULT '=',
    value VARCHAR(253) NOT NULL DEFAULT '',
    INDEX (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- جدول تسجيل الجلسات الحية وفصل المستخدمين المستهلكين للحصص
CREATE TABLE radacct (
    radacctid BIGINT(21) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    acctsessionid VARCHAR(64) NOT NULL DEFAULT '',
    username VARCHAR(64) NOT NULL DEFAULT '',
    nasipaddress VARCHAR(15) NOT NULL DEFAULT '',
    nasportid VARCHAR(15) DEFAULT NULL,
    acctstarttime DATETIME DEFAULT NULL,
    acctstoptime DATETIME DEFAULT NULL,
    acctsessiontime INT(12) DEFAULT NULL,
    acctinputoctets BIGINT(20) DEFAULT NULL,
    acctoutputoctets BIGINT(20) DEFAULT NULL,
    INDEX (username), INDEX (nasipaddress)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
