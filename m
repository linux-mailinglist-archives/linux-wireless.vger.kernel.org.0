Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71BB487166
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiAGDnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:46 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51130 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345911AbiAGDnd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:33 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hST41023056, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hST41023056
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:43:28 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 19/19] rtw89: declare AP mode support
Date:   Fri, 7 Jan 2022 11:42:39 +0800
Message-ID: <20220107034239.22002-20-pkshih@realtek.com>
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

Things are ready for AP mode, so declare this driver can support it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d23bd87661d7a..10eb575b05be0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2561,7 +2561,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ieee80211_hw_set(hw, SUPPORTS_PS);
 	ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
 
-	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION);
+	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				     BIT(NL80211_IFTYPE_AP);
 	hw->wiphy->available_antennas_tx = BIT(rtwdev->chip->rf_path_num) - 1;
 	hw->wiphy->available_antennas_rx = BIT(rtwdev->chip->rf_path_num) - 1;
 
-- 
2.25.1

