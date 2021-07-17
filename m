Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9573CC00A
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 02:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhGQAV2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jul 2021 20:21:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49662 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229462AbhGQAV2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jul 2021 20:21:28 -0400
X-UUID: 151eaf2eca8840e59778b3e943a61a49-20210717
X-UUID: 151eaf2eca8840e59778b3e943a61a49-20210717
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 352156742; Sat, 17 Jul 2021 08:18:29 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 17 Jul 2021 08:18:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 17 Jul 2021 08:18:27 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: mt7915: add control knobs for thermal throttling
Date:   Sat, 17 Jul 2021 08:18:25 +0800
Message-ID: <af157fa64bb37eb9bb44036f7888a0f3a5ddcb1c.1626480942.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With this patch, users can set the trigger/restore temperature for
thermal service according to their use cases.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 40 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 17 +++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 3 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index eb4c4991d020..77c7486d6a5c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -42,13 +42,17 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
-static ssize_t mt7915_thermal_show_temp(struct device *dev,
+static ssize_t mt7915_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
 	struct mt7915_phy *phy = dev_get_drvdata(dev);
+	int i = to_sensor_dev_attr(attr)->index;
 	int temperature;
 
+	if (i)
+		return sprintf(buf, "%u\n", phy->throttle_temp[i - 1] * 1000);
+
 	temperature = mt7915_mcu_get_temperature(phy);
 	if (temperature < 0)
 		return temperature;
@@ -57,11 +61,34 @@ static ssize_t mt7915_thermal_show_temp(struct device *dev,
 	return sprintf(buf, "%u\n", temperature * 1000);
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input, 0444, mt7915_thermal_show_temp,
-			  NULL, 0);
+static ssize_t mt7915_thermal_temp_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct mt7915_phy *phy = dev_get_drvdata(dev);
+	int ret, i = to_sensor_dev_attr(attr)->index;
+	long val;
+
+	ret = kstrtol(buf, 10, &val);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&phy->dev->mt76.mutex);
+	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 60, 130);
+	phy->throttle_temp[i - 1] = val;
+	mutex_unlock(&phy->dev->mt76.mutex);
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, mt7915_thermal_temp, 0);
+static SENSOR_DEVICE_ATTR_RW(temp1_crit, mt7915_thermal_temp, 1);
+static SENSOR_DEVICE_ATTR_RW(temp1_max, mt7915_thermal_temp, 2);
 
 static struct attribute *mt7915_hwmon_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_crit.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mt7915_hwmon);
@@ -96,6 +123,9 @@ mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
 	if (state > MT7915_THERMAL_THROTTLE_MAX)
 		return -EINVAL;
 
+	if (phy->throttle_temp[0] > phy->throttle_temp[1])
+		return 0;
+
 	if (state == phy->throttle_state)
 		return 0;
 
@@ -150,6 +180,10 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	if (IS_ERR(hwmon))
 		return PTR_ERR(hwmon);
 
+	/* initialize critical/maximum high temperature */
+	phy->throttle_temp[0] = 110;
+	phy->throttle_temp[1] = 120;
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8d646aa3d084..cb3f833181d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3544,10 +3544,6 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 	};
 	int level;
 
-#define TRIGGER_TEMPERATURE	122
-#define RESTORE_TEMPERATURE	116
-#define SUSTAIN_PERIOD		10
-
 	if (!state) {
 		req.ctrl.ctrl_id = THERMAL_PROTECT_DISABLE;
 		goto out;
@@ -3560,7 +3556,7 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 		req.ctrl.ctrl_id = THERMAL_PROTECT_DUTY_CONFIG;
 		req.ctrl.duty.duty_level = level;
 		req.ctrl.duty.duty_cycle = state;
-		state = state * 4 / 5;
+		state /= 2;
 
 		ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
 					&req, sizeof(req.ctrl), false);
@@ -3568,15 +3564,12 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 			return ret;
 	}
 
-	/* currently use fixed values for throttling, and would be better
-	 * to implement thermal zone for dynamic trip in the long run.
-	 */
-
 	/* set high-temperature trigger threshold */
 	req.ctrl.ctrl_id = THERMAL_PROTECT_ENABLE;
-	req.trigger_temp = cpu_to_le32(TRIGGER_TEMPERATURE);
-	req.restore_temp = cpu_to_le32(RESTORE_TEMPERATURE);
-	req.sustain_time = cpu_to_le16(SUSTAIN_PERIOD);
+	/* add a safety margin ~10 */
+	req.restore_temp = cpu_to_le32(phy->throttle_temp[0] - 10);
+	req.trigger_temp = cpu_to_le32(phy->throttle_temp[1]);
+	req.sustain_time = cpu_to_le16(10);
 
 out:
 	req.ctrl.type.protect_type = 1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 33be449309e0..7f3482c59603 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -123,6 +123,7 @@ struct mt7915_phy {
 
 	struct thermal_cooling_device *cdev;
 	u8 throttle_state;
+	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
 
 	u32 rxfilter;
 	u64 omac_mask;
-- 
2.29.2

