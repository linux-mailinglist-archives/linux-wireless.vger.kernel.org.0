Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562625EBA9F
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiI0G2L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiI0G2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7651A857C7
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:27:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6QfWP2008380, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6QfWP2008380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:27:06 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/9] wifi: rtw89: mac: define DMA channel mask to avoid unsupported channels
Date:   Tue, 27 Sep 2022 14:26:04 +0800
Message-ID: <20220927062611.30484-3-pkshih@realtek.com>
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

Six channels are unsupported by 8852b, so mask them out to prevent to
access undefined registers in this chip.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  6 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 5 files changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b.c

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c0f798ad60c2a..b8b143c528358 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2716,6 +2716,7 @@ struct rtw89_chip_info {
 	u8 dcfo_comp_sft;
 	const struct rtw89_imr_info *imr_info;
 	const struct rtw89_rrsr_cfgs *rrsr_cfgs;
+	u32 dma_ch_mask;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6f2fba6c32bfe..9b75d9645580f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -827,6 +827,8 @@ static void hfc_func_en(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
 
 static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 dma_ch_mask = chip->dma_ch_mask;
 	u8 ch;
 	u32 ret = 0;
 
@@ -848,6 +850,8 @@ static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
 	}
 
 	for (ch = RTW89_DMA_ACH0; ch < RTW89_DMA_H2C; ch++) {
+		if (dma_ch_mask & BIT(ch))
+			continue;
 		ret = hfc_ch_ctrl(rtwdev, ch);
 		if (ret)
 			return ret;
@@ -863,6 +867,8 @@ static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
 		udelay(10);
 	}
 	for (ch = RTW89_DMA_ACH0; ch < RTW89_DMA_H2C; ch++) {
+		if (dma_ch_mask & BIT(ch))
+			continue;
 		ret = hfc_upd_ch_info(rtwdev, ch);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index be3ec41dc55c0..124e63fe69681 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2281,6 +2281,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dcfo_comp_sft		= 3,
 	.imr_info		= &rtw8852a_imr_info,
 	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
+	.dma_ch_mask		= 0,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
new file mode 100644
index 0000000000000..f951b8f0b5cfc
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#include "core.h"
+
+const struct rtw89_chip_info rtw8852b_chip_info = {
+	.chip_id		= RTL8852B,
+	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
+				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
+				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
+};
+EXPORT_SYMBOL(rtw8852b_chip_info);
+
+MODULE_FIRMWARE("rtw89/rtw8852b_fw.bin");
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8852B driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 5dff65dbc142b..8c242d21e5fa4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3132,6 +3132,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dcfo_comp_sft		= 5,
 	.imr_info		= &rtw8852c_imr_info,
 	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
+	.dma_ch_mask		= 0,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

