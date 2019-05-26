Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D107E2AA31
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2019 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfEZOFh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 May 2019 10:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfEZOFh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 May 2019 10:05:37 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.36.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A0462075E;
        Sun, 26 May 2019 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558879535;
        bh=Fv+eOGHb457HAktB4zpCT9pOlRnry3yH+zG6W3uaI9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHSVauFURm16e/1przRdRLXM/9u4AbW2g9AUuavAnpSMK+YTbWVJAjEzjWwEJzy2i
         1ZAWIXjGTN8pb6pjPo1PIS1E/96ZWZqQ3blKhzwFWUUVCWbvt6f899T1NC9wfKfjWR
         guY8h/+OYY2sSmQ1B7cwjpAXMEgntEXUhoduKmeo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 2/4] mt76: mt7615: add the capability to configure tx power
Date:   Sun, 26 May 2019 16:05:11 +0200
Message-Id: <c6d159842b084b54988a32033f0e9dea76a378df.1558879234.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558879234.git.lorenzo@kernel.org>
References: <cover.1558879234.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_mcu_set_tx_power routine in order to cap tx power
according to the value configured by the user

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    | 34 ++++++++++
 .../wireless/mediatek/mt76/mt7615/eeprom.h    | 35 ++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  3 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 64 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +
 6 files changed, 140 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 714590878d65..023c8bbc767d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -110,6 +110,40 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	}
 }
 
+int mt7615_eeprom_get_power_index(struct ieee80211_channel *chan,
+				  u8 chain_idx)
+{
+	int index;
+
+	if (chain_idx > 3)
+		return -EINVAL;
+
+	if (chan->band == NL80211_BAND_2GHZ) {
+		index = MT_EE_TX0_2G_TARGET_POWER + chain_idx * 6;
+	} else {
+		int group = mt7615_get_channel_group(chan->hw_value);
+
+		switch (chain_idx) {
+		case 1:
+			index = MT_EE_TX1_5G_G0_TARGET_POWER;
+			break;
+		case 2:
+			index = MT_EE_TX2_5G_G0_TARGET_POWER;
+			break;
+		case 3:
+			index = MT_EE_TX3_5G_G0_TARGET_POWER;
+			break;
+		case 0:
+		default:
+			index = MT_EE_TX0_5G_G0_TARGET_POWER;
+			break;
+		}
+		index += 5 * group;
+	}
+
+	return index;
+}
+
 int mt7615_eeprom_init(struct mt7615_dev *dev)
 {
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index b422e395d6ee..3c9086b67f51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -12,6 +12,11 @@ enum mt7615_eeprom_field {
 	MT_EE_MAC_ADDR =			0x004,
 	MT_EE_NIC_CONF_0 =			0x034,
 	MT_EE_WIFI_CONF =			0x03e,
+	MT_EE_TX0_2G_TARGET_POWER =		0x058,
+	MT_EE_TX0_5G_G0_TARGET_POWER =		0x070,
+	MT_EE_TX1_5G_G0_TARGET_POWER =		0x098,
+	MT_EE_TX2_5G_G0_TARGET_POWER =		0x142,
+	MT_EE_TX3_5G_G0_TARGET_POWER =		0x16a,
 
 	__MT_EE_MAX =				0x3bf
 };
@@ -24,4 +29,34 @@ enum mt7615_eeprom_band {
 	MT_EE_DBDC,
 };
 
+enum mt7615_channel_group {
+	MT_CH_5G_JAPAN,
+	MT_CH_5G_UNII_1,
+	MT_CH_5G_UNII_2A,
+	MT_CH_5G_UNII_2B,
+	MT_CH_5G_UNII_2E_1,
+	MT_CH_5G_UNII_2E_2,
+	MT_CH_5G_UNII_2E_3,
+	MT_CH_5G_UNII_3,
+	__MT_CH_MAX
+};
+
+static inline enum mt7615_channel_group
+mt7615_get_channel_group(int channel)
+{
+	if (channel >= 184 && channel <= 196)
+		return MT_CH_5G_JAPAN;
+	if (channel <= 48)
+		return MT_CH_5G_UNII_1;
+	if (channel <= 64)
+		return MT_CH_5G_UNII_2A;
+	if (channel <= 114)
+		return MT_CH_5G_UNII_2E_1;
+	if (channel <= 144)
+		return MT_CH_5G_UNII_2E_2;
+	if (channel <= 161)
+		return MT_CH_5G_UNII_2E_3;
+	return MT_CH_5G_UNII_3;
+}
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index b0bb7cc12385..72bdb871ca13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -201,6 +201,9 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 		mutex_unlock(&dev->mt76.mutex);
 	}
 
+	if (changed & IEEE80211_CONF_CHANGE_POWER)
+		ret = mt7615_mcu_set_tx_power(dev);
+
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		mutex_lock(&dev->mt76.mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 43f70195244c..0e12e9f05f95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1151,6 +1151,70 @@ int mt7615_mcu_set_bcn(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 				   &req, sizeof(req), true);
 }
 
+int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
+{
+	int i, ret, n_chains = hweight8(dev->mt76.antenna_mask);
+	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	u8 *req, *data, *eep = (u8 *)dev->mt76.eeprom.data;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+	int freq = chandef->center_freq1, len;
+	struct {
+		u8 center_chan;
+		u8 dbdc_idx;
+		u8 band;
+		u8 rsv;
+	} __packed req_hdr = {
+		.center_chan = ieee80211_frequency_to_channel(freq),
+		.band = chandef->chan->band,
+	};
+	s8 tx_power;
+
+	len = sizeof(req_hdr) + __MT_EE_MAX - MT_EE_NIC_CONF_0;
+	req = kzalloc(len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	memcpy(req, &req_hdr, sizeof(req_hdr));
+	data = req + sizeof(req_hdr);
+	memcpy(data, eep + MT_EE_NIC_CONF_0,
+	       __MT_EE_MAX - MT_EE_NIC_CONF_0);
+
+	tx_power = hw->conf.power_level * 2;
+	switch (n_chains) {
+	case 4:
+		tx_power -= 12;
+		break;
+	case 3:
+		tx_power -= 8;
+		break;
+	case 2:
+		tx_power -= 6;
+		break;
+	default:
+		break;
+	}
+	tx_power = max_t(s8, tx_power, 0);
+	dev->mt76.txpower_cur = tx_power;
+
+	for (i = 0; i < n_chains; i++) {
+		int index = -MT_EE_NIC_CONF_0;
+
+		ret = mt7615_eeprom_get_power_index(chandef->chan, i);
+		if (ret < 0)
+			goto out;
+
+		index += ret;
+		data[index] = min_t(u8, data[index], tx_power);
+	}
+
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_TX_POWER_CTRL,
+				  req, len, true);
+out:
+	kfree(req);
+
+	return ret;
+}
+
 int mt7615_mcu_set_channel(struct mt7615_dev *dev)
 {
 	struct cfg80211_chan_def *chdef = &dev->mt76.chandef;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index e96efb13fa4d..cca11737693c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -70,6 +70,7 @@ enum {
 enum {
 	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
 	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
+	MCU_EXT_CMD_SET_TX_POWER_CTRL = 0x11,
 	MCU_EXT_CMD_EFUSE_BUFFER_MODE = 0x21,
 	MCU_EXT_CMD_STA_REC_UPDATE = 0x25,
 	MCU_EXT_CMD_BSS_INFO_UPDATE = 0x26,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 09c48dfbef3c..7c08d3b93a2a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -105,6 +105,8 @@ u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
 int mt7615_eeprom_init(struct mt7615_dev *dev);
+int mt7615_eeprom_get_power_index(struct ieee80211_channel *chan,
+				  u8 chain_idx);
 int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
 int mt7615_mcu_init(struct mt7615_dev *dev);
@@ -167,6 +169,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_init_mac(struct mt7615_dev *dev);
 int mt7615_mcu_set_rts_thresh(struct mt7615_dev *dev, u32 val);
 int mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int enter);
+int mt7615_mcu_set_tx_power(struct mt7615_dev *dev);
 void mt7615_mcu_exit(struct mt7615_dev *dev);
 
 int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-- 
2.21.0

