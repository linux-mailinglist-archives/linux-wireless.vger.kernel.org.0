Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD519F375
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 12:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDFKWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 06:22:08 -0400
Received: from nbd.name ([46.4.11.11]:57844 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgDFKWH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=crCCI286wv9x2uIvkqYwSZmu/9krzCrtA7Bv9Xd3MXw=; b=DynvsIHXdlzWN/Izd2iweMGh/1
        gQr22M7Jpt+yO+DlBO92Bj+8JMda5Z60V6BRafPgrJBfsAQLSNACXZ1KWocd35NkOKpqKqtGH0XcU
        FFp+TvsaOG2mrxh6f47LnseSJ30dB6nErWyroLmR1mnxgMKuYfbgddmBiIsUdEpdhbbc=;
Received: from [80.255.7.105] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jLOtJ-0001gZ-Pi
        for linux-wireless@vger.kernel.org; Mon, 06 Apr 2020 12:22:05 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 9E40181E8918; Mon,  6 Apr 2020 12:22:03 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/4] mt76: mt7615: add support for applying DC offset calibration from EEPROM
Date:   Mon,  6 Apr 2020 12:22:02 +0200
Message-Id: <20200406102203.54450-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406102203.54450-1-nbd@nbd.name>
References: <20200406102203.54450-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the EEPROM data is read from flash, it can contain DC offset calibration
data. Add support for sending the data to the firmware.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |   9 +-
 .../wireless/mediatek/mt76/mt7615/eeprom.h    |  19 ++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   3 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 194 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +
 6 files changed, 199 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 34c33d23d79f..7a09427463b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -72,7 +72,8 @@ static int mt7615_eeprom_load(struct mt7615_dev *dev, u32 addr)
 {
 	int ret;
 
-	ret = mt76_eeprom_init(&dev->mt76, MT7615_EEPROM_SIZE);
+	ret = mt76_eeprom_init(&dev->mt76, MT7615_EEPROM_SIZE +
+					   MT7615_EEPROM_EXTRA_DATA);
 	if (ret < 0)
 		return ret;
 
@@ -280,11 +281,13 @@ int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr)
 		return ret;
 
 	ret = mt7615_check_eeprom(&dev->mt76);
-	if (ret && dev->mt76.otp.data)
+	if (ret && dev->mt76.otp.data) {
 		memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
 		       MT7615_EEPROM_SIZE);
-	else
+	} else {
+		dev->flash_eeprom = true;
 		mt7615_cal_free_data(dev);
+	}
 
 	mt7615_eeprom_parse_hw_cap(dev);
 	memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index 8a2a64b7fcd3..bd2ac1e0e01a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -6,6 +6,21 @@
 
 #include "mt7615.h"
 
+
+#define MT7615_EEPROM_DCOC_OFFSET		MT7615_EEPROM_SIZE
+#define MT7615_EEPROM_DCOC_SIZE			256
+#define MT7615_EEPROM_DCOC_COUNT		34
+
+#define MT7615_EEPROM_TXDPD_OFFSET		(MT7615_EEPROM_SIZE + \
+						 MT7615_EEPROM_DCOC_COUNT * \
+						 MT7615_EEPROM_DCOC_SIZE)
+#define MT7615_EEPROM_TXDPD_SIZE		216
+#define MT7615_EEPROM_TXDPD_COUNT		(44 + 3)
+
+#define MT7615_EEPROM_EXTRA_DATA		(MT7615_EEPROM_TXDPD_OFFSET + \
+						 MT7615_EEPROM_TXDPD_COUNT * \
+						 MT7615_EEPROM_TXDPD_SIZE)
+
 enum mt7615_eeprom_field {
 	MT_EE_CHIP_ID =				0x000,
 	MT_EE_VERSION =				0x002,
@@ -13,6 +28,7 @@ enum mt7615_eeprom_field {
 	MT_EE_NIC_CONF_0 =			0x034,
 	MT_EE_NIC_CONF_1 =			0x036,
 	MT_EE_WIFI_CONF =			0x03e,
+	MT_EE_CALDATA_FLASH =			0x052,
 	MT_EE_TX0_2G_TARGET_POWER =		0x058,
 	MT_EE_TX0_5G_G0_TARGET_POWER =		0x070,
 	MT_EE_TX1_5G_G0_TARGET_POWER =		0x098,
@@ -27,6 +43,9 @@ enum mt7615_eeprom_field {
 	MT7663_EE_MAX =				0x400,
 };
 
+#define MT_EE_CALDATA_FLASH_TX_DPD		BIT(0)
+#define MT_EE_CALDATA_FLASH_RX_CAL		BIT(1)
+
 #define MT_EE_NIC_CONF_TX_MASK			GENMASK(7, 4)
 #define MT_EE_NIC_CONF_RX_MASK			GENMASK(3, 0)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 3e0d26183905..ef8e9336f627 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -253,6 +253,9 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_init_dfs_state(phy);
 	mt76_set_channel(phy->mt76);
 
+	if (is_mt7615(&dev->mt76) && dev->flash_eeprom)
+		mt7615_mcu_apply_rx_dcoc(phy);
+
 	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
 	if (ret)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index dcd97606e827..809aa6612d2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2481,6 +2481,25 @@ static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
 	}
 }
 
+static u8 mt7615_mcu_chan_bw(struct cfg80211_chan_def *chandef)
+{
+	static const u8 width_to_bw[] = {
+		[NL80211_CHAN_WIDTH_40] = CMD_CBW_40MHZ,
+		[NL80211_CHAN_WIDTH_80] = CMD_CBW_80MHZ,
+		[NL80211_CHAN_WIDTH_80P80] = CMD_CBW_8080MHZ,
+		[NL80211_CHAN_WIDTH_160] = CMD_CBW_160MHZ,
+		[NL80211_CHAN_WIDTH_5] = CMD_CBW_5MHZ,
+		[NL80211_CHAN_WIDTH_10] = CMD_CBW_10MHZ,
+		[NL80211_CHAN_WIDTH_20] = CMD_CBW_20MHZ,
+		[NL80211_CHAN_WIDTH_20_NOHT] = CMD_CBW_20MHZ,
+	};
+
+	if (chandef->width >= ARRAY_SIZE(width_to_bw))
+		return 0;
+
+	return width_to_bw[chandef->width];
+}
+
 int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 {
 	struct mt7615_dev *dev = phy->dev;
@@ -2521,32 +2540,7 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 		req.switch_reason = CH_SWITCH_NORMAL;
 
 	req.band_idx = phy != &dev->phy;
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_40:
-		req.bw = CMD_CBW_40MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-		req.bw = CMD_CBW_80MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_80P80:
-		req.bw = CMD_CBW_8080MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		req.bw = CMD_CBW_160MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_5:
-		req.bw = CMD_CBW_5MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_10:
-		req.bw = CMD_CBW_10MHZ;
-		break;
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-	default:
-		req.bw = CMD_CBW_20MHZ;
-		break;
-	}
+	req.bw = mt7615_mcu_chan_bw(chandef);
 
 	mt7615_mcu_set_txpower_sku(phy, req.txpower_sku);
 
@@ -2836,3 +2830,151 @@ int mt7615_mcu_sched_scan_enable(struct mt7615_phy *phy,
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SCHED_SCAN_ENABLE,
 				   &req, sizeof(req), false);
 }
+
+static int mt7615_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
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
+static int mt7615_dcoc_freq_idx(u16 freq, u8 bw)
+{
+	static const u16 freq_list[] = {
+		4980, 5805, 5905, 5190,
+		5230, 5270, 5310, 5350,
+		5390, 5430, 5470, 5510,
+		5550, 5590, 5630, 5670,
+		5710, 5755, 5795, 5835,
+		5875, 5210, 5290, 5370,
+		5450, 5530, 5610, 5690,
+		5775, 5855
+	};
+	static const u16 freq_bw40[] = {
+		5190, 5230, 5270, 5310,
+		5350, 5390, 5430, 5470,
+		5510, 5550, 5590, 5630,
+		5670, 5710, 5755, 5795,
+		5835, 5875
+	};
+	int offset_2g = ARRAY_SIZE(freq_list);
+	int idx;
+
+	if (freq < 4000) {
+		if (freq < 2427)
+			return offset_2g;
+		if (freq < 2442)
+			return offset_2g + 1;
+		if (freq < 2457)
+			return offset_2g + 2;
+
+		return offset_2g + 3;
+	}
+
+	switch (bw) {
+	case NL80211_CHAN_WIDTH_80:
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_160:
+		break;
+	default:
+		idx = mt7615_find_freq_idx(freq_bw40, ARRAY_SIZE(freq_bw40),
+					   freq + 10);
+		if (idx >= 0) {
+			freq = freq_bw40[idx];
+			break;
+		}
+
+		idx = mt7615_find_freq_idx(freq_bw40, ARRAY_SIZE(freq_bw40),
+					   freq - 10);
+		if (idx >= 0) {
+			freq = freq_bw40[idx];
+			break;
+		}
+		/* fall through */
+	case NL80211_CHAN_WIDTH_40:
+		idx = mt7615_find_freq_idx(freq_bw40, ARRAY_SIZE(freq_bw40),
+					   freq);
+		if (idx >= 0)
+			break;
+
+		return -1;
+
+	}
+
+	return mt7615_find_freq_idx(freq_list, ARRAY_SIZE(freq_list), freq);
+}
+
+int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy)
+{
+	struct mt7615_dev *dev = phy->dev;
+	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
+	int freq2 = chandef->center_freq2;
+	int ret;
+	struct {
+		u8 direction;
+		u8 runtime_calibration;
+		u8 _rsv[2];
+
+		__le16 center_freq;
+		u8 bw;
+		u8 band;
+		u8 is_freq2;
+		u8 success;
+		u8 dbdc_en;
+
+		u8 _rsv2;
+
+		struct {
+			__le32 sx0_i_lna[4];
+			__le32 sx0_q_lna[4];
+
+			__le32 sx2_i_lna[4];
+			__le32 sx2_q_lna[4];
+		} dcoc_data[4];
+	} req = {
+		.direction = 1,
+
+		.center_freq = chandef->center_freq1,
+		.bw = mt7615_mcu_chan_bw(chandef),
+		.band = chandef->center_freq1 > 4000,
+		.dbdc_en = !!dev->mt76.phy2,
+	};
+	int freq_idx;
+	u8 *eep = dev->mt76.eeprom.data;
+
+	if (!(eep[MT_EE_CALDATA_FLASH] & MT_EE_CALDATA_FLASH_RX_CAL))
+		return 0;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_160) {
+		freq2 = req.center_freq + 40;
+		req.center_freq -= 40;
+	}
+
+again:
+	req.runtime_calibration = 1;
+	freq_idx = mt7615_dcoc_freq_idx(req.center_freq, chandef->width);
+	if (freq_idx < 0)
+		goto out;
+
+	memcpy(req.dcoc_data, eep + MT7615_EEPROM_DCOC_OFFSET +
+			      freq_idx * MT7615_EEPROM_DCOC_SIZE,
+	       sizeof(req.dcoc_data));
+	req.runtime_calibration = 0;
+
+out:
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RXDCOC_CAL, &req,
+				  sizeof(req), true);
+
+	if ((chandef->width == NL80211_CHAN_WIDTH_80P80 ||
+	     chandef->width == NL80211_CHAN_WIDTH_160) && !req.is_freq2) {
+		req.is_freq2 = true;
+		req.center_freq = freq2;
+		goto again;
+	}
+
+	return ret;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 69cb68d6465d..427478002e67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -270,6 +270,7 @@ enum {
 	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
+	MCU_EXT_CMD_RXDCOC_CAL = 0x59,
 	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 304abde1482e..39c792826c48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -258,6 +258,7 @@ struct mt7615_dev {
 
 	u8 mac_work_count;
 	bool fw_debug;
+	bool flash_eeprom;
 
 	spinlock_t token_lock;
 	struct idr token;
@@ -494,6 +495,7 @@ int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 			    const struct mt7615_dfs_pattern *pattern);
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
+int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
-- 
2.24.0

