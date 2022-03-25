Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD924E6E03
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358397AbiCYGDr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358390AbiCYGDq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7722C6821
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P626jZ4011068, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P626jZ4011068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:06 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 06/16] rtw89: pci: add deglitch setting
Date:   Fri, 25 Mar 2022 14:00:45 +0800
Message-ID: <20220325060055.58482-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

Add setting to support 8852ce.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 27 ++++++++++++++----------
 drivers/net/wireless/realtek/rtw89/pci.h |  3 +++
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 25d385be6e862..5112b2d443c3e 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1809,19 +1809,24 @@ static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
 
 static int rtw89_pci_deglitch_setting(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 
-	if (rtwdev->chip->chip_id != RTL8852A)
-		return 0;
-
-	ret = rtw89_write16_mdio_clr(rtwdev, RAC_ANA24, B_AX_DEGLITCH,
-				     PCIE_PHY_GEN1);
-	if (ret)
-		return ret;
-	ret = rtw89_write16_mdio_clr(rtwdev, RAC_ANA24, B_AX_DEGLITCH,
-				     PCIE_PHY_GEN2);
-	if (ret)
-		return ret;
+	if (chip_id == RTL8852A) {
+		ret = rtw89_write16_mdio_clr(rtwdev, RAC_ANA24, B_AX_DEGLITCH,
+					     PCIE_PHY_GEN1);
+		if (ret)
+			return ret;
+		ret = rtw89_write16_mdio_clr(rtwdev, RAC_ANA24, B_AX_DEGLITCH,
+					     PCIE_PHY_GEN2);
+		if (ret)
+			return ret;
+	} else if (chip_id == RTL8852C) {
+		rtw89_write16_clr(rtwdev, R_RAC_DIRECT_OFFSET_G1 + RAC_ANA24 * 2,
+				  B_AX_DEGLITCH);
+		rtw89_write16_clr(rtwdev, R_RAC_DIRECT_OFFSET_G2 + RAC_ANA24 * 2,
+				  B_AX_DEGLITCH);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 99f0cd2f47da2..805fc3e8c1a4a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -80,6 +80,9 @@
 #define R_AX_PCIE_WDT_TIMER_S1 0x3128
 #define B_AX_PCIE_WDT_TIMER_S1_MASK GENMASK(31, 0)
 
+#define R_RAC_DIRECT_OFFSET_G1 0x3800
+#define R_RAC_DIRECT_OFFSET_G2 0x3880
+
 #define RTW89_PCI_WR_RETRY_CNT		20
 
 /* Interrupts */
-- 
2.25.1

