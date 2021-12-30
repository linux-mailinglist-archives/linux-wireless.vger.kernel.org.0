Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDE481805
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Dec 2021 02:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhL3BQq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Dec 2021 20:16:46 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37071 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhL3BQq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Dec 2021 20:16:46 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BU1GQstC027132, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BU1GQstC027132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Dec 2021 09:16:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 09:16:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 30 Dec
 2021 09:16:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <rgoldwyn@suse.com>
Subject: [PATCH 2/2] rtw89: encapsulate RX handlers to single function
Date:   Thu, 30 Dec 2021 09:16:07 +0800
Message-ID: <20211230011607.8823-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211230011607.8823-1-pkshih@realtek.com>
References: <20211230011607.8823-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We have three points to receive packets to mac80211 with three different
kinds of status. Many handlers are common and can be shared, so I move
them together, and I don't change the logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 36 +++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4ab12f20eacdc..ddbefd3d93584 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1095,6 +1095,19 @@ static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
 	rx_status->rate_idx -= 4;
 }
 
+static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
+				      struct rtw89_rx_phy_ppdu *phy_ppdu,
+				      struct rtw89_rx_desc_info *desc_info,
+				      struct sk_buff *skb_ppdu,
+				      struct ieee80211_rx_status *rx_status)
+{
+	rtw89_core_hw_to_sband_rate(rx_status);
+	rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
+	rtw89_core_correct_vht_rate(rx_status);
+	ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
+	rtwdev->napi_budget_countdown--;
+}
+
 static void rtw89_core_rx_pending_skb(struct rtw89_dev *rtwdev,
 				      struct rtw89_rx_phy_ppdu *phy_ppdu,
 				      struct rtw89_rx_desc_info *desc_info,
@@ -1114,11 +1127,7 @@ static void rtw89_core_rx_pending_skb(struct rtw89_dev *rtwdev,
 		if (rtw89_core_rx_ppdu_match(rtwdev, desc_info, rx_status))
 			rtw89_chip_query_ppdu(rtwdev, phy_ppdu, rx_status);
 		rtw89_correct_cck_chan(rtwdev, rx_status);
-		rtw89_core_hw_to_sband_rate(rx_status);
-		rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
-		rtw89_core_correct_vht_rate(rx_status);
-		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
-		rtwdev->napi_budget_countdown--;
+		rtw89_core_rx_to_mac80211(rtwdev, phy_ppdu, desc_info, skb_ppdu, rx_status);
 	}
 }
 
@@ -1343,11 +1352,7 @@ static void rtw89_core_flush_ppdu_rx_queue(struct rtw89_dev *rtwdev,
 	skb_queue_walk_safe(&ppdu_sts->rx_queue[band], skb_ppdu, tmp) {
 		skb_unlink(skb_ppdu, &ppdu_sts->rx_queue[band]);
 		rx_status = IEEE80211_SKB_RXCB(skb_ppdu);
-		rtw89_core_hw_to_sband_rate(rx_status);
-		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb_ppdu);
-		rtw89_core_correct_vht_rate(rx_status);
-		ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, &rtwdev->napi);
-		rtwdev->napi_budget_countdown--;
+		rtw89_core_rx_to_mac80211(rtwdev, NULL, desc_info, skb_ppdu, rx_status);
 	}
 }
 
@@ -1374,15 +1379,10 @@ void rtw89_core_rx(struct rtw89_dev *rtwdev,
 	memset(rx_status, 0, sizeof(*rx_status));
 	rtw89_core_update_rx_status(rtwdev, desc_info, rx_status);
 	if (desc_info->long_rxdesc &&
-	    BIT(desc_info->frame_type) & PPDU_FILTER_BITMAP) {
+	    BIT(desc_info->frame_type) & PPDU_FILTER_BITMAP)
 		skb_queue_tail(&ppdu_sts->rx_queue[band], skb);
-	} else {
-		rtw89_core_hw_to_sband_rate(rx_status);
-		rtw89_core_rx_stats(rtwdev, NULL, desc_info, skb);
-		rtw89_core_correct_vht_rate(rx_status);
-		ieee80211_rx_napi(rtwdev->hw, NULL, skb, &rtwdev->napi);
-		rtwdev->napi_budget_countdown--;
-	}
+	else
+		rtw89_core_rx_to_mac80211(rtwdev, NULL, desc_info, skb, rx_status);
 }
 EXPORT_SYMBOL(rtw89_core_rx);
 
-- 
2.25.1

