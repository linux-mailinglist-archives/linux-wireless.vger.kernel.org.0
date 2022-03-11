Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30E94D58A3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 04:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345901AbiCKDE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 22:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbiCKDE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 22:04:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF21162028
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 19:03:56 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B33nuF6021470, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B33nuF6021470
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 11:03:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Mar 2022 11:03:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 11:03:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH 02/11] rtw89: 8852c: add write/read crystal function in CFO tracking
Date:   Fri, 11 Mar 2022 11:02:52 +0800
Message-ID: <20220311030301.33921-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311030301.33921-1-pkshih@realtek.com>
References: <20220311030301.33921-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/11/2022 02:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTEgpFekyCAwMTowNjowMA==?=
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

From: Yuan-Han Zhang <yuanhan1020@realtek.com>

The CFO tracking algorithm is the same, but control methods are different.
Set parameters via xtal serial interfaces (SI).

Signed-off-by: Yuan-Han Zhang <yuanhan1020@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h |  2 ++
 drivers/net/wireless/realtek/rtw89/phy.c | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 2f707c817fa79..680b0eea31746 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -884,7 +884,9 @@ int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 
 enum rtw89_mac_xtal_si_offset {
 	XTAL_SI_XTAL_SC_XI = 0x04,
+#define XTAL_SC_XI_MASK		GENMASK(7, 0)
 	XTAL_SI_XTAL_SC_XO = 0x05,
+#define XTAL_SC_XO_MASK		GENMASK(7, 0)
 	XTAL_SI_PWR_CUT = 0x10,
 #define XTAL_SI_SMALL_PWR_CUT	BIT(0)
 #define XTAL_SI_BIG_PWR_CUT	BIT(1)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 6a7e08bdd00e7..b75d08697a224 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4,6 +4,7 @@
 
 #include "debug.h"
 #include "fw.h"
+#include "mac.h"
 #include "phy.h"
 #include "ps.h"
 #include "reg.h"
@@ -1667,15 +1668,25 @@ static void rtw89_phy_cfo_set_crystal_cap(struct rtw89_dev *rtwdev,
 					  u8 crystal_cap, bool force)
 {
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 sc_xi_val, sc_xo_val;
 
 	if (!force && cfo->crystal_cap == crystal_cap)
 		return;
 	crystal_cap = clamp_t(u8, crystal_cap, 0, 127);
-	rtw89_phy_cfo_set_xcap_reg(rtwdev, true, crystal_cap);
-	rtw89_phy_cfo_set_xcap_reg(rtwdev, false, crystal_cap);
-	sc_xo_val = rtw89_phy_cfo_get_xcap_reg(rtwdev, true);
-	sc_xi_val = rtw89_phy_cfo_get_xcap_reg(rtwdev, false);
+	if (chip->chip_id == RTL8852A) {
+		rtw89_phy_cfo_set_xcap_reg(rtwdev, true, crystal_cap);
+		rtw89_phy_cfo_set_xcap_reg(rtwdev, false, crystal_cap);
+		sc_xo_val = rtw89_phy_cfo_get_xcap_reg(rtwdev, true);
+		sc_xi_val = rtw89_phy_cfo_get_xcap_reg(rtwdev, false);
+	} else {
+		rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_SC_XO,
+					crystal_cap, XTAL_SC_XO_MASK);
+		rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_XTAL_SC_XI,
+					crystal_cap, XTAL_SC_XI_MASK);
+		rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_XTAL_SC_XO, &sc_xo_val);
+		rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_XTAL_SC_XI, &sc_xi_val);
+	}
 	cfo->crystal_cap = sc_xi_val;
 	cfo->x_cap_ofst = (s8)((int)cfo->crystal_cap - cfo->def_x_cap);
 
-- 
2.25.1

