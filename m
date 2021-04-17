Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8186363242
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 22:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbhDQUnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 16:43:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55722 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237080AbhDQUm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 16:42:59 -0400
X-UUID: 0ae8cd9f29fe4d3eb8feff4e5b4d8b0d-20210418
X-UUID: 0ae8cd9f29fe4d3eb8feff4e5b4d8b0d-20210418
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 838474654; Sun, 18 Apr 2021 04:42:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 18 Apr 2021 04:42:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 18 Apr 2021 04:42:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: add thermal sensor device support
Date:   Sun, 18 Apr 2021 04:42:23 +0800
Message-ID: <b51d79d257e150a09d51029e3465e2ce925d6cfe.1618691395.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D59C00394B710C6E8C283C631551D662974E6C55E0B5C683F1D4B8843299E1E52000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This provides userspace with a unified interface, hwmon sysfs, to monitor
temperature in the hardware and can be adaped to system monitoring tools.

For reading temperature, cat /sys/class/ieee80211/phy*/hwmon*/temp1_input

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 14 -----
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 56 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  7 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +-
 4 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 6a8ddeeecbe9..f1e8b076d54c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -224,18 +224,6 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(mt7915_tx_stats);
 
-static int mt7915_read_temperature(struct seq_file *s, void *data)
-{
-	struct mt7915_dev *dev = dev_get_drvdata(s->private);
-	int temp;
-
-	/* cpu */
-	temp = mt7915_mcu_get_temperature(dev, 0);
-	seq_printf(s, "Temperature: %d\n", temp);
-
-	return 0;
-}
-
 static int
 mt7915_queues_acq(struct seq_file *s, void *data)
 {
@@ -390,8 +378,6 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_file("radar_trigger", 0200, dir, dev,
 			    &fops_radar_trigger);
 	debugfs_create_file("ser_trigger", 0200, dir, dev, &fops_ser_trigger);
-	debugfs_create_devm_seqfile(dev->mt76.dev, "temperature", dir,
-				    mt7915_read_temperature);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower_sku", dir,
 				    mt7915_read_rate_txpower);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c13b932b0a44..cccb3df339de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -2,6 +2,8 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/etherdevice.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include "mt7915.h"
 #include "mac.h"
 #include "mcu.h"
@@ -67,6 +69,52 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
+static ssize_t mt7915_thermal_show_temp(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct mt7915_phy *phy = dev_get_drvdata(dev);
+	int temperature;
+
+	mutex_lock(&phy->dev->mt76.mutex);
+	temperature = mt7915_mcu_get_temperature(phy);
+	mutex_unlock(&phy->dev->mt76.mutex);
+
+	if (temperature < 0)
+		return temperature;
+
+	/* display in millidegree celcius */
+	return sprintf(buf, "%u\n", temperature * 1000);
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, mt7915_thermal_show_temp,
+			  NULL, 0);
+
+static struct attribute *mt7915_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mt7915_hwmon);
+
+static int mt7915_thermal_init(struct mt7915_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct device *hwmon;
+
+	/* TODO: add cooling device for throttling */
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return 0;
+
+	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
+						       wiphy_name(wiphy), phy,
+						       mt7915_hwmon_groups);
+	if (IS_ERR(hwmon))
+		return PTR_ERR(hwmon);
+
+	return 0;
+}
+
 static void
 mt7915_init_txpower(struct mt7915_dev *dev,
 		    struct ieee80211_supported_band *sband)
@@ -286,6 +334,10 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	if (ret)
 		goto error;
 
+	ret = mt7915_thermal_init(phy);
+	if (ret)
+		goto error;
+
 	return 0;
 
 error:
@@ -739,6 +791,10 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = mt7915_thermal_init(&dev->phy);
+	if (ret)
+		return ret;
+
 	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
 
 	ret = mt7915_register_ext_phy(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 559ad230eabe..17a617df6dba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3469,16 +3469,17 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
 	return 0;
 }
 
-int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
+int mt7915_mcu_get_temperature(struct mt7915_phy *phy)
 {
+	struct mt7915_dev *dev = phy->dev;
 	struct {
 		u8 ctrl_id;
 		u8 action;
-		u8 band;
+		u8 dbdc_idx;
 		u8 rsv[5];
 	} req = {
 		.ctrl_id = THERMAL_SENSOR_TEMP_QUERY,
-		.action = index,
+		.dbdc_idx = phy != &dev->phy,
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 80eb35231a1a..d5296e2d481b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -357,7 +357,7 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 			    const struct mt7915_dfs_pattern *pattern);
 int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev);
 int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
-int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index);
+int mt7915_mcu_get_temperature(struct mt7915_phy *phy);
 int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
-- 
2.18.0

