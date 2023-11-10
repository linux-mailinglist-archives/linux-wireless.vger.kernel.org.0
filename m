Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364FD7E767C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjKJBY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJBY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:26 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FDF182
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1OAsH41890518, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1OAsH41890518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Nov 2023 09:24:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: pci: reset BDRAM according to chip gen
Date:   Fri, 10 Nov 2023 09:23:13 +0800
Message-ID: <20231110012319.12727-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110012319.12727-1-pkshih@realtek.com>
References: <20231110012319.12727-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Configure callback of reset BDRAM (buffer descriptor RAM) by chip gen.
Refine the one of 802.11ax chip gen and drop a redundant duplicate of it
in 802.11ax chip gen. Then, assign right callback of rst_bdram for HCI ops
which needs to do callback according to chip gen.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 33 +++++----------------
 drivers/net/wireless/realtek/rtw89/pci.h    |  9 ++++++
 drivers/net/wireless/realtek/rtw89/pci_be.c |  1 +
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 74828dd37715..bac9ec2236da 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -19,22 +19,18 @@ MODULE_PARM_DESC(disable_clkreq, "Set Y to disable PCI clkreq support");
 MODULE_PARM_DESC(disable_aspm_l1, "Set Y to disable PCI ASPM L1 support");
 MODULE_PARM_DESC(disable_aspm_l1ss, "Set Y to disable PCI L1SS support");
 
-static int rtw89_pci_rst_bdram_pcie(struct rtw89_dev *rtwdev)
+static int rtw89_pci_rst_bdram_ax(struct rtw89_dev *rtwdev)
 {
 	u32 val;
 	int ret;
 
-	rtw89_write32(rtwdev, R_AX_PCIE_INIT_CFG1,
-		      rtw89_read32(rtwdev, R_AX_PCIE_INIT_CFG1) | B_AX_RST_BDRAM);
+	rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_RST_BDRAM);
 
 	ret = read_poll_timeout_atomic(rtw89_read32, val, !(val & B_AX_RST_BDRAM),
 				       1, RTW89_PCI_POLL_BDRAM_RST_CNT, false,
 				       rtwdev, R_AX_PCIE_INIT_CFG1);
 
-	if (ret)
-		return -EBUSY;
-
-	return 0;
+	return ret;
 }
 
 static u32 rtw89_pci_dma_recalc(struct rtw89_dev *rtwdev,
@@ -2608,7 +2604,7 @@ static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 	/* fill TRX BD indexes */
 	rtw89_pci_ops_reset(rtwdev);
 
-	ret = rtw89_pci_rst_bdram_pcie(rtwdev);
+	ret = rtw89_pci_rst_bdram_ax(rtwdev);
 	if (ret) {
 		rtw89_warn(rtwdev, "reset bdram busy\n");
 		return ret;
@@ -3691,22 +3687,6 @@ static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-
-
-static int rtw89_pci_rst_bdram(struct rtw89_dev *rtwdev)
-{
-	int ret = 0;
-	u32 val32, sts;
-
-	val32 = B_AX_RST_BDRAM;
-	rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1, val32);
-
-	ret = read_poll_timeout_atomic(rtw89_read32, sts,
-				       (sts & B_AX_RST_BDRAM) == 0x0, 1, 100,
-				       true, rtwdev, R_AX_PCIE_INIT_CFG1);
-	return ret;
-}
-
 static int rtw89_pci_lv1rst_start_dma(struct rtw89_dev *rtwdev)
 {
 	u32 ret;
@@ -3718,7 +3698,7 @@ static int rtw89_pci_lv1rst_start_dma(struct rtw89_dev *rtwdev)
 	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 	rtw89_pci_clr_idx_all(rtwdev);
 
-	ret = rtw89_pci_rst_bdram(rtwdev);
+	ret = rtw89_pci_rst_bdram_ax(rtwdev);
 	if (ret)
 		return ret;
 
@@ -3858,6 +3838,7 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
+	.rst_bdram = rtw89_pci_rst_bdram_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
@@ -3899,7 +3880,7 @@ static const struct rtw89_hci_ops rtw89_pci_ops = {
 	.clear		= rtw89_pci_clear_resource,
 	.disable_intr	= rtw89_pci_disable_intr_lock,
 	.enable_intr	= rtw89_pci_enable_intr_lock,
-	.rst_bdram	= rtw89_pci_rst_bdram_pcie,
+	.rst_bdram	= rtw89_pci_reset_bdram,
 };
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 37398e416e58..e3a4a6119660 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1041,6 +1041,7 @@ struct rtw89_pci_gen_def {
 	int (*mac_post_init)(struct rtw89_dev *rtwdev);
 
 	void (*clr_idx_all)(struct rtw89_dev *rtwdev);
+	int (*rst_bdram)(struct rtw89_dev *rtwdev);
 };
 
 struct rtw89_pci_info {
@@ -1475,4 +1476,12 @@ static inline void rtw89_pci_clr_idx_all(struct rtw89_dev *rtwdev)
 	gen_def->clr_idx_all(rtwdev);
 }
 
+static inline int rtw89_pci_reset_bdram(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	return gen_def->rst_bdram(rtwdev);
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index f3aab34a3a24..7d552b1a2d5e 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -425,5 +425,6 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.mac_post_init = rtw89_pci_ops_mac_post_init_be,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_be,
+	.rst_bdram = rtw89_pci_rst_bdram_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
-- 
2.25.1

