Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871A62D58B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 09:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbiKQIxe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 03:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239694AbiKQIxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 03:53:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34D82104
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 00:53:23 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AH8qYLp9027725, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AH8qYLp9027725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 17 Nov 2022 16:52:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 17 Nov 2022 16:53:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 17 Nov
 2022 16:53:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: avoid inaccessible IO operations during doing change_interface()
Date:   Thu, 17 Nov 2022 16:52:35 +0800
Message-ID: <20221117085235.53777-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/17/2022 08:39:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRXpMggMDY6NTY6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During doing change_interface(), hardware is power-off, so some components
are inaccessible and return error. This causes things unexpected, and we
don't have a warning message for that. So, ignore some IO operations in
this situation, and add a warning message to indicate something wrong.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  7 +++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 11 ++++++++++-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b60de6662548b..dfd0ba8cb5772 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2959,6 +2959,7 @@ enum rtw89_flags {
 	RTW89_FLAG_CRASH_SIMULATING,
 	RTW89_FLAG_WOWLAN,
 	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
+	RTW89_FLAG_CHANGING_INTERFACE,
 
 	NUM_OF_RTW89_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ecd603a881345..6587cdf6ba624 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3600,6 +3600,13 @@ int rtw89_mac_set_macid_pause(struct rtw89_dev *rtwdev, u8 macid, bool pause)
 	u8 grp = macid >> 5;
 	int ret;
 
+	/* If this is called by change_interface() in the case of P2P, it could
+	 * be power-off, so ignore this operation.
+	 */
+	if (test_bit(RTW89_FLAG_CHANGING_INTERFACE, rtwdev->flags) &&
+	    !test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
+		return 0;
+
 	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 6e79bf899901d..ce980d2f22c46 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -174,6 +174,9 @@ static int rtw89_ops_change_interface(struct ieee80211_hw *hw,
 				      enum nl80211_iftype type, bool p2p)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
+	int ret;
+
+	set_bit(RTW89_FLAG_CHANGING_INTERFACE, rtwdev->flags);
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "change vif %pM (%d)->(%d), p2p (%d)->(%d)\n",
 		    vif->addr, vif->type, type, vif->p2p, p2p);
@@ -183,7 +186,13 @@ static int rtw89_ops_change_interface(struct ieee80211_hw *hw,
 	vif->type = type;
 	vif->p2p = p2p;
 
-	return rtw89_ops_add_interface(hw, vif);
+	ret = rtw89_ops_add_interface(hw, vif);
+	if (ret)
+		rtw89_warn(rtwdev, "failed to change interface %d\n", ret);
+
+	clear_bit(RTW89_FLAG_CHANGING_INTERFACE, rtwdev->flags);
+
+	return ret;
 }
 
 static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
-- 
2.25.1

