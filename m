Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA24B542F3D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiFHLdN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiFHLdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 07:33:11 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173331BC79E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 04:33:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 258BWsFyA008932, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 258BWsFyA008932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 8 Jun 2022 19:32:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 8 Jun 2022 19:32:54 +0800
Received: from localhost (172.16.16.197) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 8 Jun
 2022 19:32:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <echuang@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH v2 2/3] rtw89: 8852c: add trigger frame counter
Date:   Wed, 8 Jun 2022 19:32:23 +0800
Message-ID: <20220608113224.11193-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608113224.11193-1-pkshih@realtek.com>
References: <20220608113224.11193-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.197]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/08/2022 11:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvOCCkV6TIIDA5OjMxOjAw?=
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

From: Po Hao Huang <phhuang@realtek.com>

Adding this allows us to maintain trigger frame statistics, which is
required for our CFO tracking decisions.

Signed-off-by: Po Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 48 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h  | 14 +++++++
 drivers/net/wireless/realtek/rtw89/debug.c |  3 +-
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4df81f00c2211..d2f2a3d65ef6f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1343,6 +1343,47 @@ struct rtw89_vif_rx_stats_iter_data {
 	const u8 *bssid;
 };
 
+static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
+				      struct ieee80211_vif *vif,
+				      struct sk_buff *skb)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct ieee80211_trigger *tf = (struct ieee80211_trigger *)skb->data;
+	u8 *pos, *end, type;
+	u16 aid;
+
+	if (!ether_addr_equal(vif->bss_conf.bssid, tf->ta) ||
+	    rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION ||
+	    rtwvif->net_type == RTW89_NET_TYPE_NO_LINK)
+		return;
+
+	type = le64_get_bits(tf->common_info, IEEE80211_TRIGGER_TYPE_MASK);
+	if (type != IEEE80211_TRIGGER_TYPE_BASIC)
+		return;
+
+	end = (u8 *)tf + skb->len;
+	pos = tf->variable;
+
+	while (end - pos >= RTW89_TF_BASIC_USER_INFO_SZ) {
+		aid = RTW89_GET_TF_USER_INFO_AID12(pos);
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+			    "[TF] aid: %d, ul_mcs: %d, rua: %d\n",
+			    aid, RTW89_GET_TF_USER_INFO_UL_MCS(pos),
+			    RTW89_GET_TF_USER_INFO_RUA(pos));
+
+		if (aid == RTW89_TF_PAD)
+			break;
+
+		if (aid == vif->bss_conf.aid) {
+			rtwvif->stats.rx_tf_acc++;
+			rtwdev->stats.rx_tf_acc++;
+			break;
+		}
+
+		pos += RTW89_TF_BASIC_USER_INFO_SZ;
+	}
+}
+
 static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 				    struct ieee80211_vif *vif)
 {
@@ -1355,6 +1396,11 @@ static void rtw89_vif_rx_stats_iter(void *data, u8 *mac,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	const u8 *bssid = iter_data->bssid;
 
+	if (ieee80211_is_trigger(hdr->frame_control)) {
+		rtw89_stats_trigger_frame(rtwdev, vif, skb);
+		return;
+	}
+
 	if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
 		return;
 
@@ -2023,6 +2069,8 @@ static bool rtw89_traffic_stats_calc(struct rtw89_dev *rtwdev,
 	stats->rx_unicast = 0;
 	stats->tx_cnt = 0;
 	stats->rx_cnt = 0;
+	stats->rx_tf_periodic = stats->rx_tf_acc;
+	stats->rx_tf_acc = 0;
 
 	if (tx_tfc_lv != stats->tx_tfc_lv || rx_tfc_lv != stats->rx_tfc_lv)
 		return true;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 6dd341f3fd33e..1fa6fe8b99530 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -55,6 +55,16 @@ enum htc_om_channel_width {
 #define RTW89_HTC_MASK_HTC_OM_DL_MU_MIMO_RR BIT(16)
 #define RTW89_HTC_MASK_HTC_OM_UL_MU_DATA_DIS BIT(17)
 
+#define RTW89_TF_PAD GENMASK(11, 0)
+#define RTW89_TF_BASIC_USER_INFO_SZ 6
+
+#define RTW89_GET_TF_USER_INFO_AID12(data)	\
+	le32_get_bits(*((const __le32 *)(data)), GENMASK(11, 0))
+#define RTW89_GET_TF_USER_INFO_RUA(data)	\
+	le32_get_bits(*((const __le32 *)(data)), GENMASK(19, 12))
+#define RTW89_GET_TF_USER_INFO_UL_MCS(data)	\
+	le32_get_bits(*((const __le32 *)(data)), GENMASK(24, 21))
+
 enum rtw89_subband {
 	RTW89_CH_2G = 0,
 	RTW89_CH_5G_BAND_1 = 1,
@@ -943,6 +953,10 @@ struct rtw89_traffic_stats {
 	u32 rx_throughput;
 	u32 tx_throughput_raw;
 	u32 rx_throughput_raw;
+
+	u32 rx_tf_acc;
+	u32 rx_tf_periodic;
+
 	enum rtw89_tfc_lv tx_tfc_lv;
 	enum rtw89_tfc_lv rx_tfc_lv;
 	struct ewma_tp tx_ewma_tp;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 7820bc3ab3b47..f00f81916f2f5 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2376,7 +2376,8 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 	seq_printf(m, "TP TX: %u [%u] Mbps (lv: %d), RX: %u [%u] Mbps (lv: %d)\n",
 		   stats->tx_throughput, stats->tx_throughput_raw, stats->tx_tfc_lv,
 		   stats->rx_throughput, stats->rx_throughput_raw, stats->rx_tfc_lv);
-	seq_printf(m, "Beacon: %u\n", pkt_stat->beacon_nr);
+	seq_printf(m, "Beacon: %u, TF: %u\n", pkt_stat->beacon_nr,
+		   stats->rx_tf_periodic);
 	seq_printf(m, "Avg packet length: TX=%u, RX=%u\n", stats->tx_avg_len,
 		   stats->rx_avg_len);
 
-- 
2.25.1

