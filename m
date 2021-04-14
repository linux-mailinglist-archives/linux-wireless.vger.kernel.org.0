Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3235F931
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 18:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351840AbhDNQrf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 12:47:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43850 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1351865AbhDNQqs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 12:46:48 -0400
X-UUID: d5400b2eae034d6abb108b04d17354ea-20210415
X-UUID: d5400b2eae034d6abb108b04d17354ea-20210415
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1708257320; Thu, 15 Apr 2021 00:45:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Apr 2021 00:45:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Apr 2021 00:45:50 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] mt76: mt7915: add support for applying pre-calibraion data
Date:   Thu, 15 Apr 2021 00:45:49 +0800
Message-ID: <a0b463543e418e03c0a749be027b991f1ca8ecaa.1618418328.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the EEPROM data is read from flash, it can contain pre-calibration
data, which can save calibration time.

Note that group_cal can save 30% bootup calibration time, and dpd_cal can
save 75% channel switching time.

Tested-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - use min_t instead.
---
 drivers/net/wireless/mediatek/mt76/eeprom.c   |  11 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  25 ++-
 .../wireless/mediatek/mt76/mt7915/eeprom.h    |  11 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   7 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   6 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 142 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |   2 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   4 +
 9 files changed, 199 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
index 665b54c5c8ae..3f7a5a508605 100644
--- a/drivers/net/wireless/mediatek/mt76/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
@@ -9,8 +9,7 @@
 #include <linux/etherdevice.h>
 #include "mt76.h"
 
-static int
-mt76_get_of_eeprom(struct mt76_dev *dev, int len)
+int mt76_get_of_eeprom(struct mt76_dev *dev, void *eep, int offset, int len)
 {
 #if defined(CONFIG_OF) && defined(CONFIG_MTD)
 	struct device_node *np = dev->dev->of_node;
@@ -18,7 +17,6 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 	const __be32 *list;
 	const char *part;
 	phandle phandle;
-	int offset = 0;
 	int size;
 	size_t retlen;
 	int ret;
@@ -54,7 +52,7 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 	}
 
 	offset = be32_to_cpup(list);
-	ret = mtd_read(mtd, offset, len, &retlen, dev->eeprom.data);
+	ret = mtd_read(mtd, offset, len, &retlen, eep);
 	put_mtd_device(mtd);
 	if (ret)
 		goto out_put_node;
@@ -65,7 +63,7 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 	}
 
 	if (of_property_read_bool(dev->dev->of_node, "big-endian")) {
-		u8 *data = (u8 *)dev->eeprom.data;
+		u8 *data = (u8 *)eep;
 		int i;
 
 		/* convert eeprom data in Little Endian */
@@ -86,6 +84,7 @@ mt76_get_of_eeprom(struct mt76_dev *dev, int len)
 	return -ENOENT;
 #endif
 }
+EXPORT_SYMBOL_GPL(mt76_get_of_eeprom);
 
 void
 mt76_eeprom_override(struct mt76_phy *phy)
@@ -119,6 +118,6 @@ mt76_eeprom_init(struct mt76_dev *dev, int len)
 	if (!dev->eeprom.data)
 		return -ENOMEM;
 
-	return !mt76_get_of_eeprom(dev, len);
+	return !mt76_get_of_eeprom(dev, dev->eeprom.data, 0, len);
 }
 EXPORT_SYMBOL_GPL(mt76_eeprom_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b09b0f5ffd6d..1b290d3bd7aa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -828,6 +828,7 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_phy *phy);
+int mt76_get_of_eeprom(struct mt76_dev *dev, void *data, int offset, int len);
 
 struct mt76_queue *
 mt76_init_queue(struct mt76_dev *dev, int qid, int idx, int n_desc,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 738ecf8f4fa2..353f8d8497d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -14,6 +14,23 @@ static u32 mt7915_eeprom_read(struct mt7915_dev *dev, u32 offset)
 	return data[offset];
 }
 
+static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	u32 val;
+
+	val = mt7915_eeprom_read(dev, MT_EE_DO_PRE_CAL);
+	if (val != (MT_EE_WIFI_CAL_DPD | MT_EE_WIFI_CAL_GROUP))
+		return 0;
+
+	val = MT_EE_CAL_GROUP_SIZE + MT_EE_CAL_DPD_SIZE;
+	dev->cal = devm_kzalloc(mdev->dev, val, GFP_KERNEL);
+	if (!dev->cal)
+		return -ENOMEM;
+
+	return mt76_get_of_eeprom(mdev, dev->cal, MT_EE_PRECAL, val);
+}
+
 static int mt7915_eeprom_load(struct mt7915_dev *dev)
 {
 	int ret;
@@ -22,12 +39,14 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	if (ret)
+	if (ret) {
 		dev->flash_mode = true;
-	else
+		ret = mt7915_eeprom_load_precal(dev);
+	} else {
 		memset(dev->mt76.eeprom.data, -1, MT7915_EEPROM_SIZE);
+	}
 
-	return 0;
+	return ret;
 }
 
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 3ee8c27bb61b..8ef5ebfad706 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -17,14 +17,23 @@ enum mt7915_eeprom_field {
 	MT_EE_MAC_ADDR =	0x004,
 	MT_EE_MAC_ADDR2 =	0x00a,
 	MT_EE_DDIE_FT_VERSION =	0x050,
+	MT_EE_DO_PRE_CAL =	0x062,
 	MT_EE_WIFI_CONF =	0x190,
 	MT_EE_TX0_POWER_2G =	0x2fc,
 	MT_EE_TX0_POWER_5G =	0x34b,
 	MT_EE_ADIE_FT_VERSION =	0x9a0,
 
-	__MT_EE_MAX =		0xe00
+	__MT_EE_MAX =		0xe00,
+	/* 0xe10 ~ 0x5780 used to save group cal data */
+	MT_EE_PRECAL =		0xe10
 };
 
+#define MT_EE_WIFI_CAL_GROUP			BIT(0)
+#define MT_EE_WIFI_CAL_DPD			GENMASK(2, 1)
+#define MT_EE_CAL_UNIT				1024
+#define MT_EE_CAL_GROUP_SIZE			(44 * MT_EE_CAL_UNIT)
+#define MT_EE_CAL_DPD_SIZE			(54 * MT_EE_CAL_UNIT)
+
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(7, 6)
 #define MT_EE_WIFI_CONF1_BAND_SEL		GENMASK(7, 6)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 1b688bd5c52c..3f9f74aa8399 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -378,6 +378,13 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	if (ret < 0)
 		return ret;
 
+
+	if (dev->flash_mode) {
+		ret = mt7915_mcu_apply_group_cal(dev);
+		if (ret)
+			return ret;
+	}
+
 	/* Beacon and mgmt frames should occupy wcid 0 */
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7915_WTBL_STA - 1);
 	if (idx)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2fd87987312e..413abbca3246 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -313,6 +313,12 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 	mt7915_init_dfs_state(phy);
 	mt76_set_channel(phy->mt76);
 
+	if (dev->flash_mode) {
+		ret = mt7915_mcu_apply_tx_dpd(phy);
+		if (ret)
+			goto out;
+	}
+
 	ret = mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD(CHANNEL_SWITCH));
 	if (ret)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 0b739ed8ce33..bf5ea461d585 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3327,6 +3327,148 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 	return 0;
 }
 
+static int mt7915_mcu_set_pre_cal(struct mt7915_dev *dev, u8 idx,
+				  u8 *data, u32 len, int cmd)
+{
+	struct {
+		u8 dir;
+		u8 valid;
+		__le16 bitmap;
+		s8 precal;
+		u8 action;
+		u8 band;
+		u8 idx;
+		u8 rsv[4];
+		__le32 len;
+	} req;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, sizeof(req) + len);
+	if (!skb)
+		return -ENOMEM;
+
+	req.idx = idx;
+	req.len = cpu_to_le32(len);
+	skb_put_data(skb, &req, sizeof(req));
+	skb_put_data(skb, data, len);
+
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, false);
+}
+
+int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev)
+{
+	u8 idx = 0, *cal = dev->cal, *eep = dev->mt76.eeprom.data;
+	u32 total = MT_EE_CAL_GROUP_SIZE;
+
+	if (!(eep[MT_EE_DO_PRE_CAL] & MT_EE_WIFI_CAL_GROUP))
+		return 0;
+
+	/*
+	 * Items: Rx DCOC, RSSI DCOC, Tx TSSI DCOC, Tx LPFG
+	 * Tx FDIQ, Tx DCIQ, Rx FDIQ, Rx FIIQ, ADCDCOC
+	 */
+	while (total > 0) {
+		int ret, len;
+
+		len = min_t(u32, total, MT_EE_CAL_UNIT);
+
+		ret = mt7915_mcu_set_pre_cal(dev, idx, cal, len,
+					     MCU_EXT_CMD(GROUP_PRE_CAL_INFO));
+		if (ret)
+			return ret;
+
+		total -= len;
+		cal += len;
+		idx++;
+	}
+
+	return 0;
+}
+
+static int mt7915_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
+{
+	int i;
+
+	for (i = 0; i < n_freqs; i++)
+		if (cur == freqs[i])
+			return i;
+
+	return -1;
+}
+
+static int mt7915_dpd_freq_idx(u16 freq, u8 bw)
+{
+	static const u16 freq_list[] = {
+		5180, 5200, 5220, 5240,
+		5260, 5280, 5300, 5320,
+		5500, 5520, 5540, 5560,
+		5580, 5600, 5620, 5640,
+		5660, 5680, 5700, 5745,
+		5765, 5785, 5805, 5825
+	};
+	int offset_2g = ARRAY_SIZE(freq_list);
+	int idx;
+
+	if (freq < 4000) {
+		if (freq < 2432)
+			return offset_2g;
+		if (freq < 2457)
+			return offset_2g + 1;
+
+		return offset_2g + 2;
+	}
+
+	if (bw == NL80211_CHAN_WIDTH_80P80 || bw == NL80211_CHAN_WIDTH_160)
+		return -1;
+
+	if (bw != NL80211_CHAN_WIDTH_20) {
+		idx = mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
+					   freq + 10);
+		if (idx >= 0)
+			return idx;
+
+		idx = mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
+					   freq - 10);
+		if (idx >= 0)
+			return idx;
+	}
+
+	return mt7915_find_freq_idx(freq_list, ARRAY_SIZE(freq_list), freq);
+}
+
+int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy)
+{
+	struct mt7915_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	u16 total = 2, idx, center_freq = chandef->center_freq1;
+	u8 *cal = dev->cal, *eep = dev->mt76.eeprom.data;
+
+	if (!(eep[MT_EE_DO_PRE_CAL] & MT_EE_WIFI_CAL_DPD))
+		return 0;
+
+	idx = mt7915_dpd_freq_idx(center_freq, chandef->width);
+	if (idx < 0)
+		return -EINVAL;
+
+	/* Items: Tx DPD, Tx Flatness */
+	idx = idx * 2;
+	cal += MT_EE_CAL_GROUP_SIZE;
+
+	while (total--) {
+		int ret;
+
+		cal += (idx * MT_EE_CAL_UNIT);
+		ret = mt7915_mcu_set_pre_cal(dev, idx, cal, MT_EE_CAL_UNIT,
+					     MCU_EXT_CMD(DPD_PRE_CAL_INFO));
+		if (ret)
+			return ret;
+
+		idx++;
+	}
+
+	return 0;
+}
+
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 4a932140a7c3..42582a66e42d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -284,6 +284,8 @@ enum {
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
+	MCU_EXT_CMD_GROUP_PRE_CAL_INFO = 0xab,
+	MCU_EXT_CMD_DPD_PRE_CAL_INFO = 0xac,
 	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3df1d3e95b25..15e88179ab62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -201,6 +201,8 @@ struct mt7915_dev {
 	bool flash_mode;
 	bool fw_debug;
 	bool ibf;
+
+	void *cal;
 };
 
 enum {
@@ -359,6 +361,8 @@ int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
 			    const struct mt7915_dfs_pulse *pulse);
 int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 			    const struct mt7915_dfs_pattern *pattern);
+int mt7915_mcu_apply_group_cal(struct mt7915_dev *dev);
+int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index);
 int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
-- 
2.18.0

