Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F807DDD17
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 08:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjKAHWp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 03:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjKAHWn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 03:22:43 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528D5C2
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 00:22:41 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A17MWjsC1220515, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A17MWjsC1220515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:22:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Nov 2023 15:22:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 1 Nov 2023
 15:22:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: pci: use gen_def pointer to configure mac_{pre,post}_init and clear PCI ring index
Date:   Wed, 1 Nov 2023 15:21:46 +0800
Message-ID: <20231101072149.21997-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101072149.21997-1-pkshih@realtek.com>
References: <20231101072149.21997-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use gen_def pointer to call three WiFi 6 specific functions, and add _ax
suffix to them. Then, we will implement functions for WiFi 7 chips later.

The mac_{pre,post}_init are used to initialize PCI during doing MAC
initialization, and clear PCI ring index to make index consistent between
driver, firmware and hardware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 10 ++++++---
 drivers/net/wireless/realtek/rtw89/pci.h | 28 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 411e9c270638..0384f46648e7 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2361,7 +2361,7 @@ static void rtw89_pci_set_keep_reg(struct rtw89_dev *rtwdev)
 			  B_AX_PCIE_TXRST_KEEP_REG | B_AX_PCIE_RXRST_KEEP_REG);
 }
 
-static void rtw89_pci_clr_idx_all(struct rtw89_dev *rtwdev)
+static void rtw89_pci_clr_idx_all_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
@@ -2549,7 +2549,7 @@ static int rtw89_pci_ops_deinit(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
+static int rtw89_pci_ops_mac_pre_init_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	int ret;
@@ -2706,7 +2706,7 @@ int rtw89_pci_ltr_set_v1(struct rtw89_dev *rtwdev, bool en)
 }
 EXPORT_SYMBOL(rtw89_pci_ltr_set_v1);
 
-static int rtw89_pci_ops_mac_post_init(struct rtw89_dev *rtwdev)
+static int rtw89_pci_ops_mac_post_init_ax(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
@@ -3854,6 +3854,10 @@ SIMPLE_DEV_PM_OPS(rtw89_pm_ops, rtw89_pci_suspend, rtw89_pci_resume);
 EXPORT_SYMBOL(rtw89_pm_ops);
 
 const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
+	.mac_pre_init = rtw89_pci_ops_mac_pre_init_ax,
+	.mac_post_init = rtw89_pci_ops_mac_post_init_ax,
+
+	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index f4662c7057ee..32e56938a170 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -923,6 +923,10 @@ struct rtw89_pci_bd_ram {
 };
 
 struct rtw89_pci_gen_def {
+	int (*mac_pre_init)(struct rtw89_dev *rtwdev);
+	int (*mac_post_init)(struct rtw89_dev *rtwdev);
+
+	void (*clr_idx_all)(struct rtw89_dev *rtwdev);
 };
 
 struct rtw89_pci_info {
@@ -1331,4 +1335,28 @@ void rtw89_chip_recognize_intrs(struct rtw89_dev *rtwdev,
 	info->recognize_intrs(rtwdev, rtwpci, isrs);
 }
 
+static inline int rtw89_pci_ops_mac_pre_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	return gen_def->mac_pre_init(rtwdev);
+}
+
+static inline int rtw89_pci_ops_mac_post_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	return gen_def->mac_post_init(rtwdev);
+}
+
+static inline void rtw89_pci_clr_idx_all(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
+
+	gen_def->clr_idx_all(rtwdev);
+}
+
 #endif
-- 
2.25.1

