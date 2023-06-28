Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6697409D9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjF1Hwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:31 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38834 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230062AbjF1Hw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:27 -0400
X-UUID: 69d749ac158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PDBp3ubpi0AX8K1afGQ3HIIZvxTnrR/q8CynkPXibyw=;
        b=K66NKLsKN7aDGFbzW0MHgRsoclSXjTGEIIVe/dQdIfUU8CW9leBZ6gTMTWakeV7qs/uyvQAwwi6z+whArW+rOx8KSRA4vnHz1L0d1SThpwdpY3UDo7Y0eto/dhpMgf3NuF5Oavufi+px+AV/nL3hxYNabWDh4LJ2wnX2BYleh2k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:9879a687-b845-4514-a7fe-ed06dd4aa57e,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:01c9525,CLOUDID:5aea7182-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 2,OSH
X-CID-BAS: 2,OSH,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 69d749ac158211ee9cb5633481061a41-20230628
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 564531952; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:15 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 11/16] wifi: mt76: mt792x: introduce mt792x-lib module
Date:   Wed, 28 Jun 2023 15:05:57 +0800
Message-ID: <7171944a1223f4ce8f04db7632139c233976993c.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

mt792x-lib module will contain the shared code between mt7921 and new
MT79 WiFi7 chipset

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile   |   4 +
 .../net/wireless/mediatek/mt76/mt7921/Kconfig |   2 +-
 .../wireless/mediatek/mt76/mt7921/Makefile    |   4 +-
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  16 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 148 +----
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 535 ++----------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  25 +-
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |   4 +
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/trace.c |  12 -
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  61 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  | 469 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt792x_mac.c   | 136 +++++
 .../net/wireless/mediatek/mt76/mt792x_regs.h  |   3 -
 .../net/wireless/mediatek/mt76/mt792x_trace.c |  14 +
 .../{mt7921/mt7921_trace.h => mt792x_trace.h} |  14 +-
 19 files changed, 763 insertions(+), 694 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_core.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_trace.c
 rename drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} (72%)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 18152c16c36f..1ddf195597a8 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -29,6 +29,10 @@ config MT76_CONNAC_LIB
 	tristate
 	select MT76_CORE
 
+config MT792x_LIB
+	tristate
+	select MT76_CONNAC_LIB
+
 source "drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7603/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index d8e8079c8b54..a20eebba04ba 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_MT76_SDIO) += mt76-sdio.o
 obj-$(CONFIG_MT76x02_LIB) += mt76x02-lib.o
 obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o
 obj-$(CONFIG_MT76_CONNAC_LIB) += mt76-connac-lib.o
+obj-$(CONFIG_MT792x_LIB) += mt792x-lib.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
@@ -19,6 +20,7 @@ mt76-sdio-y := sdio.o sdio_txrx.o
 CFLAGS_trace.o := -I$(src)
 CFLAGS_usb_trace.o := -I$(src)
 CFLAGS_mt76x02_trace.o := -I$(src)
+CFLAGS_mt792x_trace.o := -I$(src)
 
 mt76x02-lib-y := mt76x02_util.o mt76x02_mac.o mt76x02_mcu.o \
 		 mt76x02_eeprom.o mt76x02_phy.o mt76x02_mmio.o \
@@ -29,6 +31,8 @@ mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
 
 mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o mt76_connac3_mac.o
 
+mt792x-lib-y := mt792x_core.o mt792x_mac.o mt792x_trace.o
+
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
 obj-$(CONFIG_MT7603E) += mt7603/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
index adff2d7350b5..b92630cdf88b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: ISC
 config MT7921_COMMON
 	tristate
-	select MT76_CONNAC_LIB
+	select MT792x_LIB
 	select WANT_DEV_COREDUMP
 
 config MT7921E
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index e5d2d2e131a2..fd82dff76dae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -5,9 +5,7 @@ obj-$(CONFIG_MT7921E) += mt7921e.o
 obj-$(CONFIG_MT7921S) += mt7921s.o
 obj-$(CONFIG_MT7921U) += mt7921u.o
 
-CFLAGS_trace.o := -I$(src)
-
-mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o trace.o
+mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7921-common-$(CONFIG_ACPI) += acpi_sar.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 0c94fa7ae485..59920cffee6a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -67,7 +67,7 @@ mt7921_ampdu_stat_read_phy(struct mt792x_phy *phy,
 	if (!phy)
 		return;
 
-	mt7921_mac_update_mib_stats(phy);
+	mt792x_mac_update_mib_stats(phy);
 
 	/* Tx ampdu stat */
 	for (i = 0; i < ARRAY_SIZE(range); i++)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index d78cdaaf5bb6..449ce34a6dcf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -12,7 +12,7 @@
 
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
-		.max = MT7921_MAX_INTERFACES,
+		.max = MT792x_MAX_INTERFACES,
 		.types = BIT(NL80211_IFTYPE_STATION)
 	},
 	{
@@ -25,7 +25,7 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	{
 		.limits = if_limits,
 		.n_limits = ARRAY_SIZE(if_limits),
-		.max_interfaces = MT7921_MAX_INTERFACES,
+		.max_interfaces = MT792x_MAX_INTERFACES,
 		.num_different_channels = 1,
 		.beacon_int_infra_match = true,
 	},
@@ -126,7 +126,7 @@ mt7921_regd_notifier(struct wiphy *wiphy,
 static int
 mt7921_init_wiphy(struct ieee80211_hw *hw)
 {
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
 
@@ -319,7 +319,7 @@ int mt7921_mac_init(struct mt792x_dev *dev)
 	/* enable hardware rx header translation */
 	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_RX_HDR_TRANS_EN);
 
-	for (i = 0; i < MT7921_WTBL_SIZE; i++)
+	for (i = 0; i < MT792x_WTBL_SIZE; i++)
 		mt7921_mac_wtbl_update(dev, i,
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	for (i = 0; i < 2; i++)
@@ -379,7 +379,7 @@ static int mt7921_init_wcid(struct mt792x_dev *dev)
 	int idx;
 
 	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx)
 		return -ENOSPC;
 
@@ -437,7 +437,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
-	dev->mt76.tx_worker.fn = mt7921_tx_worker;
+	dev->mt76.tx_worker.fn = mt792x_tx_worker;
 
 	INIT_DELAYED_WORK(&dev->pm.ps_work, mt7921_pm_power_save_work);
 	INIT_WORK(&dev->pm.wake_work, mt7921_pm_wake_work);
@@ -447,7 +447,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	if (mt76_is_sdio(&dev->mt76))
 		init_waitqueue_head(&dev->mt76.sdio.wait);
 	spin_lock_init(&dev->pm.txq_lock);
-	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
+	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt792x_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
 	INIT_DELAYED_WORK(&dev->coredump.work, mt7921_coredump_work);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -461,7 +461,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	INIT_WORK(&dev->init_work, mt7921_init_work);
 
 	INIT_WORK(&dev->phy.roc_work, mt7921_roc_work);
-	timer_setup(&dev->phy.roc_timer, mt7921_roc_timer, 0);
+	timer_setup(&dev->phy.roc_timer, mt792x_roc_timer, 0);
 	init_waitqueue_head(&dev->phy.roc_wait);
 
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 49ba23ecf495..40f006664ad7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -15,6 +15,15 @@
 
 #define MT_WTBL_AC0_CTT_OFFSET		20
 
+bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
 static u32 mt7921_mac_wtbl_lmac_addr(int idx, u8 offset)
 {
 	return MT_WTBL_LMAC_OFFS(idx, 0) + offset * 4;
@@ -43,15 +52,6 @@ static struct mt76_wcid *mt7921_rx_get_wcid(struct mt792x_dev *dev,
 	return &sta->vif->sta.wcid;
 }
 
-bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask)
-{
-	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
-		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
-
-	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
-			 0, 5000);
-}
-
 static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 {
 	static const u8 ac_to_tid[] = {
@@ -528,7 +528,7 @@ void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data)
 	if (pid < MT_PACKET_ID_FIRST)
 		return;
 
-	if (wcidx >= MT7921_WTBL_SIZE)
+	if (wcidx >= MT792x_WTBL_SIZE)
 		return;
 
 	rcu_read_lock();
@@ -721,47 +721,6 @@ void mt7921_mac_reset_counters(struct mt792x_phy *phy)
 	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
 }
 
-void mt7921_mac_set_timing(struct mt792x_phy *phy)
-{
-	s16 coverage_class = phy->coverage_class;
-	struct mt792x_dev *dev = phy->dev;
-	u32 val, reg_offset;
-	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
-		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
-	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
-		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
-	bool is_2ghz = phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ;
-	int sifs = is_2ghz ? 10 : 16, offset;
-
-	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
-		return;
-
-	mt76_set(dev, MT_ARB_SCR(0),
-		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
-	udelay(1);
-
-	offset = 3 * coverage_class;
-	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
-		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
-
-	mt76_wr(dev, MT_TMAC_CDTR(0), cck + reg_offset);
-	mt76_wr(dev, MT_TMAC_ODTR(0), ofdm + reg_offset);
-	mt76_wr(dev, MT_TMAC_ICR0(0),
-		FIELD_PREP(MT_IFS_EIFS, 360) |
-		FIELD_PREP(MT_IFS_RIFS, 2) |
-		FIELD_PREP(MT_IFS_SIFS, sifs) |
-		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
-
-	if (phy->slottime < 20 || !is_2ghz)
-		val = MT7921_CFEND_RATE_DEFAULT;
-	else
-		val = MT7921_CFEND_RATE_11B;
-
-	mt76_rmw_field(dev, MT_AGG_ACR0(0), MT_AGG_ACR_CFEND_RATE, val);
-	mt76_clear(dev, MT_ARB_SCR(0),
-		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
-}
-
 static u8
 mt7921_phy_get_nf(struct mt792x_phy *phy, int idx)
 {
@@ -902,91 +861,6 @@ void mt7921_reset(struct mt76_dev *mdev)
 }
 EXPORT_SYMBOL_GPL(mt7921_reset);
 
-void mt7921_mac_update_mib_stats(struct mt792x_phy *phy)
-{
-	struct mt76_mib_stats *mib = &phy->mib;
-	struct mt792x_dev *dev = phy->dev;
-	int i, aggr0 = 0, aggr1;
-	u32 val;
-
-	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(0),
-					   MT_MIB_SDR3_FCS_ERR_MASK);
-	mib->ack_fail_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR3(0),
-					    MT_MIB_ACK_FAIL_COUNT_MASK);
-	mib->ba_miss_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR2(0),
-					   MT_MIB_BA_FAIL_COUNT_MASK);
-	mib->rts_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR0(0),
-				       MT_MIB_RTS_COUNT_MASK);
-	mib->rts_retries_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR1(0),
-					       MT_MIB_RTS_FAIL_COUNT_MASK);
-
-	mib->tx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR12(0));
-	mib->tx_mpdu_attempts_cnt += mt76_rr(dev, MT_MIB_SDR14(0));
-	mib->tx_mpdu_success_cnt += mt76_rr(dev, MT_MIB_SDR15(0));
-
-	val = mt76_rr(dev, MT_MIB_SDR32(0));
-	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR9_EBF_CNT_MASK, val);
-	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR9_IBF_CNT_MASK, val);
-
-	val = mt76_rr(dev, MT_ETBF_TX_APP_CNT(0));
-	mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, val);
-	mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, val);
-
-	val = mt76_rr(dev, MT_ETBF_RX_FB_CNT(0));
-	mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, val);
-	mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, val);
-	mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, val);
-	mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, val);
-
-	mib->rx_mpdu_cnt += mt76_rr(dev, MT_MIB_SDR5(0));
-	mib->rx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR22(0));
-	mib->rx_ampdu_bytes_cnt += mt76_rr(dev, MT_MIB_SDR23(0));
-	mib->rx_ba_cnt += mt76_rr(dev, MT_MIB_SDR31(0));
-
-	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
-		val = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
-		mib->tx_amsdu[i] += val;
-		mib->tx_amsdu_cnt += val;
-	}
-
-	for (i = 0, aggr1 = aggr0 + 8; i < 4; i++) {
-		u32 val2;
-
-		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
-		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
-
-		phy->mt76->aggr_stats[aggr0++] += val & 0xffff;
-		phy->mt76->aggr_stats[aggr0++] += val >> 16;
-		phy->mt76->aggr_stats[aggr1++] += val2 & 0xffff;
-		phy->mt76->aggr_stats[aggr1++] += val2 >> 16;
-	}
-}
-
-void mt7921_mac_work(struct work_struct *work)
-{
-	struct mt792x_phy *phy;
-	struct mt76_phy *mphy;
-
-	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
-					       mac_work.work);
-	phy = mphy->priv;
-
-	mt792x_mutex_acquire(phy->dev);
-
-	mt76_update_survey(mphy);
-	if (++mphy->mac_work_count == 2) {
-		mphy->mac_work_count = 0;
-
-		mt7921_mac_update_mib_stats(phy);
-	}
-
-	mt792x_mutex_release(phy->dev);
-
-	mt76_tx_status_check(mphy->dev, false);
-	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
-				     MT7921_WATCHDOG_TIME);
-}
-
 void mt7921_pm_wake_work(struct work_struct *work)
 {
 	struct mt792x_dev *dev;
@@ -1013,7 +887,7 @@ void mt7921_pm_wake_work(struct work_struct *work)
 		}
 		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
 			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
-						     MT7921_WATCHDOG_TIME);
+						     MT792x_WATCHDOG_TIME);
 	}
 
 	ieee80211_wake_queues(mphy->hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7213718ae399..223968807516 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -244,7 +244,7 @@ int __mt7921_start(struct mt792x_phy *phy)
 	set_bit(MT76_STATE_RUNNING, &mphy->state);
 
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
-				     MT7921_WATCHDOG_TIME);
+				     MT792x_WATCHDOG_TIME);
 
 	return 0;
 }
@@ -252,7 +252,7 @@ EXPORT_SYMBOL_GPL(__mt7921_start);
 
 static int mt7921_start(struct ieee80211_hw *hw)
 {
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	int err;
 
 	mt792x_mutex_acquire(phy->dev);
@@ -265,7 +265,7 @@ static int mt7921_start(struct ieee80211_hw *hw)
 void mt7921_stop(struct ieee80211_hw *hw)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
@@ -281,19 +281,19 @@ void mt7921_stop(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL_GPL(mt7921_stop);
 
-static int mt7921_add_interface(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif)
+static int
+mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt76_txq *mtxq;
 	int idx, ret = 0;
 
 	mt792x_mutex_acquire(dev);
 
 	mvif->mt76.idx = __ffs64(~dev->mt76.vif_mask);
-	if (mvif->mt76.idx >= MT7921_MAX_INTERFACES) {
+	if (mvif->mt76.idx >= MT792x_MAX_INTERFACES) {
 		ret = -ENOSPC;
 		goto out;
 	}
@@ -311,7 +311,7 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	dev->mt76.vif_mask |= BIT_ULL(mvif->mt76.idx);
 	phy->omac_mask |= BIT_ULL(mvif->mt76.omac_idx);
 
-	idx = MT7921_WTBL_RESERVED - mvif->mt76.idx;
+	idx = MT792x_WTBL_RESERVED - mvif->mt76.idx;
 
 	INIT_LIST_HEAD(&mvif->sta.wcid.poll_list);
 	mvif->sta.wcid.idx = idx;
@@ -338,33 +338,6 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void mt7921_remove_interface(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_sta *msta = &mvif->sta;
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	int idx = msta->wcid.idx;
-
-	mt792x_mutex_acquire(dev);
-	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
-	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
-
-	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
-
-	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
-	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
-	mt792x_mutex_release(dev);
-
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (!list_empty(&msta->wcid.poll_list))
-		list_del_init(&msta->wcid.poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
-
-	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
-}
-
 static void mt7921_roc_iter(void *priv, u8 *mac,
 			    struct ieee80211_vif *vif)
 {
@@ -392,13 +365,6 @@ void mt7921_roc_work(struct work_struct *work)
 	ieee80211_remain_on_channel_expired(phy->mt76->hw);
 }
 
-void mt7921_roc_timer(struct timer_list *timer)
-{
-	struct mt792x_phy *phy = from_timer(phy, timer, roc_timer);
-
-	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
-}
-
 static int mt7921_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
 {
 	int err = 0;
@@ -451,7 +417,7 @@ static int mt7921_remain_on_channel(struct ieee80211_hw *hw,
 				    enum ieee80211_roc_type type)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	int err;
 
 	mt792x_mutex_acquire(phy->dev);
@@ -465,7 +431,7 @@ static int mt7921_cancel_remain_on_channel(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 	return mt7921_abort_roc(phy, mvif);
 }
@@ -486,7 +452,7 @@ static int mt7921_set_channel(struct mt792x_phy *phy)
 	if (ret)
 		goto out;
 
-	mt7921_mac_set_timing(phy);
+	mt792x_mac_set_timeing(phy);
 
 	mt7921_mac_reset_counters(phy);
 	phy->noise = 0;
@@ -497,7 +463,7 @@ static int mt7921_set_channel(struct mt792x_phy *phy)
 
 	mt76_worker_schedule(&dev->mt76.tx_worker);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &phy->mt76->mac_work,
-				     MT7921_WATCHDOG_TIME);
+				     MT792x_WATCHDOG_TIME);
 
 	return ret;
 }
@@ -631,7 +597,7 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
 static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	int ret = 0;
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
@@ -662,20 +628,6 @@ static int mt7921_config(struct ieee80211_hw *hw, u32 changed)
 	return ret;
 }
 
-static int
-mt7921_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       unsigned int link_id, u16 queue,
-	       const struct ieee80211_tx_queue_params *params)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-
-	/* no need to update right away, we'll get BSS_CHANGED_QOS */
-	queue = mt76_connac_lmac_mapping(queue);
-	mvif->queue_params[queue] = *params;
-
-	return 0;
-}
-
 static void mt7921_configure_filter(struct ieee80211_hw *hw,
 				    unsigned int changed_flags,
 				    unsigned int *total_flags,
@@ -710,7 +662,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 				    struct ieee80211_bss_conf *info,
 				    u64 changed)
 {
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 
 	mt792x_mutex_acquire(dev);
@@ -720,7 +672,7 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 
 		if (slottime != phy->slottime) {
 			phy->slottime = slottime;
-			mt7921_mac_set_timing(phy);
+			mt792x_mac_set_timeing(phy);
 		}
 	}
 
@@ -760,7 +712,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int ret, idx;
 
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7921_WTBL_STA - 1);
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
@@ -851,60 +803,6 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_remove);
 
-void mt7921_tx_worker(struct mt76_worker *w)
-{
-	struct mt792x_dev *dev = container_of(w, struct mt792x_dev,
-					      mt76.tx_worker);
-
-	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
-		queue_work(dev->mt76.wq, &dev->pm.wake_work);
-		return;
-	}
-
-	mt76_txq_schedule_all(&dev->mphy);
-	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
-}
-
-static void mt7921_tx(struct ieee80211_hw *hw,
-		      struct ieee80211_tx_control *control,
-		      struct sk_buff *skb)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt76_phy *mphy = hw->priv;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_vif *vif = info->control.vif;
-	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
-	int qid;
-
-	if (control->sta) {
-		struct mt792x_sta *sta;
-
-		sta = (struct mt792x_sta *)control->sta->drv_priv;
-		wcid = &sta->wcid;
-	}
-
-	if (vif && !control->sta) {
-		struct mt792x_vif *mvif;
-
-		mvif = (struct mt792x_vif *)vif->drv_priv;
-		wcid = &mvif->sta.wcid;
-	}
-
-	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
-		mt76_tx(mphy, control->sta, wcid, skb);
-		mt76_connac_pm_unref(mphy, &dev->pm);
-		return;
-	}
-
-	qid = skb_get_queue_mapping(skb);
-	if (qid >= MT_TXQ_PSD) {
-		qid = IEEE80211_AC_BE;
-		skb_set_queue_mapping(skb, qid);
-	}
-
-	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
-}
-
 static int mt7921_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
@@ -990,277 +888,6 @@ static int mt7921_sta_state(struct ieee80211_hw *hw,
 	return mt76_sta_state(hw, vif, sta, old_state, new_state);
 }
 
-static int
-mt7921_get_stats(struct ieee80211_hw *hw,
-		 struct ieee80211_low_level_stats *stats)
-{
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt76_mib_stats *mib = &phy->mib;
-
-	mt792x_mutex_acquire(phy->dev);
-
-	stats->dot11RTSSuccessCount = mib->rts_cnt;
-	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
-	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
-	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
-
-	mt792x_mutex_release(phy->dev);
-
-	return 0;
-}
-
-static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
-	/* tx counters */
-	"tx_ampdu_cnt",
-	"tx_mpdu_attempts",
-	"tx_mpdu_success",
-	"tx_pkt_ebf_cnt",
-	"tx_pkt_ibf_cnt",
-	"tx_ampdu_len:0-1",
-	"tx_ampdu_len:2-10",
-	"tx_ampdu_len:11-19",
-	"tx_ampdu_len:20-28",
-	"tx_ampdu_len:29-37",
-	"tx_ampdu_len:38-46",
-	"tx_ampdu_len:47-55",
-	"tx_ampdu_len:56-79",
-	"tx_ampdu_len:80-103",
-	"tx_ampdu_len:104-127",
-	"tx_ampdu_len:128-151",
-	"tx_ampdu_len:152-175",
-	"tx_ampdu_len:176-199",
-	"tx_ampdu_len:200-223",
-	"tx_ampdu_len:224-247",
-	"ba_miss_count",
-	"tx_beamformer_ppdu_iBF",
-	"tx_beamformer_ppdu_eBF",
-	"tx_beamformer_rx_feedback_all",
-	"tx_beamformer_rx_feedback_he",
-	"tx_beamformer_rx_feedback_vht",
-	"tx_beamformer_rx_feedback_ht",
-	"tx_msdu_pack_1",
-	"tx_msdu_pack_2",
-	"tx_msdu_pack_3",
-	"tx_msdu_pack_4",
-	"tx_msdu_pack_5",
-	"tx_msdu_pack_6",
-	"tx_msdu_pack_7",
-	"tx_msdu_pack_8",
-	/* rx counters */
-	"rx_mpdu_cnt",
-	"rx_ampdu_cnt",
-	"rx_ampdu_bytes_cnt",
-	"rx_ba_cnt",
-	/* per vif counters */
-	"v_tx_mode_cck",
-	"v_tx_mode_ofdm",
-	"v_tx_mode_ht",
-	"v_tx_mode_ht_gf",
-	"v_tx_mode_vht",
-	"v_tx_mode_he_su",
-	"v_tx_mode_he_ext_su",
-	"v_tx_mode_he_tb",
-	"v_tx_mode_he_mu",
-	"v_tx_bw_20",
-	"v_tx_bw_40",
-	"v_tx_bw_80",
-	"v_tx_bw_160",
-	"v_tx_mcs_0",
-	"v_tx_mcs_1",
-	"v_tx_mcs_2",
-	"v_tx_mcs_3",
-	"v_tx_mcs_4",
-	"v_tx_mcs_5",
-	"v_tx_mcs_6",
-	"v_tx_mcs_7",
-	"v_tx_mcs_8",
-	"v_tx_mcs_9",
-	"v_tx_mcs_10",
-	"v_tx_mcs_11",
-	"v_tx_nss_1",
-	"v_tx_nss_2",
-	"v_tx_nss_3",
-	"v_tx_nss_4",
-};
-
-static void
-mt7921_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		      u32 sset, u8 *data)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	if (sset != ETH_SS_STATS)
-		return;
-
-	memcpy(data, *mt7921_gstrings_stats, sizeof(mt7921_gstrings_stats));
-
-	if (mt76_is_sdio(&dev->mt76))
-		return;
-
-	data += sizeof(mt7921_gstrings_stats);
-	page_pool_ethtool_stats_get_strings(data);
-}
-
-static int
-mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			 int sset)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	if (sset != ETH_SS_STATS)
-		return 0;
-
-	if (mt76_is_sdio(&dev->mt76))
-		return ARRAY_SIZE(mt7921_gstrings_stats);
-
-	return ARRAY_SIZE(mt7921_gstrings_stats) +
-	       page_pool_ethtool_stats_get_count();
-}
-
-static void
-mt7921_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
-{
-	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct mt76_ethtool_worker_info *wi = wi_data;
-
-	if (msta->vif->mt76.idx != wi->idx)
-		return;
-
-	mt76_ethtool_worker(wi, &msta->wcid.stats, false);
-}
-
-static
-void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			 struct ethtool_stats *stats, u64 *data)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	int stats_size = ARRAY_SIZE(mt7921_gstrings_stats);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt792x_dev *dev = phy->dev;
-	struct mt76_mib_stats *mib = &phy->mib;
-	struct mt76_ethtool_worker_info wi = {
-		.data = data,
-		.idx = mvif->mt76.idx,
-	};
-	int i, ei = 0;
-
-	mt792x_mutex_acquire(dev);
-
-	mt7921_mac_update_mib_stats(phy);
-
-	data[ei++] = mib->tx_ampdu_cnt;
-	data[ei++] = mib->tx_mpdu_attempts_cnt;
-	data[ei++] = mib->tx_mpdu_success_cnt;
-	data[ei++] = mib->tx_pkt_ebf_cnt;
-	data[ei++] = mib->tx_pkt_ibf_cnt;
-
-	/* Tx ampdu stat */
-	for (i = 0; i < 15; i++)
-		data[ei++] = phy->mt76->aggr_stats[i];
-
-	data[ei++] = phy->mib.ba_miss_cnt;
-
-	/* Tx Beamformer monitor */
-	data[ei++] = mib->tx_bf_ibf_ppdu_cnt;
-	data[ei++] = mib->tx_bf_ebf_ppdu_cnt;
-
-	/* Tx Beamformer Rx feedback monitor */
-	data[ei++] = mib->tx_bf_rx_fb_all_cnt;
-	data[ei++] = mib->tx_bf_rx_fb_he_cnt;
-	data[ei++] = mib->tx_bf_rx_fb_vht_cnt;
-	data[ei++] = mib->tx_bf_rx_fb_ht_cnt;
-
-	/* Tx amsdu info (pack-count histogram) */
-	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++)
-		data[ei++] = mib->tx_amsdu[i];
-
-	/* rx counters */
-	data[ei++] = mib->rx_mpdu_cnt;
-	data[ei++] = mib->rx_ampdu_cnt;
-	data[ei++] = mib->rx_ampdu_bytes_cnt;
-	data[ei++] = mib->rx_ba_cnt;
-
-	/* Add values for all stations owned by this vif */
-	wi.initial_stat_idx = ei;
-	ieee80211_iterate_stations_atomic(hw, mt7921_ethtool_worker, &wi);
-
-	mt792x_mutex_release(dev);
-
-	if (!wi.sta_count)
-		return;
-
-	ei += wi.worker_stat_count;
-
-	if (!mt76_is_sdio(&dev->mt76)) {
-		mt76_ethtool_page_pool_stats(&dev->mt76, &data[ei], &ei);
-		stats_size += page_pool_ethtool_stats_get_count();
-	}
-
-	if (ei != stats_size)
-		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %d", ei, stats_size);
-}
-
-static u64
-mt7921_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	u8 omac_idx = mvif->mt76.omac_idx;
-	union {
-		u64 t64;
-		u32 t32[2];
-	} tsf;
-	u16 n;
-
-	mt792x_mutex_acquire(dev);
-
-	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
-	/* TSF software read */
-	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_MODE);
-	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(0));
-	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(0));
-
-	mt792x_mutex_release(dev);
-
-	return tsf.t64;
-}
-
-static void
-mt7921_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       u64 timestamp)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	u8 omac_idx = mvif->mt76.omac_idx;
-	union {
-		u64 t64;
-		u32 t32[2];
-	} tsf = { .t64 = timestamp, };
-	u16 n;
-
-	mt792x_mutex_acquire(dev);
-
-	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
-	mt76_wr(dev, MT_LPON_UTTR0(0), tsf.t32[0]);
-	mt76_wr(dev, MT_LPON_UTTR1(0), tsf.t32[1]);
-	/* TSF software overwrite */
-	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_WRITE);
-
-	mt792x_mutex_release(dev);
-}
-
-static void
-mt7921_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
-{
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
-	struct mt792x_dev *dev = phy->dev;
-
-	mt792x_mutex_acquire(dev);
-	phy->coverage_class = max_t(s16, coverage_class, 0);
-	mt7921_mac_set_timing(phy);
-	mt792x_mutex_release(dev);
-}
-
 void mt7921_scan_work(struct work_struct *work)
 {
 	struct mt792x_phy *phy;
@@ -1360,7 +987,7 @@ static int
 mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	int max_nss = hweight8(hw->wiphy->available_antennas_tx);
 
 	if (!tx_ant || tx_ant != rx_ant || ffs(tx_ant) > max_nss)
@@ -1382,49 +1009,12 @@ mt7921_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	return 0;
 }
 
-static void mt7921_sta_statistics(struct ieee80211_hw *hw,
-				  struct ieee80211_vif *vif,
-				  struct ieee80211_sta *sta,
-				  struct station_info *sinfo)
-{
-	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct rate_info *txrate = &msta->wcid.rate;
-
-	if (!txrate->legacy && !txrate->flags)
-		return;
-
-	if (txrate->legacy) {
-		sinfo->txrate.legacy = txrate->legacy;
-	} else {
-		sinfo->txrate.mcs = txrate->mcs;
-		sinfo->txrate.nss = txrate->nss;
-		sinfo->txrate.bw = txrate->bw;
-		sinfo->txrate.he_gi = txrate->he_gi;
-		sinfo->txrate.he_dcm = txrate->he_dcm;
-		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
-	}
-	sinfo->tx_failed = msta->wcid.stats.tx_failed;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
-
-	sinfo->tx_retries = msta->wcid.stats.tx_retries;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
-
-	sinfo->txrate.flags = txrate->flags;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
-
-	sinfo->ack_signal = (s8)msta->ack_signal;
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
-
-	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
-	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
-}
-
 #ifdef CONFIG_PM
 static int mt7921_suspend(struct ieee80211_hw *hw,
 			  struct cfg80211_wowlan *wowlan)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 	cancel_delayed_work_sync(&phy->scan_work);
 	cancel_delayed_work_sync(&phy->mt76->mac_work);
@@ -1448,7 +1038,7 @@ static int mt7921_suspend(struct ieee80211_hw *hw,
 static int mt7921_resume(struct ieee80211_hw *hw)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 	mt792x_mutex_acquire(dev);
 
@@ -1459,21 +1049,13 @@ static int mt7921_resume(struct ieee80211_hw *hw)
 					    &dev->mphy);
 
 	ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
-				     MT7921_WATCHDOG_TIME);
+				     MT792x_WATCHDOG_TIME);
 
 	mt792x_mutex_release(dev);
 
 	return 0;
 }
 
-static void mt7921_set_wakeup(struct ieee80211_hw *hw, bool enabled)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-	struct mt76_dev *mdev = &dev->mt76;
-
-	device_set_wakeup_enable(mdev->dev, enabled);
-}
-
 static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct cfg80211_gtk_rekey_data *data)
@@ -1486,15 +1068,6 @@ static void mt7921_set_rekey_data(struct ieee80211_hw *hw,
 }
 #endif /* CONFIG_PM */
 
-static void mt7921_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			 u32 queues, bool drop)
-{
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	wait_event_timeout(dev->mt76.tx_wait, !mt76_has_tx_pending(&dev->mphy),
-			   HZ / 2);
-}
-
 static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 					 struct ieee80211_vif *vif,
 					 struct ieee80211_sta *sta,
@@ -1588,7 +1161,7 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			return err;
 	}
 
-	mt7921_init_acpi_sar_power(mt7921_hw_phy(hw), !sar);
+	mt7921_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
 
 	err = mt76_connac_mcu_set_rate_txpower(mphy);
 
@@ -1631,7 +1204,7 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *link_conf)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	int err;
 
@@ -1659,7 +1232,7 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       struct ieee80211_bss_conf *link_conf)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
 	int err;
 
@@ -1709,7 +1282,7 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 		      struct ieee80211_chanctx_conf *ctx,
 		      u32 changed)
 {
-	struct mt792x_phy *phy = mt7921_hw_phy(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
 	mt792x_mutex_acquire(phy->dev);
 	ieee80211_iterate_active_interfaces(phy->mt76->hw,
@@ -1718,36 +1291,6 @@ mt7921_change_chanctx(struct ieee80211_hw *hw,
 	mt792x_mutex_release(phy->dev);
 }
 
-static int
-mt7921_assign_vif_chanctx(struct ieee80211_hw *hw,
-			  struct ieee80211_vif *vif,
-			  struct ieee80211_bss_conf *link_conf,
-			  struct ieee80211_chanctx_conf *ctx)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	mutex_lock(&dev->mt76.mutex);
-	mvif->ctx = ctx;
-	mutex_unlock(&dev->mt76.mutex);
-
-	return 0;
-}
-
-static void
-mt7921_unassign_vif_chanctx(struct ieee80211_hw *hw,
-			    struct ieee80211_vif *vif,
-			    struct ieee80211_bss_conf *link_conf,
-			    struct ieee80211_chanctx_conf *ctx)
-{
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_dev *dev = mt792x_hw_dev(hw);
-
-	mutex_lock(&dev->mt76.mutex);
-	mvif->ctx = NULL;
-	mutex_unlock(&dev->mt76.mutex);
-}
-
 static void mt7921_mgd_prepare_tx(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif,
 				  struct ieee80211_prep_tx_info *info)
@@ -1773,13 +1316,13 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
 }
 
 const struct ieee80211_ops mt7921_ops = {
-	.tx = mt7921_tx,
+	.tx = mt792x_tx,
 	.start = mt7921_start,
 	.stop = mt7921_stop,
 	.add_interface = mt7921_add_interface,
-	.remove_interface = mt7921_remove_interface,
+	.remove_interface = mt792x_remove_interface,
 	.config = mt7921_config,
-	.conf_tx = mt7921_conf_tx,
+	.conf_tx = mt792x_conf_tx,
 	.configure_filter = mt7921_configure_filter,
 	.bss_info_changed = mt7921_bss_info_changed,
 	.start_ap = mt7921_start_ap,
@@ -1797,19 +1340,19 @@ const struct ieee80211_ops mt7921_ops = {
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.channel_switch_beacon = mt7921_channel_switch_beacon,
 	.get_txpower = mt76_get_txpower,
-	.get_stats = mt7921_get_stats,
-	.get_et_sset_count = mt7921_get_et_sset_count,
-	.get_et_strings = mt7921_get_et_strings,
-	.get_et_stats = mt7921_get_et_stats,
-	.get_tsf = mt7921_get_tsf,
-	.set_tsf = mt7921_set_tsf,
+	.get_stats = mt792x_get_stats,
+	.get_et_sset_count = mt792x_get_et_sset_count,
+	.get_et_strings = mt792x_get_et_strings,
+	.get_et_stats = mt792x_get_et_stats,
+	.get_tsf = mt792x_get_tsf,
+	.set_tsf = mt792x_set_tsf,
 	.get_survey = mt76_get_survey,
 	.get_antenna = mt76_get_antenna,
 	.set_antenna = mt7921_set_antenna,
-	.set_coverage_class = mt7921_set_coverage_class,
+	.set_coverage_class = mt792x_set_coverage_class,
 	.hw_scan = mt7921_hw_scan,
 	.cancel_hw_scan = mt7921_cancel_hw_scan,
-	.sta_statistics = mt7921_sta_statistics,
+	.sta_statistics = mt792x_sta_statistics,
 	.sched_scan_start = mt7921_start_sched_scan,
 	.sched_scan_stop = mt7921_stop_sched_scan,
 	CFG80211_TESTMODE_CMD(mt7921_testmode_cmd)
@@ -1817,18 +1360,18 @@ const struct ieee80211_ops mt7921_ops = {
 #ifdef CONFIG_PM
 	.suspend = mt7921_suspend,
 	.resume = mt7921_resume,
-	.set_wakeup = mt7921_set_wakeup,
+	.set_wakeup = mt792x_set_wakeup,
 	.set_rekey_data = mt7921_set_rekey_data,
 #endif /* CONFIG_PM */
-	.flush = mt7921_flush,
+	.flush = mt792x_flush,
 	.set_sar_specs = mt7921_set_sar_specs,
 	.remain_on_channel = mt7921_remain_on_channel,
 	.cancel_remain_on_channel = mt7921_cancel_remain_on_channel,
 	.add_chanctx = mt7921_add_chanctx,
 	.remove_chanctx = mt7921_remove_chanctx,
 	.change_chanctx = mt7921_change_chanctx,
-	.assign_vif_chanctx = mt7921_assign_vif_chanctx,
-	.unassign_vif_chanctx = mt7921_unassign_vif_chanctx,
+	.assign_vif_chanctx = mt792x_assign_vif_chanctx,
+	.unassign_vif_chanctx = mt792x_unassign_vif_chanctx,
 	.mgd_prepare_tx = mt7921_mgd_prepare_tx,
 	.mgd_complete_tx = mt7921_mgd_complete_tx,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index db3394ba4e45..3dd9ff5e466b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -4,9 +4,9 @@
 #include <linux/fs.h>
 #include <linux/firmware.h>
 #include "mt7921.h"
-#include "mt7921_trace.h"
 #include "mcu.h"
 #include "../mt76_connac2_mac.h"
+#include "../mt792x_trace.h"
 
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index ad18fcc4a7b0..4722952bb846 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -8,15 +8,8 @@
 #include "regs.h"
 #include "acpi_sar.h"
 
-#define MT7921_MAX_INTERFACES		4
-#define MT7921_WTBL_SIZE		20
-#define MT7921_WTBL_RESERVED		(MT7921_WTBL_SIZE - 1)
-#define MT7921_WTBL_STA			(MT7921_WTBL_RESERVED - \
-					 MT7921_MAX_INTERFACES)
-
 #define MT7921_PM_TIMEOUT		(HZ / 12)
 #define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
-#define MT7921_WATCHDOG_TIME		(HZ / 4)
 
 #define MT7921_TX_RING_SIZE		2048
 #define MT7921_TX_MCU_RING_SIZE		256
@@ -43,9 +36,6 @@
 
 #define MT7921_EEPROM_BLOCK_SIZE	16
 
-#define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
-#define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
-
 #define MT7921_SKU_RATE_NUM		161
 #define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
 #define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
@@ -208,14 +198,6 @@ struct mt7921_txpwr {
 	} data[TXPWR_MAX_NUM];
 };
 
-static inline struct mt792x_phy *
-mt7921_hw_phy(struct ieee80211_hw *hw)
-{
-	struct mt76_phy *phy = hw->priv;
-
-	return phy->priv;
-}
-
 extern const struct ieee80211_ops mt7921_ops;
 
 u32 mt7921_reg_map(struct mt792x_dev *dev, u32 addr);
@@ -300,25 +282,21 @@ mt7921_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
 
 void mt7921_stop(struct ieee80211_hw *hw);
 int mt7921_mac_init(struct mt792x_dev *dev);
-bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt792x_phy *phy);
-void mt7921_mac_set_timing(struct mt792x_phy *phy);
+bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta);
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
-void mt7921_mac_work(struct work_struct *work);
 void mt7921_mac_reset_work(struct work_struct *work);
-void mt7921_mac_update_mib_stats(struct mt792x_phy *phy);
 void mt7921_reset(struct mt76_dev *mdev);
 int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			   struct ieee80211_sta *sta,
 			   struct mt76_tx_info *tx_info);
 
-void mt7921_tx_worker(struct mt76_worker *w);
 bool mt7921_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
@@ -338,7 +316,6 @@ int mt7921_mcu_uni_rx_ba(struct mt792x_dev *dev,
 			 bool enable);
 void mt7921_scan_work(struct work_struct *work);
 void mt7921_roc_work(struct work_struct *work);
-void mt7921_roc_timer(struct timer_list *timer);
 int mt7921_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif);
 int mt7921_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt7921_mcu_fw_pmctrl(struct mt792x_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index fefc10539586..c5ca1b931584 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -93,4 +93,8 @@
 #define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x200)
 #define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
 
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x230)
+#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 360de6a0de2b..310eeca024ad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -23,7 +23,7 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	/* We just return in case firmware assertion to avoid blocking the
 	 * common workqueue to run, for example, the coredump work might be
-	 * blocked by mt7921_mac_work that is excuting register access via sdio
+	 * blocked by mt792x_mac_work that is excuting register access via sdio
 	 * bus.
 	 */
 	if (dev->fw_assert)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/trace.c b/drivers/net/wireless/mediatek/mt76/mt7921/trace.c
deleted file mode 100644
index 4dc3c7b89ebd..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7921/trace.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: ISC
-/*
- * Copyright (C) 2021 Lorenzo Bianconi <lorenzo@kernel.org>
- */
-
-#include <linux/module.h>
-
-#ifndef __CHECKER__
-#define CREATE_TRACE_POINTS
-#include "mt7921_trace.h"
-
-#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 9c724bc156af..83236a6c300e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -9,6 +9,19 @@
 
 #include "mt76_connac_mcu.h"
 
+#define MT792x_MAX_INTERFACES	4
+#define MT792x_WTBL_SIZE	20
+#define MT792x_WTBL_RESERVED	(MT792x_WTBL_SIZE - 1)
+#define MT792x_WTBL_STA		(MT792x_WTBL_RESERVED - MT792x_MAX_INTERFACES)
+
+#define MT792x_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT792x_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+
+/* NOTE: used to map mt76_rates. idx may change if firmware expands table */
+#define MT792x_BASIC_RATES_TBL	11
+
+#define MT792x_WATCHDOG_TIME	(HZ / 4)
+
 struct mt792x_vif;
 struct mt792x_sta;
 
@@ -134,9 +147,57 @@ mt792x_hw_dev(struct ieee80211_hw *hw)
 	return container_of(phy->dev, struct mt792x_dev, mt76);
 }
 
+static inline struct mt792x_phy *
+mt792x_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
 #define mt792x_mutex_acquire(dev)	\
 	mt76_connac_mutex_acquire(&(dev)->mt76, &(dev)->pm)
 #define mt792x_mutex_release(dev)	\
 	mt76_connac_mutex_release(&(dev)->mt76, &(dev)->pm)
 
+void mt792x_mac_update_mib_stats(struct mt792x_phy *phy);
+void mt792x_mac_set_timeing(struct mt792x_phy *phy);
+void mt792x_mac_work(struct work_struct *work);
+void mt792x_remove_interface(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif);
+void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
+	       struct sk_buff *skb);
+int mt792x_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   unsigned int link_id, u16 queue,
+		   const struct ieee80211_tx_queue_params *params);
+int mt792x_get_stats(struct ieee80211_hw *hw,
+		     struct ieee80211_low_level_stats *stats);
+u64 mt792x_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void mt792x_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    u64 timestamp);
+void mt792x_tx_worker(struct mt76_worker *w);
+void mt792x_roc_timer(struct timer_list *timer);
+void mt792x_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  u32 queues, bool drop);
+int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct ieee80211_chanctx_conf *ctx);
+void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *link_conf,
+				 struct ieee80211_chanctx_conf *ctx);
+void mt792x_set_wakeup(struct ieee80211_hw *hw, bool enabled);
+void mt792x_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   u32 sset, u8 *data);
+int mt792x_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     int sset);
+void mt792x_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 struct ethtool_stats *stats, u64 *data);
+void mt792x_sta_statistics(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta,
+			   struct station_info *sinfo);
+void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class);
+
 #endif /* __MT7925_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
new file mode 100644
index 000000000000..fa648b133397
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -0,0 +1,469 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include <linux/module.h>
+
+#include "mt792x.h"
+#include "mt792x_regs.h"
+
+void mt792x_tx(struct ieee80211_hw *hw, struct ieee80211_tx_control *control,
+	       struct sk_buff *skb)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_phy *mphy = hw->priv;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_wcid *wcid = &dev->mt76.global_wcid;
+	int qid;
+
+	if (control->sta) {
+		struct mt792x_sta *sta;
+
+		sta = (struct mt792x_sta *)control->sta->drv_priv;
+		wcid = &sta->wcid;
+	}
+
+	if (vif && !control->sta) {
+		struct mt792x_vif *mvif;
+
+		mvif = (struct mt792x_vif *)vif->drv_priv;
+		wcid = &mvif->sta.wcid;
+	}
+
+	if (mt76_connac_pm_ref(mphy, &dev->pm)) {
+		mt76_tx(mphy, control->sta, wcid, skb);
+		mt76_connac_pm_unref(mphy, &dev->pm);
+		return;
+	}
+
+	qid = skb_get_queue_mapping(skb);
+	if (qid >= MT_TXQ_PSD) {
+		qid = IEEE80211_AC_BE;
+		skb_set_queue_mapping(skb, qid);
+	}
+
+	mt76_connac_pm_queue_skb(hw, &dev->pm, wcid, skb);
+}
+EXPORT_SYMBOL_GPL(mt792x_tx);
+
+void mt792x_remove_interface(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = &mvif->sta;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int idx = msta->wcid.idx;
+
+	mt792x_mutex_acquire(dev);
+	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
+	mt76_connac_mcu_uni_add_dev(&dev->mphy, vif, &mvif->sta.wcid, false);
+
+	rcu_assign_pointer(dev->mt76.wcid[idx], NULL);
+
+	dev->mt76.vif_mask &= ~BIT_ULL(mvif->mt76.idx);
+	phy->omac_mask &= ~BIT_ULL(mvif->mt76.omac_idx);
+	mt792x_mutex_release(dev);
+
+	spin_lock_bh(&dev->mt76.sta_poll_lock);
+	if (!list_empty(&msta->wcid.poll_list))
+		list_del_init(&msta->wcid.poll_list);
+	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+
+	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+}
+EXPORT_SYMBOL_GPL(mt792x_remove_interface);
+
+int mt792x_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   unsigned int link_id, u16 queue,
+		   const struct ieee80211_tx_queue_params *params)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+
+	/* no need to update right away, we'll get BSS_CHANGED_QOS */
+	queue = mt76_connac_lmac_mapping(queue);
+	mvif->queue_params[queue] = *params;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_conf_tx);
+
+int mt792x_get_stats(struct ieee80211_hw *hw,
+		     struct ieee80211_low_level_stats *stats)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt76_mib_stats *mib = &phy->mib;
+
+	mt792x_mutex_acquire(phy->dev);
+
+	stats->dot11RTSSuccessCount = mib->rts_cnt;
+	stats->dot11RTSFailureCount = mib->rts_retries_cnt;
+	stats->dot11FCSErrorCount = mib->fcs_err_cnt;
+	stats->dot11ACKFailureCount = mib->ack_fail_cnt;
+
+	mt792x_mutex_release(phy->dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_get_stats);
+
+u64 mt792x_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	u8 omac_idx = mvif->mt76.omac_idx;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf;
+	u16 n;
+
+	mt792x_mutex_acquire(dev);
+
+	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
+	/* TSF software read */
+	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_MODE);
+	tsf.t32[0] = mt76_rr(dev, MT_LPON_UTTR0(0));
+	tsf.t32[1] = mt76_rr(dev, MT_LPON_UTTR1(0));
+
+	mt792x_mutex_release(dev);
+
+	return tsf.t64;
+}
+EXPORT_SYMBOL_GPL(mt792x_get_tsf);
+
+void mt792x_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		    u64 timestamp)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	u8 omac_idx = mvif->mt76.omac_idx;
+	union {
+		u64 t64;
+		u32 t32[2];
+	} tsf = { .t64 = timestamp, };
+	u16 n;
+
+	mt792x_mutex_acquire(dev);
+
+	n = omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : omac_idx;
+	mt76_wr(dev, MT_LPON_UTTR0(0), tsf.t32[0]);
+	mt76_wr(dev, MT_LPON_UTTR1(0), tsf.t32[1]);
+	/* TSF software overwrite */
+	mt76_set(dev, MT_LPON_TCR(0, n), MT_LPON_TCR_SW_WRITE);
+
+	mt792x_mutex_release(dev);
+}
+EXPORT_SYMBOL_GPL(mt792x_set_tsf);
+
+void mt792x_tx_worker(struct mt76_worker *w)
+{
+	struct mt792x_dev *dev = container_of(w, struct mt792x_dev,
+					      mt76.tx_worker);
+
+	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm)) {
+		queue_work(dev->mt76.wq, &dev->pm.wake_work);
+		return;
+	}
+
+	mt76_txq_schedule_all(&dev->mphy);
+	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+}
+EXPORT_SYMBOL_GPL(mt792x_tx_worker);
+
+void mt792x_roc_timer(struct timer_list *timer)
+{
+	struct mt792x_phy *phy = from_timer(phy, timer, roc_timer);
+
+	ieee80211_queue_work(phy->mt76->hw, &phy->roc_work);
+}
+EXPORT_SYMBOL_GPL(mt792x_roc_timer);
+
+void mt792x_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  u32 queues, bool drop)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	wait_event_timeout(dev->mt76.tx_wait,
+			   !mt76_has_tx_pending(&dev->mphy), HZ / 2);
+}
+EXPORT_SYMBOL_GPL(mt792x_flush);
+
+int mt792x_assign_vif_chanctx(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_bss_conf *link_conf,
+			      struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mvif->ctx = ctx;
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_assign_vif_chanctx);
+
+void mt792x_unassign_vif_chanctx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *link_conf,
+				 struct ieee80211_chanctx_conf *ctx)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mvif->ctx = NULL;
+	mutex_unlock(&dev->mt76.mutex);
+}
+EXPORT_SYMBOL_GPL(mt792x_unassign_vif_chanctx);
+
+void mt792x_set_wakeup(struct ieee80211_hw *hw, bool enabled)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt76_dev *mdev = &dev->mt76;
+
+	device_set_wakeup_enable(mdev->dev, enabled);
+}
+EXPORT_SYMBOL_GPL(mt792x_set_wakeup);
+
+static const char mt792x_gstrings_stats[][ETH_GSTRING_LEN] = {
+	/* tx counters */
+	"tx_ampdu_cnt",
+	"tx_mpdu_attempts",
+	"tx_mpdu_success",
+	"tx_pkt_ebf_cnt",
+	"tx_pkt_ibf_cnt",
+	"tx_ampdu_len:0-1",
+	"tx_ampdu_len:2-10",
+	"tx_ampdu_len:11-19",
+	"tx_ampdu_len:20-28",
+	"tx_ampdu_len:29-37",
+	"tx_ampdu_len:38-46",
+	"tx_ampdu_len:47-55",
+	"tx_ampdu_len:56-79",
+	"tx_ampdu_len:80-103",
+	"tx_ampdu_len:104-127",
+	"tx_ampdu_len:128-151",
+	"tx_ampdu_len:152-175",
+	"tx_ampdu_len:176-199",
+	"tx_ampdu_len:200-223",
+	"tx_ampdu_len:224-247",
+	"ba_miss_count",
+	"tx_beamformer_ppdu_iBF",
+	"tx_beamformer_ppdu_eBF",
+	"tx_beamformer_rx_feedback_all",
+	"tx_beamformer_rx_feedback_he",
+	"tx_beamformer_rx_feedback_vht",
+	"tx_beamformer_rx_feedback_ht",
+	"tx_msdu_pack_1",
+	"tx_msdu_pack_2",
+	"tx_msdu_pack_3",
+	"tx_msdu_pack_4",
+	"tx_msdu_pack_5",
+	"tx_msdu_pack_6",
+	"tx_msdu_pack_7",
+	"tx_msdu_pack_8",
+	/* rx counters */
+	"rx_mpdu_cnt",
+	"rx_ampdu_cnt",
+	"rx_ampdu_bytes_cnt",
+	"rx_ba_cnt",
+	/* per vif counters */
+	"v_tx_mode_cck",
+	"v_tx_mode_ofdm",
+	"v_tx_mode_ht",
+	"v_tx_mode_ht_gf",
+	"v_tx_mode_vht",
+	"v_tx_mode_he_su",
+	"v_tx_mode_he_ext_su",
+	"v_tx_mode_he_tb",
+	"v_tx_mode_he_mu",
+	"v_tx_mode_eht_su",
+	"v_tx_mode_eht_trig",
+	"v_tx_mode_eht_mu",
+	"v_tx_bw_20",
+	"v_tx_bw_40",
+	"v_tx_bw_80",
+	"v_tx_bw_160",
+	"v_tx_mcs_0",
+	"v_tx_mcs_1",
+	"v_tx_mcs_2",
+	"v_tx_mcs_3",
+	"v_tx_mcs_4",
+	"v_tx_mcs_5",
+	"v_tx_mcs_6",
+	"v_tx_mcs_7",
+	"v_tx_mcs_8",
+	"v_tx_mcs_9",
+	"v_tx_mcs_10",
+	"v_tx_mcs_11",
+	"v_tx_mcs_12",
+	"v_tx_mcs_13",
+	"v_tx_nss_1",
+	"v_tx_nss_2",
+	"v_tx_nss_3",
+	"v_tx_nss_4",
+};
+
+void mt792x_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   u32 sset, u8 *data)
+{
+	if (sset != ETH_SS_STATS)
+		return;
+
+	memcpy(data, *mt792x_gstrings_stats, sizeof(mt792x_gstrings_stats));
+
+	data += sizeof(mt792x_gstrings_stats);
+	page_pool_ethtool_stats_get_strings(data);
+}
+EXPORT_SYMBOL_GPL(mt792x_get_et_strings);
+
+int mt792x_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			     int sset)
+{
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	return ARRAY_SIZE(mt792x_gstrings_stats) +
+	       page_pool_ethtool_stats_get_count();
+}
+EXPORT_SYMBOL_GPL(mt792x_get_et_sset_count);
+
+static void
+mt792x_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt76_ethtool_worker_info *wi = wi_data;
+
+	if (msta->vif->mt76.idx != wi->idx)
+		return;
+
+	mt76_ethtool_worker(wi, &msta->wcid.stats, true);
+}
+
+void mt792x_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			 struct ethtool_stats *stats, u64 *data)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	int stats_size = ARRAY_SIZE(mt792x_gstrings_stats);
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = phy->dev;
+	struct mt76_mib_stats *mib = &phy->mib;
+	struct mt76_ethtool_worker_info wi = {
+		.data = data,
+		.idx = mvif->mt76.idx,
+	};
+	int i, ei = 0;
+
+	mt792x_mutex_acquire(dev);
+
+	mt792x_mac_update_mib_stats(phy);
+
+	data[ei++] = mib->tx_ampdu_cnt;
+	data[ei++] = mib->tx_mpdu_attempts_cnt;
+	data[ei++] = mib->tx_mpdu_success_cnt;
+	data[ei++] = mib->tx_pkt_ebf_cnt;
+	data[ei++] = mib->tx_pkt_ibf_cnt;
+
+	/* Tx ampdu stat */
+	for (i = 0; i < 15; i++)
+		data[ei++] = phy->mt76->aggr_stats[i];
+
+	data[ei++] = phy->mib.ba_miss_cnt;
+
+	/* Tx Beamformer monitor */
+	data[ei++] = mib->tx_bf_ibf_ppdu_cnt;
+	data[ei++] = mib->tx_bf_ebf_ppdu_cnt;
+
+	/* Tx Beamformer Rx feedback monitor */
+	data[ei++] = mib->tx_bf_rx_fb_all_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_he_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_vht_cnt;
+	data[ei++] = mib->tx_bf_rx_fb_ht_cnt;
+
+	/* Tx amsdu info (pack-count histogram) */
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++)
+		data[ei++] = mib->tx_amsdu[i];
+
+	/* rx counters */
+	data[ei++] = mib->rx_mpdu_cnt;
+	data[ei++] = mib->rx_ampdu_cnt;
+	data[ei++] = mib->rx_ampdu_bytes_cnt;
+	data[ei++] = mib->rx_ba_cnt;
+
+	/* Add values for all stations owned by this vif */
+	wi.initial_stat_idx = ei;
+	ieee80211_iterate_stations_atomic(hw, mt792x_ethtool_worker, &wi);
+
+	mt792x_mutex_release(dev);
+
+	if (!wi.sta_count)
+		return;
+
+	ei += wi.worker_stat_count;
+
+	mt76_ethtool_page_pool_stats(&dev->mt76, &data[ei], &ei);
+	stats_size += page_pool_ethtool_stats_get_count();
+
+	if (ei != stats_size)
+		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %d", ei,
+			stats_size);
+}
+EXPORT_SYMBOL_GPL(mt792x_get_et_stats);
+
+void mt792x_sta_statistics(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta,
+			   struct station_info *sinfo)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct rate_info *txrate = &msta->wcid.rate;
+
+	if (!txrate->legacy && !txrate->flags)
+		return;
+
+	if (txrate->legacy) {
+		sinfo->txrate.legacy = txrate->legacy;
+	} else {
+		sinfo->txrate.mcs = txrate->mcs;
+		sinfo->txrate.nss = txrate->nss;
+		sinfo->txrate.bw = txrate->bw;
+		sinfo->txrate.he_gi = txrate->he_gi;
+		sinfo->txrate.he_dcm = txrate->he_dcm;
+		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
+	}
+	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
+	sinfo->txrate.flags = txrate->flags;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+	sinfo->ack_signal = (s8)msta->ack_signal;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
+
+	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
+}
+EXPORT_SYMBOL_GPL(mt792x_sta_statistics);
+
+void mt792x_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	struct mt792x_dev *dev = phy->dev;
+
+	mt792x_mutex_acquire(dev);
+
+	phy->coverage_class = max_t(s16, coverage_class, 0);
+	mt792x_mac_set_timeing(phy);
+
+	mt792x_mutex_release(dev);
+}
+EXPORT_SYMBOL_GPL(mt792x_set_coverage_class);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_mac.c b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
new file mode 100644
index 000000000000..862cca816aae
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_mac.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#include <linux/module.h>
+
+#include "mt792x.h"
+#include "mt792x_regs.h"
+
+void mt792x_mac_work(struct work_struct *work)
+{
+	struct mt792x_phy *phy;
+	struct mt76_phy *mphy;
+
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
+
+	mt792x_mutex_acquire(phy->dev);
+
+	mt76_update_survey(mphy);
+	if (++mphy->mac_work_count == 2) {
+		mphy->mac_work_count = 0;
+
+		mt792x_mac_update_mib_stats(phy);
+	}
+
+	mt792x_mutex_release(phy->dev);
+
+	mt76_tx_status_check(mphy->dev, false);
+	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
+				     MT792x_WATCHDOG_TIME);
+}
+EXPORT_SYMBOL_GPL(mt792x_mac_work);
+
+void mt792x_mac_set_timeing(struct mt792x_phy *phy)
+{
+	s16 coverage_class = phy->coverage_class;
+	struct mt792x_dev *dev = phy->dev;
+	u32 val, reg_offset;
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
+	bool is_2ghz = phy->mt76->chandef.chan->band == NL80211_BAND_2GHZ;
+	int sifs = is_2ghz ? 10 : 16, offset;
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
+	mt76_set(dev, MT_ARB_SCR(0),
+		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+	udelay(1);
+
+	offset = 3 * coverage_class;
+	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+
+	mt76_wr(dev, MT_TMAC_CDTR(0), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(0), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(0),
+		FIELD_PREP(MT_IFS_EIFS, 360) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, sifs) |
+		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
+
+	if (phy->slottime < 20 || !is_2ghz)
+		val = MT792x_CFEND_RATE_DEFAULT;
+	else
+		val = MT792x_CFEND_RATE_11B;
+
+	mt76_rmw_field(dev, MT_AGG_ACR0(0), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(0),
+		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+}
+EXPORT_SYMBOL_GPL(mt792x_mac_set_timeing);
+
+void mt792x_mac_update_mib_stats(struct mt792x_phy *phy)
+{
+	struct mt76_mib_stats *mib = &phy->mib;
+	struct mt792x_dev *dev = phy->dev;
+	int i, aggr0 = 0, aggr1;
+	u32 val;
+
+	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(0),
+					   MT_MIB_SDR3_FCS_ERR_MASK);
+	mib->ack_fail_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR3(0),
+					    MT_MIB_ACK_FAIL_COUNT_MASK);
+	mib->ba_miss_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR2(0),
+					   MT_MIB_BA_FAIL_COUNT_MASK);
+	mib->rts_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR0(0),
+				       MT_MIB_RTS_COUNT_MASK);
+	mib->rts_retries_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR1(0),
+					       MT_MIB_RTS_FAIL_COUNT_MASK);
+
+	mib->tx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR12(0));
+	mib->tx_mpdu_attempts_cnt += mt76_rr(dev, MT_MIB_SDR14(0));
+	mib->tx_mpdu_success_cnt += mt76_rr(dev, MT_MIB_SDR15(0));
+
+	val = mt76_rr(dev, MT_MIB_SDR32(0));
+	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR9_EBF_CNT_MASK, val);
+	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR9_IBF_CNT_MASK, val);
+
+	val = mt76_rr(dev, MT_ETBF_TX_APP_CNT(0));
+	mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, val);
+	mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, val);
+
+	val = mt76_rr(dev, MT_ETBF_RX_FB_CNT(0));
+	mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, val);
+	mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, val);
+	mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, val);
+	mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, val);
+
+	mib->rx_mpdu_cnt += mt76_rr(dev, MT_MIB_SDR5(0));
+	mib->rx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR22(0));
+	mib->rx_ampdu_bytes_cnt += mt76_rr(dev, MT_MIB_SDR23(0));
+	mib->rx_ba_cnt += mt76_rr(dev, MT_MIB_SDR31(0));
+
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu); i++) {
+		val = mt76_rr(dev, MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+		mib->tx_amsdu[i] += val;
+		mib->tx_amsdu_cnt += val;
+	}
+
+	for (i = 0, aggr1 = aggr0 + 8; i < 4; i++) {
+		u32 val2;
+
+		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
+		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
+
+		phy->mt76->aggr_stats[aggr0++] += val & 0xffff;
+		phy->mt76->aggr_stats[aggr0++] += val >> 16;
+		phy->mt76->aggr_stats[aggr1++] += val2 & 0xffff;
+		phy->mt76->aggr_stats[aggr1++] += val2 >> 16;
+	}
+}
+EXPORT_SYMBOL_GPL(mt792x_mac_update_mib_stats);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index aa6a677427a4..5f2407fbf95f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -157,9 +157,6 @@
 #define MT_WTBLON_TOP_BASE		0x820d4000
 #define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
 
-#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x230)
-#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
-#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
 #define MT_WTBL_UPDATE_BUSY		BIT(31)
 
 #define MT_WTBL_ITCR			MT_WTBLON_TOP(0x3b0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_trace.c b/drivers/net/wireless/mediatek/mt76/mt792x_trace.c
new file mode 100644
index 000000000000..b6f284fb929d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_trace.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2023 Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/module.h>
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "mt792x_trace.h"
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(lp_event);
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h b/drivers/net/wireless/mediatek/mt76/mt792x_trace.h
similarity index 72%
rename from drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
rename to drivers/net/wireless/mediatek/mt76/mt792x_trace.h
index 9426fda69c30..61f2aa260656 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_trace.h
@@ -1,20 +1,20 @@
 /* SPDX-License-Identifier: ISC */
 /*
- * Copyright (C) 2021 Lorenzo Bianconi <lorenzo@kernel.org>
+ * Copyright (C) 2023 Lorenzo Bianconi <lorenzo@kernel.org>
  */
 
-#if !defined(__MT7921_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
-#define __MT7921_TRACE_H
+#if !defined(__MT792X_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __MT792X_TRACE_H
 
 #include <linux/tracepoint.h>
-#include "mt7921.h"
+#include "mt792x.h"
 
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM mt7921
+#define TRACE_SYSTEM mt792x
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+#define DEV_ASSIGN	strscpy(__entry->wiphy_name,	\
 				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
@@ -46,6 +46,6 @@ TRACE_EVENT(lp_event,
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE mt7921_trace
+#define TRACE_INCLUDE_FILE mt792x_trace
 
 #include <trace/define_trace.h>
-- 
2.18.0

