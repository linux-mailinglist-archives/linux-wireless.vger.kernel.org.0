Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B664D7B60
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiCNHO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiCNHO4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:14:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D73A11176
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:46 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7DejoE003291, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7DejoE003291
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 14 Mar 2022 15:13:40 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 2/8] rtw89: mac: move table of mem base addr to common
Date:   Mon, 14 Mar 2022 15:12:44 +0800
Message-ID: <20220314071250.40292-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314071250.40292-1-pkshih@realtek.com>
References: <20220314071250.40292-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Previously, mac_mem_base_addr_table was declared in debug.c locally
because it's only used via debugfs to dump mac memory. Now, we plan to
refine SER (system error recover) flow which will also need to dump mac
memory to somewhere as information for error which is catched. So, we
move mac_mem_base_addr_table to mac.c rtw89_mac_mem_base_addrs earlier
as common code.

(no logic is changed)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 22 +---------------------
 drivers/net/wireless/realtek/rtw89/mac.c   | 20 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h   |  2 ++
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index b73cc03cecfd7..09c545497ec5c 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -724,26 +724,6 @@ rtw89_debug_priv_mac_mem_dump_select(struct file *filp,
 	return count;
 }
 
-static const u32 mac_mem_base_addr_table[RTW89_MAC_MEM_MAX] = {
-	[RTW89_MAC_MEM_AXIDMA]	        = AXIDMA_BASE_ADDR,
-	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR,
-	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR,
-	[RTW89_MAC_MEM_SHCUT_MACHDR]	= SHCUT_MACHDR_BASE_ADDR,
-	[RTW89_MAC_MEM_STA_SCHED]	= STA_SCHED_BASE_ADDR,
-	[RTW89_MAC_MEM_RXPLD_FLTR_CAM]	= RXPLD_FLTR_CAM_BASE_ADDR,
-	[RTW89_MAC_MEM_SECURITY_CAM]	= SECURITY_CAM_BASE_ADDR,
-	[RTW89_MAC_MEM_WOW_CAM]		= WOW_CAM_BASE_ADDR,
-	[RTW89_MAC_MEM_CMAC_TBL]	= CMAC_TBL_BASE_ADDR,
-	[RTW89_MAC_MEM_ADDR_CAM]	= ADDR_CAM_BASE_ADDR,
-	[RTW89_MAC_MEM_BA_CAM]		= BA_CAM_BASE_ADDR,
-	[RTW89_MAC_MEM_BCN_IE_CAM0]	= BCN_IE_CAM0_BASE_ADDR,
-	[RTW89_MAC_MEM_BCN_IE_CAM1]	= BCN_IE_CAM1_BASE_ADDR,
-	[RTW89_MAC_MEM_TXD_FIFO_0]	= TXD_FIFO_0_BASE_ADDR,
-	[RTW89_MAC_MEM_TXD_FIFO_1]	= TXD_FIFO_1_BASE_ADDR,
-	[RTW89_MAC_MEM_TXDATA_FIFO_0]	= TXDATA_FIFO_0_BASE_ADDR,
-	[RTW89_MAC_MEM_TXDATA_FIFO_1]	= TXDATA_FIFO_1_BASE_ADDR,
-};
-
 static void rtw89_debug_dump_mac_mem(struct seq_file *m,
 				     struct rtw89_dev *rtwdev,
 				     u8 sel, u32 start_addr, u32 len)
@@ -757,7 +737,7 @@ static void rtw89_debug_dump_mac_mem(struct seq_file *m,
 	pages = len / MAC_MEM_DUMP_PAGE_SIZE + 1;
 	start_page = start_addr / MAC_MEM_DUMP_PAGE_SIZE;
 	residue = start_addr % MAC_MEM_DUMP_PAGE_SIZE;
-	base_addr = mac_mem_base_addr_table[sel];
+	base_addr = rtw89_mac_mem_base_addrs[sel];
 	base_addr += start_page * MAC_MEM_DUMP_PAGE_SIZE;
 
 	for (p = 0; p < pages; p++) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8fbdfd983cc53..942c56c3dce09 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -10,6 +10,26 @@
 #include "reg.h"
 #include "util.h"
 
+const u32 rtw89_mac_mem_base_addrs[RTW89_MAC_MEM_MAX] = {
+	[RTW89_MAC_MEM_AXIDMA]	        = AXIDMA_BASE_ADDR,
+	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR,
+	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR,
+	[RTW89_MAC_MEM_SHCUT_MACHDR]	= SHCUT_MACHDR_BASE_ADDR,
+	[RTW89_MAC_MEM_STA_SCHED]	= STA_SCHED_BASE_ADDR,
+	[RTW89_MAC_MEM_RXPLD_FLTR_CAM]	= RXPLD_FLTR_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_SECURITY_CAM]	= SECURITY_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_WOW_CAM]		= WOW_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_CMAC_TBL]	= CMAC_TBL_BASE_ADDR,
+	[RTW89_MAC_MEM_ADDR_CAM]	= ADDR_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_BA_CAM]		= BA_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_BCN_IE_CAM0]	= BCN_IE_CAM0_BASE_ADDR,
+	[RTW89_MAC_MEM_BCN_IE_CAM1]	= BCN_IE_CAM1_BASE_ADDR,
+	[RTW89_MAC_MEM_TXD_FIFO_0]	= TXD_FIFO_0_BASE_ADDR,
+	[RTW89_MAC_MEM_TXD_FIFO_1]	= TXD_FIFO_1_BASE_ADDR,
+	[RTW89_MAC_MEM_TXDATA_FIFO_0]	= TXDATA_FIFO_0_BASE_ADDR,
+	[RTW89_MAC_MEM_TXDATA_FIFO_1]	= TXDATA_FIFO_1_BASE_ADDR,
+};
+
 int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 mac_idx,
 			   enum rtw89_mac_hwmod_sel sel)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 2f707c817fa79..8aed3596bc145 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -273,6 +273,8 @@ enum rtw89_mac_mem_sel {
 	RTW89_MAC_MEM_INVALID = RTW89_MAC_MEM_LAST,
 };
 
+extern const u32 rtw89_mac_mem_base_addrs[];
+
 enum rtw89_rpwm_req_pwr_state {
 	RTW89_MAC_RPWM_REQ_PWR_STATE_ACTIVE = 0,
 	RTW89_MAC_RPWM_REQ_PWR_STATE_BAND0_RFON = 1,
-- 
2.25.1

