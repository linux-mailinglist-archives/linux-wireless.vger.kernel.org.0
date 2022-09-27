Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126B25EBA9A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiI0G2E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiI0G2B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 640E1857E5
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:27:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6QiLaA008395, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6QiLaA008395
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 27 Sep 2022 14:27:09 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/9] wifi: rtw89: pci: add to do PCI auto calibration
Date:   Tue, 27 Sep 2022 14:26:07 +0800
Message-ID: <20220927062611.30484-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927062611.30484-1-pkshih@realtek.com>
References: <20220927062611.30484-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/27/2022 06:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjcgpFekyCAwNDo1MzowMA==?=
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

8852be needs this with n times calibration to correct hardware clock.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 957f4e550a7ef..b52edf2cf7434 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1874,6 +1874,18 @@ __get_target(struct rtw89_dev *rtwdev, u16 *target, enum rtw89_pcie_phy phy_rate
 	return 0;
 }
 
+static int rtw89_pci_autok_x(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	if (rtwdev->chip->chip_id != RTL8852B)
+		return 0;
+
+	ret = rtw89_write16_mdio_mask(rtwdev, RAC_REG_FLD_0, BAC_AUTOK_N_MASK,
+				      PCIE_AUTOK_4, PCIE_PHY_GEN1);
+	return ret;
+}
+
 static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
 {
 	enum rtw89_pcie_phy phy_rate;
@@ -2452,6 +2464,12 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	rtw89_pci_hci_ldo(rtwdev);
 	rtw89_pci_dphy_delay(rtwdev);
 
+	ret = rtw89_pci_autok_x(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR] pcie autok_x fail %d\n", ret);
+		return ret;
+	}
+
 	ret = rtw89_pci_auto_refclk_cal(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR] pcie autok fail %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index e49ffc9cf7903..179740607778a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -23,6 +23,9 @@
 #define PCIE_DPHY_DLY_25US		0x1
 #define RAC_ANA19			0x19
 #define B_PCIE_BIT_RD_SEL		BIT(2)
+#define RAC_REG_FLD_0			0x1D
+#define BAC_AUTOK_N_MASK		GENMASK(3, 2)
+#define PCIE_AUTOK_4			0x3
 #define RAC_ANA1F			0x1F
 #define RAC_ANA24			0x24
 #define B_AX_DEGLITCH			GENMASK(11, 8)
-- 
2.25.1

