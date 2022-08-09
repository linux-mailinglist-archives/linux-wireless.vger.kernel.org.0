Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B558D79D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242736AbiHIKun (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 06:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242672AbiHIKug (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 06:50:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 919682DEA
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 03:50:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 279AoABs9018833, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 279AoABs9018833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 9 Aug 2022 18:50:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 18:50:20 +0800
Received: from localhost (172.16.16.191) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 9 Aug 2022
 18:50:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 03/13] wifi: rtw89: re-arrange channel related stuffs under HAL
Date:   Tue, 9 Aug 2022 18:49:42 +0800
Message-ID: <20220809104952.61355-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809104952.61355-1-pkshih@realtek.com>
References: <20220809104952.61355-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.191]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2022 10:19:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvOSCkV6TIIDA4OjU0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

We are planning to support mac80211 chanctx. To reduce future works,
the driver architecture is adjusted first to isolate related things.

According to chip, our HW may have multiple sub-entities to support
multiple mac80211 chanctx. Struct rtw89_chan has been introduced for
things about channel/band/subband/... Now introduce struct rtw89_chan_rcd
to record difference after assigning new one of struct rtw89_chan.

We will implement and support chanctx with single channel first, i.e.
only use entry in RTW89_SUB_ENTITY_0, before handling dual channels.

Our hierarchy in planning will become as the following.
DEV
-> HAL
---> entity (manage status across sub-entities)
-----> sub-entity[*] (support mac80211 chanctx)
where each sub-entity contains one struct rtw89_chan.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Makefile   |  1 +
 drivers/net/wireless/realtek/rtw89/chan.c     | 22 ++++++
 drivers/net/wireless/realtek/rtw89/chan.h     |  4 ++
 drivers/net/wireless/realtek/rtw89/coex.c     | 11 ++-
 drivers/net/wireless/realtek/rtw89/coex.h     |  4 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 58 +++++++---------
 drivers/net/wireless/realtek/rtw89/core.h     | 40 ++++++++---
 drivers/net/wireless/realtek/rtw89/debug.c    |  3 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 35 ++++++----
 drivers/net/wireless/realtek/rtw89/mac.c      | 15 ++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 39 +++++++----
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 17 +++--
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 68 +++++++++++--------
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 28 +++++---
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 66 ++++++++++--------
 drivers/net/wireless/realtek/rtw89/sar.c      |  6 +-
 17 files changed, 257 insertions(+), 163 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/chan.c

diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 3006482d25c77..a87f2aff4def2 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -12,6 +12,7 @@ rtw89_core-y += core.o \
 		sar.o \
 		coex.o \
 		ps.o \
+		chan.o \
 		ser.o
 
 obj-$(CONFIG_RTW89_8852A) += rtw89_8852a.o
diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
new file mode 100644
index 0000000000000..a5d1bf573ea62
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2020-2022  Realtek Corporation
+ */
+
+#include "chan.h"
+
+bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
+			      enum rtw89_sub_entity_idx idx,
+			      const struct rtw89_chan *new)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_chan *chan = &hal->chan[idx];
+	struct rtw89_chan_rcd *rcd = &hal->chan_rcd[idx];
+	bool band_changed;
+
+	rcd->prev_primary_channel = chan->primary_channel;
+	rcd->prev_band_type = chan->band_type;
+	band_changed = new->band_type != chan->band_type;
+
+	*chan = *new;
+	return band_changed;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index bcaeb98670f17..ac5cc356b8182 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -21,4 +21,8 @@ static inline void rtw89_set_entity_state(struct rtw89_dev *rtwdev, bool active)
 	WRITE_ONCE(hal->entity_active, active);
 }
 
+bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
+			      enum rtw89_sub_entity_idx idx,
+			      const struct rtw89_chan *new);
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 683854bba217b..5e169388867f8 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -4150,7 +4150,7 @@ enum btc_wl_mode {
 void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      struct rtw89_sta *rtwsta, enum btc_role_state state)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
 	struct rtw89_btc *btc = &rtwdev->btc;
@@ -4165,8 +4165,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 		    vif->type == NL80211_IFTYPE_STATION);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], port=%d\n", rtwvif->port);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], band=%d ch=%d bw=%d\n",
-		    hal->current_band_type, hal->current_channel,
-		    hal->current_band_width);
+		    chan->band_type, chan->channel, chan->band_width);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], associated=%d\n",
 		    state == BTC_ROLE_MSTS_STA_CONN_END);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -4205,9 +4204,9 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	r.connected = MLME_LINKED;
 	r.bcn_period = vif->bss_conf.beacon_int;
 	r.dtim_period = vif->bss_conf.dtim_period;
-	r.band = hal->current_band_type;
-	r.ch = hal->current_channel;
-	r.bw = hal->current_band_width;
+	r.band = chan->band_type;
+	r.ch = chan->channel;
+	r.bw = chan->band_width;
 	ether_addr_copy(r.mac_addr, rtwvif->mac_addr);
 
 	if (rtwsta && vif->type == NL80211_IFTYPE_STATION)
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index c3a722d259d7f..b48a441ae6e23 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -167,12 +167,12 @@ static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
 				  enum rtw89_rf_path_bit paths)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 phy_map;
 
 	phy_map = FIELD_PREP(BTC_RFK_PATH_MAP, paths) |
 		  FIELD_PREP(BTC_RFK_PHY_MAP, BIT(phy_idx)) |
-		  FIELD_PREP(BTC_RFK_BAND_MAP, hal->current_band_type);
+		  FIELD_PREP(BTC_RFK_BAND_MAP, chan->band_type);
 
 	return phy_map;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d7c3a2ac137f8..78d9e6a7a0981 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -370,10 +370,8 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_chan chan;
 	struct rtw89_channel_help_params bak;
-	u8 center_chan, bandwidth;
 	bool band_changed;
 	bool entity_active;
 
@@ -383,18 +381,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	if (WARN(chan.channel == 0, "Invalid channel\n"))
 		return;
 
-	center_chan = chan.channel;
-	bandwidth = chan.band_width;
-	band_changed = hal->current_band_type != chan.band_type;
-
-	hal->current_band_width = bandwidth;
-	hal->current_channel = center_chan;
-	hal->current_freq = chan.freq;
-	hal->prev_primary_channel = hal->current_primary_channel;
-	hal->prev_band_type = hal->current_band_type;
-	hal->current_primary_channel = chan.primary_channel;
-	hal->current_band_type = chan.band_type;
-	hal->current_subband = chan.subband_type;
+	band_changed = rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &chan);
 
 	rtw89_set_entity_state(rtwdev, true);
 
@@ -407,7 +394,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 	rtw89_chip_set_channel_done(rtwdev, &bak);
 
 	if (!entity_active || band_changed) {
-		rtw89_btc_ntfy_switch_band(rtwdev, RTW89_PHY_0, hal->current_band_type);
+		rtw89_btc_ntfy_switch_band(rtwdev, RTW89_PHY_0, chan.band_type);
 		rtw89_chip_rfk_band_changed(rtwdev);
 	}
 }
@@ -547,8 +534,8 @@ static u16 rtw89_core_get_mgmt_rate(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb = tx_req->skb;
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = tx_info->control.vif;
-	struct rtw89_hal *hal = &rtwdev->hal;
-	u16 lowest_rate = hal->current_band_type == RTW89_BAND_2G ?
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u16 lowest_rate = chan->band_type == RTW89_BAND_2G ?
 			  RTW89_HW_RATE_CCK1 : RTW89_HW_RATE_OFDM6;
 
 	if (!vif || !vif->bss_conf.basic_rates || !tx_req->sta)
@@ -564,6 +551,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 qsel, ch_dma;
 
 	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : RTW89_TX_QSEL_B0_MGMT;
@@ -582,9 +570,9 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	desc_info->data_rate = rtw89_core_get_mgmt_rate(rtwdev, tx_req);
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXRX,
-		    "tx mgmt frame with rate 0x%x on channel %d (bw %d)\n",
-		    desc_info->data_rate, rtwdev->hal.current_channel,
-		    rtwdev->hal.current_band_width);
+		    "tx mgmt frame with rate 0x%x on channel %d (band %d, bw %d)\n",
+		    desc_info->data_rate, chan->channel, chan->band_type,
+		    chan->band_width);
 }
 
 static void
@@ -609,15 +597,16 @@ static void rtw89_core_get_no_ul_ofdma_htc(struct rtw89_dev *rtwdev, __le32 *htc
 	};
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 om_bandwidth;
 
 	if (!chip->dis_2g_40m_ul_ofdma ||
-	    hal->current_band_type != RTW89_BAND_2G ||
-	    hal->current_band_width != RTW89_CHANNEL_WIDTH_40)
+	    chan->band_type != RTW89_BAND_2G ||
+	    chan->band_width != RTW89_CHANNEL_WIDTH_40)
 		return;
 
-	om_bandwidth = hal->current_band_width < ARRAY_SIZE(rtw89_bandwidth_to_om) ?
-		       rtw89_bandwidth_to_om[hal->current_band_width] : 0;
+	om_bandwidth = chan->band_width < ARRAY_SIZE(rtw89_bandwidth_to_om) ?
+		       rtw89_bandwidth_to_om[chan->band_width] : 0;
 	*htc = le32_encode_bits(RTW89_HTC_VARIANT_HE, RTW89_HTC_MASK_VARIANT) |
 	       le32_encode_bits(RTW89_HTC_VARIANT_HE_CID_OM, RTW89_HTC_MASK_CTL_ID) |
 	       le32_encode_bits(hal->rx_nss - 1, RTW89_HTC_MASK_HTC_OM_RX_NSS) |
@@ -731,7 +720,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = tx_req->vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	struct sk_buff *skb = tx_req->skb;
 	u8 tid, tid_indicate;
@@ -756,7 +745,7 @@ rtw89_core_tx_update_data_info(struct rtw89_dev *rtwdev,
 
 	if (rate_pattern->enable)
 		desc_info->data_retry_lowest_rate = rate_pattern->rate;
-	else if (hal->current_band_type == RTW89_BAND_2G)
+	else if (chan->band_type == RTW89_BAND_2G)
 		desc_info->data_retry_lowest_rate = RTW89_HW_RATE_CCK1;
 	else
 		desc_info->data_retry_lowest_rate = RTW89_HW_RATE_OFDM6;
@@ -1466,8 +1455,11 @@ static void rtw89_core_rx_stats(struct rtw89_dev *rtwdev,
 static void rtw89_correct_cck_chan(struct rtw89_dev *rtwdev,
 				   struct ieee80211_rx_status *status)
 {
-	u16 chan = rtwdev->hal.prev_primary_channel;
-	u8 band = chan <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+	const struct rtw89_chan_rcd *rcd =
+		rtw89_chan_rcd_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u16 chan = rcd->prev_primary_channel;
+	u8 band = rcd->prev_band_type == RTW89_BAND_2G ?
+		  NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
 
 	if (status->band != NL80211_BAND_2GHZ &&
 	    status->encoding == RX_ENC_LEGACY &&
@@ -1680,7 +1672,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 					struct ieee80211_rx_status *rx_status)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *cur = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u16 data_rate;
 	u8 data_rate_mode;
 
@@ -1690,8 +1682,8 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 
 	if (rtwdev->scanning &&
 	    RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw)) {
-		u8 chan = hal->current_primary_channel;
-		u8 band = hal->current_band_type;
+		u8 chan = cur->primary_channel;
+		u8 band = cur->band_type;
 		enum nl80211_band nl_band;
 
 		nl_band = rtw89_hw_to_nl80211_band(band);
@@ -3025,7 +3017,7 @@ EXPORT_SYMBOL(rtw89_core_deinit);
 void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   const u8 *mac_addr, bool hw_scan)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 
 	rtwdev->scanning = true;
 	rtw89_leave_lps(rtwdev);
@@ -3033,7 +3025,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		rtw89_leave_ips(rtwdev);
 
 	ether_addr_copy(rtwvif->mac_addr, mac_addr);
-	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, hal->current_band_type);
+	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, chan->band_type);
 	rtw89_chip_rfk_scan(rtwdev, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 194cba379285b..86e7341198c6f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -542,6 +542,12 @@ enum rtw89_phy_idx {
 	RTW89_PHY_MAX
 };
 
+enum rtw89_sub_entity_idx {
+	RTW89_SUB_ENTITY_0 = 0,
+
+	NUM_OF_RTW89_SUB_ENTITY,
+};
+
 enum rtw89_rf_path {
 	RF_PATH_A = 0,
 	RF_PATH_B = 1,
@@ -634,6 +640,11 @@ struct rtw89_chan {
 	enum rtw89_sc_offset pri_ch_idx;
 };
 
+struct rtw89_chan_rcd {
+	u8 prev_primary_channel;
+	enum rtw89_band prev_band_type;
+};
+
 struct rtw89_channel_help_params {
 	u32 tx_en;
 };
@@ -2602,14 +2613,6 @@ struct rtw89_sar_info {
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
-	u8 current_channel;
-	u32 current_freq;
-	u8 prev_primary_channel;
-	u8 current_primary_channel;
-	enum rtw89_subband current_subband;
-	u8 current_band_width;
-	u8 prev_band_type;
-	u8 current_band_type;
 	u32 sw_amsdu_max_size;
 	u32 antenna_tx;
 	u32 antenna_rx;
@@ -2619,6 +2622,9 @@ struct rtw89_hal {
 	bool support_igi;
 
 	bool entity_active;
+
+	struct rtw89_chan chan[NUM_OF_RTW89_SUB_ENTITY];
+	struct rtw89_chan_rcd chan_rcd[NUM_OF_RTW89_SUB_ENTITY];
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
@@ -3602,6 +3608,24 @@ void rtw89_chip_set_channel_done(struct rtw89_dev *rtwdev,
 	rtwdev->chip->ops->set_channel_help(rtwdev, false, p);
 }
 
+static inline
+const struct rtw89_chan *rtw89_chan_get(struct rtw89_dev *rtwdev,
+					enum rtw89_sub_entity_idx idx)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	return &hal->chan[idx];
+}
+
+static inline
+const struct rtw89_chan_rcd *rtw89_chan_rcd_get(struct rtw89_dev *rtwdev,
+						enum rtw89_sub_entity_idx idx)
+{
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	return &hal->chan_rcd[idx];
+}
+
 static inline void rtw89_chip_fem_setup(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 829c61da99bb9..9c93117c62a44 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -525,7 +525,8 @@ static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
 
 static void __print_regd(struct seq_file *m, struct rtw89_dev *rtwdev)
 {
-	u8 band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 
 	switch (regd) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 6473015a6b2a1..8dcd02d90f457 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3,6 +3,7 @@
  */
 
 #include "cam.h"
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "fw.h"
@@ -926,9 +927,9 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_sta *sta)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
@@ -947,7 +948,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
 	SET_CMC_TBL_DISRTSFB(skb->data, 1);
 	SET_CMC_TBL_DISDATAFB(skb->data, 1);
-	if (hal->current_band_type == RTW89_BAND_2G)
+	if (chan->band_type == RTW89_BAND_2G)
 		SET_CMC_TBL_RTS_RTY_LOWEST_RATE(skb->data, RTW89_HW_RATE_CCK1);
 	else
 		SET_CMC_TBL_RTS_RTY_LOWEST_RATE(skb->data, RTW89_HW_RATE_OFDM6);
@@ -1036,8 +1037,8 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct sk_buff *skb;
 	struct sk_buff *skb_beacon;
 	u16 tim_offset;
@@ -1066,7 +1067,7 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	SET_BCN_UPD_MACID(skb->data, rtwvif->mac_id);
 	SET_BCN_UPD_SSN_SEL(skb->data, RTW89_MGMT_HW_SSN_SEL);
 	SET_BCN_UPD_SSN_MODE(skb->data, RTW89_MGMT_HW_SEQ_MODE);
-	SET_BCN_UPD_RATE(skb->data, hal->current_band_type == RTW89_BAND_2G ?
+	SET_BCN_UPD_RATE(skb->data, chan->band_type == RTW89_BAND_2G ?
 				    RTW89_HW_RATE_CCK1 : RTW89_HW_RATE_OFDM6);
 
 	skb_put_data(skb, skb_beacon->data, skb_beacon->len);
@@ -1788,6 +1789,7 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
 	struct rtw89_fw_h2c_rf_get_mccch *mccch;
 	struct sk_buff *skb;
@@ -1804,8 +1806,8 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 	mccch->ch_1 = cpu_to_le32(mcc_info->ch[1]);
 	mccch->band_0 = cpu_to_le32(mcc_info->band[0]);
 	mccch->band_1 = cpu_to_le32(mcc_info->band[1]);
-	mccch->current_channel = cpu_to_le32(rtwdev->hal.current_channel);
-	mccch->current_band_type = cpu_to_le32(rtwdev->hal.current_band_type);
+	mccch->current_channel = cpu_to_le32(chan->channel);
+	mccch->current_band_type = cpu_to_le32(chan->band_type);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_NOTIFY,
@@ -2377,18 +2379,21 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 void rtw89_store_op_chan(struct rtw89_dev *rtwdev, bool backup)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *cur = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_chan new;
 
 	if (backup) {
-		scan_info->op_pri_ch = hal->current_primary_channel;
-		scan_info->op_chan = hal->current_channel;
-		scan_info->op_bw = hal->current_band_width;
-		scan_info->op_band = hal->current_band_type;
+		scan_info->op_pri_ch = cur->primary_channel;
+		scan_info->op_chan = cur->channel;
+		scan_info->op_bw = cur->band_width;
+		scan_info->op_band = cur->band_type;
 	} else {
-		hal->current_primary_channel = scan_info->op_pri_ch;
-		hal->current_channel = scan_info->op_chan;
-		hal->current_band_width = scan_info->op_bw;
-		hal->current_band_type = scan_info->op_band;
+		new = *cur;
+		new.primary_channel = scan_info->op_pri_ch;
+		new.channel = scan_info->op_chan;
+		new.band_width = scan_info->op_bw;
+		new.band_type = scan_info->op_band;
+		rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &new);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 85e333e995d2a..b9fb983b6ce24 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3655,7 +3655,8 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			   u32 len)
 {
 	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *cur = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	struct rtw89_chan new;
 	u8 reason, status, tx_fail, band;
 	u16 chan;
 
@@ -3681,12 +3682,12 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 		rtw89_hw_scan_complete(rtwdev, vif, false);
 		break;
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
-		hal->prev_band_type = hal->current_band_type;
-		hal->current_band_type = band;
-		hal->prev_primary_channel = hal->current_primary_channel;
-		hal->current_primary_channel = chan;
-		hal->current_channel = chan;
-		hal->current_band_width = RTW89_CHANNEL_WIDTH_20;
+		new = *cur;
+		new.channel = chan;
+		new.primary_channel = chan;
+		new.band_type = band;
+		new.band_width = RTW89_CHANNEL_WIDTH_20;
+		rtw89_assign_entity_chan(rtwdev, RTW89_SUB_ENTITY_0, &new);
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
 			rtw89_store_op_chan(rtwdev, false);
 			ieee80211_wake_queues(rtwdev->hw);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index cef27e781ae24..ff645f8905aa8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -235,11 +235,12 @@ static u8 rtw89_aifsn_to_aifs(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif *rtwvif, u8 aifsn)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 slot_time;
 	u8 sifs;
 
 	slot_time = vif->bss_conf.use_short_slot ? 9 : 20;
-	sifs = rtwdev->hal.current_band_type == RTW89_BAND_5G ? 16 : 10;
+	sifs = chan->band_type == RTW89_BAND_5G ? 16 : 10;
 
 	return aifsn * slot_time + sifs;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ad86c93a36ebf..dce3ff0cde3ed 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -142,8 +142,8 @@ static u64 rtw89_phy_ra_mask_recover(u64 ra_mask, u64 ra_mask_bak)
 
 static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct cfg80211_bitrate_mask *mask = &rtwsta->mask;
 	enum nl80211_band band;
 	u64 cfg_mask;
@@ -151,7 +151,7 @@ static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtw
 	if (!rtwsta->use_cfg_mask)
 		return -1;
 
-	switch (hal->current_band_type) {
+	switch (chan->band_type) {
 	case RTW89_BAND_2G:
 		band = NL80211_BAND_2GHZ;
 		cfg_mask = u64_encode_bits(mask->control[NL80211_BAND_2GHZ].legacy,
@@ -168,7 +168,7 @@ static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev, struct rtw89_sta *rtw
 					   RA_MASK_OFDM_RATES);
 		break;
 	default:
-		rtw89_warn(rtwdev, "unhandled band type %d\n", hal->current_band_type);
+		rtw89_warn(rtwdev, "unhandled band type %d\n", chan->band_type);
 		return -1;
 	}
 
@@ -209,6 +209,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
 	struct rtw89_ra_info *ra = &rtwsta->ra;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
 	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi);
 	u64 ra_mask = 0;
@@ -260,7 +261,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 			ldpc_en = 1;
 	}
 
-	switch (rtwdev->hal.current_band_type) {
+	switch (chan->band_type) {
 	case RTW89_BAND_2G:
 		ra_mask |= sta->deflink.supp_rates[NL80211_BAND_2GHZ];
 		if (sta->deflink.supp_rates[NL80211_BAND_2GHZ] <= 0xf)
@@ -416,6 +417,7 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	struct ieee80211_supported_band *sband;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern next_pattern = {0};
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	static const u16 hw_rate_he[] = {RTW89_HW_RATE_HE_NSS1_MCS0,
 					 RTW89_HW_RATE_HE_NSS2_MCS0,
 					 RTW89_HW_RATE_HE_NSS3_MCS0,
@@ -428,7 +430,7 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 					 RTW89_HW_RATE_MCS8,
 					 RTW89_HW_RATE_MCS16,
 					 RTW89_HW_RATE_MCS24};
-	u8 band = rtwdev->hal.current_band_type;
+	u8 band = chan->band_type;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
 	u8 tx_nss = rtwdev->hal.tx_nss;
 	u8 i;
@@ -1471,7 +1473,8 @@ EXPORT_SYMBOL(rtw89_phy_load_txpwr_byrate);
 s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev,
 			       const struct rtw89_rate_desc *rate_desc)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 	s8 *byr;
 	u8 idx;
 
@@ -1542,7 +1545,8 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt = 0, sar;
@@ -1729,9 +1733,10 @@ void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 				struct rtw89_txpwr_limit *lmt,
 				u8 ntx)
 {
-	u8 pri_ch = rtwdev->hal.current_primary_channel;
-	u8 ch = rtwdev->hal.current_channel;
-	u8 bw = rtwdev->hal.current_band_width;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 pri_ch = chan->primary_channel;
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
 
 	memset(lmt, 0, sizeof(*lmt));
 
@@ -1756,7 +1761,8 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 					u8 ru, u8 ntx, u8 ch)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 lmt_ru = 0, sar;
@@ -1883,8 +1889,9 @@ void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 				   struct rtw89_txpwr_limit_ru *lmt_ru,
 				   u8 ntx)
 {
-	u8 ch = rtwdev->hal.current_channel;
-	u8 bw = rtwdev->hal.current_band_width;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
 
 	memset(lmt_ru, 0, sizeof(*lmt_ru));
 
@@ -3247,10 +3254,11 @@ static void rtw89_phy_dig_update_rssi_info(struct rtw89_dev *rtwdev)
 static void rtw89_phy_dig_update_para(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_dig_info *dig = &rtwdev->dig;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 	const u16 *fa_th_src = NULL;
 
-	switch (rtwdev->hal.current_band_type) {
+	switch (chan->band_type) {
 	case RTW89_BAND_2G:
 		dig->lna_gain = dig->lna_gain_g;
 		dig->tia_gain = dig->tia_gain_g;
@@ -3483,7 +3491,8 @@ static void rtw89_phy_dig_config_igi(struct rtw89_dev *rtwdev)
 static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 				    bool enable)
 {
-	enum rtw89_bandwidth cbw = rtwdev->hal.current_band_width;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_bandwidth cbw = chan->band_width;
 	struct rtw89_dig_info *dig = &rtwdev->dig;
 	u8 final_rssi = 0, under_region = dig->pd_low_th_ofst;
 	u8 ofdm_cca_th;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6a87f30ca25ca..ef200d32eab33 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1381,7 +1381,8 @@ static void rtw8852a_set_txpwr_ref(struct rtw89_dev *rtwdev,
 static void rtw8852a_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx)
 {
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
 	static const u8 rs[] = {
 		RTW89_RS_CCK,
 		RTW89_RS_OFDM,
@@ -1446,8 +1447,9 @@ static void rtw8852a_set_txpwr_limit(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_PAGE_SIZE 40
-	u8 ch = rtwdev->hal.current_channel;
-	u8 bw = rtwdev->hal.current_band_width;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit lmt[NTX_NUM_8852A];
 	u32 addr, val;
 	const s8 *ptr;
@@ -1477,8 +1479,9 @@ static void rtw8852a_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 					enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_RU_PAGE_SIZE 24
-	u8 ch = rtwdev->hal.current_channel;
-	u8 bw = rtwdev->hal.current_band_width;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852A];
 	u32 addr, val;
 	const s8 *ptr;
@@ -1593,10 +1596,12 @@ void rtw8852a_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 			     struct rtw8852a_bb_pmac_info *tx_info,
 			     enum rtw89_phy_idx idx)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
 	if (!tx_info->en_pmac_tx) {
 		rtw8852a_stop_pmac_tx(rtwdev, tx_info, idx);
 		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0, idx);
-		if (rtwdev->hal.current_band_type == RTW89_BAND_2G)
+		if (chan->band_type == RTW89_BAND_2G)
 			rtw89_phy_write32_clr(rtwdev, R_RXCCA, B_RXCCA_DIS);
 		return;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 3d60feb783121..32744201241ec 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -1359,7 +1359,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy, u8 path)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u32 reg_rf18 = 0x0, reg_35c = 0x0;
 	u8 idx = 0;
 	u8 get_empty_table = false;
@@ -1380,9 +1380,9 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]cfg ch = %d\n", reg_rf18);
 	reg_35c = rtw89_phy_read32_mask(rtwdev, 0x35c, 0x00000c00);
 
-	iqk_info->iqk_band[path] = hal->current_band_type;
-	iqk_info->iqk_bw[path] = hal->current_band_width;
-	iqk_info->iqk_ch[path] = hal->current_channel;
+	iqk_info->iqk_band[path] = chan->band_type;
+	iqk_info->iqk_bw[path] = chan->band_width;
+	iqk_info->iqk_ch[path] = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]iqk_info->iqk_band[%x] = 0x%x\n", path,
@@ -1879,13 +1879,12 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 			     enum rtw89_rf_path path)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
-	struct rtw89_hal *hal = &rtwdev->hal;
-
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 kidx = dpk->cur_idx[path];
 
-	dpk->bp[path][kidx].band = hal->current_band_type;
-	dpk->bp[path][kidx].ch = hal->current_channel;
-	dpk->bp[path][kidx].bw = hal->current_band_width;
+	dpk->bp[path][kidx].band = chan->band_type;
+	dpk->bp[path][kidx].ch = chan->channel;
+	dpk->bp[path][kidx].bw = chan->band_width;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
@@ -2358,6 +2357,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 #define DPK_RXBB_UPPER 0x1f
 #define DPK_RXBB_LOWER 0
 #define DPK_GL_CRIT 7
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 tmp_txagc, tmp_rxbb = 0, tmp_gl_idx = 0;
 	u8 agc_cnt = 0;
 	bool limited_rxbb = false;
@@ -2404,7 +2404,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    "[DPK] Adjust RXBB (%d) = 0x%x\n", offset,
 				    tmp_rxbb);
 			if (offset != 0 || agc_cnt == 0) {
-				if (rtwdev->hal.current_band_width < RTW89_CHANNEL_WIDTH_80)
+				if (chan->band_width < RTW89_CHANNEL_WIDTH_80)
 					_dpk_bypass_rxcfir(rtwdev, path, true);
 				else
 					_dpk_lbk_rxiqk(rtwdev, phy, path);
@@ -2548,11 +2548,12 @@ static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			      enum rtw89_rf_path path)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
 
-	cur_band = rtwdev->hal.current_band_type;
-	cur_ch = rtwdev->hal.current_channel;
+	cur_band = chan->band_type;
+	cur_ch = chan->channel;
 
 	for (idx = 0; idx < RTW89_DPK_BKUP_NUM; idx++) {
 		if (cur_band != dpk->bp[path][idx].band ||
@@ -2681,12 +2682,13 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_fem_info *fem = &rtwdev->fem;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 
-	if (fem->epa_2g && rtwdev->hal.current_band_type == RTW89_BAND_2G) {
+	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK,
 			    "[DPK] Skip DPK due to 2G_ext_PA exist!!\n");
 		return true;
-	} else if (fem->epa_5g && rtwdev->hal.current_band_type == RTW89_BAND_5G) {
+	} else if (fem->epa_5g && chan->band_type == RTW89_BAND_5G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK,
 			    "[DPK] Skip DPK due to 5G_ext_PA exist!!\n");
 		return true;
@@ -2842,7 +2844,8 @@ static void _dpk_track(struct rtw89_dev *rtwdev)
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 
 	if (band == RTW89_BAND_2G)
 		rtw89_write_rf(rtwdev, path, RR_TXPOW, RR_TXPOW_TXG, 0x1);
@@ -2852,7 +2855,8 @@ static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852a_tssi_sys_defs_tbl);
 	rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
@@ -2863,7 +2867,8 @@ static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 static void _tssi_ini_txpwr_ctrl_bb(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    enum rtw89_rf_path path)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
 				 &rtw8852a_tssi_txpwr_ctrl_bb_defs_a_tbl,
@@ -2905,8 +2910,9 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	u8 ch = rtwdev->hal.current_channel;
-	u8 subband = rtwdev->hal.current_subband;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
 	const s8 *thm_down_a = NULL;
 	const s8 *thm_up_b = NULL;
@@ -3099,7 +3105,8 @@ static void _tssi_set_txagc_offset_mv_avg(struct rtw89_dev *rtwdev,
 static void _tssi_pak(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		      enum rtw89_rf_path path)
 {
-	u8 subband = rtwdev->hal.current_subband;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 subband = chan->subband_type;
 
 	switch (subband) {
 	default:
@@ -3275,7 +3282,8 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			    enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st = 0;
 	s8 de_2nd = 0;
@@ -3312,7 +3320,8 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 				 enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st = 0;
 	s8 tde_2nd = 0;
@@ -3350,6 +3359,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 {
 #define __DE_MASK 0x003ff000
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	static const u32 r_cck_long[RF_PATH_NUM_8852A] = {0x5858, 0x7858};
 	static const u32 r_cck_short[RF_PATH_NUM_8852A] = {0x5860, 0x7860};
 	static const u32 r_mcs_20m[RF_PATH_NUM_8852A] = {0x5838, 0x7838};
@@ -3358,7 +3368,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 	static const u32 r_mcs_80m_80m[RF_PATH_NUM_8852A] = {0x5850, 0x7850};
 	static const u32 r_mcs_5m[RF_PATH_NUM_8852A] = {0x5828, 0x7828};
 	static const u32 r_mcs_10m[RF_PATH_NUM_8852A] = {0x5830, 0x7830};
-	u8 ch = rtwdev->hal.current_channel;
+	u8 ch = chan->channel;
 	u8 i, gidx;
 	s8 ofdm_de;
 	s8 trim_de;
@@ -3478,9 +3488,10 @@ static void _tssi_track(struct rtw89_dev *rtwdev)
 static void _tssi_high_power(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	u8 ch = rtwdev->hal.current_channel, ch_tmp;
-	u8 bw = rtwdev->hal.current_band_width;
-	u8 subband = rtwdev->hal.current_subband;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel, ch_tmp;
+	u8 bw = chan->band_width;
+	u8 subband = chan->subband_type;
 	s8 power;
 	s32 xdbm;
 
@@ -3523,9 +3534,10 @@ static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	const struct rtw89_chip_info *mac_reg = rtwdev->chip;
-	u8 ch = rtwdev->hal.current_channel, ch_tmp;
-	u8 bw = rtwdev->hal.current_band_width;
+	u8 ch = chan->channel, ch_tmp;
+	u8 bw = chan->band_width;
 	u32 tx_en;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, 0);
 	s8 power;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8c00aaeedb920..b81aec0630969 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1532,7 +1532,7 @@ static void rtw8852c_bb_reset_all(struct rtw89_dev *rtwdev,
 static void rtw8852c_bb_reset_en(struct rtw89_dev *rtwdev,
 				 enum rtw89_phy_idx phy_idx, bool en)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 
 	if (en) {
 		rtw89_phy_write32_idx(rtwdev, R_S0_HW_SI_DIS,
@@ -1541,7 +1541,7 @@ static void rtw8852c_bb_reset_en(struct rtw89_dev *rtwdev,
 				      B_S1_HW_SI_DIS_W_R_TRIG, 0x0, phy_idx);
 		rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1,
 				      phy_idx);
-		if (hal->current_band_type == RTW89_BAND_2G)
+		if (chan->band_type == RTW89_BAND_2G)
 			rtw89_phy_write32_mask(rtwdev, R_RXCCA_V1, B_RXCCA_DIS_V1, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0x0);
 	} else {
@@ -1964,7 +1964,8 @@ static void rtw8852c_set_txpwr_ref(struct rtw89_dev *rtwdev,
 static void rtw8852c_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx)
 {
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
 	static const u8 rs[] = {
 		RTW89_RS_CCK,
 		RTW89_RS_OFDM,
@@ -2049,7 +2050,8 @@ static void rtw8852c_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
 	__DECL_DFIR_ADDR(filter,
 			 0x45BC, 0x45CC, 0x45D0, 0x45D4, 0x45D8, 0x45C0,
 			 0x45C4, 0x45C8);
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
 	const u32 *param;
 	int i;
 
@@ -2082,7 +2084,8 @@ static void rtw8852c_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
 static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx)
 {
-	u8 band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 tx_shape_cck = rtw89_8852c_tx_shape[band][RTW89_RS_CCK][regd];
 	u8 tx_shape_ofdm = rtw89_8852c_tx_shape[band][RTW89_RS_OFDM][regd];
@@ -2099,8 +2102,9 @@ static void rtw8852c_set_txpwr_limit(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_PAGE_SIZE 40
-	u8 ch = rtwdev->hal.current_channel;
-	u8 bw = rtwdev->hal.current_band_width;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit lmt[NTX_NUM_8852C];
 	u32 addr, val;
 	const s8 *ptr;
@@ -2130,8 +2134,9 @@ static void rtw8852c_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 					enum rtw89_phy_idx phy_idx)
 {
 #define __MAC_TXPWR_LMT_RU_PAGE_SIZE 24
-	u8 ch = rtwdev->hal.current_channel;
-	u8 bw = rtwdev->hal.current_band_width;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
 	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852C];
 	u32 addr, val;
 	const s8 *ptr;
@@ -2226,7 +2231,8 @@ rtw8852c_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 static void rtw8852c_bb_cfg_rx_path(struct rtw89_dev *rtwdev, u8 rx_path)
 {
-	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 	u32 rst_mask0 = B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI;
 	u32 rst_mask1 = B_P1_TXPW_RSTB_MANON | B_P1_TXPW_RSTB_TSSI;
 
@@ -2320,7 +2326,7 @@ static void rtw8852c_bb_cfg_rx_path(struct rtw89_dev *rtwdev, u8 rx_path)
 					       1);
 			rtw89_phy_write32_mask(rtwdev, R_RXHE, B_RXHETB_MAX_NSS,
 					       1);
-			rtw8852c_ctrl_btg(rtwdev, hal->current_band_type == RTW89_BAND_2G);
+			rtw8852c_ctrl_btg(rtwdev, band == RTW89_BAND_2G);
 			rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB,
 					       rst_mask0, 1);
 			rtw89_phy_write32_mask(rtwdev, R_P0_TXPW_RSTB,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index fa109ee673cfc..478a36de1bd3d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1294,14 +1294,14 @@ static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy, u8 path)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	struct rtw89_hal *hal = &rtwdev->hal;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
 
-	iqk_info->iqk_band[path] = hal->current_band_type;
-	iqk_info->iqk_bw[path] = hal->current_band_width;
-	iqk_info->iqk_ch[path] = hal->current_channel;
+	iqk_info->iqk_band[path] = chan->band_type;
+	iqk_info->iqk_bw[path] = chan->band_width;
+	iqk_info->iqk_ch[path] = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[IQK]iqk_info->iqk_band[%x] = 0x%x\n", path,
@@ -1691,14 +1691,14 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
-	struct rtw89_hal *hal = &rtwdev->hal;
 
 	u8 kidx = dpk->cur_idx[path];
 
-	dpk->bp[path][kidx].band = hal->current_band_type;
-	dpk->bp[path][kidx].ch = hal->current_channel;
-	dpk->bp[path][kidx].bw = hal->current_band_width;
+	dpk->bp[path][kidx].band = chan->band_type;
+	dpk->bp[path][kidx].ch = chan->channel;
+	dpk->bp[path][kidx].bw = chan->band_width;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] S%d[%d] (PHY%d): TSSI %s/ DBCC %s/ %s/ CH%d/ %s\n",
@@ -2272,12 +2272,13 @@ static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			      enum rtw89_rf_path path)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
 
-	cur_band = rtwdev->hal.current_band_type;
-	cur_ch = rtwdev->hal.current_channel;
+	cur_band = chan->band_type;
+	cur_ch = chan->channel;
 
 	for (idx = 0; idx < RTW89_DPK_BKUP_NUM; idx++) {
 		if (cur_band != dpk->bp[path][idx].band ||
@@ -2530,17 +2531,19 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_fem_info *fem = &rtwdev->fem;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 band = chan->band_type;
 
-	if (rtwdev->hal.cv == CHIP_CAV && rtwdev->hal.current_band_type != RTW89_BAND_2G) {
+	if (rtwdev->hal.cv == CHIP_CAV && band != RTW89_BAND_2G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to CAV & not 2G!!\n");
 		return true;
-	} else if (fem->epa_2g && rtwdev->hal.current_band_type == RTW89_BAND_2G) {
+	} else if (fem->epa_2g && band == RTW89_BAND_2G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to 2G_ext_PA exist!!\n");
 		return true;
-	} else if (fem->epa_5g && rtwdev->hal.current_band_type == RTW89_BAND_5G) {
+	} else if (fem->epa_5g && band == RTW89_BAND_5G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to 5G_ext_PA exist!!\n");
 		return true;
-	} else if (fem->epa_6g && rtwdev->hal.current_band_type == RTW89_BAND_6G) {
+	} else if (fem->epa_6g && band == RTW89_BAND_6G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Skip DPK due to 6G_ext_PA exist!!\n");
 		return true;
 	}
@@ -2663,7 +2666,8 @@ static void _dpk_track(struct rtw89_dev *rtwdev)
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_sys_defs_tbl);
 
@@ -2697,7 +2701,8 @@ static void _tssi_ini_txpwr_ctrl_bb_he_tb(struct rtw89_dev *rtwdev,
 static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A) {
 		rtw89_rfk_parser(rtwdev, &rtw8852c_tssi_dck_defs_a_tbl);
@@ -2735,8 +2740,9 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	u8 ch = rtwdev->hal.current_channel;
-	u8 subband = rtwdev->hal.current_subband;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
 	const s8 *thm_down_a = NULL;
 	const s8 *thm_up_b = NULL;
@@ -2908,7 +2914,8 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A) {
 		rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
@@ -2924,7 +2931,8 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 static void _tssi_set_aligk_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    enum rtw89_rf_path path)
 {
-	enum rtw89_band band = rtwdev->hal.current_band_type;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
 	const struct rtw89_rfk_tbl *tbl;
 
 	if (path == RF_PATH_A) {
@@ -3335,8 +3343,9 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			    enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	enum rtw89_band band = rtwdev->hal.current_band_type;
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st;
 	s8 de_2nd;
@@ -3398,8 +3407,9 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 				 enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	enum rtw89_band band = rtwdev->hal.current_band_type;
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st = 0;
 	s8 tde_2nd = 0;
@@ -3462,7 +3472,8 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	u8 ch = rtwdev->hal.current_channel;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
 	s8 trim_de;
@@ -3812,6 +3823,7 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 
 void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
 	u8 idx = mcc_info->table_idx;
 	int i;
@@ -3824,8 +3836,8 @@ void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_i
 	}
 
 	mcc_info->table_idx = idx;
-	mcc_info->ch[idx] = rtwdev->hal.current_channel;
-	mcc_info->band[idx] = rtwdev->hal.current_band_type;
+	mcc_info->ch[idx] = chan->channel;
+	mcc_info->band[idx] = chan->band_type;
 }
 
 void rtw8852c_rck(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 41cd619f4e980..dfccae81c3804 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -81,9 +81,9 @@ static const struct rtw89_sar_span rtw89_sar_overlapping_6ghz[] = {
 static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev, s32 *cfg)
 {
 	struct rtw89_sar_cfg_common *rtwsar = &rtwdev->sar.cfg_common;
-	struct rtw89_hal *hal = &rtwdev->hal;
-	enum rtw89_band band = hal->current_band_type;
-	u32 center_freq = hal->current_freq;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	enum rtw89_band band = chan->band_type;
+	u32 center_freq = chan->freq;
 	const struct rtw89_sar_span *span = NULL;
 	enum rtw89_sar_subband subband_l, subband_h;
 	int idx;
-- 
2.25.1

