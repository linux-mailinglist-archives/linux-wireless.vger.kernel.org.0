Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D633677A9
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 05:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDVDFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 23:05:12 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45289 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDVDFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 23:05:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13M34UJQ0021047, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13M34UJQ0021047
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 11:04:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 11:04:30 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 22 Apr
 2021 11:04:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <steventing@realtek.com>
Subject: [PATCH v2 1/2] rtw88: follow the AP basic rates for tx mgmt frame
Date:   Thu, 22 Apr 2021 11:04:12 +0800
Message-ID: <20210422030413.9738-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjEgpFWkyCAxMToyMzowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/22/2021 02:42:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163276 [Apr 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/22/2021 02:45:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/22/2021 02:46:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163276 [Apr 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/22/2021 02:50:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yu-Yen Ting <steventing@realtek.com>

By default the driver uses the 1M and 6M rate for managemnt frames
in 2G and 5G bands respectively. But when the basic rates is
configured from the mac80211, we need to send the management frames
according to the basic rates.

This commit makes the driver use the lowest basic rates to send
the management frames.

Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: move debugfs as a separated patch
v1: the original patch is "[PATCH 2/7] rtw88: follow the AP basic rates for tx mgmt frame"
---
 drivers/net/wireless/realtek/rtw88/tx.c | 26 ++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 0193708fc013..e5949a775283 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -233,17 +233,33 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 }
 
+static u8 rtw_get_mgmt_rate(struct rtw_dev *rtwdev, struct sk_buff *skb,
+			    u8 lowest_rate, bool ignore_rate)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = tx_info->control.vif;
+
+	if (!vif || !vif->bss_conf.basic_rates || ignore_rate)
+		return lowest_rate;
+
+	return __ffs(vif->bss_conf.basic_rates) + lowest_rate;
+}
+
 static void rtw_tx_pkt_info_update_rate(struct rtw_dev *rtwdev,
 					struct rtw_tx_pkt_info *pkt_info,
-					struct sk_buff *skb)
+					struct sk_buff *skb,
+					bool ignore_rate)
 {
 	if (rtwdev->hal.current_band_type == RTW_BAND_2G) {
 		pkt_info->rate_id = RTW_RATEID_B_20M;
-		pkt_info->rate = DESC_RATE1M;
+		pkt_info->rate = rtw_get_mgmt_rate(rtwdev, skb, DESC_RATE1M,
+						   ignore_rate);
 	} else {
 		pkt_info->rate_id = RTW_RATEID_G;
-		pkt_info->rate = DESC_RATE6M;
+		pkt_info->rate = rtw_get_mgmt_rate(rtwdev, skb, DESC_RATE6M,
+						   ignore_rate);
 	}
+
 	pkt_info->use_rate = true;
 	pkt_info->dis_rate_fallback = true;
 }
@@ -280,7 +296,7 @@ static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
 					struct ieee80211_sta *sta,
 					struct sk_buff *skb)
 {
-	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb);
+	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb, false);
 	pkt_info->dis_qselseq = true;
 	pkt_info->en_hwseq = true;
 	pkt_info->hw_ssn_sel = 0;
@@ -404,7 +420,7 @@ void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
 	if (type != RSVD_BEACON && type != RSVD_DUMMY)
 		pkt_info->qsel = TX_DESC_QSEL_MGMT;
 
-	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb);
+	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb, true);
 
 	bmc = is_broadcast_ether_addr(hdr->addr1) ||
 	      is_multicast_ether_addr(hdr->addr1);
-- 
2.21.0

