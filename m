Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88ECE19F377
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 12:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDFKWJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 06:22:09 -0400
Received: from nbd.name ([46.4.11.11]:57846 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgDFKWH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8vH1xF61/ZFYOqWNx8U9RB2QPfejsoA41TuM6ryiKuY=; b=ox5PuaHZhHNusiYSUVD3MsPYrw
        Y7edsGG4KX7JD70tp4M+uVU4IO39FXGwEILzO6mZc4ThHGV+Avsajkv2AcJ1yE3wahngEWOACvtEn
        FNysZG4Y0YTc7jZAEwthunNvIUuQ6+Dyxv1Li5tMYGTUuK5PRYH6qG6VPDy+ZAFo77Ek=;
Received: from [80.255.7.105] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jLOtJ-0001gY-SJ
        for linux-wireless@vger.kernel.org; Mon, 06 Apr 2020 12:22:06 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 9D7EC81E8916; Mon,  6 Apr 2020 12:22:03 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: mt7615: add support for applying tx DPD calibration from EEPROM
Date:   Mon,  6 Apr 2020 12:22:03 +0200
Message-Id: <20200406102203.54450-4-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406102203.54450-1-nbd@nbd.name>
References: <20200406102203.54450-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the EEPROM data is read from flash, it can contain tx DPD calibration
data. Add support for sending the data to the firmware.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 120 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   1 +
 4 files changed, 125 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index ef8e9336f627..b346080458bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -253,8 +253,10 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	mt7615_init_dfs_state(phy);
 	mt76_set_channel(phy->mt76);
 
-	if (is_mt7615(&dev->mt76) && dev->flash_eeprom)
+	if (is_mt7615(&dev->mt76) && dev->flash_eeprom) {
 		mt7615_mcu_apply_rx_dcoc(phy);
+		mt7615_mcu_apply_tx_dpd(phy);
+	}
 
 	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 809aa6612d2b..b236612dd033 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2978,3 +2978,123 @@ int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy)
 
 	return ret;
 }
+
+static int mt7615_dpd_freq_idx(u16 freq, u8 bw)
+{
+	static const u16 freq_list[] = {
+		4920, 4940, 4960, 4980,
+		5040, 5060, 5080, 5180,
+		5200, 5220, 5240, 5260,
+		5280, 5300, 5320, 5340,
+		5360, 5380, 5400, 5420,
+		5440, 5460, 5480, 5500,
+		5520, 5540, 5560, 5580,
+		5600, 5620, 5640, 5660,
+		5680, 5700, 5720, 5745,
+		5765, 5785, 5805, 5825,
+		5845, 5865, 5885, 5905
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
+	if (bw != NL80211_CHAN_WIDTH_20) {
+		idx = mt7615_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
+					   freq + 10);
+		if (idx >= 0)
+			return idx;
+
+		idx = mt7615_find_freq_idx(freq_list, ARRAY_SIZE(freq_list),
+					   freq - 10);
+		if (idx >= 0)
+			return idx;
+	}
+
+	return mt7615_find_freq_idx(freq_list, ARRAY_SIZE(freq_list), freq);
+}
+
+
+int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
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
+			struct {
+				u32 dpd_g0;
+				u8 data[32];
+			} wf0, wf1;
+
+			struct {
+				u32 dpd_g0_prim;
+				u32 dpd_g0_sec;
+				u8 data_prim[32];
+				u8 data_sec[32];
+			} wf2, wf3;
+		} dpd_data;
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
+	if (!(eep[MT_EE_CALDATA_FLASH] & MT_EE_CALDATA_FLASH_TX_DPD))
+		return 0;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_160) {
+		freq2 = req.center_freq + 40;
+		req.center_freq -= 40;
+	}
+
+again:
+	req.runtime_calibration = 1;
+	freq_idx = mt7615_dpd_freq_idx(req.center_freq, chandef->width);
+	if (freq_idx < 0)
+		goto out;
+
+	memcpy(&req.dpd_data, eep + MT7615_EEPROM_TXDPD_OFFSET +
+			      freq_idx * MT7615_EEPROM_TXDPD_SIZE,
+	       sizeof(req.dpd_data));
+	req.runtime_calibration = 0;
+
+out:
+	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXDPD_CAL, &req,
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
index 427478002e67..983625fb72ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -271,6 +271,7 @@ enum {
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_RXDCOC_CAL = 0x59,
+	MCU_EXT_CMD_TXDPD_CAL = 0x60,
 	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 39c792826c48..65a2b30fc588 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -496,6 +496,7 @@ int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 			    const struct mt7615_dfs_pattern *pattern);
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
 int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy);
+int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
-- 
2.24.0

