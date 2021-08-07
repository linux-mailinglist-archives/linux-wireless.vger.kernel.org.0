Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A910B3E32EE
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Aug 2021 05:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhHGDOx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Aug 2021 23:14:53 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37660 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230236AbhHGDOu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Aug 2021 23:14:50 -0400
X-UUID: 3131ab2d458841498ed3d2aee9a66a35-20210807
X-UUID: 3131ab2d458841498ed3d2aee9a66a35-20210807
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1051312131; Sat, 07 Aug 2021 11:14:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 7 Aug 2021 11:14:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 7 Aug 2021 11:14:26 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/4] mt76: mt7615: checkpatch cleanup
Date:   Sat, 7 Aug 2021 11:14:22 +0800
Message-ID: <1991c856459c2014386d1a16f6657e9ba82b6d1f.1628301615.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <77372f644903053e09d671325c0cd44cf75e14ac.1628301615.git.ryder.lee@mediatek.com>
References: <77372f644903053e09d671325c0cd44cf75e14ac.1628301615.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix reasonable checkpatch warnings.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   7 +-
 .../wireless/mediatek/mt76/mt7615/eeprom.h    |   1 -
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  22 +--
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 138 +++++++++---------
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |   1 -
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |   4 +-
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  |   2 +-
 .../wireless/mediatek/mt76/mt7615/testmode.c  |   2 -
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |   2 +-
 12 files changed, 90 insertions(+), 99 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index 00aefea1bf61..29159cc253e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -216,7 +216,6 @@ void mt7615_dma_start(struct mt7615_dev *dev)
 
 		mt76_wr(dev, MT_MCU2HOST_INT_ENABLE, MT7663_MCU_CMD_ERROR_MASK);
 	}
-
 }
 
 int mt7615_dma_init(struct mt7615_dev *dev)
@@ -271,7 +270,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 		return ret;
 
 	if (!is_mt7615(&dev->mt76))
-	    rx_ring_size /= 2;
+		rx_ring_size /= 2;
 
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MAIN], 0,
 			       rx_ring_size, MT_RX_BUF_SIZE, MT_RX_RING_BASE);
@@ -296,9 +295,9 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 
 	mask = MT_INT_RX_DONE_ALL | mt7615_tx_mcu_int_mask(dev);
 	if (is_mt7663(&dev->mt76))
-	    mask |= MT7663_INT_MCU_CMD;
+		mask |= MT7663_INT_MCU_CMD;
 	else
-	    mask |= MT_INT_MCU_CMD;
+		mask |= MT_INT_MCU_CMD;
 
 	mt7615_irq_enable(dev, mask);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index a024dee10362..4ada3b4fda60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -6,7 +6,6 @@
 
 #include "mt7615.h"
 
-
 #define MT7615_EEPROM_DCOC_OFFSET		MT7615_EEPROM_SIZE
 #define MT7615_EEPROM_DCOC_SIZE			256
 #define MT7615_EEPROM_DCOC_COUNT		34
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 114c2dce61f9..337051deeff0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -196,7 +196,6 @@ void mt7615_mac_set_timing(struct mt7615_phy *phy)
 	else
 		mt76_clear(dev, MT_ARB_SCR,
 			   MT_ARB_SCR_TX0_DISABLE | MT_ARB_SCR_RX0_DISABLE);
-
 }
 
 static void
@@ -611,7 +610,6 @@ static void
 mt7615_mac_write_txwi_8023(struct mt7615_dev *dev, __le32 *txwi,
 			   struct sk_buff *skb, struct mt76_wcid *wcid)
 {
-
 	bool is_mmio = mt76_is_mmio(&dev->mt76);
 	u8 fc_type, fc_stype;
 	bool wmm = false;
@@ -1163,7 +1161,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	mt76_wr(dev, addr + 27 * 4, w27);
 
 	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
-	addr = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+	addr = idx > 1 ? MT_LPON_TCR2(idx) : MT_LPON_TCR0(idx);
 
 	mt76_rmw(dev, addr, MT_LPON_TCR_MODE, MT_LPON_TCR_READ); /* TSF read */
 	sta->rate_set_tsf = mt76_rr(dev, MT_LPON_UTTR0) & ~BIT(0);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8a001a44944b..2f7c20630992 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -271,7 +271,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 
 	mt76_testmode_reset(phy->mt76, true);
 	if (vif == phy->monitor_vif)
-	    phy->monitor_vif = NULL;
+		phy->monitor_vif = NULL;
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 
@@ -840,16 +840,16 @@ static int
 mt7615_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       struct ieee80211_sta *sta)
 {
-    return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
-			  IEEE80211_STA_NONE);
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
+			      IEEE80211_STA_NONE);
 }
 
 static int
 mt7615_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  struct ieee80211_sta *sta)
 {
-    return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
-			  IEEE80211_STA_NOTEXIST);
+	return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
+			      IEEE80211_STA_NOTEXIST);
 }
 
 static int
@@ -886,7 +886,7 @@ mt7615_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	u32 reg;
 
 	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
-	reg = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+	reg = idx > 1 ? MT_LPON_TCR2(idx) : MT_LPON_TCR0(idx);
 
 	mt7615_mutex_acquire(dev);
 
@@ -914,7 +914,7 @@ mt7615_set_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u32 reg;
 
 	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
-	reg = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+	reg = idx > 1 ? MT_LPON_TCR2(idx) : MT_LPON_TCR0(idx);
 
 	mt7615_mutex_acquire(dev);
 
@@ -940,7 +940,7 @@ mt7615_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u32 reg;
 
 	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
-	reg = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+	reg = idx > 1 ? MT_LPON_TCR2(idx) : MT_LPON_TCR0(idx);
 
 	mt7615_mutex_acquire(dev);
 
@@ -1205,9 +1205,9 @@ static void mt7615_sta_set_4addr(struct ieee80211_hw *hw,
 }
 
 static void mt7615_sta_set_decap_offload(struct ieee80211_hw *hw,
-				 struct ieee80211_vif *vif,
-				 struct ieee80211_sta *sta,
-				 bool enabled)
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 bool enabled)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 5d373f590271..7fe511cf1695 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1894,7 +1894,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	};
 	int ret;
 
-	dev->mt76.mcu_ops = &mt7615_mcu_ops,
+	dev->mt76.mcu_ops = &mt7615_mcu_ops;
 
 	ret = mt7615_mcu_drv_pmctrl(dev);
 	if (ret)
@@ -2504,7 +2504,6 @@ static int mt7615_dcoc_freq_idx(u16 freq, u8 bw)
 			break;
 
 		return -1;
-
 	}
 
 	return mt7615_find_freq_idx(freq_list, ARRAY_SIZE(freq_list), freq);
@@ -2624,7 +2623,6 @@ static int mt7615_dpd_freq_idx(u16 freq, u8 bw)
 	return mt7615_find_freq_idx(freq_list, ARRAY_SIZE(freq_list), freq);
 }
 
-
 int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index 98c383e400a1..fae9a04881ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -106,59 +106,59 @@ enum {
 };
 
 enum {
-    MT_SKU_CCK_1_2 = 0,
-    MT_SKU_CCK_55_11,
-    MT_SKU_OFDM_6_9,
-    MT_SKU_OFDM_12_18,
-    MT_SKU_OFDM_24_36,
-    MT_SKU_OFDM_48,
-    MT_SKU_OFDM_54,
-    MT_SKU_HT20_0_8,
-    MT_SKU_HT20_32,
-    MT_SKU_HT20_1_2_9_10,
-    MT_SKU_HT20_3_4_11_12,
-    MT_SKU_HT20_5_13,
-    MT_SKU_HT20_6_14,
-    MT_SKU_HT20_7_15,
-    MT_SKU_HT40_0_8,
-    MT_SKU_HT40_32,
-    MT_SKU_HT40_1_2_9_10,
-    MT_SKU_HT40_3_4_11_12,
-    MT_SKU_HT40_5_13,
-    MT_SKU_HT40_6_14,
-    MT_SKU_HT40_7_15,
-    MT_SKU_VHT20_0,
-    MT_SKU_VHT20_1_2,
-    MT_SKU_VHT20_3_4,
-    MT_SKU_VHT20_5_6,
-    MT_SKU_VHT20_7,
-    MT_SKU_VHT20_8,
-    MT_SKU_VHT20_9,
-    MT_SKU_VHT40_0,
-    MT_SKU_VHT40_1_2,
-    MT_SKU_VHT40_3_4,
-    MT_SKU_VHT40_5_6,
-    MT_SKU_VHT40_7,
-    MT_SKU_VHT40_8,
-    MT_SKU_VHT40_9,
-    MT_SKU_VHT80_0,
-    MT_SKU_VHT80_1_2,
-    MT_SKU_VHT80_3_4,
-    MT_SKU_VHT80_5_6,
-    MT_SKU_VHT80_7,
-    MT_SKU_VHT80_8,
-    MT_SKU_VHT80_9,
-    MT_SKU_VHT160_0,
-    MT_SKU_VHT160_1_2,
-    MT_SKU_VHT160_3_4,
-    MT_SKU_VHT160_5_6,
-    MT_SKU_VHT160_7,
-    MT_SKU_VHT160_8,
-    MT_SKU_VHT160_9,
-    MT_SKU_1SS_DELTA,
-    MT_SKU_2SS_DELTA,
-    MT_SKU_3SS_DELTA,
-    MT_SKU_4SS_DELTA,
+	MT_SKU_CCK_1_2,
+	MT_SKU_CCK_55_11,
+	MT_SKU_OFDM_6_9,
+	MT_SKU_OFDM_12_18,
+	MT_SKU_OFDM_24_36,
+	MT_SKU_OFDM_48,
+	MT_SKU_OFDM_54,
+	MT_SKU_HT20_0_8,
+	MT_SKU_HT20_32,
+	MT_SKU_HT20_1_2_9_10,
+	MT_SKU_HT20_3_4_11_12,
+	MT_SKU_HT20_5_13,
+	MT_SKU_HT20_6_14,
+	MT_SKU_HT20_7_15,
+	MT_SKU_HT40_0_8,
+	MT_SKU_HT40_32,
+	MT_SKU_HT40_1_2_9_10,
+	MT_SKU_HT40_3_4_11_12,
+	MT_SKU_HT40_5_13,
+	MT_SKU_HT40_6_14,
+	MT_SKU_HT40_7_15,
+	MT_SKU_VHT20_0,
+	MT_SKU_VHT20_1_2,
+	MT_SKU_VHT20_3_4,
+	MT_SKU_VHT20_5_6,
+	MT_SKU_VHT20_7,
+	MT_SKU_VHT20_8,
+	MT_SKU_VHT20_9,
+	MT_SKU_VHT40_0,
+	MT_SKU_VHT40_1_2,
+	MT_SKU_VHT40_3_4,
+	MT_SKU_VHT40_5_6,
+	MT_SKU_VHT40_7,
+	MT_SKU_VHT40_8,
+	MT_SKU_VHT40_9,
+	MT_SKU_VHT80_0,
+	MT_SKU_VHT80_1_2,
+	MT_SKU_VHT80_3_4,
+	MT_SKU_VHT80_5_6,
+	MT_SKU_VHT80_7,
+	MT_SKU_VHT80_8,
+	MT_SKU_VHT80_9,
+	MT_SKU_VHT160_0,
+	MT_SKU_VHT160_1_2,
+	MT_SKU_VHT160_3_4,
+	MT_SKU_VHT160_5_6,
+	MT_SKU_VHT160_7,
+	MT_SKU_VHT160_8,
+	MT_SKU_VHT160_9,
+	MT_SKU_1SS_DELTA,
+	MT_SKU_2SS_DELTA,
+	MT_SKU_3SS_DELTA,
+	MT_SKU_4SS_DELTA,
 };
 
 struct mt7615_mcu_rxd {
@@ -281,23 +281,23 @@ struct mt7615_roc_tlv {
 } __packed;
 
 enum {
-	PATCH_NOT_DL_SEM_FAIL	 = 0x0,
-	PATCH_IS_DL		 = 0x1,
-	PATCH_NOT_DL_SEM_SUCCESS = 0x2,
-	PATCH_REL_SEM_SUCCESS	 = 0x3
+	PATCH_NOT_DL_SEM_FAIL,
+	PATCH_IS_DL,
+	PATCH_NOT_DL_SEM_SUCCESS,
+	PATCH_REL_SEM_SUCCESS
 };
 
 enum {
-	FW_STATE_INITIAL          = 0,
-	FW_STATE_FW_DOWNLOAD      = 1,
-	FW_STATE_NORMAL_OPERATION = 2,
-	FW_STATE_NORMAL_TRX       = 3,
+	FW_STATE_INITIAL,
+	FW_STATE_FW_DOWNLOAD,
+	FW_STATE_NORMAL_OPERATION,
+	FW_STATE_NORMAL_TRX,
 	FW_STATE_CR4_RDY          = 7
 };
 
 enum {
 	FW_STATE_PWR_ON = 1,
-	FW_STATE_N9_RDY = 2,
+	FW_STATE_N9_RDY,
 };
 
 enum {
@@ -371,14 +371,14 @@ enum {
 };
 
 enum {
-	CH_SWITCH_NORMAL = 0,
+	CH_SWITCH_NORMAL,
 	CH_SWITCH_SCAN = 3,
-	CH_SWITCH_MCC = 4,
-	CH_SWITCH_DFS = 5,
-	CH_SWITCH_BACKGROUND_SCAN_START = 6,
-	CH_SWITCH_BACKGROUND_SCAN_RUNNING = 7,
-	CH_SWITCH_BACKGROUND_SCAN_STOP = 8,
-	CH_SWITCH_SCAN_BYPASS_DPD = 9
+	CH_SWITCH_MCC,
+	CH_SWITCH_DFS,
+	CH_SWITCH_BACKGROUND_SCAN_START,
+	CH_SWITCH_BACKGROUND_SCAN_RUNNING,
+	CH_SWITCH_BACKGROUND_SCAN_STOP,
+	CH_SWITCH_SCAN_BYPASS_DPD
 };
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index f9d745f7d43b..c97764016a99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -359,5 +359,4 @@ void mt7615_mac_reset_work(struct work_struct *work)
 	if (phy2)
 		ieee80211_queue_delayed_work(ext_phy->hw,
 					     &phy2->mt76->mac_work, timeout);
-
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 6712ad9faeaa..36cd19c05915 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -603,7 +603,7 @@ enum mt7615_reg_base {
 #define MT_MCU_PTA(_n)			(MT_MCU_PTA_BASE + (_n))
 
 #define MT_ANT_SWITCH_CON(_n)		MT_MCU_PTA(0x0c8 + ((_n) - 1) * 4)
-#define MT_ANT_SWITCH_CON_MODE(_n)	(GENMASK(4, 0) << (_n * 8))
-#define MT_ANT_SWITCH_CON_MODE1(_n)	(GENMASK(3, 0) << (_n * 8))
+#define MT_ANT_SWITCH_CON_MODE(_n)	(GENMASK(4, 0) << ((_n) * 8))
+#define MT_ANT_SWITCH_CON_MODE1(_n)	(GENMASK(3, 0) << ((_n) * 8))
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 45c1cd3b9f49..77e6a57b2dc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -147,7 +147,7 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	dev->mt76.mcu_ops = &mt7663s_mcu_ops,
+	dev->mt76.mcu_ops = &mt7663s_mcu_ops;
 
 	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
 	if (ret) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index 59d99264f5e5..05dbe09df429 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -14,7 +14,6 @@ enum {
 	NUM_TM_CHANGED
 };
 
-
 static const u8 tm_change_map[] = {
 	[TM_CHANGED_TXPOWER_CTRL] = MT76_TM_ATTR_TX_POWER_CONTROL,
 	[TM_CHANGED_TXPOWER] = MT76_TM_ATTR_TX_POWER,
@@ -186,7 +185,6 @@ mt7615_tm_set_tx_antenna(struct mt7615_phy *phy, bool en)
 		mt76_rmw_field(dev, MT_WF_PHY_RFINTF3_0(i),
 			       MT_WF_PHY_RFINTF3_0_ANT,
 			       (td->tx_antenna_mask & BIT(i)) ? 0 : 0xa);
-
 	}
 
 	/* 2.4 GHz band */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 028ff432d811..f7d7e9334637 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -53,7 +53,7 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
 	};
 	int ret;
 
-	dev->mt76.mcu_ops = &mt7663u_mcu_ops,
+	dev->mt76.mcu_ops = &mt7663u_mcu_ops;
 
 	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
 	if (test_and_clear_bit(MT76_STATE_POWER_OFF, &dev->mphy.state)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index fcbaee21bd4c..6b4d72bcbb54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -121,7 +121,7 @@ static int mt7663_usb_sdio_set_rates(struct mt7615_dev *dev,
 
 	idx = sta->vif->mt76.omac_idx;
 	idx = idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
-	addr = idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
+	addr = idx > 1 ? MT_LPON_TCR2(idx) : MT_LPON_TCR0(idx);
 
 	mt76_rmw(dev, addr, MT_LPON_TCR_MODE, MT_LPON_TCR_READ); /* TSF read */
 	val = mt76_rr(dev, MT_LPON_UTTR0);
-- 
2.29.2

