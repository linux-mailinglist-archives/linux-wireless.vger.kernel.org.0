Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731B44F806C
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 15:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbiDGNZo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbiDGNZm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 09:25:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F638C7FF
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 06:23:41 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 237DNaczE007535, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 237DNaczE007535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 21:23:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 21:23:35 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 7 Apr
 2022 21:23:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 07/13] rtw89: 8852c: disable firmware watchdog if CPU disabled
Date:   Thu, 7 Apr 2022 21:23:10 +0800
Message-ID: <20220407132316.61132-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407132316.61132-1-pkshih@realtek.com>
References: <20220407132316.61132-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 13:10:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkV6TIIDA4OjExOjAw?=
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

From: Chia-Yuan Li <leo.li@realtek.com>

Disable watchdog timer to prevent it timeout suddenly.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 37 +++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.h |  6 ++--
 drivers/net/wireless/realtek/rtw89/reg.h | 17 +++++++++++
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 91383c08beb3a..da66d28e98a62 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -10,7 +10,7 @@
 #include "reg.h"
 #include "util.h"
 
-const u32 rtw89_mac_mem_base_addrs[RTW89_MAC_MEM_MAX] = {
+const u32 rtw89_mac_mem_base_addrs[RTW89_MAC_MEM_NUM] = {
 	[RTW89_MAC_MEM_AXIDMA]	        = AXIDMA_BASE_ADDR,
 	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR,
 	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR,
@@ -28,8 +28,27 @@ const u32 rtw89_mac_mem_base_addrs[RTW89_MAC_MEM_MAX] = {
 	[RTW89_MAC_MEM_TXD_FIFO_1]	= TXD_FIFO_1_BASE_ADDR,
 	[RTW89_MAC_MEM_TXDATA_FIFO_0]	= TXDATA_FIFO_0_BASE_ADDR,
 	[RTW89_MAC_MEM_TXDATA_FIFO_1]	= TXDATA_FIFO_1_BASE_ADDR,
+	[RTW89_MAC_MEM_CPU_LOCAL]	= CPU_LOCAL_BASE_ADDR,
 };
 
+static void rtw89_mac_mem_write(struct rtw89_dev *rtwdev, u32 offset,
+				u32 val, enum rtw89_mac_mem_sel sel)
+{
+	u32 addr = rtw89_mac_mem_base_addrs[sel] + offset;
+
+	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, addr);
+	rtw89_write32(rtwdev, R_AX_INDIR_ACCESS_ENTRY, val);
+}
+
+static u32 rtw89_mac_mem_read(struct rtw89_dev *rtwdev, u32 offset,
+			      enum rtw89_mac_mem_sel sel)
+{
+	u32 addr = rtw89_mac_mem_base_addrs[sel] + offset;
+
+	rtw89_write32(rtwdev, R_AX_FILTER_MODEL_ADDR, addr);
+	return rtw89_read32(rtwdev, R_AX_INDIR_ACCESS_ENTRY);
+}
+
 int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 mac_idx,
 			   enum rtw89_mac_hwmod_sel sel)
 {
@@ -2965,6 +2984,19 @@ static int rtw89_mac_trx_init(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+
+	rtw89_mac_mem_write(rtwdev, R_AX_WDT_CTRL,
+			    WDT_CTRL_ALL_DIS, RTW89_MAC_MEM_CPU_LOCAL);
+
+	val32 = rtw89_mac_mem_read(rtwdev, R_AX_WDT_STATUS, RTW89_MAC_MEM_CPU_LOCAL);
+	val32 |= B_AX_FS_WDT_INT;
+	val32 &= ~B_AX_FS_WDT_INT_MSK;
+	rtw89_mac_mem_write(rtwdev, R_AX_WDT_STATUS, val32, RTW89_MAC_MEM_CPU_LOCAL);
+}
+
 static void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
 {
 	clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
@@ -2973,6 +3005,9 @@ static void rtw89_mac_disable_cpu(struct rtw89_dev *rtwdev)
 	rtw89_write32_clr(rtwdev, R_AX_WCPU_FW_CTRL, B_AX_WCPU_FWDL_EN |
 			  B_AX_H2C_PATH_RDY | B_AX_FWDL_PATH_RDY);
 	rtw89_write32_clr(rtwdev, R_AX_SYS_CLK_CTRL, B_AX_CPU_CLK_EN);
+
+	rtw89_disable_fw_watchdog(rtwdev);
+
 	rtw89_write32_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_PLATFORM_EN);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index de65d9becb056..31d53de97cfce 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -245,6 +245,7 @@ enum rtw89_mac_dbg_port_sel {
 #define	TXD_FIFO_1_BASE_ADDR		0x188A1080
 #define	TXDATA_FIFO_0_BASE_ADDR		0x18856000
 #define	TXDATA_FIFO_1_BASE_ADDR		0x188A1000
+#define	CPU_LOCAL_BASE_ADDR		0x18003000
 
 #define CCTL_INFO_SIZE		32
 
@@ -266,11 +267,10 @@ enum rtw89_mac_mem_sel {
 	RTW89_MAC_MEM_TXD_FIFO_1,
 	RTW89_MAC_MEM_TXDATA_FIFO_0,
 	RTW89_MAC_MEM_TXDATA_FIFO_1,
+	RTW89_MAC_MEM_CPU_LOCAL,
 
 	/* keep last */
-	RTW89_MAC_MEM_LAST,
-	RTW89_MAC_MEM_MAX = RTW89_MAC_MEM_LAST,
-	RTW89_MAC_MEM_INVALID = RTW89_MAC_MEM_LAST,
+	RTW89_MAC_MEM_NUM,
 };
 
 extern const u32 rtw89_mac_mem_base_addrs[];
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bc343e756aad7..0ec6636d62c9a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3773,4 +3773,21 @@
 #define B_IQKINF2_FCNT GENMASK(23, 16)
 #define B_IQKINF2_KCNT GENMASK(15, 8)
 #define B_IQKINF2_NCTLV GENMAKS(7, 0)
+
+/* WiFi CPU local domain */
+#define R_AX_WDT_CTRL 0x0040
+#define B_AX_WDT_EN BIT(31)
+#define B_AX_WDT_OPT_RESET_PLATFORM_EN BIT(29)
+#define B_AX_IO_HANG_IMR BIT(27)
+#define B_AX_IO_HANG_CMAC_RDATA_EN BIT(26)
+#define B_AX_IO_HANG_DMAC_EN BIT(25)
+#define B_AX_WDT_CLR BIT(16)
+#define B_AX_WDT_COUNT_SH 0
+#define B_AX_WDT_COUNT_MSK 0xffff
+#define WDT_CTRL_ALL_DIS 0
+
+#define R_AX_WDT_STATUS 0x0044
+#define B_AX_FS_WDT_INT BIT(8)
+#define B_AX_FS_WDT_INT_MSK BIT(0)
+
 #endif
-- 
2.25.1

