Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190704587F0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 03:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhKVCPJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Nov 2021 21:15:09 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42110 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhKVCPJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Nov 2021 21:15:09 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AM2Bp592027996, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AM2Bp592027996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Nov 2021 10:11:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 22 Nov 2021 10:11:50 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 22 Nov
 2021 10:11:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <Larry.Finger@lwfinger.net>,
        <leo.li@realtek.com>
Subject: [PATCH v2] rtw89: add AXIDMA and TX FIFO dump in mac_mem_dump
Date:   Mon, 22 Nov 2021 10:11:29 +0800
Message-ID: <20211122021129.4339-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 11/22/2021 01:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzIyIKRXpMggMTI6MjU6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/22/2021 01:53:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167391 [Nov 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/22/2021 01:57:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chia-Yuan Li <leo.li@realtek.com>

The AXIDMA is tx/rx packet transmission between PCIE host
and device, and TX FIFO is MAC TX data.
We dump them to verify that these memory buffers are correct.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2:
    - correct description of commit message
    - add Reviewed-by: Larry (Thank you!)
---
 drivers/net/wireless/realtek/rtw89/debug.c |  5 +++++
 drivers/net/wireless/realtek/rtw89/mac.h   | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 29eb188c888c7..dabee20b37c49 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -723,6 +723,7 @@ rtw89_debug_priv_mac_mem_dump_select(struct file *filp,
 }
 
 static const u32 mac_mem_base_addr_table[RTW89_MAC_MEM_MAX] = {
+	[RTW89_MAC_MEM_AXIDMA]	        = AXIDMA_BASE_ADDR,
 	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR,
 	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR,
 	[RTW89_MAC_MEM_SHCUT_MACHDR]	= SHCUT_MACHDR_BASE_ADDR,
@@ -735,6 +736,10 @@ static const u32 mac_mem_base_addr_table[RTW89_MAC_MEM_MAX] = {
 	[RTW89_MAC_MEM_BA_CAM]		= BA_CAM_BASE_ADDR,
 	[RTW89_MAC_MEM_BCN_IE_CAM0]	= BCN_IE_CAM0_BASE_ADDR,
 	[RTW89_MAC_MEM_BCN_IE_CAM1]	= BCN_IE_CAM1_BASE_ADDR,
+	[RTW89_MAC_MEM_TXD_FIFO_0]	= TXD_FIFO_0_BASE_ADDR,
+	[RTW89_MAC_MEM_TXD_FIFO_1]	= TXD_FIFO_1_BASE_ADDR,
+	[RTW89_MAC_MEM_TXDATA_FIFO_0]	= TXDATA_FIFO_0_BASE_ADDR,
+	[RTW89_MAC_MEM_TXDATA_FIFO_1]	= TXDATA_FIFO_1_BASE_ADDR,
 };
 
 static void rtw89_debug_dump_mac_mem(struct seq_file *m,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 6f3db8a2a9c2a..94cd29bd83d77 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -227,6 +227,7 @@ enum rtw89_mac_dbg_port_sel {
 /* SRAM mem dump */
 #define R_AX_INDIR_ACCESS_ENTRY 0x40000
 
+#define	AXIDMA_BASE_ADDR		0x18006000
 #define	STA_SCHED_BASE_ADDR		0x18808000
 #define	RXPLD_FLTR_CAM_BASE_ADDR	0x18813000
 #define	SECURITY_CAM_BASE_ADDR		0x18814000
@@ -240,10 +241,15 @@ enum rtw89_mac_dbg_port_sel {
 #define	DMAC_TBL_BASE_ADDR		0x18800000
 #define	SHCUT_MACHDR_BASE_ADDR		0x18800800
 #define	BCN_IE_CAM1_BASE_ADDR		0x188A0000
+#define	TXD_FIFO_0_BASE_ADDR		0x18856200
+#define	TXD_FIFO_1_BASE_ADDR		0x188A1080
+#define	TXDATA_FIFO_0_BASE_ADDR		0x18856000
+#define	TXDATA_FIFO_1_BASE_ADDR		0x188A1000
 
 #define CCTL_INFO_SIZE		32
 
 enum rtw89_mac_mem_sel {
+	RTW89_MAC_MEM_AXIDMA,
 	RTW89_MAC_MEM_SHARED_BUF,
 	RTW89_MAC_MEM_DMAC_TBL,
 	RTW89_MAC_MEM_SHCUT_MACHDR,
@@ -256,6 +262,10 @@ enum rtw89_mac_mem_sel {
 	RTW89_MAC_MEM_BA_CAM,
 	RTW89_MAC_MEM_BCN_IE_CAM0,
 	RTW89_MAC_MEM_BCN_IE_CAM1,
+	RTW89_MAC_MEM_TXD_FIFO_0,
+	RTW89_MAC_MEM_TXD_FIFO_1,
+	RTW89_MAC_MEM_TXDATA_FIFO_0,
+	RTW89_MAC_MEM_TXDATA_FIFO_1,
 
 	/* keep last */
 	RTW89_MAC_MEM_LAST,
-- 
2.25.1

