Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82F0E899C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388660AbfJ2NfL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 09:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388325AbfJ2NfK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 09:35:10 -0400
Received: from localhost.localdomain.com (unknown [176.229.194.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4688420874;
        Tue, 29 Oct 2019 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572356109;
        bh=4OfIOKhwnpG0sc/SXINhWpaClpb0H1A5gZiNBXuLI3A=;
        h=From:To:Cc:Subject:Date:From;
        b=AP3jNrgIuwGr5Adp/7ZNv9cnZwGX0UnByf32rZG1sySElZ6R1wvJVl9NH6J0sWUa3
         WmGHlErqoqCGN10da5gz/trg2rRGdSsJlE+Z3eQK8PgFPsKVtCq0ZwFXlxqbEcSsJy
         NvxHY6667emOEsgUWVp9S9kKlkDAdTxD+CjS6N10=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sgruszka@redhat.com
Subject: [PATCH] mt76: use mt76_dev in mt76_is_{mmio,usb}
Date:   Tue, 29 Oct 2019 14:34:44 +0100
Message-Id: <dc879af3f22e3cdc34eb205145d48ad060c04b04.1572354715.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert mt76_is_mmio and mt76_is_usb to rely on mt76_dev instead of
mt76x02_dev since this is a property not strictly related to hw chipset
and it will be more reusable

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h          |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    | 12 ++++++------
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c  |  6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5644df793450..d22d673e3c5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -49,8 +49,8 @@ struct mt76_bus_ops {
 	enum mt76_bus_type type;
 };
 
-#define mt76_is_usb(dev) ((dev)->mt76.bus->type == MT76_BUS_USB)
-#define mt76_is_mmio(dev) ((dev)->mt76.bus->type == MT76_BUS_MMIO)
+#define mt76_is_usb(dev) ((dev)->bus->type == MT76_BUS_USB)
+#define mt76_is_mmio(dev) ((dev)->bus->type == MT76_BUS_MMIO)
 
 enum mt76_txq_id {
 	MT_TXQ_VO = IEEE80211_AC_VO,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index f7682bd2e5a8..b2ccf50512dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -13,7 +13,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 {
 	cancel_delayed_work_sync(&dev->cal_work);
 	mt76x02_pre_tbtt_enable(dev, false);
-	if (mt76_is_mmio(dev))
+	if (mt76_is_mmio(&dev->mt76))
 		tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
 	mt76_set_channel(&dev->mt76);
@@ -22,7 +22,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76x02_mac_cc_reset(dev);
 	mt76x02_edcca_init(dev);
 
-	if (mt76_is_mmio(dev)) {
+	if (mt76_is_mmio(&dev->mt76)) {
 		mt76x02_dfs_init_params(dev);
 		tasklet_enable(&dev->dfs_pd.dfs_tasklet);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index 82f5b481b723..6953f253a28a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -30,7 +30,7 @@
 
 static inline bool is_mt7610e(struct mt76x02_dev *dev)
 {
-	if (!mt76_is_mmio(dev))
+	if (!mt76_is_mmio(&dev->mt76))
 		return false;
 
 	return mt76_chip(&dev->mt76) == 0x7610;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 61e1a086f3cb..2ecd45f8af90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -102,7 +102,7 @@ static int mt76x0_rf_csr_rr(struct mt76x02_dev *dev, u32 offset)
 static int
 mt76x0_rf_wr(struct mt76x02_dev *dev, u32 offset, u8 val)
 {
-	if (mt76_is_usb(dev)) {
+	if (mt76_is_usb(&dev->mt76)) {
 		struct mt76_reg_pair pair = {
 			.reg = offset,
 			.value = val,
@@ -121,7 +121,7 @@ static int mt76x0_rf_rr(struct mt76x02_dev *dev, u32 offset)
 	int ret;
 	u32 val;
 
-	if (mt76_is_usb(dev)) {
+	if (mt76_is_usb(&dev->mt76)) {
 		struct mt76_reg_pair pair = {
 			.reg = offset,
 		};
@@ -176,7 +176,7 @@ mt76x0_phy_rf_csr_wr_rp(struct mt76x02_dev *dev,
 }
 
 #define RF_RANDOM_WRITE(dev, tab) do {					\
-	if (mt76_is_mmio(dev))						\
+	if (mt76_is_mmio(&dev->mt76))					\
 		mt76x0_phy_rf_csr_wr_rp(dev, tab, ARRAY_SIZE(tab));	\
 	else								\
 		mt76_wr_rp(dev, MT_MCU_MEMMAP_RF, tab, ARRAY_SIZE(tab));\
@@ -744,7 +744,7 @@ mt76x0_phy_get_delta_power(struct mt76x02_dev *dev, u8 tx_mode,
 
 	if (!tx_mode) {
 		data = mt76_rr(dev, MT_BBP(CORE, 1));
-		if (is_mt7630(dev) && mt76_is_mmio(dev)) {
+		if (is_mt7630(dev) && mt76_is_mmio(&dev->mt76)) {
 			int offset;
 
 			/* 2.3 * 8192 or 1.5 * 8192 */
@@ -966,7 +966,7 @@ void mt76x0_phy_set_channel(struct mt76x02_dev *dev,
 		break;
 	}
 
-	if (mt76_is_usb(dev)) {
+	if (mt76_is_usb(&dev->mt76)) {
 		mt76x0_phy_bbp_set_bw(dev, chandef->width);
 	} else {
 		if (chandef->width == NL80211_CHAN_WIDTH_80 ||
@@ -1122,7 +1122,7 @@ static void mt76x0_rf_patch_reg_array(struct mt76x02_dev *dev,
 
 		switch (reg) {
 		case MT_RF(0, 3):
-			if (mt76_is_mmio(dev)) {
+			if (mt76_is_mmio(&dev->mt76)) {
 				if (is_mt7630(dev))
 					val = 0x70;
 				else
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 4be7a24097cc..6274b6a24b07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -114,7 +114,7 @@ int mt76x02_mcu_calibrate(struct mt76x02_dev *dev, int type, u32 param)
 		.id = cpu_to_le32(type),
 		.value = cpu_to_le32(param),
 	};
-	bool is_mt76x2e = mt76_is_mmio(dev) && is_mt76x2(dev);
+	bool is_mt76x2e = mt76_is_mmio(&dev->mt76) && is_mt76x2(dev);
 	int ret;
 
 	if (is_mt76x2e)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index bb7edf288597..c57a93fa2557 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -161,7 +161,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 #endif
 		BIT(NL80211_IFTYPE_ADHOC);
 
-	if (mt76_is_usb(dev)) {
+	if (mt76_is_usb(&dev->mt76)) {
 		hw->extra_tx_headroom += sizeof(struct mt76x02_txwi) +
 					 MT_DMA_HDR_LEN;
 		wiphy->iface_combinations = mt76x02u_if_comb;
@@ -446,7 +446,7 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	 * data registers and sent via HW beacons engine, they require to
 	 * be already encrypted.
 	 */
-	if (mt76_is_usb(dev) &&
+	if (mt76_is_usb(&dev->mt76) &&
 	    vif->type == NL80211_IFTYPE_AP &&
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
@@ -627,7 +627,7 @@ void mt76x02_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta,
 	int idx = msta->wcid.idx;
 
 	mt76_stop_tx_queues(&dev->mt76, sta, true);
-	if (mt76_is_mmio(dev))
+	if (mt76_is_mmio(mdev))
 		mt76x02_mac_wcid_set_drop(dev, idx, ps);
 }
 EXPORT_SYMBOL_GPL(mt76x02_sta_ps);
-- 
2.21.0

