Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C561361571A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 02:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiKBBnz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 21:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKBBnx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 21:43:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9957EDEB7
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 18:43:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2A21gxcH7012581, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2A21gxcH7012581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 2 Nov 2022 09:42:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 2 Nov 2022 09:43:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 2 Nov 2022
 09:43:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: dump dispatch status via debug port
Date:   Wed, 2 Nov 2022 09:42:59 +0800
Message-ID: <20221102014300.14091-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102014300.14091-1-pkshih@realtek.com>
References: <20221102014300.14091-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/02/2022 01:23:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzEgpFWkyCAxMDozMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Chia-Yuan Li <leo.li@realtek.com>

Dispatch is a component to decide packets forward to host, DMAC or
HAXIDMA. It contains CDT standing for CPU dispatcher, HDT standing
for host dispatcher, WDE standing for descriptor engine and PLE standing
for payload engine. STF is one kind of modes, it can be used if packet
send to hardware and doesn't need release report.

These debug port information can help to clarify the reason if
packets stuck in dispatch.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 575 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h   |  45 ++
 drivers/net/wireless/realtek/rtw89/reg.h   |   5 +
 3 files changed, 625 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index cd44d9aa37ca0..afd10e91d3ea5 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -1114,6 +1114,303 @@ static const struct rtw89_mac_dbg_port_info dbg_port_ptcl_c1 = {
 	.rd_msk = B_AX_PTCL_DBG_INFO_MASK
 };
 
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_tx0_5 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0xD,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_tx6 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x5,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_tx7 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x9,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_tx8 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x3,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_tx9_C = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x1,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_txD = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x0,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_tx0 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0xB,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_tx1 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x4,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_tx3 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x8,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_tx4 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x7,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_tx5_8 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x1,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_tx9 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x3,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_txA_C = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x0,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_rx0 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x8,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_rx1_2 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x0,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_rx3 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x6,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_rx4 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x0,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_hdt_rx5 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 2,
+	.sel_msk = B_AX_DISPATCHER_DBG_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x0,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_rx_p0_0 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x3,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_rx_p0_1 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x6,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_rx_p0_2 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x0,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_cdt_rx_p1 = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x8,
+	.end = 0xE,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_stf_ctrl = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x5,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_addr_ctrl = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x6,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_wde_intf = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0xF,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_ple_intf = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x9,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
+static const struct rtw89_mac_dbg_port_info dbg_port_dspt_flow_ctrl = {
+	.sel_addr = R_AX_DISPATCHER_DBG_PORT,
+	.sel_byte = 1,
+	.sel_msk = B_AX_DISPATCHER_CH_SEL_MASK,
+	.srt = 0x0,
+	.end = 0x3,
+	.rd_addr = R_AX_DBG_PORT_SEL,
+	.rd_byte = 4,
+	.rd_msk = B_AX_DEBUG_ST_MASK
+};
+
 static const struct rtw89_mac_dbg_port_info dbg_port_sch_c0 = {
 	.sel_addr = R_AX_SCH_DBG_SEL,
 	.sel_byte = 1,
@@ -1603,6 +1900,7 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 			     struct rtw89_dev *rtwdev, u32 sel)
 {
 	const struct rtw89_mac_dbg_port_info *info;
+	u32 index;
 	u32 val32;
 	u16 val16;
 	u8 val8;
@@ -1878,6 +2176,235 @@ rtw89_debug_mac_dbg_port_sel(struct seq_file *m,
 		info = &dbg_port_pktinfo;
 		seq_puts(m, "Enable pktinfo dump.\n");
 		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX0:
+		rtw89_write32_mask(rtwdev, R_AX_DBG_CTRL,
+				   B_AX_DBG_SEL0, 0x80);
+		rtw89_write32_mask(rtwdev, R_AX_SYS_STATUS1,
+				   B_AX_SEL_0XC0_MASK, 1);
+		fallthrough;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX1:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX2:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX3:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX4:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX5:
+		info = &dbg_port_dspt_hdt_tx0_5;
+		index = sel - RTW89_DBG_PORT_SEL_DSPT_HDT_TX0;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, index);
+		seq_printf(m, "Enable Dispatcher hdt tx%x dump.\n", index);
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX6:
+		info = &dbg_port_dspt_hdt_tx6;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 6);
+		seq_puts(m, "Enable Dispatcher hdt tx6 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX7:
+		info = &dbg_port_dspt_hdt_tx7;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 7);
+		seq_puts(m, "Enable Dispatcher hdt tx7 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX8:
+		info = &dbg_port_dspt_hdt_tx8;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 8);
+		seq_puts(m, "Enable Dispatcher hdt tx8 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TX9:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TXA:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TXB:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TXC:
+		info = &dbg_port_dspt_hdt_tx9_C;
+		index = sel + 9 - RTW89_DBG_PORT_SEL_DSPT_HDT_TX9;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, index);
+		seq_printf(m, "Enable Dispatcher hdt tx%x dump.\n", index);
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_TXD:
+		info = &dbg_port_dspt_hdt_txD;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 0);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 0xD);
+		seq_puts(m, "Enable Dispatcher hdt txD dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX0:
+		info = &dbg_port_dspt_cdt_tx0;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 0);
+		seq_puts(m, "Enable Dispatcher cdt tx0 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX1:
+		info = &dbg_port_dspt_cdt_tx1;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 1);
+		seq_puts(m, "Enable Dispatcher cdt tx1 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX3:
+		info = &dbg_port_dspt_cdt_tx3;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 3);
+		seq_puts(m, "Enable Dispatcher cdt tx3 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX4:
+		info = &dbg_port_dspt_cdt_tx4;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 4);
+		seq_puts(m, "Enable Dispatcher cdt tx4 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX5:
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX6:
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX7:
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX8:
+		info = &dbg_port_dspt_cdt_tx5_8;
+		index = sel + 5 - RTW89_DBG_PORT_SEL_DSPT_CDT_TX5;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, index);
+		seq_printf(m, "Enable Dispatcher cdt tx%x dump.\n", index);
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TX9:
+		info = &dbg_port_dspt_cdt_tx9;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 9);
+		seq_puts(m, "Enable Dispatcher cdt tx9 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TXA:
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TXB:
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_TXC:
+		info = &dbg_port_dspt_cdt_txA_C;
+		index = sel + 0xA - RTW89_DBG_PORT_SEL_DSPT_CDT_TXA;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 1);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, index);
+		seq_printf(m, "Enable Dispatcher cdt tx%x dump.\n", index);
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX0:
+		info = &dbg_port_dspt_hdt_rx0;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 0);
+		seq_puts(m, "Enable Dispatcher hdt rx0 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX1:
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX2:
+		info = &dbg_port_dspt_hdt_rx1_2;
+		index = sel + 1 - RTW89_DBG_PORT_SEL_DSPT_HDT_RX1;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, index);
+		seq_printf(m, "Enable Dispatcher hdt rx%x dump.\n", index);
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX3:
+		info = &dbg_port_dspt_hdt_rx3;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 3);
+		seq_puts(m, "Enable Dispatcher hdt rx3 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX4:
+		info = &dbg_port_dspt_hdt_rx4;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 4);
+		seq_puts(m, "Enable Dispatcher hdt rx4 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_HDT_RX5:
+		info = &dbg_port_dspt_hdt_rx5;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 2);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 5);
+		seq_puts(m, "Enable Dispatcher hdt rx5 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_0:
+		info = &dbg_port_dspt_cdt_rx_p0_0;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 3);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 0);
+		seq_puts(m, "Enable Dispatcher cdt rx part0 0 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0:
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_1:
+		info = &dbg_port_dspt_cdt_rx_p0_1;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 3);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 1);
+		seq_puts(m, "Enable Dispatcher cdt rx part0 1 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_2:
+		info = &dbg_port_dspt_cdt_rx_p0_2;
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_INTN_SEL_MASK, 3);
+		rtw89_write16_mask(rtwdev, info->sel_addr,
+				   B_AX_DISPATCHER_CH_SEL_MASK, 2);
+		seq_puts(m, "Enable Dispatcher cdt rx part0 2 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P1:
+		info = &dbg_port_dspt_cdt_rx_p1;
+		rtw89_write8_mask(rtwdev, info->sel_addr,
+				  B_AX_DISPATCHER_INTN_SEL_MASK, 3);
+		seq_puts(m, "Enable Dispatcher cdt rx part1 dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_STF_CTRL:
+		info = &dbg_port_dspt_stf_ctrl;
+		rtw89_write8_mask(rtwdev, info->sel_addr,
+				  B_AX_DISPATCHER_INTN_SEL_MASK, 4);
+		seq_puts(m, "Enable Dispatcher stf control dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_ADDR_CTRL:
+		info = &dbg_port_dspt_addr_ctrl;
+		rtw89_write8_mask(rtwdev, info->sel_addr,
+				  B_AX_DISPATCHER_INTN_SEL_MASK, 5);
+		seq_puts(m, "Enable Dispatcher addr control dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_WDE_INTF:
+		info = &dbg_port_dspt_wde_intf;
+		rtw89_write8_mask(rtwdev, info->sel_addr,
+				  B_AX_DISPATCHER_INTN_SEL_MASK, 6);
+		seq_puts(m, "Enable Dispatcher wde interface dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_PLE_INTF:
+		info = &dbg_port_dspt_ple_intf;
+		rtw89_write8_mask(rtwdev, info->sel_addr,
+				  B_AX_DISPATCHER_INTN_SEL_MASK, 7);
+		seq_puts(m, "Enable Dispatcher ple interface dump.\n");
+		break;
+	case RTW89_DBG_PORT_SEL_DSPT_FLOW_CTRL:
+		info = &dbg_port_dspt_flow_ctrl;
+		rtw89_write8_mask(rtwdev, info->sel_addr,
+				  B_AX_DISPATCHER_INTN_SEL_MASK, 8);
+		seq_puts(m, "Enable Dispatcher flow control dump.\n");
+		break;
 	case RTW89_DBG_PORT_SEL_PCIE_TXDMA:
 		info = &dbg_port_pcie_txdma;
 		val32 = rtw89_read32(rtwdev, R_AX_DBG_CTRL);
@@ -1956,6 +2483,10 @@ static bool is_dbg_port_valid(struct rtw89_dev *rtwdev, u32 sel)
 	    sel >= RTW89_DBG_PORT_SEL_WDE_BUFMGN_FREEPG &&
 	    sel <= RTW89_DBG_PORT_SEL_PKTINFO)
 		return false;
+	if (rtw89_mac_check_mac_en(rtwdev, 0, RTW89_DMAC_SEL) &&
+	    sel >= RTW89_DBG_PORT_SEL_DSPT_HDT_TX0 &&
+	    sel <= RTW89_DBG_PORT_SEL_DSPT_FLOW_CTRL)
+		return false;
 	if (rtw89_mac_check_mac_en(rtwdev, 0, RTW89_CMAC_SEL) &&
 	    sel >= RTW89_DBG_PORT_SEL_PTCL_C0 &&
 	    sel <= RTW89_DBG_PORT_SEL_TXTF_INFOH_C0)
@@ -2026,6 +2557,50 @@ static int rtw89_debug_mac_dbg_port_dump(struct rtw89_dev *rtwdev,
 	case_DBG_SEL(PLE_QUEMGN_QLNKTBL);
 	case_DBG_SEL(PLE_QUEMGN_QEMPTY);
 	case_DBG_SEL(PKTINFO);
+	case_DBG_SEL(DSPT_HDT_TX0);
+	case_DBG_SEL(DSPT_HDT_TX1);
+	case_DBG_SEL(DSPT_HDT_TX2);
+	case_DBG_SEL(DSPT_HDT_TX3);
+	case_DBG_SEL(DSPT_HDT_TX4);
+	case_DBG_SEL(DSPT_HDT_TX5);
+	case_DBG_SEL(DSPT_HDT_TX6);
+	case_DBG_SEL(DSPT_HDT_TX7);
+	case_DBG_SEL(DSPT_HDT_TX8);
+	case_DBG_SEL(DSPT_HDT_TX9);
+	case_DBG_SEL(DSPT_HDT_TXA);
+	case_DBG_SEL(DSPT_HDT_TXB);
+	case_DBG_SEL(DSPT_HDT_TXC);
+	case_DBG_SEL(DSPT_HDT_TXD);
+	case_DBG_SEL(DSPT_HDT_TXE);
+	case_DBG_SEL(DSPT_HDT_TXF);
+	case_DBG_SEL(DSPT_CDT_TX0);
+	case_DBG_SEL(DSPT_CDT_TX1);
+	case_DBG_SEL(DSPT_CDT_TX3);
+	case_DBG_SEL(DSPT_CDT_TX4);
+	case_DBG_SEL(DSPT_CDT_TX5);
+	case_DBG_SEL(DSPT_CDT_TX6);
+	case_DBG_SEL(DSPT_CDT_TX7);
+	case_DBG_SEL(DSPT_CDT_TX8);
+	case_DBG_SEL(DSPT_CDT_TX9);
+	case_DBG_SEL(DSPT_CDT_TXA);
+	case_DBG_SEL(DSPT_CDT_TXB);
+	case_DBG_SEL(DSPT_CDT_TXC);
+	case_DBG_SEL(DSPT_HDT_RX0);
+	case_DBG_SEL(DSPT_HDT_RX1);
+	case_DBG_SEL(DSPT_HDT_RX2);
+	case_DBG_SEL(DSPT_HDT_RX3);
+	case_DBG_SEL(DSPT_HDT_RX4);
+	case_DBG_SEL(DSPT_HDT_RX5);
+	case_DBG_SEL(DSPT_CDT_RX_P0);
+	case_DBG_SEL(DSPT_CDT_RX_P0_0);
+	case_DBG_SEL(DSPT_CDT_RX_P0_1);
+	case_DBG_SEL(DSPT_CDT_RX_P0_2);
+	case_DBG_SEL(DSPT_CDT_RX_P1);
+	case_DBG_SEL(DSPT_STF_CTRL);
+	case_DBG_SEL(DSPT_ADDR_CTRL);
+	case_DBG_SEL(DSPT_WDE_INTF);
+	case_DBG_SEL(DSPT_PLE_INTF);
+	case_DBG_SEL(DSPT_FLOW_CTRL);
 	case_DBG_SEL(PCIE_TXDMA);
 	case_DBG_SEL(PCIE_RXDMA);
 	case_DBG_SEL(PCIE_CVT);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 34f7d51be3f97..46d9cad2b5ec8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -211,6 +211,51 @@ enum rtw89_mac_dbg_port_sel {
 	RTW89_DBG_PORT_SEL_PLE_QUEMGN_QLNKTBL,
 	RTW89_DBG_PORT_SEL_PLE_QUEMGN_QEMPTY,
 	RTW89_DBG_PORT_SEL_PKTINFO,
+	/* DISPATCHER related */
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX0,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX1,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX2,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX3,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX4,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX5,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX6,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX7,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX8,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TX9,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TXA,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TXB,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TXC,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TXD,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TXE,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_TXF,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX0,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX1,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX3,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX4,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX5,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX6,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX7,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX8,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TX9,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TXA,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TXB,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_TXC,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_RX0,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_RX1,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_RX2,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_RX3,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_RX4,
+	RTW89_DBG_PORT_SEL_DSPT_HDT_RX5,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_0,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_1,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P0_2,
+	RTW89_DBG_PORT_SEL_DSPT_CDT_RX_P1,
+	RTW89_DBG_PORT_SEL_DSPT_STF_CTRL,
+	RTW89_DBG_PORT_SEL_DSPT_ADDR_CTRL,
+	RTW89_DBG_PORT_SEL_DSPT_WDE_INTF,
+	RTW89_DBG_PORT_SEL_DSPT_PLE_INTF,
+	RTW89_DBG_PORT_SEL_DSPT_FLOW_CTRL,
 	/* PCIE related */
 	RTW89_DBG_PORT_SEL_PCIE_TXDMA,
 	RTW89_DBG_PORT_SEL_PCIE_RXDMA,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2f6358244934f..8a1cb8f4aa16c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -952,6 +952,11 @@
 				    B_AX_STF_OQT_OVERFLOW_ERR_INT_EN | \
 				    B_AX_STF_OQT_UNDERFLOW_ERR_INT_EN)
 
+#define R_AX_DISPATCHER_DBG_PORT 0x8860
+#define B_AX_DISPATCHER_DBG_SEL_MASK GENMASK(11, 8)
+#define B_AX_DISPATCHER_INTN_SEL_MASK GENMASK(7, 4)
+#define B_AX_DISPATCHER_CH_SEL_MASK GENMASK(3, 0)
+
 #define R_AX_RX_FUNCTION_STOP 0x8920
 #define B_AX_HDR_RX_STOP BIT(0)
 
-- 
2.25.1

