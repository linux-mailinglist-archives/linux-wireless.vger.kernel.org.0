Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3287F4CF191
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiCGGHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiCGGG7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:06:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E75F269
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:06:05 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22765wPS2022581, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22765wPS2022581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:05:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 14:05:57 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:05:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 07/13] rtw89: add hci_func_en_addr to support variant generation
Date:   Mon, 7 Mar 2022 14:04:51 +0800
Message-ID: <20220307060457.56789-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307060457.56789-1-pkshih@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/07/2022 05:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNyCkV6TIIDAzOjQ5OjAw?=
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

The HCI_FUNC_EN address of 8852C is different from existing chipset, so
add a chip_info::hci_func_en_addr to fill the address individually.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 2 ++
 drivers/net/wireless/realtek/rtw89/mac.c      | 4 +++-
 drivers/net/wireless/realtek/rtw89/reg.h      | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1338c08d7bd39..18e38cc3a6d22 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2282,6 +2282,8 @@ struct rtw89_chip_info {
 	u8 rf_para_dlink_num;
 	const struct rtw89_btc_rf_trx_para *rf_para_dlink;
 	u8 ps_mode_supported;
+
+	u32 hci_func_en_addr;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d202ee761e902..9ba47a72812f9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2619,7 +2619,9 @@ static int rtw89_mac_fw_dl_pre_init(struct rtw89_dev *rtwdev)
 
 static void rtw89_mac_hci_func_en(struct rtw89_dev *rtwdev)
 {
-	rtw89_write32_set(rtwdev, R_AX_HCI_FUNC_EN,
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	rtw89_write32_set(rtwdev, chip->hci_func_en_addr,
 			  B_AX_HCI_TXDMA_EN | B_AX_HCI_RXDMA_EN);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bb95e524d67be..86b18dbbc7691 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -217,6 +217,8 @@
 #define B_AX_ASFF_FULL_NO_STK BIT(1)
 #define B_AX_EN_STUCK_DBG BIT(0)
 
+#define R_AX_HCI_FUNC_EN_V1 0x7880
+
 #define R_AX_PHYREG_SET 0x8040
 #define PHYREG_SET_ALL_CYCLE 0x8
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 1448214d6241b..86a5808a76c80 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2057,6 +2057,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
+	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index cb4bcb85c4185..3fa2dd4ff514c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -194,6 +194,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
+	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

