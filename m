Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA281487159
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345893AbiAGDnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:11 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51070 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345883AbiAGDnK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:10 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073h65T1022920, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073h65T1022920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:43:06 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/19] rtw89: allocate mac_id for each station in AP mode
Date:   Fri, 7 Jan 2022 11:42:26 +0800
Message-ID: <20220107034239.22002-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In station mode, mac_id of station is the same as rtwvif's one.
In AP mode, each station uses individual mac_id.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7fee45d8b82a1..3163c63091868 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1885,6 +1885,9 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev);
+	} else if (vif->type == NL80211_IFTYPE_AP) {
+		rtwsta->mac_id = rtw89_core_acquire_bit_map(rtwdev->mac_id_map,
+							    RTW89_MAX_MAC_ID_NUM);
 	}
 
 	return 0;
@@ -1997,6 +2000,8 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 	if (vif->type == NL80211_IFTYPE_STATION)
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
+	else if (vif->type == NL80211_IFTYPE_AP)
+		rtw89_core_release_bit_map(rtwdev->mac_id_map, rtwsta->mac_id);
 
 	return 0;
 }
-- 
2.25.1

