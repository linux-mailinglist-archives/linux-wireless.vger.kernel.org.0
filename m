Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36E481804
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Dec 2021 02:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbhL3BQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Dec 2021 20:16:44 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37070 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhL3BQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Dec 2021 20:16:43 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BU1GKn74027120, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BU1GKn74027120
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Dec 2021 09:16:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Dec 2021 09:16:20 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 30 Dec
 2021 09:16:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <rgoldwyn@suse.com>
Subject: [PATCH 1/2] rtw89: limit RX status rate of VHT to MCS 9
Date:   Thu, 30 Dec 2021 09:16:06 +0800
Message-ID: <20211230011607.8823-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/30/2021 00:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzI5IKRVpMggMTA6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852AE can receive packets with VHT MCS10/11 that is out of specification,
so mac80211 warns and drops the packets, and it leads low TCP throughput.

  Rate marked as a VHT rate but data is invalid: MCS: 10, NSS: 2
  WARNING: CPU: 1 PID: 7817 at net/mac80211/rx.c:4856 ieee80211_rx_list+0x223/0x2f0 [mac80211]

Therefore, limit the report rate to VHT MCS9. Meanwhile, we want to know
we have received this kind of packets, so show the counter of VHT MCS10/11
in debugfs, like:

  TP TX: 1 [1] Mbps (lv: 1), RX: 460 [438] Mbps (lv: 4)
  Beacon: 18
  Avg packet length: TX=96, RX=3083
  RX count:
     Legacy: [0, 0, 0, 0]
       OFDM: [0, 0, 0, 0, 0, 0, 0, 0]
       HT 0: [0, 0, 0, 0, 0, 0, 0, 0]
       HT 1: [0, 0, 0, 0, 0, 0, 0, 0]
    VHT 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
    VHT 2SS: [0, 0, 0, 0, 0, 0, 24, 718, 4591, 31564][418, 0]
     HE 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
     HE 2ss: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  TX rate [0]: VHT 2SS MCS-9 SGI	(hw_rate=0x119)	==> agg_wait=1 (3500)
  RX rate [0]: VHT 2SS MCS-9 SGI	(hw_rate=0x119)
  RSSI: -28 dBm (raw=165, prev=163)

Buglink: https://bugzilla.suse.com/show_bug.cgi?id=1192891
Reported-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw89/debug.c | 22 ++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 00ae86807dc21..4ab12f20eacdc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1062,6 +1062,16 @@ static void rtw89_core_rx_stats(struct rtw89_dev *rtwdev,
 	rtw89_iterate_vifs_bh(rtwdev, rtw89_vif_rx_stats_iter, &iter_data);
 }
 
+static void rtw89_core_correct_vht_rate(struct ieee80211_rx_status *rx_status)
+{
+	/* Our hardware can receive the VHT packet with rate higher than MCS 9.
+	 * This kind of packet is out of specification and dropped by mac80211,
+	 * and it leads very low TCP throughput.
+	 */
+	if (rx_status->encoding == RX_ENC_VHT && rx_status->rate_idx > 9)
+		rx_status->rate_idx = 9;
+}
+
 static void rtw89_correct_cck_chan(struct rtw89_dev *rtwdev,
 				   struct ieee80211_rx_status *status)
 {
@@ -1106,6 +1116,7 @@ static void rtw89_core_rx_pending_skb(struct rtw89_dev *rtwdev,
 		rtw89_correct_cck_chan(rtwdev, rx_status);
 		rtw89_core_hw_to_sband_rate(rx_status);
 		rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
+		rtw89_core_correct_vht_rate(rx_status);
 		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
 		rtwdev->napi_budget_countdown--;
 	}
@@ -1334,6 +1345,7 @@ static void rtw89_core_flush_ppdu_rx_queue(struct rtw89_dev *rtwdev,
 		rx_status = IEEE80211_SKB_RXCB(skb_ppdu);
 		rtw89_core_hw_to_sband_rate(rx_status);
 		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb_ppdu);
+		rtw89_core_correct_vht_rate(rx_status);
 		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
 		rtwdev->napi_budget_countdown--;
 	}
@@ -1367,6 +1379,7 @@ void rtw89_core_rx(struct rtw89_dev *rtwdev,
 	} else {
 		rtw89_core_hw_to_sband_rate(rx_status);
 		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb);
+		rtw89_core_correct_vht_rate(rx_status);
 		ieee80211_rx_napi(rtwdev->hw, NULL, skb, &rtwdev->napi);
 		rtwdev->napi_budget_countdown--;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 9756d75ef24e1..fb2f4870172d9 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2322,16 +2322,17 @@ rtw89_debug_append_rx_rate(struct seq_file *m, struct rtw89_pkt_stat *pkt_stat,
 static const struct rtw89_rx_rate_cnt_info {
 	enum rtw89_hw_rate first_rate;
 	int len;
+	int ext;
 	const char *rate_mode;
 } rtw89_rx_rate_cnt_infos[] = {
-	{RTW89_HW_RATE_CCK1, 4, "Legacy:"},
-	{RTW89_HW_RATE_OFDM6, 8, "OFDM:"},
-	{RTW89_HW_RATE_MCS0, 8, "HT 0:"},
-	{RTW89_HW_RATE_MCS8, 8, "HT 1:"},
-	{RTW89_HW_RATE_VHT_NSS1_MCS0, 10, "VHT 1SS:"},
-	{RTW89_HW_RATE_VHT_NSS2_MCS0, 10, "VHT 2SS:"},
-	{RTW89_HW_RATE_HE_NSS1_MCS0, 12, "HE 1SS:"},
-	{RTW89_HW_RATE_HE_NSS2_MCS0, 12, "HE 2ss:"},
+	{RTW89_HW_RATE_CCK1, 4, 0, "Legacy:"},
+	{RTW89_HW_RATE_OFDM6, 8, 0, "OFDM:"},
+	{RTW89_HW_RATE_MCS0, 8, 0, "HT 0:"},
+	{RTW89_HW_RATE_MCS8, 8, 0, "HT 1:"},
+	{RTW89_HW_RATE_VHT_NSS1_MCS0, 10, 2, "VHT 1SS:"},
+	{RTW89_HW_RATE_VHT_NSS2_MCS0, 10, 2, "VHT 2SS:"},
+	{RTW89_HW_RATE_HE_NSS1_MCS0, 12, 0, "HE 1SS:"},
+	{RTW89_HW_RATE_HE_NSS2_MCS0, 12, 0, "HE 2ss:"},
 };
 
 static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
@@ -2356,6 +2357,11 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 		seq_printf(m, "%10s [", info->rate_mode);
 		rtw89_debug_append_rx_rate(m, pkt_stat,
 					   info->first_rate, info->len);
+		if (info->ext) {
+			seq_puts(m, "][");
+			rtw89_debug_append_rx_rate(m, pkt_stat,
+						   info->first_rate + info->len, info->ext);
+		}
 		seq_puts(m, "]\n");
 	}
 
-- 
2.25.1

