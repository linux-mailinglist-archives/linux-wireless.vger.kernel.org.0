Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EAC369C5E
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Apr 2021 00:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhDWWDH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 18:03:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59546 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232438AbhDWWCw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 18:02:52 -0400
X-UUID: 903a1ba955f04758b4870090959c600a-20210424
X-UUID: 903a1ba955f04758b4870090959c600a-20210424
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 67483423; Sat, 24 Apr 2021 06:02:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 24 Apr 2021 06:02:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 24 Apr 2021 06:02:07 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 3/3] mt76: mt7615: add thermal sensor device support
Date:   Sat, 24 Apr 2021 06:02:06 +0800
Message-ID: <44af7f8bfd4d801108aed04a5494a552e4ca2c00.1619214926.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <202e3d430a232592c1194d4fdec1adb1b3703588.1619214926.git.ryder.lee@mediatek.com>
References: <202e3d430a232592c1194d4fdec1adb1b3703588.1619214926.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915, switching to use standard hwmon sysfs.
For reading temperature, cat /sys/class/ieee80211/phy*/hwmon*/temp1_input

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v3 - none
changes since v2 - fix build error
---
 .../wireless/mediatek/mt76/mt7615/debugfs.c   | 20 --------
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 50 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  6 +--
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +-
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  4 ++
 5 files changed, 58 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 1b414220521a..96b75f316071 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -291,24 +291,6 @@ mt7615_radio_read(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int mt7615_read_temperature(struct seq_file *s, void *data)
-{
-	struct mt7615_dev *dev = dev_get_drvdata(s->private);
-	int temp;
-
-	if (!mt7615_wait_for_mcu_init(dev))
-		return 0;
-
-	/* cpu */
-	mt7615_mutex_acquire(dev);
-	temp = mt7615_mcu_get_temperature(dev, 0);
-	mt7615_mutex_release(dev);
-
-	seq_printf(s, "Temperature: %d\n", temp);
-
-	return 0;
-}
-
 static int
 mt7615_queues_acq(struct seq_file *s, void *data)
 {
@@ -536,8 +518,6 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 
 	debugfs_create_file("reset_test", 0200, dir, dev,
 			    &fops_reset_test);
-	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
-				    mt7615_read_temperature);
 	debugfs_create_file("ext_mac_addr", 0600, dir, dev, &fops_ext_mac_addr);
 
 	debugfs_create_u32("rf_wfidx", 0600, dir, &dev->debugfs_rf_wf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index d84662fb0304..515933d239ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -8,11 +8,61 @@
  */
 
 #include <linux/etherdevice.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include "mt7615.h"
 #include "mac.h"
 #include "mcu.h"
 #include "eeprom.h"
 
+static ssize_t mt7615_thermal_show_temp(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct mt7615_dev *mdev = dev_get_drvdata(dev);
+	int temperature;
+
+	if (!mt7615_wait_for_mcu_init(mdev))
+		return 0;
+
+	mt7615_mutex_acquire(mdev);
+	temperature = mt7615_mcu_get_temperature(mdev);
+	mt7615_mutex_release(mdev);
+
+	if (temperature < 0)
+		return temperature;
+
+	/* display in millidegree celcius */
+	return sprintf(buf, "%u\n", temperature * 1000);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, mt7615_thermal_show_temp,
+			  NULL, 0);
+
+static struct attribute *mt7615_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mt7615_hwmon);
+
+int mt7615_thermal_init(struct mt7615_dev *dev)
+{
+	struct wiphy *wiphy = mt76_hw(dev)->wiphy;
+	struct device *hwmon;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return 0;
+
+	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
+						       wiphy_name(wiphy), dev,
+						       mt7615_hwmon_groups);
+	if (IS_ERR(hwmon))
+		return PTR_ERR(hwmon);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt7615_thermal_init);
+
 static void
 mt7615_phy_init(struct mt7615_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index be976fe97290..67af2e2d4779 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2301,14 +2301,12 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
 
-int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index)
+int mt7615_mcu_get_temperature(struct mt7615_dev *dev)
 {
 	struct {
 		u8 action;
 		u8 rsv[3];
-	} req = {
-		.action = index,
-	};
+	} req = {};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_GET_TEMP, &req,
 				 sizeof(req), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 6a50338ec9f5..68c844527f65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -359,6 +359,7 @@ static inline int mt7622_wmac_init(struct mt7615_dev *dev)
 }
 #endif
 
+int mt7615_thermal_init(struct mt7615_dev *dev);
 int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		      int irq, const u32 *map);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
@@ -497,7 +498,7 @@ u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg);
 int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val);
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
-int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index);
+int mt7615_mcu_get_temperature(struct mt7615_dev *dev);
 int mt7615_mcu_set_tx_power(struct mt7615_phy *phy);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 49540b00519d..10bd2c2bbf1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -153,6 +153,10 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7615_thermal_init(dev);
+	if (ret)
+		return ret;
+
 	ieee80211_queue_work(mt76_hw(dev), &dev->mcu_work);
 	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
 	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
-- 
2.18.0

