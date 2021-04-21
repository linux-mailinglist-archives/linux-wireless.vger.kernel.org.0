Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52A13673C5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 21:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245570AbhDUTv4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 15:51:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54113 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235545AbhDUTv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 15:51:56 -0400
X-UUID: 2076d38287c04dc2a9f7cbd5674da551-20210422
X-UUID: 2076d38287c04dc2a9f7cbd5674da551-20210422
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2002199893; Thu, 22 Apr 2021 03:51:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Apr 2021 03:51:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Apr 2021 03:51:15 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/3] mt76: mt7915: add thermal cooling device support
Date:   Thu, 22 Apr 2021 03:51:10 +0800
Message-ID: <da2052fb3e2a93f20b3781305e38a8f24598455f.1619026557.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <202e3d430a232592c1194d4fdec1adb1b3703588.1619026557.git.ryder.lee@mediatek.com>
References: <202e3d430a232592c1194d4fdec1adb1b3703588.1619026557.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thermal cooling device support is added to control the temperature by
throttling the data transmission for the given duration. Throttling is
done by adjusting Tx period by given percentage of time. The thermal
device allows user to configure duty cycle.

Throttling can be disabled by setting the duty cycle to 0. The cooling
device can be found under /sys/class/thermal/cooling_deviceX/.
Corresponding soft link to this device can be found under phy folder

To set duty cycle as 80%,
echo 80 > /sys/class/ieee80211/phy*/cooling_device/cur_state

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 83 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 71 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 12 +++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  6 ++
 4 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index b1c4dbad837c..2a8a904d7246 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -4,6 +4,7 @@
 #include <linux/etherdevice.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/thermal.h>
 #include "mt7915.h"
 #include "mac.h"
 #include "mcu.h"
@@ -93,10 +94,80 @@ static struct attribute *mt7915_hwmon_attrs[] = {
 };
 ATTRIBUTE_GROUPS(mt7915_hwmon);
 
+static int
+mt7915_thermal_get_max_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	*state = MT7915_THERMAL_THROTTLE_MAX;
+
+	return 0;
+}
+
+static int
+mt7915_thermal_get_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long *state)
+{
+	struct mt7915_phy *phy = cdev->devdata;
+
+	*state = phy->throttle_state;
+
+	return 0;
+}
+
+static int
+mt7915_thermal_set_cur_throttle_state(struct thermal_cooling_device *cdev,
+				      unsigned long state)
+{
+	struct mt7915_phy *phy = cdev->devdata;
+	int ret;
+
+	if (state > MT7915_THERMAL_THROTTLE_MAX)
+		return -EINVAL;
+
+	if (state == phy->throttle_state)
+		return 0;
+
+	ret = mt7915_mcu_set_thermal_throttling(phy, state);
+	if (ret)
+		return ret;
+
+	phy->throttle_state = state;
+
+	return 0;
+}
+
+static const struct thermal_cooling_device_ops mt7915_thermal_ops = {
+	.get_max_state = mt7915_thermal_get_max_throttle_state,
+	.get_cur_state = mt7915_thermal_get_cur_throttle_state,
+	.set_cur_state = mt7915_thermal_set_cur_throttle_state,
+};
+
+static void mt7915_unregister_thermal(struct mt7915_phy *phy)
+{
+	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+
+	sysfs_remove_link(&wiphy->dev.kobj, "cooling_device");
+	thermal_cooling_device_unregister(phy->cdev);
+}
+
 static int mt7915_thermal_init(struct mt7915_phy *phy)
 {
 	struct wiphy *wiphy = phy->mt76->hw->wiphy;
+	struct thermal_cooling_device *cdev;
 	struct device *hwmon;
+	int ret = 0;
+
+	cdev = thermal_cooling_device_register(wiphy_name(wiphy), phy,
+					       &mt7915_thermal_ops);
+	if (IS_ERR(cdev))
+		return PTR_ERR(cdev);
+
+	ret = sysfs_create_link(&wiphy->dev.kobj, &cdev->device.kobj,
+				"cooling_device");
+	if (ret)
+		goto err;
+
+	phy->cdev = cdev;
 
 	if (!IS_REACHABLE(CONFIG_HWMON))
 		return 0;
@@ -104,10 +175,16 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	hwmon = devm_hwmon_device_register_with_groups(&wiphy->dev,
 						       wiphy_name(wiphy), phy,
 						       mt7915_hwmon_groups);
-	if (IS_ERR(hwmon))
-		return PTR_ERR(hwmon);
+	if (IS_ERR(hwmon)) {
+		ret = PTR_ERR(hwmon);
+		goto err;
+	}
 
 	return 0;
+
+err:
+	mt7915_unregister_thermal(phy);
+	return ret;
 }
 
 static void
@@ -740,6 +817,7 @@ static void mt7915_unregister_ext_phy(struct mt7915_dev *dev)
 	if (!phy)
 		return;
 
+	mt7915_unregister_thermal(phy);
 	mt76_unregister_phy(mphy);
 	ieee80211_free_hw(mphy->hw);
 }
@@ -802,6 +880,7 @@ int mt7915_register_device(struct mt7915_dev *dev)
 void mt7915_unregister_device(struct mt7915_dev *dev)
 {
 	mt7915_unregister_ext_phy(dev);
+	mt7915_unregister_thermal(&dev->phy);
 	mt76_unregister_device(&dev->mt76);
 	mt7915_mcu_exit(dev);
 	mt7915_tx_token_put(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 17a617df6dba..e4306acea505 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3486,6 +3486,77 @@ int mt7915_mcu_get_temperature(struct mt7915_phy *phy)
 				 sizeof(req), true);
 }
 
+int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct {
+		struct req_ctrl {
+			u8 ctrl_id;
+			u8 dbdc_idx;
+			union {
+				struct {
+					u8 protect_type; /* 1: duty admit, 2: radio off */
+					u8 trigger_type; /* 0: low, 1: high */
+				} __packed type;
+				struct {
+					u8 duty_level;	/* level 0~3 */
+					u8 duty_cycle;
+				} __packed duty;
+			};
+		} __packed ctrl;
+		__le32 trigger_temp;
+		__le32 restore_temp;
+		__le16 sustain_time;
+		u8 rsv[2];
+	} __packed req = {
+		.ctrl = {
+			.dbdc_idx = phy != &dev->phy,
+		},
+	};
+	int level;
+
+#define TRIGGER_TEMPERATURE	122
+#define RESTORE_TEMPERATURE	116
+#define SUSTAIN_PERIOD		10
+
+	if (!state) {
+		req.ctrl.ctrl_id = THERMAL_PROTECT_DISABLE;
+		goto out;
+	}
+
+	/* set duty cycle and level */
+	for (level = 0; level < 4; level++) {
+		int ret;
+
+		req.ctrl.ctrl_id = THERMAL_PROTECT_DUTY_CONFIG;
+		req.ctrl.duty.duty_level = level;
+		req.ctrl.duty.duty_cycle = state;
+		state = state * 4 / 5;
+
+		ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
+					&req, sizeof(struct req_ctrl), false);
+		if (ret)
+			return ret;
+	}
+
+	/* currently use fixed values for throttling, and would be better
+	 * to implement thermal zone for dynamic trip in the long run.
+	 */
+
+	/* set high-temperature trigger threshold */
+	req.ctrl.ctrl_id = THERMAL_PROTECT_ENABLE;
+	req.trigger_temp = cpu_to_le32(TRIGGER_TEMPERATURE);
+	req.restore_temp = cpu_to_le32(RESTORE_TEMPERATURE);
+	req.sustain_time = cpu_to_le16(SUSTAIN_PERIOD);
+
+out:
+	req.ctrl.type.protect_type = 1;
+	req.ctrl.type.trigger_type = 1;
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_PROT),
+				 &req, sizeof(req), false);
+}
+
 int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 42582a66e42d..6377c1b16a42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -262,6 +262,7 @@ enum {
 	MCU_EXT_CMD_FW_LOG_2_HOST = 0x13,
 	MCU_EXT_CMD_TXBF_ACTION = 0x1e,
 	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
+	MCU_EXT_CMD_THERMAL_PROT = 0x23,
 	MCU_EXT_CMD_STA_REC_UPDATE = 0x25,
 	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
 	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
@@ -1066,6 +1067,17 @@ enum {
 	THERMAL_SENSOR_TASK_CTRL,
 };
 
+enum {
+	THERMAL_PROTECT_PARAMETER_CTRL,
+	THERMAL_PROTECT_BASIC_INFO,
+	THERMAL_PROTECT_ENABLE,
+	THERMAL_PROTECT_DISABLE,
+	THERMAL_PROTECT_DUTY_CONFIG,
+	THERMAL_PROTECT_MECH_INFO,
+	THERMAL_PROTECT_DUTY_INFO,
+	THERMAL_PROTECT_STATE_ACT,
+};
+
 enum {
 	MT_EBF = BIT(0),	/* explicit beamforming */
 	MT_IBF = BIT(1)		/* implicit beamforming */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index d5296e2d481b..43e3d977cdb2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -39,6 +39,8 @@
 #define MT7915_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
 #define MT7915_2G_RATE_DEFAULT		0x0	/* CCK 1M */
 
+#define MT7915_THERMAL_THROTTLE_MAX	100
+
 struct mt7915_vif;
 struct mt7915_sta;
 struct mt7915_dfs_pulse;
@@ -127,6 +129,9 @@ struct mt7915_phy {
 
 	struct ieee80211_vif *monitor_vif;
 
+	struct thermal_cooling_device *cdev;
+	u8 throttle_state;
+
 	u32 rxfilter;
 	u64 omac_mask;
 
@@ -358,6 +363,7 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev);
 int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
 int mt7915_mcu_get_temperature(struct mt7915_phy *phy);
+int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state);
 int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
-- 
2.18.0

