Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2834F7C47
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 11:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244088AbiDGKBd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 06:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244087AbiDGKBa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 06:01:30 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9B1133161
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 02:59:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2379xMsaD006117, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2379xMsaD006117
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 17:59:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 17:59:22 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 7 Apr
 2022 17:59:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH 3/6] rtw88: Add update beacon flow for AP mode
Date:   Thu, 7 Apr 2022 17:58:55 +0800
Message-ID: <20220407095858.46807-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407095858.46807-1-pkshih@realtek.com>
References: <20220407095858.46807-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 09:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkV6TIIDA4OjExOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

From: Po-Hao Huang <phhuang@realtek.com>

To support stations in power saving mode, AP should notify stations
that there are frames buffered at the AP via TIM during beacons.
Driver used to transmit identical beacons that were downloaded to
hardware during the initiation phase. This beacon will become
obsolete over time.

If the beacon does not contain sufficient information, station would
not be able to percept that there is data to receive. Hence it won't
wake up and start the PS-poll procedure, this could lead to timeout
and/or lost data segments. In order to resolve this issue, driver will
now download beacon to hardware whenever the content is updated.

Enable hardware to update dtim_count for more efficiency, this reduces
the overhead of downloading beacon at every beacon interval since most
of the time only the dtim_count needs to be updated.

Change queue mapping for broadcast/multicast frames to high queue, so
these frames can be prioritized and sent when dtim_count is zero.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  4 +++-
 drivers/net/wireless/realtek/rtw88/fw.h       |  1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c | 17 ++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.c     |  6 ++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  2 ++
 drivers/net/wireless/realtek/rtw88/pci.c      |  3 +++
 drivers/net/wireless/realtek/rtw88/reg.h      |  2 ++
 drivers/net/wireless/realtek/rtw88/tx.c       | 17 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/tx.h       |  4 ++++
 9 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 941df27f0b692..c1af2704bb866 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1047,6 +1047,7 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 	struct rtw_vif *rtwvif;
 	struct sk_buff *skb_new;
 	struct cfg80211_ssid *ssid;
+	u16 tim_offset;
 
 	if (rsvd_pkt->type == RSVD_DUMMY) {
 		skb_new = alloc_skb(1, GFP_KERNEL);
@@ -1065,7 +1066,8 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 
 	switch (rsvd_pkt->type) {
 	case RSVD_BEACON:
-		skb_new = ieee80211_beacon_get(hw, vif);
+		skb_new = ieee80211_beacon_get_tim(hw, vif, &tim_offset, NULL);
+		rsvd_pkt->tim_offset = tim_offset;
 		break;
 	case RSVD_PS_POLL:
 		skb_new = ieee80211_pspoll_get(hw, vif);
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 3486eb9585def..734113fba184e 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -172,6 +172,7 @@ struct rtw_rsvd_page {
 	struct sk_buff *skb;
 	enum rtw_rsvd_packet_type type;
 	u8 page;
+	u16 tim_offset;
 	bool add_txdesc;
 	struct cfg80211_ssid *ssid;
 	u16 probe_req_size;
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index c9341af493645..1ee41dfda5e1b 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -402,8 +402,10 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			coex_stat->wl_beacon_interval = conf->beacon_int;
 	}
 
-	if (changed & BSS_CHANGED_BEACON)
+	if (changed & BSS_CHANGED_BEACON) {
+		rtw_set_dtim_period(rtwdev, conf->dtim_period);
 		rtw_fw_download_rsvd_page(rtwdev);
+	}
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED) {
 		if (conf->enable_beacon)
@@ -474,6 +476,18 @@ static int rtw_ops_sta_remove(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int rtw_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
+			   bool set)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_fw_download_rsvd_page(rtwdev);
+	mutex_unlock(&rtwdev->mutex);
+
+	return 0;
+}
+
 static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 			   struct ieee80211_key_conf *key)
@@ -875,6 +889,7 @@ const struct ieee80211_ops rtw_ops = {
 	.conf_tx		= rtw_ops_conf_tx,
 	.sta_add		= rtw_ops_sta_add,
 	.sta_remove		= rtw_ops_sta_remove,
+	.set_tim		= rtw_ops_set_tim,
 	.set_key		= rtw_ops_set_key,
 	.ampdu_action		= rtw_ops_ampdu_action,
 	.can_aggregate_in_amsdu	= rtw_ops_can_aggregate_in_amsdu,
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9a0a4babf1b60..8fb102cb04c37 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -664,6 +664,12 @@ void rtw_set_rx_freq_band(struct rtw_rx_pkt_stat *pkt_stat, u8 channel)
 }
 EXPORT_SYMBOL(rtw_set_rx_freq_band);
 
+void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period)
+{
+	rtw_write32_set(rtwdev, REG_TCR, BIT_TCR_UPDATE_TIMIE);
+	rtw_write8(rtwdev, REG_DTIM_COUNTER_ROOT, dtim_period - 1);
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *chan_params)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index f694a2d86e0b2..2743074a42560 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -580,6 +580,7 @@ struct rtw_tx_pkt_info {
 	u32 tx_pkt_size;
 	u8 offset;
 	u8 pkt_offset;
+	u8 tim_offset;
 	u8 mac_id;
 	u8 rate_id;
 	u8 rate;
@@ -2131,6 +2132,7 @@ static inline int rtw_chip_dump_fw_crash(struct rtw_dev *rtwdev)
 }
 
 void rtw_set_rx_freq_band(struct rtw_rx_pkt_stat *pkt_stat, u8 channel);
+void rtw_set_dtim_period(struct rtw_dev *rtwdev, int dtim_period);
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a0991d3f15c01..8e122e121e854 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -689,6 +689,9 @@ static u8 rtw_hw_queue_mapping(struct sk_buff *skb)
 		queue = RTW_TX_QUEUE_BCN;
 	else if (unlikely(ieee80211_is_mgmt(fc) || ieee80211_is_ctl(fc)))
 		queue = RTW_TX_QUEUE_MGMT;
+	else if (is_broadcast_ether_addr(hdr->addr1) ||
+		 is_multicast_ether_addr(hdr->addr1))
+		queue = RTW_TX_QUEUE_HI0;
 	else if (WARN_ON_ONCE(q_mapping >= ARRAY_SIZE(ac_to_hwq)))
 		queue = ac_to_hwq[IEEE80211_AC_BE];
 	else
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 84ba9ec489c37..03bd8dc53f72a 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -389,12 +389,14 @@
 #define BIT_EN_FREE_CNT		BIT(3)
 #define BIT_DIS_SECOND_CCA	(BIT(0) | BIT(1))
 #define REG_HIQ_NO_LMT_EN	0x5A7
+#define REG_DTIM_COUNTER_ROOT	0x5A8
 #define BIT_HIQ_NO_LMT_EN_ROOT	BIT(0)
 #define REG_TIMER0_SRC_SEL	0x05B4
 #define BIT_TSFT_SEL_TIMER0	(BIT(4) | BIT(5) | BIT(6))
 
 #define REG_TCR			0x0604
 #define BIT_PWRMGT_HWDATA_EN	BIT(7)
+#define BIT_TCR_UPDATE_TIMIE	BIT(5)
 #define REG_RCR			0x0608
 #define BIT_APP_FCS		BIT(31)
 #define BIT_APP_MIC		BIT(30)
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 94d1089f40220..ec440c8969a5b 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -67,6 +67,10 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 	SET_TX_DESC_HW_SSN_SEL(txdesc, pkt_info->hw_ssn_sel);
 	SET_TX_DESC_NAVUSEHDR(txdesc, pkt_info->nav_use_hdr);
 	SET_TX_DESC_BT_NULL(txdesc, pkt_info->bt_null);
+	if (pkt_info->tim_offset) {
+		SET_TX_DESC_TIM_EN(txdesc, 1);
+		SET_TX_DESC_TIM_OFFSET(txdesc, pkt_info->tim_offset);
+	}
 }
 EXPORT_SYMBOL(rtw_tx_fill_tx_desc);
 
@@ -448,6 +452,19 @@ void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 	if (type == RSVD_QOS_NULL)
 		pkt_info->bt_null = true;
 
+	if (type == RSVD_BEACON) {
+		struct rtw_rsvd_page *rsvd_pkt;
+		int hdr_len;
+
+		rsvd_pkt = list_first_entry_or_null(&rtwdev->rsvd_page_list,
+						    struct rtw_rsvd_page,
+						    build_list);
+		if (rsvd_pkt && rsvd_pkt->tim_offset != 0) {
+			hdr_len = sizeof(struct ieee80211_hdr_3addr);
+			pkt_info->tim_offset = rsvd_pkt->tim_offset - hdr_len;
+		}
+	}
+
 	rtw_tx_pkt_info_update_sec(rtwdev, pkt_info, skb);
 
 	/* TODO: need to change hw port and hw ssn sel for multiple vifs */
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 56371eff9f7ff..8419603adce4a 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -33,6 +33,10 @@
 	le32p_replace_bits((__le32 *)(txdesc) + 0x05, value, GENMASK(6, 5))
 #define SET_TX_DESC_SW_SEQ(txdesc, value)                                      \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x09, value, GENMASK(23, 12))
+#define SET_TX_DESC_TIM_EN(txdesc, value)                                      \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x09, value, BIT(7))
+#define SET_TX_DESC_TIM_OFFSET(txdesc, value)                                  \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x09, value, GENMASK(6, 0))
 #define SET_TX_DESC_MAX_AGG_NUM(txdesc, value)                                 \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, GENMASK(21, 17))
 #define SET_TX_DESC_USE_RTS(tx_desc, value)                                    \
-- 
2.25.1

