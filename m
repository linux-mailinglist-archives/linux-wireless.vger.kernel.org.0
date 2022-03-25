Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77A44E6E04
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358399AbiCYGDt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358395AbiCYGDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C66C682B
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P627PB0011081, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P627PB0011081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 14:02:07 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 07/16] rtw89: pci: add L1 settings
Date:   Fri, 25 Mar 2022 14:00:46 +0800
Message-ID: <20220325060055.58482-8-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Configure L1 settings of enter and exit.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 5112b2d443c3e..dcf907b81cffa 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1935,6 +1935,22 @@ static void rtw89_pci_gen2_force_ib(struct rtw89_dev *rtwdev)
 			  B_AX_SYSON_DIS_PMCR_AX_WRMSK);
 }
 
+static void rtw89_pci_l1_ent_lat(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->chip->chip_id != RTL8852C)
+		return;
+
+	rtw89_write32_clr(rtwdev, R_AX_PCIE_PS_CTRL_V1, B_AX_SEL_REQ_ENTR_L1);
+}
+
+static void rtw89_pci_wd_exit_l1(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->chip->chip_id != RTL8852C)
+		return;
+
+	rtw89_write32_set(rtwdev, R_AX_PCIE_PS_CTRL_V1, B_AX_DMAC0_EXIT_L1_EN);
+}
+
 static void rtw89_pci_set_sic(struct rtw89_dev *rtwdev)
 {
 	if (rtwdev->chip->chip_id == RTL8852C)
@@ -2228,6 +2244,8 @@ static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 	rtw89_pci_autoload_hang(rtwdev);
 	rtw89_pci_l12_vmain(rtwdev);
 	rtw89_pci_gen2_force_ib(rtwdev);
+	rtw89_pci_l1_ent_lat(rtwdev);
+	rtw89_pci_wd_exit_l1(rtwdev);
 	rtw89_pci_set_sic(rtwdev);
 	rtw89_pci_set_lbc(rtwdev);
 	rtw89_pci_set_io_rcy(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 805fc3e8c1a4a..a085d1f27a120 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -38,6 +38,13 @@
 #define R_AX_MDIO_WDATA			0x10A4
 #define R_AX_MDIO_RDATA			0x10A6
 
+#define R_AX_PCIE_PS_CTRL_V1		0x3008
+#define B_AX_CMAC_EXIT_L1_EN		BIT(7)
+#define B_AX_DMAC0_EXIT_L1_EN		BIT(6)
+#define B_AX_SEL_XFER_PENDING		BIT(3)
+#define B_AX_SEL_REQ_ENTR_L1		BIT(2)
+#define B_AX_SEL_REQ_EXIT_L1		BIT(0)
+
 #define R_AX_PCIE_BG_CLR		0x303C
 #define B_AX_BG_CLR_ASYNC_M3		BIT(4)
 
-- 
2.25.1

