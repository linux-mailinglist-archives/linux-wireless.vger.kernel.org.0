Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454116F8EB
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 07:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfGVFbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 01:31:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57949 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727237AbfGVFbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 01:31:55 -0400
X-UUID: ef9c4800ea0040609c309f274ea46eb1-20190722
X-UUID: ef9c4800ea0040609c309f274ea46eb1-20190722
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 722400565; Mon, 22 Jul 2019 13:31:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 22 Jul 2019 13:31:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 22 Jul 2019 13:31:19 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/5] mt76: mt76x02: fix some checkpatch warnings
Date:   Mon, 22 Jul 2019 13:31:14 +0800
Message-ID: <43e7130b3da3cd4aed1c46df8b5564822c8bea68.1563772403.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1563772403.git.ryder.lee@mediatek.com>
References: <cover.1563772403.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 364E517CC44E7BFE10874A6C17D61FDC403084EEBF70E28CCCC54AF1E64D6A3A2000:8
X-MTK:  N
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This fixes the following checkpatch.pl warning:
ERROR: code indent should use tabs where possible
CHECK: Alignment should match open parenthesis
CHECK: No space is necessary after a cast
CHECK: Please don't use multiple blank lines
CHECK: Avoid precedence issues in macro
WARNING: Statements should start on a tabstop
WARNING: Unnecessary space before function pointer arguments

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76x0/mt76x0.h    |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   | 23 ++++++++-------
 .../net/wireless/mediatek/mt76/mt76x0/phy.h   | 10 +++----
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |  6 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02.h  | 25 +++++++++--------
 .../wireless/mediatek/mt76/mt76x02_beacon.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 16 +++++------
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  | 13 +++++----
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c | 11 ++++----
 .../net/wireless/mediatek/mt76/mt76x02_phy.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt76x02_regs.h | 28 +++++++++----------
 .../wireless/mediatek/mt76/mt76x02_trace.h    |  3 +-
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 20 ++++++-------
 .../wireless/mediatek/mt76/mt76x2/eeprom.c    | 10 ++++---
 .../net/wireless/mediatek/mt76/mt76x2/mcu.h   |  3 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  1 -
 .../wireless/mediatek/mt76/mt76x2/pci_mcu.c   |  4 +--
 .../net/wireless/mediatek/mt76/mt76x2/phy.c   |  3 +-
 19 files changed, 99 insertions(+), 88 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
index 97e47cd2d744..caa87f0c3cb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h
@@ -55,7 +55,7 @@ int mt76x0_config(struct ieee80211_hw *hw, u32 changed);
 void mt76x0_phy_init(struct mt76x02_dev *dev);
 int mt76x0_phy_wait_bbp_ready(struct mt76x02_dev *dev);
 int mt76x0_phy_set_channel(struct mt76x02_dev *dev,
-			    struct cfg80211_chan_def *chandef);
+			   struct cfg80211_chan_def *chandef);
 void mt76x0_phy_set_txpower(struct mt76x02_dev *dev);
 void mt76x0_phy_calibrate(struct mt76x02_dev *dev, bool power_on);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 1ecfc334ae79..bfcef33cd4c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -109,7 +109,7 @@ mt76x0_rf_wr(struct mt76x02_dev *dev, u32 offset, u8 val)
 		};
 
 		WARN_ON_ONCE(!test_bit(MT76_STATE_MCU_RUNNING,
-			     &dev->mt76.state));
+				       &dev->mt76.state));
 		return mt76_wr_rp(dev, MT_MCU_MEMMAP_RF, &pair, 1);
 	} else {
 		return mt76x0_rf_csr_wr(dev, offset, val);
@@ -127,7 +127,7 @@ static int mt76x0_rf_rr(struct mt76x02_dev *dev, u32 offset)
 		};
 
 		WARN_ON_ONCE(!test_bit(MT76_STATE_MCU_RUNNING,
-			     &dev->mt76.state));
+				       &dev->mt76.state));
 		ret = mt76_rd_rp(dev, MT_MCU_MEMMAP_RF, &pair, 1);
 		val = pair.value;
 	} else {
@@ -230,7 +230,8 @@ mt76x0_phy_set_band(struct mt76x02_dev *dev, enum nl80211_band band)
 }
 
 static void
-mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel, u16 rf_bw_band)
+mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel,
+			      u16 rf_bw_band)
 {
 	const struct mt76x0_freq_item *freq_item;
 	u16 rf_band = rf_bw_band & 0xff00;
@@ -252,9 +253,9 @@ mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel, u16 rf_bw_ban
 			rf_band = mt76x0_frequency_plan[i].band;
 
 			if (b_sdm)
-				freq_item = &(mt76x0_sdm_frequency_plan[i]);
+				freq_item = &mt76x0_sdm_frequency_plan[i];
 			else
-				freq_item = &(mt76x0_frequency_plan[i]);
+				freq_item = &mt76x0_frequency_plan[i];
 
 			mt76x0_rf_wr(dev, MT_RF(0, 37), freq_item->pllR37);
 			mt76x0_rf_wr(dev, MT_RF(0, 36), freq_item->pllR36);
@@ -360,10 +361,12 @@ mt76x0_phy_set_chan_rf_params(struct mt76x02_dev *dev, u8 channel, u16 rf_bw_ban
 	band = (rf_band & RF_G_BAND) ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
 	if (mt76x02_ext_pa_enabled(dev, band)) {
 		/*
-			MT_RF_MISC (offset: 0x0518)
-			[2]1'b1: enable external A band PA, 1'b0: disable external A band PA
-			[3]1'b1: enable external G band PA, 1'b0: disable external G band PA
-		*/
+		 * MT_RF_MISC (offset: 0x0518)
+		 * [2]1'b1: enable external A band PA,
+		 *    1'b0: disable external A band PA
+		 * [3]1'b1: enable external G band PA,
+		 *    1'b0: disable external G band PA
+		 */
 		if (rf_band & RF_A_BAND)
 			mt76_set(dev, MT_RF_MISC, BIT(2));
 		else
@@ -490,7 +493,7 @@ mt76x0_phy_bbp_set_bw(struct mt76x02_dev *dev, enum nl80211_chan_width width)
 	case NL80211_CHAN_WIDTH_160:
 	case NL80211_CHAN_WIDTH_5:
 		/* TODO error */
-		return ;
+		return;
 	}
 
 	mt76x02_mcu_function_select(dev, BW_SETTING, bw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h
index b4b2ca747699..441d6559d4fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.h
@@ -6,8 +6,8 @@
 #ifndef _MT76X0_PHY_H_
 #define _MT76X0_PHY_H_
 
-#define RF_G_BAND 	0x0100
-#define RF_A_BAND 	0x0200
+#define RF_G_BAND	0x0100
+#define RF_A_BAND	0x0200
 #define RF_A_BAND_LB	0x0400
 #define RF_A_BAND_MB	0x0800
 #define RF_A_BAND_HB	0x1000
@@ -18,9 +18,9 @@
 #define RF_BW_10        4
 #define RF_BW_80        8
 
-#define MT_RF(bank, reg) ((bank) << 16 | (reg))
-#define MT_RF_BANK(offset) (offset >> 16)
-#define MT_RF_REG(offset) (offset & 0xff)
+#define MT_RF(bank, reg)		((bank) << 16 | (reg))
+#define MT_RF_BANK(offset)		((offset) >> 16)
+#define MT_RF_REG(offset)		((offset) & 0xff)
 
 #define MT_RF_VCO_BP_CLOSE_LOOP		BIT(3)
 #define MT_RF_VCO_BP_CLOSE_LOOP_MASK	GENMASK(3, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index b007bcd2e999..f010df4fad37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -237,7 +237,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 	if (ret)
 		goto err;
 
-	/* Disable the HW, otherwise MCU fail to initalize on hot reboot */
+	/* Disable the HW, otherwise MCU fail to initialize on hot reboot */
 	mt76x0_chip_onoff(dev, false, false);
 
 	if (!mt76x02_wait_for_mac(mdev)) {
@@ -275,9 +275,9 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 static void mt76x0_disconnect(struct usb_interface *usb_intf)
 {
 	struct mt76x02_dev *dev = usb_get_intfdata(usb_intf);
-	bool initalized = test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	bool initialized = test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
 
-	if (!initalized)
+	if (!initialized)
 		return;
 
 	ieee80211_unregister_hw(dev->mt76.hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index f7fd53a1738a..7fa0c9eab164 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -71,8 +71,8 @@ struct mt76x02_calibration {
 struct mt76x02_beacon_ops {
 	unsigned int nslots;
 	unsigned int slot_size;
-	void (*pre_tbtt_enable) (struct mt76x02_dev *, bool);
-	void (*beacon_enable) (struct mt76x02_dev *, bool);
+	void (*pre_tbtt_enable)(struct mt76x02_dev *dev, bool en);
+	void (*beacon_enable)(struct mt76x02_dev *dev, bool en);
 };
 
 struct mt76x02_dev {
@@ -137,8 +137,8 @@ extern struct ieee80211_rate mt76x02_rates[12];
 
 void mt76x02_init_device(struct mt76x02_dev *dev);
 void mt76x02_configure_filter(struct ieee80211_hw *hw,
-			     unsigned int changed_flags,
-			     unsigned int *total_flags, u64 multicast);
+			      unsigned int changed_flags,
+			      unsigned int *total_flags, u64 multicast);
 int mt76x02_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		    struct ieee80211_sta *sta);
 void mt76x02_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
@@ -147,20 +147,20 @@ void mt76x02_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt76x02_config_mac_addr_list(struct mt76x02_dev *dev);
 
 int mt76x02_add_interface(struct ieee80211_hw *hw,
-			 struct ieee80211_vif *vif);
+			  struct ieee80211_vif *vif);
 void mt76x02_remove_interface(struct ieee80211_hw *hw,
-			     struct ieee80211_vif *vif);
+			      struct ieee80211_vif *vif);
 
 int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			struct ieee80211_ampdu_params *params);
+			 struct ieee80211_ampdu_params *params);
 int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-		   struct ieee80211_key_conf *key);
+		    struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		    struct ieee80211_key_conf *key);
 int mt76x02_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		   u16 queue, const struct ieee80211_tx_queue_params *params);
+		    u16 queue, const struct ieee80211_tx_queue_params *params);
 void mt76x02_sta_rate_tbl_update(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta);
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta);
 s8 mt76x02_tx_get_max_txpwr_adj(struct mt76x02_dev *dev,
 				const struct ieee80211_tx_rate *rate);
 s8 mt76x02_tx_get_txpwr_adj(struct mt76x02_dev *dev, s8 txpwr,
@@ -197,6 +197,7 @@ struct beacon_bc_data {
 	struct sk_buff_head q;
 	struct sk_buff *tail[8];
 };
+
 void mt76x02_init_beacon_config(struct mt76x02_dev *dev);
 void mt76x02e_init_beacon_config(struct mt76x02_dev *dev);
 void mt76x02_resync_beacon_timer(struct mt76x02_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index d61c686e08de..f8847fbd0ade 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -237,7 +237,8 @@ mt76x02_add_buffered_bc(void *priv, u8 *mac, struct ieee80211_vif *vif)
 }
 
 void
-mt76x02_enqueue_buffered_bc(struct mt76x02_dev *dev, struct beacon_bc_data *data,
+mt76x02_enqueue_buffered_bc(struct mt76x02_dev *dev,
+			    struct beacon_bc_data *data,
 			    int max_nframes)
 {
 	int i, nframes;
@@ -281,4 +282,3 @@ void mt76x02_init_beacon_config(struct mt76x02_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76x02_init_beacon_config);
 
-
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 82bafb5ac326..a3917d0a5120 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -92,7 +92,6 @@ void mt76x02_mac_wcid_sync_pn(struct mt76x02_dev *dev, u8 idx,
 	atomic64_set(&key->tx_pn, pn);
 }
 
-
 int mt76x02_mac_wcid_set_key(struct mt76x02_dev *dev, u8 idx,
 			     struct ieee80211_key_conf *key)
 {
@@ -267,7 +266,7 @@ bool mt76x02_mac_load_tx_status(struct mt76x02_dev *dev,
 
 static int
 mt76x02_mac_process_tx_rate(struct ieee80211_tx_rate *txrate, u16 rate,
-			   enum nl80211_band band)
+			    enum nl80211_band band)
 {
 	u8 idx = FIELD_GET(MT_RXWI_RATE_INDEX, rate);
 
@@ -343,7 +342,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 	    ieee80211_has_protected(hdr->frame_control)) {
 		wcid = NULL;
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
-		                       info->control.rates, 1);
+				       info->control.rates, 1);
 	}
 
 	if (wcid)
@@ -353,6 +352,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 
 	if (wcid && wcid->sw_iv && key) {
 		u64 pn = atomic64_inc_return(&key->tx_pn);
+
 		ccmp_pn[0] = pn;
 		ccmp_pn[1] = pn >> 8;
 		ccmp_pn[2] = 0;
@@ -445,8 +445,8 @@ mt76x02_tx_rate_fallback(struct ieee80211_tx_rate *rates, int idx, int phy)
 	case MT_PHY_TYPE_HT:
 		/* MCS 8 falls back to MCS 0 */
 		if (rates[0].idx == 8) {
-		    rates[1].idx = 0;
-		    break;
+			rates[1].idx = 0;
+			break;
 		}
 		/* fall through */
 	default:
@@ -568,9 +568,9 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 		u32 stat_val, stat_cache;
 
 		stat_val = stat->rate;
-		stat_val |= ((u32) stat->retry) << 16;
+		stat_val |= ((u32)stat->retry) << 16;
 		stat_cache = msta->status.rate;
-		stat_cache |= ((u32) msta->status.retry) << 16;
+		stat_cache |= ((u32)msta->status.retry) << 16;
 
 		if (*update == 0 && stat_val == stat_cache &&
 		    stat->wcid == msta->status.wcid && msta->n_frames < 32) {
@@ -718,7 +718,7 @@ mt76x02_mac_get_rssi(struct mt76x02_dev *dev, s8 rssi, int chain)
 int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 			   void *rxi)
 {
-	struct mt76_rx_status *status = (struct mt76_rx_status *) skb->cb;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76x02_rxwi *rxwi = rxi;
 	struct mt76x02_sta *sta;
 	u32 rxinfo = le32_to_cpu(rxwi->rxinfo);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 6501b853b65c..c1fd28dc9244 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -65,7 +65,7 @@ int mt76x02_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 			break;
 		}
 
-		rxfce = (u32 *) skb->cb;
+		rxfce = (u32 *)skb->cb;
 
 		if (seq == FIELD_GET(MT_RX_FCE_INFO_CMD_SEQ, *rxfce))
 			check_seq = true;
@@ -86,11 +86,11 @@ int mt76x02_mcu_function_select(struct mt76x02_dev *dev, enum mcu_function func,
 				u32 val)
 {
 	struct {
-	    __le32 id;
-	    __le32 value;
+		__le32 id;
+		__le32 value;
 	} __packed __aligned(4) msg = {
-	    .id = cpu_to_le32(func),
-	    .value = cpu_to_le32(val),
+		.id = cpu_to_le32(func),
+		.value = cpu_to_le32(val),
 	};
 	bool wait = false;
 
@@ -111,7 +111,8 @@ int mt76x02_mcu_set_radio_state(struct mt76x02_dev *dev, bool on)
 		.level = cpu_to_le32(0),
 	};
 
-	return mt76_mcu_send_msg(dev, CMD_POWER_SAVING_OP, &msg, sizeof(msg), false);
+	return mt76_mcu_send_msg(dev, CMD_POWER_SAVING_OP, &msg, sizeof(msg),
+				 false);
 }
 EXPORT_SYMBOL_GPL(mt76x02_mcu_set_radio_state);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 467b28379870..8bf93684febf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -97,7 +97,8 @@ void mt76x02e_init_beacon_config(struct mt76x02_dev *dev)
 	dev->beacon_ops = &beacon_ops;
 
 	/* Fire a pre-TBTT interrupt 8 ms before TBTT */
-	mt76_rmw_field(dev, MT_INT_TIMER_CFG, MT_INT_TIMER_CFG_PRE_TBTT, 8 << 4);
+	mt76_rmw_field(dev, MT_INT_TIMER_CFG, MT_INT_TIMER_CFG_PRE_TBTT,
+		       8 << 4);
 	mt76_rmw_field(dev, MT_INT_TIMER_CFG, MT_INT_TIMER_CFG_GP_TIMER,
 		       MT_DFS_GP_INTERVAL);
 	mt76_wr(dev, MT_INT_TIMER_EN, 0);
@@ -201,7 +202,7 @@ int mt76x02_dma_init(struct mt76x02_dev *dev)
 		return -ENOMEM;
 
 	tasklet_init(&dev->mt76.tx_tasklet, mt76x02_tx_tasklet,
-		     (unsigned long) dev);
+		     (unsigned long)dev);
 	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt76x02_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
@@ -395,12 +396,12 @@ static void mt76x02_key_sync(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid;
 
 	if (!sta)
-	    return;
+		return;
 
-	wcid = (struct mt76_wcid *) sta->drv_priv;
+	wcid = (struct mt76_wcid *)sta->drv_priv;
 
 	if (wcid->hw_key_idx != key->keyidx || wcid->sw_iv)
-	    return;
+		return;
 
 	mt76x02_mac_wcid_sync_pn(dev, wcid->idx, key);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
index a54b63a96eae..b86a33b2a16d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_phy.c
@@ -183,7 +183,8 @@ bool mt76x02_phy_adjust_vga_gain(struct mt76x02_dev *dev)
 	bool ret = false;
 	u32 false_cca;
 
-	false_cca = FIELD_GET(MT_RX_STAT_1_CCA_ERRORS, mt76_rr(dev, MT_RX_STAT_1));
+	false_cca = FIELD_GET(MT_RX_STAT_1_CCA_ERRORS,
+			      mt76_rr(dev, MT_RX_STAT_1));
 	dev->cal.false_cca = false_cca;
 	if (false_cca > 800 && dev->cal.agc_gain_adjust < limit) {
 		dev->cal.agc_gain_adjust += 2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
index ea7833964ec0..b2868ae79290 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_regs.h
@@ -19,8 +19,8 @@
 
 #define MT_ASIC_VERSION			0x0000
 
-#define MT76XX_REV_E3		0x22
-#define MT76XX_REV_E4		0x33
+#define MT76XX_REV_E3			0x22
+#define MT76XX_REV_E4			0x33
 
 #define MT_CMB_CTRL			0x0020
 #define MT_CMB_CTRL_XTAL_RDY		BIT(22)
@@ -120,7 +120,7 @@
 #define MT_INT_RX_DONE(_n)		BIT(_n)
 #define MT_INT_RX_DONE_ALL		GENMASK(1, 0)
 #define MT_INT_TX_DONE_ALL		GENMASK(13, 4)
-#define MT_INT_TX_DONE(_n)		BIT(_n + 4)
+#define MT_INT_TX_DONE(_n)		BIT((_n) + 4)
 #define MT_INT_RX_COHERENT		BIT(16)
 #define MT_INT_TX_COHERENT		BIT(17)
 #define MT_INT_ANY_COHERENT		BIT(18)
@@ -149,21 +149,21 @@
 
 #define MT_WPDMA_DELAY_INT_CFG		0x0210
 
-#define MT_WMM_AIFSN		0x0214
+#define MT_WMM_AIFSN			0x0214
 #define MT_WMM_AIFSN_MASK		GENMASK(3, 0)
 #define MT_WMM_AIFSN_SHIFT(_n)		((_n) * 4)
 
-#define MT_WMM_CWMIN		0x0218
+#define MT_WMM_CWMIN			0x0218
 #define MT_WMM_CWMIN_MASK		GENMASK(3, 0)
 #define MT_WMM_CWMIN_SHIFT(_n)		((_n) * 4)
 
-#define MT_WMM_CWMAX		0x021c
+#define MT_WMM_CWMAX			0x021c
 #define MT_WMM_CWMAX_MASK		GENMASK(3, 0)
 #define MT_WMM_CWMAX_SHIFT(_n)		((_n) * 4)
 
 #define MT_WMM_TXOP_BASE		0x0220
 #define MT_WMM_TXOP(_n)			(MT_WMM_TXOP_BASE + (((_n) / 2) << 2))
-#define MT_WMM_TXOP_SHIFT(_n)		((_n & 1) * 16)
+#define MT_WMM_TXOP_SHIFT(_n)		(((_n) & 1) * 16)
 #define MT_WMM_TXOP_MASK		GENMASK(15, 0)
 
 #define MT_WMM_CTRL			0x0230 /* MT76x0 */
@@ -607,7 +607,7 @@
 
 #define MT_TX_AGG_CNT(_id)		((_id) < 8 ?			\
 					 MT_TX_AGG_CNT_BASE0 + ((_id) << 2) : \
-					 MT_TX_AGG_CNT_BASE1 + ((_id - 8) << 2))
+					 MT_TX_AGG_CNT_BASE1 + (((_id) - 8) << 2))
 
 #define MT_TX_STAT_FIFO_EXT		0x1798
 #define MT_TX_STAT_FIFO_EXT_RETRY	GENMASK(7, 0)
@@ -680,17 +680,17 @@
 
 #define MT_SKEY_BASE_0			0xac00
 #define MT_SKEY_BASE_1			0xb400
-#define MT_SKEY_0(_bss, _idx)		(MT_SKEY_BASE_0 + (4 * (_bss) + _idx) * 32)
-#define MT_SKEY_1(_bss, _idx)		(MT_SKEY_BASE_1 + (4 * ((_bss) & 7) + _idx) * 32)
-#define MT_SKEY(_bss, _idx)		((_bss & 8) ? MT_SKEY_1(_bss, _idx) : MT_SKEY_0(_bss, _idx))
+#define MT_SKEY_0(_bss, _idx)		(MT_SKEY_BASE_0 + (4 * (_bss) + (_idx)) * 32)
+#define MT_SKEY_1(_bss, _idx)		(MT_SKEY_BASE_1 + (4 * ((_bss) & 7) + (_idx)) * 32)
+#define MT_SKEY(_bss, _idx)		(((_bss) & 8) ? MT_SKEY_1(_bss, _idx) : MT_SKEY_0(_bss, _idx))
 
 #define MT_SKEY_MODE_BASE_0		0xb000
 #define MT_SKEY_MODE_BASE_1		0xb3f0
-#define MT_SKEY_MODE_0(_bss)		(MT_SKEY_MODE_BASE_0 + ((_bss / 2) << 2))
+#define MT_SKEY_MODE_0(_bss)		(MT_SKEY_MODE_BASE_0 + (((_bss) / 2) << 2))
 #define MT_SKEY_MODE_1(_bss)		(MT_SKEY_MODE_BASE_1 + ((((_bss) & 7) / 2) << 2))
-#define MT_SKEY_MODE(_bss)		((_bss & 8) ? MT_SKEY_MODE_1(_bss) : MT_SKEY_MODE_0(_bss))
+#define MT_SKEY_MODE(_bss)		(((_bss) & 8) ? MT_SKEY_MODE_1(_bss) : MT_SKEY_MODE_0(_bss))
 #define MT_SKEY_MODE_MASK		GENMASK(3, 0)
-#define MT_SKEY_MODE_SHIFT(_bss, _idx)	(4 * ((_idx) + 4 * (_bss & 1)))
+#define MT_SKEY_MODE_SHIFT(_bss, _idx)	(4 * ((_idx) + 4 * ((_bss) & 1)))
 
 #define MT_BEACON_BASE			0xc000
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
index 713f12d3c8de..ae884f539f3f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
@@ -25,7 +25,8 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name, wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
+#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 5e4f3a8c5784..e4332d5a5757 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -53,7 +53,7 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
 	pad = round_up(skb->len, 4) + 4 - skb->len;
 
 	/* First packet of a A-MSDU burst keeps track of the whole burst
-	 * length, need to update lenght of it and the last packet.
+	 * length, need to update length of it and the last packet.
 	 */
 	skb_walk_frags(skb, iter) {
 		last = iter;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index fa45ed280ab1..e84006cd6f9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -21,14 +21,14 @@
 #define CCK_RATE(_idx, _rate) {					\
 	.bitrate = _rate,					\
 	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | _idx,		\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (8 + _idx),	\
+	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (8 + (_idx)),	\
 }
 
 #define OFDM_RATE(_idx, _rate) {				\
 	.bitrate = _rate,					\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | _idx,		\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | _idx,	\
+	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
 }
 
 struct ieee80211_rate mt76x02_rates[] = {
@@ -281,7 +281,7 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 	mvif->idx = idx;
 	mvif->group_wcid.idx = MT_VIF_WCID(idx);
 	mvif->group_wcid.hw_key_idx = -1;
-	mtxq = (struct mt76_txq *) vif->txq->drv_priv;
+	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	mtxq->wcid = &mvif->group_wcid;
 
 	mt76_txq_init(&dev->mt76, vif->txq);
@@ -345,7 +345,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	struct ieee80211_sta *sta = params->sta;
 	struct mt76x02_dev *dev = hw->priv;
-	struct mt76x02_sta *msta = (struct mt76x02_sta *) sta->drv_priv;
+	struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	u16 tid = params->tid;
 	u16 ssn = params->ssn;
@@ -434,7 +434,7 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE))
 		return -EOPNOTSUPP;
 
-	msta = sta ? (struct mt76x02_sta *) sta->drv_priv : NULL;
+	msta = sta ? (struct mt76x02_sta *)sta->drv_priv : NULL;
 	wcid = msta ? &msta->wcid : &mvif->group_wcid;
 
 	if (cmd == SET_KEY) {
@@ -558,11 +558,11 @@ int mt76x02_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 EXPORT_SYMBOL_GPL(mt76x02_set_rts_threshold);
 
 void mt76x02_sta_rate_tbl_update(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta)
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta)
 {
 	struct mt76x02_dev *dev = hw->priv;
-	struct mt76x02_sta *msta = (struct mt76x02_sta *) sta->drv_priv;
+	struct mt76x02_sta *msta = (struct mt76x02_sta *)sta->drv_priv;
 	struct ieee80211_sta_rates *rates = rcu_dereference(sta->rates);
 	struct ieee80211_tx_rate rate = {};
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index 6f6998561d9d..f17058346ff1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -33,7 +33,7 @@ mt76x2_eeprom_get_macaddr(struct mt76x02_dev *dev)
 static bool
 mt76x2_has_cal_free_data(struct mt76x02_dev *dev, u8 *efuse)
 {
-	u16 *efuse_w = (u16 *) efuse;
+	u16 *efuse_w = (u16 *)efuse;
 
 	if (efuse_w[MT_EE_NIC_CONF_0] != 0)
 		return false;
@@ -372,7 +372,8 @@ mt76x2_get_power_info_2g(struct mt76x02_dev *dev,
 	t->chain[chain].tssi_slope = data[0];
 	t->chain[chain].tssi_offset = data[1];
 	t->chain[chain].target_power = data[2];
-	t->chain[chain].delta = mt76x02_sign_extend_optional(data[delta_idx], 7);
+	t->chain[chain].delta =
+		mt76x02_sign_extend_optional(data[delta_idx], 7);
 
 	val = mt76x02_eeprom_get(dev, MT_EE_RF_2G_TSSI_OFF_TXPOWER);
 	t->target_power = val >> 8;
@@ -381,7 +382,7 @@ mt76x2_get_power_info_2g(struct mt76x02_dev *dev,
 static void
 mt76x2_get_power_info_5g(struct mt76x02_dev *dev,
 			 struct mt76x2_tx_power_info *t,
-		         struct ieee80211_channel *chan,
+			 struct ieee80211_channel *chan,
 			 int chain, int offset)
 {
 	int channel = chan->hw_value;
@@ -423,7 +424,8 @@ mt76x2_get_power_info_5g(struct mt76x02_dev *dev,
 	t->chain[chain].tssi_slope = data[0];
 	t->chain[chain].tssi_offset = data[1];
 	t->chain[chain].target_power = data[2];
-	t->chain[chain].delta = mt76x02_sign_extend_optional(data[delta_idx], 7);
+	t->chain[chain].delta =
+		mt76x02_sign_extend_optional(data[delta_idx], 7);
 
 	val = mt76x02_eeprom_get(dev, MT_EE_RF_2G_RX_HIGH_GAIN);
 	t->target_power = val & 0xff;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h
index 40ef43926c06..75f1b2acb141 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h
@@ -71,7 +71,8 @@ struct mt76x2_tssi_comp {
 	u8 offset1;
 } __packed __aligned(4);
 
-int mt76x2_mcu_tssi_comp(struct mt76x02_dev *dev, struct mt76x2_tssi_comp *tssi_data);
+int mt76x2_mcu_tssi_comp(struct mt76x02_dev *dev,
+			 struct mt76x2_tssi_comp *tssi_data);
 int mt76x2_mcu_init_gain(struct mt76x02_dev *dev, u8 channel, u32 gain,
 			 bool force);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index 71aea2832644..b8f657517f37 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -336,4 +336,3 @@ int mt76x2_register_device(struct mt76x02_dev *dev)
 	return ret;
 }
 
-
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
index 605dc66ae83b..e38715c1bcad 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c
@@ -66,7 +66,7 @@ mt76pci_load_rom_patch(struct mt76x02_dev *dev)
 
 	mt76_wr(dev, MT_MCU_PCIE_REMAP_BASE4, MT_MCU_ROM_PATCH_OFFSET);
 
-	cur = (__le32 *) (fw->data + sizeof(*hdr));
+	cur = (__le32 *)(fw->data + sizeof(*hdr));
 	len = fw->size - sizeof(*hdr);
 	mt76_wr_copy(dev, MT_MCU_ROM_PATCH_ADDR, cur, len);
 
@@ -121,7 +121,7 @@ mt76pci_load_firmware(struct mt76x02_dev *dev)
 	dev_info(dev->mt76.dev, "Build: %x\n", val);
 	dev_info(dev->mt76.dev, "Build Time: %.16s\n", hdr->build_time);
 
-	cur = (__le32 *) (fw->data + sizeof(*hdr));
+	cur = (__le32 *)(fw->data + sizeof(*hdr));
 	len = le32_to_cpu(hdr->ilm_len);
 
 	mt76_wr(dev, MT_MCU_PCIE_REMAP_BASE4, MT_MCU_ILM_OFFSET);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index cdedf95ca4f5..57212b049ee2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -25,7 +25,8 @@ mt76x2_adjust_high_lna_gain(struct mt76x02_dev *dev, int reg, s8 offset)
 {
 	s8 gain;
 
-	gain = FIELD_GET(MT_BBP_AGC_LNA_HIGH_GAIN, mt76_rr(dev, MT_BBP(AGC, reg)));
+	gain = FIELD_GET(MT_BBP_AGC_LNA_HIGH_GAIN,
+			 mt76_rr(dev, MT_BBP(AGC, reg)));
 	gain -= offset / 2;
 	mt76_rmw_field(dev, MT_BBP(AGC, reg), MT_BBP_AGC_LNA_HIGH_GAIN, gain);
 }
-- 
2.18.0

