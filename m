Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA794DD318
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiCRCet (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiCRCen (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A497C199E0C
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2XAuoC017631, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2XAuoC017631
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 18 Mar 2022 10:33:10 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 03/11] rtw89: regd: consider 6G band
Date:   Fri, 18 Mar 2022 10:32:06 +0800
Message-ID: <20220318023214.32411-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318023214.32411-1-pkshih@realtek.com>
References: <20220318023214.32411-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/18/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAxMjo0MDowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Wrap regd debug dump into a macro and add dump for 6G band field.
Extend the macro used to configure regd table to account for multiple
bands beyond 2G and 5G.

And the follow-up commit will configure the corresponding values for
6G band into regd table.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 37 +++++++++++------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 4c37e590e43c3..4d4bc201485b4 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -5,10 +5,9 @@
 #include "debug.h"
 #include "ps.h"
 
-#define COUNTRY_REGD(_alpha2, _txpwr_regd_2g, _txpwr_regd_5g) \
+#define COUNTRY_REGD(_alpha2, _txpwr_regd...) \
 	{.alpha2 = (_alpha2), \
-	 .txpwr_regd[RTW89_BAND_2G] = (_txpwr_regd_2g), \
-	 .txpwr_regd[RTW89_BAND_5G] = (_txpwr_regd_5g) \
+	 .txpwr_regd = {_txpwr_regd}, \
 	}
 
 static const struct rtw89_regulatory rtw89_ww_regd =
@@ -272,6 +271,17 @@ static bool rtw89_regd_is_ww(const struct rtw89_regulatory *regd)
 	return regd == &rtw89_ww_regd;
 }
 
+#define rtw89_debug_regd(_dev, _regd, _desc, _argv...) \
+do { \
+	typeof(_regd) __r = _regd; \
+	rtw89_debug(_dev, RTW89_DBG_REGD, _desc \
+		    ": %c%c: mapping txregd to {2g: %d, 5g: %d, 6g: %d}\n", \
+		    ##_argv, __r->alpha2[0], __r->alpha2[1], \
+		    __r->txpwr_regd[RTW89_BAND_2G], \
+		    __r->txpwr_regd[RTW89_BAND_5G], \
+		    __r->txpwr_regd[RTW89_BAND_6G]); \
+} while (0)
+
 int rtw89_regd_init(struct rtw89_dev *rtwdev,
 		    void (*reg_notifier)(struct wiphy *wiphy,
 					 struct regulatory_request *request))
@@ -294,20 +304,12 @@ int rtw89_regd_init(struct rtw89_dev *rtwdev,
 		if (ret)
 			rtw89_warn(rtwdev, "failed to hint regulatory:%d\n", ret);
 
-		rtw89_debug(rtwdev, RTW89_DBG_REGD,
-			    "efuse country code %c%c, mapping to 2g txregd %d, 5g txregd %d\n",
-			    rtwdev->efuse.country_code[0], rtwdev->efuse.country_code[1],
-			    rtwdev->regd->txpwr_regd[RTW89_BAND_2G],
-			    rtwdev->regd->txpwr_regd[RTW89_BAND_5G]);
-
+		rtw89_debug_regd(rtwdev, chip_regd, "efuse country code");
 		return 0;
 	}
-	rtw89_debug(rtwdev, RTW89_DBG_REGD,
-		    "worldwide roaming chip, follow the setting of stack(%c%c), mapping to 2g txregd %d, 5g txregd %d\n",
-		     rtwdev->regd->alpha2[0], rtwdev->regd->alpha2[1],
-		     rtwdev->regd->txpwr_regd[RTW89_BAND_2G],
-		     rtwdev->regd->txpwr_regd[RTW89_BAND_5G]);
 
+	rtw89_debug_regd(rtwdev, rtwdev->regd,
+			 "worldwide roaming chip, follow the setting of stack");
 	return 0;
 }
 
@@ -341,11 +343,8 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 		goto exit;
 	}
 	rtw89_regd_notifier_apply(rtwdev, wiphy, request);
-	rtw89_debug(rtwdev, RTW89_DBG_REGD,
-		    "get alpha2 %c%c from initiator %d, mapping to 2g txregd %d, 5g txregd %d\n",
-		    request->alpha2[0], request->alpha2[1], request->initiator,
-		    rtwdev->regd->txpwr_regd[RTW89_BAND_2G],
-		    rtwdev->regd->txpwr_regd[RTW89_BAND_5G]);
+	rtw89_debug_regd(rtwdev, rtwdev->regd, "get from initiator %d, alpha2",
+			 request->initiator);
 
 	rtw89_chip_set_txpwr(rtwdev);
 
-- 
2.25.1

