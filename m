Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5F12D899
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2019 13:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLaMZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Dec 2019 07:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfLaMZP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Dec 2019 07:25:15 -0500
Received: from localhost.localdomain.homenet.telecomitalia.it (host163-113-dynamic.21-87-r.retail.telecomitalia.it [87.21.113.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C291206D9;
        Tue, 31 Dec 2019 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577795114;
        bh=29PYfquoiXAZCU+rIkBw9eX0JPDU6C05zB/AS9Gfu2U=;
        h=From:To:Cc:Subject:Date:From;
        b=vQ7u402GPtAxiuVZ+ruROda9w7kojGDlTCXiGFAcGbzahqTmpVWkfA01MeUXi0aaj
         eYpmT5pAl4iP3sB7IOMQ/iBTAhoG+LuArqSgushxUAvH9jMlDkjtFeG5pAQJmLPhdD
         HhE5EgpCAC2WgWtS2ott8wjBIC7RB3G2xA2MpQNU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: initialize radar specs from host driver
Date:   Tue, 31 Dec 2019 13:25:23 +0100
Message-Id: <acd04b9636106d6448ff57ec4cc90bb221d746f6.1577790002.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce dfs radar pattern specs in mt7615 driver in order to make
dfs debugging easier. Radar pulse/pattern thresholds are taken from
vendor SDK.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 78 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 32 ++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 48 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 ++
 5 files changed, 166 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c958137465c9..2da6cd299cb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -17,6 +17,44 @@
 
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 
+static const struct mt7615_dfs_radar_spec etsi_radar_specs = {
+	.pulse_th = { 40, -10, -80, 800, 3360, 128, 5200 },
+	.radar_pattern = {
+		[5] =  { 1, 0,  6, 32, 28, 0, 17,  990, 5010, 1, 1 },
+		[6] =  { 1, 0,  9, 32, 28, 0, 27,  615, 5010, 1, 1 },
+		[7] =  { 1, 0, 15, 32, 28, 0, 27,  240,  445, 1, 1 },
+		[8] =  { 1, 0, 12, 32, 28, 0, 42,  240,  510, 1, 1 },
+		[9] =  { 1, 1,  0,  0,  0, 0, 14, 2490, 3343, 0, 0, 12, 32, 28 },
+		[10] = { 1, 1,  0,  0,  0, 0, 14, 2490, 3343, 0, 0, 15, 32, 24 },
+		[11] = { 1, 1,  0,  0,  0, 0, 14,  823, 2510, 0, 0, 18, 32, 28 },
+		[12] = { 1, 1,  0,  0,  0, 0, 14,  823, 2510, 0, 0, 27, 32, 24 },
+	},
+};
+
+static const struct mt7615_dfs_radar_spec fcc_radar_specs = {
+	.pulse_th = { 40, -10, -80, 800, 3360, 128, 5200 },
+	.radar_pattern = {
+		[0] = { 1, 0,  9,  32, 28, 0, 13, 508, 3076, 1,  1 },
+		[1] = { 1, 0, 12,  32, 28, 0, 17, 140,  240, 1,  1 },
+		[2] = { 1, 0,  8,  32, 28, 0, 22, 190,  510, 1,  1 },
+		[3] = { 1, 0,  6,  32, 28, 0, 32, 190,  510, 1,  1 },
+		[4] = { 1, 0,  9, 255, 28, 0, 13, 323,  343, 1, 32 },
+	},
+};
+
+static const struct mt7615_dfs_radar_spec jp_radar_specs = {
+	.pulse_th = { 40, -10, -80, 800, 3360, 128, 5200 },
+	.radar_pattern = {
+		[0] =  { 1, 0,  8, 32, 28, 0, 13,  508, 3076, 1,  1 },
+		[1] =  { 1, 0, 12, 32, 28, 0, 17,  140,  240, 1,  1 },
+		[2] =  { 1, 0,  8, 32, 28, 0, 22,  190,  510, 1,  1 },
+		[3] =  { 1, 0,  6, 32, 28, 0, 32,  190,  510, 1,  1 },
+		[4] =  { 1, 0,  9, 32, 28, 0, 13,  323,  343, 1, 32 },
+		[13] = { 1, 0, 8,  32, 28, 0, 14, 3836, 3856, 1,  1 },
+		[14] = { 1, 0, 8,  32, 28, 0, 14, 3990, 4010, 1,  1 },
+	},
+};
+
 static struct mt76_wcid *mt7615_rx_get_wcid(struct mt7615_dev *dev,
 					    u8 idx, bool unicast)
 {
@@ -1663,6 +1701,40 @@ static int mt7615_dfs_start_radar_detector(struct mt7615_phy *phy)
 	return 0;
 }
 
+static int
+mt7615_dfs_init_radar_specs(struct mt7615_phy *phy)
+{
+	const struct mt7615_dfs_radar_spec *radar_specs;
+	struct mt7615_dev *dev = phy->dev;
+	int err, i;
+
+	switch (dev->mt76.region) {
+	case NL80211_DFS_FCC:
+		radar_specs = &fcc_radar_specs;
+		err = mt7615_mcu_set_fcc5_lpn(dev, 8);
+		if (err < 0)
+			return err;
+		break;
+	case NL80211_DFS_ETSI:
+		radar_specs = &etsi_radar_specs;
+		break;
+	case NL80211_DFS_JP:
+		radar_specs = &jp_radar_specs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(radar_specs->radar_pattern); i++) {
+		err = mt7615_mcu_set_radar_th(dev, i,
+					      &radar_specs->radar_pattern[i]);
+		if (err < 0)
+			return err;
+	}
+
+	return mt7615_mcu_set_pulse_th(dev, &radar_specs->pulse_th);
+}
+
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 {
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
@@ -1684,6 +1756,12 @@ int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy)
 	if (phy->dfs_state == chandef->chan->dfs_state)
 		return 0;
 
+	err = mt7615_dfs_init_radar_specs(phy);
+	if (err < 0) {
+		phy->dfs_state = -1;
+		goto stop;
+	}
+
 	phy->dfs_state = chandef->chan->dfs_state;
 
 	if (chandef->chan->flags & IEEE80211_CHAN_RADAR) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 8579b829778d..8f053fadd3df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -306,6 +306,38 @@ struct mt7615_tx_free {
 #define MT_TXS6_F1_RCPI_1		GENMASK(15, 8)
 #define MT_TXS6_F1_RCPI_0		GENMASK(7, 0)
 
+struct mt7615_dfs_pulse {
+	u32 max_width;		/* us */
+	int max_pwr;		/* dbm */
+	int min_pwr;		/* dbm */
+	u32 min_stgr_pri;	/* us */
+	u32 max_stgr_pri;	/* us */
+	u32 min_cr_pri;		/* us */
+	u32 max_cr_pri;		/* us */
+};
+
+struct mt7615_dfs_pattern {
+	u8 enb;
+	u8 stgr;
+	u8 min_crpn;
+	u8 max_crpn;
+	u8 min_crpr;
+	u8 min_pw;
+	u8 max_pw;
+	u32 min_pri;
+	u32 max_pri;
+	u8 min_crbn;
+	u8 max_crbn;
+	u8 min_stgpn;
+	u8 max_stgpn;
+	u8 min_stgpr;
+};
+
+struct mt7615_dfs_radar_spec {
+	struct mt7615_dfs_pulse pulse_th;
+	struct mt7615_dfs_pattern radar_pattern[16];
+};
+
 enum mt7615_cipher_type {
 	MT_CIPHER_NONE,
 	MT_CIPHER_WEP40,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 9d2d7f25385c..41eeca09409f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1358,6 +1358,54 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 				   &req, sizeof(req), true);
 }
 
+int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
+{
+	struct {
+		u16 tag;
+		u16 min_lpn;
+	} req = {
+		.tag = 0x1,
+		.min_lpn = val,
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
+				   &req, sizeof(req), true);
+}
+
+int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
+			    const struct mt7615_dfs_pulse *pulse)
+{
+	struct {
+		u16 tag;
+		struct mt7615_dfs_pulse pulse;
+	} req = {
+		.tag = 0x3,
+	};
+
+	memcpy(&req.pulse, pulse, sizeof(*pulse));
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
+				   &req, sizeof(req), true);
+}
+
+int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
+			    const struct mt7615_dfs_pattern *pattern)
+{
+	struct {
+		u16 tag;
+		u16 radar_type;
+		struct mt7615_dfs_pattern pattern;
+	} req = {
+		.tag = 0x2,
+		.radar_type = index,
+	};
+
+	memcpy(&req.pattern, pattern, sizeof(*pattern));
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
+				   &req, sizeof(req), true);
+}
+
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 {
 	struct {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 0c576dcb9ce5..a7cf777d69a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -158,6 +158,7 @@ enum {
 	MCU_EXT_CMD_MAC_INIT_CTRL = 0x46,
 	MCU_EXT_CMD_BCN_OFFLOAD = 0x49,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+	MCU_EXT_CMD_SET_RDD_TH = 0x7c,
 	MCU_EXT_CMD_SET_RDD_PATTERN = 0x7d,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index eaafae9cc279..963aa421c719 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -46,6 +46,8 @@
 
 struct mt7615_vif;
 struct mt7615_sta;
+struct mt7615_dfs_pulse;
+struct mt7615_dfs_pattern;
 
 enum mt7615_hw_txq_id {
 	MT7615_TXQ_MAIN,
@@ -332,6 +334,11 @@ void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
 int mt76_dfs_start_rdd(struct mt7615_dev *dev, bool force);
+int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val);
+int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
+			    const struct mt7615_dfs_pulse *pulse);
+int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
+			    const struct mt7615_dfs_pattern *pattern);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
-- 
2.21.0

