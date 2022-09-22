Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC965E57BB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 03:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIVBFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Sep 2022 21:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIVBFf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Sep 2022 21:05:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF81480481
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 18:05:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28M14wTxA019413, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28M14wTxA019413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 22 Sep 2022 09:04:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Sep 2022 09:05:22 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 22 Sep
 2022 09:05:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: support WMM-PS in P2P GO mode
Date:   Thu, 22 Sep 2022 09:04:34 +0800
Message-ID: <20220922010435.12167-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922010435.12167-1-pkshih@realtek.com>
References: <20220922010435.12167-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/22/2022 00:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjEgpFWkyCAxMDo1MjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dian-Syuan Yang <dian_syuan0116@realtek.com>

To handle a connected client using WMM-PS, the P2P GO also need to enable
this power save mechanism.

We add WIPHY_FLAG_AP_UAPSD flag to support it and define maximum number
of buffered frames the WMM GO may deliver to the WMM client.

Signed-off-by: Dian-Syuan Yang <dian_syuan0116@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 87938c9e24e17..25f759a8a5c59 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3227,6 +3227,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->queues = IEEE80211_NUM_ACS;
 	hw->max_rx_aggregation_subframes = RTW89_MAX_RX_AGG_NUM;
 	hw->max_tx_aggregation_subframes = RTW89_MAX_TX_AGG_NUM;
+	hw->uapsd_max_sp_len = IEEE80211_WMM_IE_STA_QOSINFO_SP_ALL;
 
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
@@ -3251,7 +3252,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	hw->wiphy->available_antennas_rx = BIT(rtwdev->chip->rf_path_num) - 1;
 
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
-			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
+			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP |
+			    WIPHY_FLAG_AP_UAPSD;
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
 	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
-- 
2.25.1

