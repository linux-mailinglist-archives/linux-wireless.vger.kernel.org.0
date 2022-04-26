Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A2650F113
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 08:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiDZGgZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 02:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbiDZGgW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 02:36:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867B915FC7
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:33:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23Q6Ww9D2015192, This message is accepted by code: ctloc85258
Received: from mail.realtek.com ([172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23Q6Ww9D2015192
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Apr 2022 14:32:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 14:32:58 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 26 Apr
 2022 14:32:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/15] rtw89: 8852c: rfk: add RFK tables
Date:   Tue, 26 Apr 2022 14:32:21 +0800
Message-ID: <20220426063235.41650-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426063235.41650-1-pkshih@realtek.com>
References: <20220426063235.41650-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/26/2022 06:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjYgpFekyCAwNDozODowMA==?=
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

These tables are used by RFK (RF calibration) to set parameters. These
parameters can trigger certain calibration, or configure/reset settings
before and after RF calibrations.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../realtek/rtw89/rtw8852c_rfk_table.c        | 781 ++++++++++++++++++
 .../realtek/rtw89/rtw8852c_rfk_table.h        |  67 ++
 2 files changed, 848 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.h

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
new file mode 100644
index 0000000000000..d727d528b3651
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#include "rtw8852c_rfk_table.h"
+
+static const struct rtw89_reg5_def rtw8852c_dack_reload_defs[] = {
+	RTW89_DECL_RFK_WM(0xc004, BIT(17), 0x1),
+	RTW89_DECL_RFK_WM(0xc024, BIT(17), 0x1),
+	RTW89_DECL_RFK_WM(0xc104, BIT(17), 0x1),
+	RTW89_DECL_RFK_WM(0xc124, BIT(17), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dack_reload_defs);
+
+static const struct rtw89_reg5_def rtw8852c_dack_reset_defs_a[] = {
+	RTW89_DECL_RFK_WM(0xc000, BIT(17), 0x0),
+	RTW89_DECL_RFK_WM(0xc000, BIT(17), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dack_reset_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_dack_reset_defs_b[] = {
+	RTW89_DECL_RFK_WM(0xc100, BIT(17), 0x0),
+	RTW89_DECL_RFK_WM(0xc100, BIT(17), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dack_reset_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_dack_defs_s0[] = {
+	RTW89_DECL_RFK_WM(0x12b8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x030c, BIT(28), 0x1),
+	RTW89_DECL_RFK_WM(0x032c, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc004, 0xfff00000, 0x30),
+	RTW89_DECL_RFK_WM(0xc024, 0xfff00000, 0x30),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dack_defs_s0);
+
+static const struct rtw89_reg5_def rtw8852c_dack_defs_s1[] = {
+	RTW89_DECL_RFK_WM(0x32b8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x030c, BIT(28), 0x1),
+	RTW89_DECL_RFK_WM(0x032c, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc104, 0xfff00000, 0x30),
+	RTW89_DECL_RFK_WM(0xc124, 0xfff00000, 0x30),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dack_defs_s1);
+
+static const struct rtw89_reg5_def rtw8852c_drck_defs[] = {
+	RTW89_DECL_RFK_WM(0xc0c4, BIT(6), 0x0),
+	RTW89_DECL_RFK_WM(0xc094, BIT(9), 0x1),
+	RTW89_DECL_RFK_DELAY(1),
+	RTW89_DECL_RFK_WM(0xc094, BIT(9), 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_drck_defs);
+
+static const struct rtw89_reg5_def rtw8852c_iqk_rxk_cfg_defs[] = {
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x0f),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x03),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0001),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_iqk_rxk_cfg_defs);
+
+static const struct rtw89_reg5_def rtw8852c_iqk_afebb_restore_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00010000, 0x1),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00100000, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x01000000, 0x1),
+	RTW89_DECL_RFK_WM(0x20fc, 0x10000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5670, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x12a0, 0x000ff000, 0x00),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00010000, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x01000000, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x10005, 0x00001, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_iqk_afebb_restore_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_iqk_afebb_restore_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x32b8, 0x40000000, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00020000, 0x1),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00200000, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x02000000, 0x1),
+	RTW89_DECL_RFK_WM(0x20fc, 0x20000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7670, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x32a0, 0x000ff000, 0x00),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00020000, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x02000000, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_B, 0x10005, 0x00001, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_iqk_afebb_restore_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_read_rxsram_pre_defs[] = {
+	RTW89_DECL_RFK_WM(0x80e8, BIT(7), 0x1),
+	RTW89_DECL_RFK_WM(0x8074, BIT(31), 0x1),
+	RTW89_DECL_RFK_WM(0x80d4, MASKDWORD, 0x00020000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_read_rxsram_pre_defs);
+
+static const struct rtw89_reg5_def rtw8852c_read_rxsram_post_defs[] = {
+	RTW89_DECL_RFK_WM(0x80e8, BIT(7), 0x0),
+	RTW89_DECL_RFK_WM(0x8074, BIT(31), 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_read_rxsram_post_defs);
+
+static const struct rtw89_reg5_def rtw8852c_dpk_mdpd_order0_defs[] = {
+	RTW89_DECL_RFK_WM(0x80a0, BIT(1) | BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0x809c, BIT(10) | BIT(9), 0x2),
+	RTW89_DECL_RFK_WM(0x80a0, 0x00001F00, 0x4),
+	RTW89_DECL_RFK_WM(0x8070, 0x70000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dpk_mdpd_order0_defs);
+
+static const struct rtw89_reg5_def rtw8852c_dpk_mdpd_order1_defs[] = {
+	RTW89_DECL_RFK_WM(0x80a0, BIT(1) | BIT(0), 0x1),
+	RTW89_DECL_RFK_WM(0x809c, BIT(10) | BIT(9), 0x1),
+	RTW89_DECL_RFK_WM(0x80a0, 0x00001F00, 0x0),
+	RTW89_DECL_RFK_WM(0x8070, 0x70000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dpk_mdpd_order1_defs);
+
+static const struct rtw89_reg5_def rtw8852c_dpk_mdpd_order2_defs[] = {
+	RTW89_DECL_RFK_WM(0x80a0, BIT(1) | BIT(0), 0x2),
+	RTW89_DECL_RFK_WM(0x809c, BIT(10) | BIT(9), 0x0),
+	RTW89_DECL_RFK_WM(0x80a0, 0x00001F00, 0x0),
+	RTW89_DECL_RFK_WM(0x8070, 0x70000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dpk_mdpd_order2_defs);
+
+static const struct rtw89_reg5_def rtw8852c_dpk_mdpd_order3_defs[] = {
+	RTW89_DECL_RFK_WM(0x80a0, BIT(1) | BIT(0), 0x3),
+	RTW89_DECL_RFK_WM(0x809c, BIT(10) | BIT(9), 0x3),
+	RTW89_DECL_RFK_WM(0x80a0, 0x00001F00, 0x4),
+	RTW89_DECL_RFK_WM(0x8070, 0x70000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dpk_mdpd_order3_defs);
+
+static const struct rtw89_reg5_def rtw8852c_dpk_kip_pwr_clk_on_defs[] = {
+	RTW89_DECL_RFK_WM(0x8008, MASKDWORD, 0x00000080),
+	RTW89_DECL_RFK_WM(0x8088, MASKDWORD, 0x807f030a),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dpk_kip_pwr_clk_on_defs);
+
+static const struct rtw89_reg5_def rtw8852c_dpk_kip_pwr_clk_off_defs[] = {
+	RTW89_DECL_RFK_WM(0x8008, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x8088, MASKDWORD, 0x80000000),
+	RTW89_DECL_RFK_WM(0x80f4, BIT(18), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_dpk_kip_pwr_clk_off_defs);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_sys_defs[] = {
+	RTW89_DECL_RFK_WM(0x12bc, 0x000ffff0, 0xb5b5),
+	RTW89_DECL_RFK_WM(0x32bc, 0x000ffff0, 0xb5b5),
+	RTW89_DECL_RFK_WM(0x0300, 0xff000000, 0x16),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ffff, 0x1f19),
+	RTW89_DECL_RFK_WM(0x0308, 0xff000000, 0x1c),
+	RTW89_DECL_RFK_WM(0x0314, 0xffff0000, 0x2041),
+	RTW89_DECL_RFK_WM(0x0318, 0xffffffff, 0x20012041),
+	RTW89_DECL_RFK_WM(0x0324, 0xffff0000, 0x2001),
+	RTW89_DECL_RFK_WM(0x0020, 0x00006000, 0x3),
+	RTW89_DECL_RFK_WM(0x0024, 0x00006000, 0x3),
+	RTW89_DECL_RFK_WM(0x0704, 0xffff0000, 0x601e),
+	RTW89_DECL_RFK_WM(0x2704, 0xffff0000, 0x601e),
+	RTW89_DECL_RFK_WM(0x0700, 0xf0000000, 0x4),
+	RTW89_DECL_RFK_WM(0x2700, 0xf0000000, 0x4),
+	RTW89_DECL_RFK_WM(0x0650, 0x3c000000, 0x0),
+	RTW89_DECL_RFK_WM(0x2650, 0x3c000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_sys_defs);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_sys_defs_2g_a[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x33),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x33),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_sys_defs_2g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_sys_defs_2g_b[] = {
+	RTW89_DECL_RFK_WM(0x320c, 0x000000ff, 0x33),
+	RTW89_DECL_RFK_WM(0x32c0, 0x0ff00000, 0x33),
+	RTW89_DECL_RFK_WM(0x78f8, 0x40000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_sys_defs_2g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_sys_defs_5g_a[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x44),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x44),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_sys_defs_5g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_sys_defs_5g_b[] = {
+	RTW89_DECL_RFK_WM(0x320c, 0x000000ff, 0x44),
+	RTW89_DECL_RFK_WM(0x32c0, 0x0ff00000, 0x44),
+	RTW89_DECL_RFK_WM(0x78f8, 0x40000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_sys_defs_5g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x5800, 0xffffffff, 0x003f807f),
+	RTW89_DECL_RFK_WM(0x580c, 0x0000007f, 0x40),
+	RTW89_DECL_RFK_WM(0x580c, 0x0fffff00, 0x00040),
+	RTW89_DECL_RFK_WM(0x5810, 0xffffffff, 0x59010000),
+	RTW89_DECL_RFK_WM(0x5814, 0x01ffffff, 0x026d000),
+	RTW89_DECL_RFK_WM(0x5814, 0xf8000000, 0x00),
+	RTW89_DECL_RFK_WM(0x5818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x581c, 0x3fffffff, 0x3dc80280),
+	RTW89_DECL_RFK_WM(0x5820, 0xffffffff, 0x00000080),
+	RTW89_DECL_RFK_WM(0x58e8, 0x0000003f, 0x03),
+	RTW89_DECL_RFK_WM(0x580c, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x580c, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5834, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x5838, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x5854, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x5858, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x5860, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5864, 0x07ffffff, 0x00801ff),
+	RTW89_DECL_RFK_WM(0x5898, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x589c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58a4, 0x000000ff, 0x16),
+	RTW89_DECL_RFK_WM(0x58b4, 0x7fffffff, 0x0a002000),
+	RTW89_DECL_RFK_WM(0x58b8, 0x7fffffff, 0x00007628),
+	RTW89_DECL_RFK_WM(0x58bc, 0x07ffffff, 0x7a7807f),
+	RTW89_DECL_RFK_WM(0x58c0, 0xfffe0000, 0x003f),
+	RTW89_DECL_RFK_WM(0x58c4, 0xffffffff, 0x0003ffff),
+	RTW89_DECL_RFK_WM(0x58c8, 0x00ffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x58c8, 0xf0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x58cc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58d0, 0x07ffffff, 0x2008101),
+	RTW89_DECL_RFK_WM(0x58d4, 0x000000ff, 0x00),
+	RTW89_DECL_RFK_WM(0x58d4, 0x0003fe00, 0x0ff),
+	RTW89_DECL_RFK_WM(0x58d4, 0x07fc0000, 0x100),
+	RTW89_DECL_RFK_WM(0x58d8, 0xffffffff, 0x8008016c),
+	RTW89_DECL_RFK_WM(0x58dc, 0x0001ffff, 0x0807f),
+	RTW89_DECL_RFK_WM(0x58dc, 0xfff00000, 0x800),
+	RTW89_DECL_RFK_WM(0x58f0, 0x0003ffff, 0x001ff),
+	RTW89_DECL_RFK_WM(0x58f4, 0x000fffff, 0x000),
+	RTW89_DECL_RFK_WM(0x58f8, 0x000fffff, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_txpwr_ctrl_bb_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x7800, 0xffffffff, 0x003f807f),
+	RTW89_DECL_RFK_WM(0x780c, 0x0000007f, 0x40),
+	RTW89_DECL_RFK_WM(0x780c, 0x0fffff00, 0x00040),
+	RTW89_DECL_RFK_WM(0x7810, 0xffffffff, 0x59010000),
+	RTW89_DECL_RFK_WM(0x7814, 0x01ffffff, 0x026d000),
+	RTW89_DECL_RFK_WM(0x7814, 0xf8000000, 0x00),
+	RTW89_DECL_RFK_WM(0x7818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x781c, 0x3fffffff, 0x3dc80280),
+	RTW89_DECL_RFK_WM(0x7820, 0xffffffff, 0x00000080),
+	RTW89_DECL_RFK_WM(0x78e8, 0x0000003f, 0x03),
+	RTW89_DECL_RFK_WM(0x780c, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x780c, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7834, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x7838, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x7854, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x7858, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x7860, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7864, 0x07ffffff, 0x00801ff),
+	RTW89_DECL_RFK_WM(0x7898, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x789c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x78a4, 0x000000ff, 0x16),
+	RTW89_DECL_RFK_WM(0x78b4, 0x7fffffff, 0x0a002000),
+	RTW89_DECL_RFK_WM(0x78b8, 0x7fffffff, 0x00007628),
+	RTW89_DECL_RFK_WM(0x78bc, 0x07ffffff, 0x7a7807f),
+	RTW89_DECL_RFK_WM(0x78c0, 0xfffe0000, 0x003f),
+	RTW89_DECL_RFK_WM(0x78c4, 0xffffffff, 0x0003ffff),
+	RTW89_DECL_RFK_WM(0x78c8, 0x00ffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x78c8, 0xf0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x78cc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x78d0, 0x07ffffff, 0x2008101),
+	RTW89_DECL_RFK_WM(0x78d4, 0x000000ff, 0x00),
+	RTW89_DECL_RFK_WM(0x78d4, 0x0003fe00, 0x0ff),
+	RTW89_DECL_RFK_WM(0x78d4, 0x07fc0000, 0x100),
+	RTW89_DECL_RFK_WM(0x78d8, 0xffffffff, 0x8008016c),
+	RTW89_DECL_RFK_WM(0x78dc, 0x0001ffff, 0x0807f),
+	RTW89_DECL_RFK_WM(0x78dc, 0xfff00000, 0x800),
+	RTW89_DECL_RFK_WM(0x78f0, 0x0003ffff, 0x001ff),
+	RTW89_DECL_RFK_WM(0x78f4, 0x000fffff, 0x000),
+	RTW89_DECL_RFK_WM(0x78f8, 0x000fffff, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_txpwr_ctrl_bb_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58a0, 0xffffffff, 0x000000fe),
+	RTW89_DECL_RFK_WM(0x58e4, 0x0000007f, 0x1f),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78a0, 0xffffffff, 0x000000fe),
+	RTW89_DECL_RFK_WM(0x78e4, 0x0000007f, 0x1f),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_dck_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58c4, 0x3ffc0000, 0x0),
+	RTW89_DECL_RFK_WM(0x58c8, 0x00000fff, 0x0),
+	RTW89_DECL_RFK_WM(0x58c8, 0x00fff000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_dck_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_dck_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78c4, 0x3ffc0000, 0x0),
+	RTW89_DECL_RFK_WM(0x78c8, 0x00000fff, 0x0),
+	RTW89_DECL_RFK_WM(0x78c8, 0x00fff000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_dck_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_dck_defs_2g_a[] = {
+	RTW89_DECL_RFK_WM(0x580c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5814, 0x003ff000, 0x1af),
+	RTW89_DECL_RFK_WM(0x5814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_dck_defs_2g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_dck_defs_2g_b[] = {
+	RTW89_DECL_RFK_WM(0x780c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7814, 0x003ff000, 0x1af),
+	RTW89_DECL_RFK_WM(0x7814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_dck_defs_2g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_dck_defs_5g_a[] = {
+	RTW89_DECL_RFK_WM(0x580c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5814, 0x00001000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x0003c000, 0xb),
+	RTW89_DECL_RFK_WM(0x5814, 0x00002000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x003c0000, 0x6),
+	RTW89_DECL_RFK_WM(0x5814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_dck_defs_5g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_dck_defs_5g_b[] = {
+	RTW89_DECL_RFK_WM(0x780c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7814, 0x00001000, 0x1),
+	RTW89_DECL_RFK_WM(0x7814, 0x0003c000, 0xb),
+	RTW89_DECL_RFK_WM(0x7814, 0x00002000, 0x1),
+	RTW89_DECL_RFK_WM(0x7814, 0x003c0000, 0x6),
+	RTW89_DECL_RFK_WM(0x7814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_dck_defs_5g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_bbgain_split_a[] = {
+	RTW89_DECL_RFK_WM(0x5818, 0x08000000, 0x1),
+	RTW89_DECL_RFK_WM(0x58d4, 0xf0000000, 0x7),
+	RTW89_DECL_RFK_WM(0x58f0, 0x000c0000, 0x1),
+	RTW89_DECL_RFK_WM(0x58f0, 0xfff00000, 0x400),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_bbgain_split_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_bbgain_split_b[] = {
+	RTW89_DECL_RFK_WM(0x7818, 0x08000000, 0x1),
+	RTW89_DECL_RFK_WM(0x78d4, 0xf0000000, 0x7),
+	RTW89_DECL_RFK_WM(0x78f0, 0x000c0000, 0x1),
+	RTW89_DECL_RFK_WM(0x78f0, 0xfff00000, 0x400),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_bbgain_split_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_slope_cal_org_defs_2g_a[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0201020),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0801008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x0808081e),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x081d),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_slope_cal_org_defs_2g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_slope_cal_org_defs_2g_b[] = {
+	RTW89_DECL_RFK_WM(0x7608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x760c, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7610, 0x07ffffff, 0x0204020),
+	RTW89_DECL_RFK_WM(0x7614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7618, 0x07ffffff, 0x0801008),
+	RTW89_DECL_RFK_WM(0x761c, 0x000001ff, 0x020),
+	RTW89_DECL_RFK_WM(0x761c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x7620, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x7624, 0xffffffff, 0x08081e21),
+	RTW89_DECL_RFK_WM(0x7628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x762c, 0x0000ffff, 0x1d23),
+	RTW89_DECL_RFK_WM(0x781c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_slope_cal_org_defs_2g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_slope_cal_org_defs_5g_a[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_slope_cal_org_defs_5g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_slope_cal_org_defs_5g_b[] = {
+	RTW89_DECL_RFK_WM(0x7608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x760c, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x761c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x761c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x7620, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x7624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x7628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x762c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x781c, 0x00100000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_slope_cal_org_defs_5g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_2g_a[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x2d2721),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000ffc00, 0x3b8),
+	RTW89_DECL_RFK_WM(0x5634, 0x3ff00000, 0x3d2),
+	RTW89_DECL_RFK_WM(0x5638, 0x000003ff, 0x042),
+	RTW89_DECL_RFK_WM(0x5638, 0x000ffc00, 0x06b),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5640, 0x000ffc00, 0x3bc),
+	RTW89_DECL_RFK_WM(0x5640, 0x3ff00000, 0x3d6),
+	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x03e),
+	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x06b),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_2g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_2g_b[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x2d2721),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7634, 0x000ffc00, 0x3c0),
+	RTW89_DECL_RFK_WM(0x7634, 0x3ff00000, 0x3da),
+	RTW89_DECL_RFK_WM(0x7638, 0x000003ff, 0x002),
+	RTW89_DECL_RFK_WM(0x7638, 0x000ffc00, 0x071),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7640, 0x000ffc00, 0x3c8),
+	RTW89_DECL_RFK_WM(0x7640, 0x3ff00000, 0x3e2),
+	RTW89_DECL_RFK_WM(0x7644, 0x000003ff, 0x00c),
+	RTW89_DECL_RFK_WM(0x7644, 0x000ffc00, 0x071),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_2g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_5g_a[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x312600),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x5638, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x5638, 0x000ffc00, 0x07d),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5640, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3ff00000, 0x000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_5g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_5g_b[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x312600),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7634, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x7634, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x7638, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x7638, 0x000ffc00, 0x07d),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7640, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3ff00000, 0x000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000ffc00, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_5g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_6g_a[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x312600),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x5638, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x5638, 0x000ffc00, 0x080),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5640, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3ff00000, 0x000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_6g_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_set_aligk_default_defs_6g_b[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x312600),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7634, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x7634, 0x3ff00000, 0x3e9),
+	RTW89_DECL_RFK_WM(0x7638, 0x000003ff, 0x039),
+	RTW89_DECL_RFK_WM(0x7638, 0x000ffc00, 0x080),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7640, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3ff00000, 0x000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000ffc00, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_set_aligk_default_defs_6g_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_slope_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5818, 0x10000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5814, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x581c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x58e8, 0x0000003f, 0x0f),
+	RTW89_DECL_RFK_WM(0x581c, 0x000003ff, 0x280),
+	RTW89_DECL_RFK_WM(0x581c, 0x000ffc00, 0x200),
+	RTW89_DECL_RFK_WM(0x58b8, 0x007f0000, 0x00),
+	RTW89_DECL_RFK_WM(0x58b8, 0x7f000000, 0x00),
+	RTW89_DECL_RFK_WM(0x58b4, 0x7f000000, 0x0a),
+	RTW89_DECL_RFK_WM(0x58b8, 0x0000007f, 0x28),
+	RTW89_DECL_RFK_WM(0x58b8, 0x00007f00, 0x76),
+	RTW89_DECL_RFK_WM(0x5810, 0x20000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5814, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x580c, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x580c, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5834, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x5834, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5838, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5838, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x5854, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x5854, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5858, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5858, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x5824, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x5824, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5828, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5828, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x582c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x582c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5830, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5830, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x583c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x583c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5840, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5840, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x5844, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x5844, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5848, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5848, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x584c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x584c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5850, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5850, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x585c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x585c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5860, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x5860, 0x003ff000, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_slope_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_slope_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x7820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7818, 0x10000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7814, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x781c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x78e8, 0x0000003f, 0x0f),
+	RTW89_DECL_RFK_WM(0x781c, 0x000003ff, 0x280),
+	RTW89_DECL_RFK_WM(0x781c, 0x000ffc00, 0x200),
+	RTW89_DECL_RFK_WM(0x78b8, 0x007f0000, 0x00),
+	RTW89_DECL_RFK_WM(0x78b8, 0x7f000000, 0x00),
+	RTW89_DECL_RFK_WM(0x78b4, 0x7f000000, 0x0a),
+	RTW89_DECL_RFK_WM(0x78b8, 0x0000007f, 0x28),
+	RTW89_DECL_RFK_WM(0x78b8, 0x00007f00, 0x76),
+	RTW89_DECL_RFK_WM(0x7810, 0x20000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7814, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x780c, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x780c, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7834, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x7834, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7838, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7838, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x7854, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x7854, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7858, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7858, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x7824, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x7824, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7828, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7828, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x782c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x782c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7830, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7830, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x783c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x783c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7840, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7840, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x7844, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x7844, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7848, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7848, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x784c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x784c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7850, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7850, 0x003ff000, 0x000),
+	RTW89_DECL_RFK_WM(0x785c, 0x0003ffff, 0x115f2),
+	RTW89_DECL_RFK_WM(0x785c, 0x3ffc0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7860, 0x00000fff, 0x121),
+	RTW89_DECL_RFK_WM(0x7860, 0x003ff000, 0x000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_slope_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_run_slope_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_run_slope_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_run_slope_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x7820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7820, 0x80000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_run_slope_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_track_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5818, 0x10000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5814, 0x00000800, 0x0),
+	RTW89_DECL_RFK_WM(0x581c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5864, 0x000003ff, 0x1ff),
+	RTW89_DECL_RFK_WM(0x5864, 0x000ffc00, 0x200),
+	RTW89_DECL_RFK_WM(0x5820, 0x00000fff, 0x080),
+	RTW89_DECL_RFK_WM(0x5814, 0x01000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_track_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_track_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x7820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7818, 0x10000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7814, 0x00000800, 0x0),
+	RTW89_DECL_RFK_WM(0x781c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7864, 0x000003ff, 0x1ff),
+	RTW89_DECL_RFK_WM(0x7864, 0x000ffc00, 0x200),
+	RTW89_DECL_RFK_WM(0x7820, 0x00000fff, 0x080),
+	RTW89_DECL_RFK_WM(0x7814, 0x01000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_track_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_txagc_ofst_mv_avg_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58e4, 0x00003800, 0x1),
+	RTW89_DECL_RFK_WM(0x58e4, 0x00004000, 0x0),
+	RTW89_DECL_RFK_WM(0x58e4, 0x00008000, 0x1),
+	RTW89_DECL_RFK_WM(0x58e4, 0x000f0000, 0x0),
+	RTW89_DECL_RFK_WM(0x58e8, 0x0000003f, 0x03),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_txagc_ofst_mv_avg_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_txagc_ofst_mv_avg_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78e4, 0x00003800, 0x1),
+	RTW89_DECL_RFK_WM(0x78e4, 0x00004000, 0x0),
+	RTW89_DECL_RFK_WM(0x78e4, 0x00008000, 0x1),
+	RTW89_DECL_RFK_WM(0x78e4, 0x000f0000, 0x0),
+	RTW89_DECL_RFK_WM(0x78e8, 0x0000003f, 0x03),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_txagc_ofst_mv_avg_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_enable_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58e4, 0x00004000, 0x0),
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WRF(0x0, 0x10055, 0x00080, 0x1),
+	RTW89_DECL_RFK_WM(0x5818, 0x10000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_enable_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_enable_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78e4, 0x00004000, 0x0),
+	RTW89_DECL_RFK_WM(0x7820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7820, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WRF(0x1, 0x10055, 0x00080, 0x1),
+	RTW89_DECL_RFK_WM(0x7818, 0x10000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_enable_defs_b);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_disable_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5818, 0x10000000, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58e4, 0x00004000, 0x00000001),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_disable_defs_a);
+
+static const struct rtw89_reg5_def rtw8852c_tssi_disable_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x7820, 0x80000000, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7818, 0x10000000, 0x00000000),
+	RTW89_DECL_RFK_WM(0x78e4, 0x00004000, 0x00000001),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852c_tssi_disable_defs_b);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.h
new file mode 100644
index 0000000000000..953a960ef1e85
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk_table.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#ifndef __RTW89_8852C_RFK_TABLE_H__
+#define __RTW89_8852C_RFK_TABLE_H__
+
+#include "phy.h"
+
+extern const struct rtw89_rfk_tbl rtw8852c_dack_reload_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dack_reset_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dack_reset_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dack_defs_s0_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dack_defs_s1_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_drck_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_iqk_rxk_cfg_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_iqk_afebb_restore_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_iqk_afebb_restore_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_read_rxsram_pre_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_read_rxsram_post_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dpk_mdpd_order0_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dpk_mdpd_order1_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dpk_mdpd_order2_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dpk_mdpd_order3_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dpk_kip_pwr_clk_on_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_dpk_kip_pwr_clk_off_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_sys_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_sys_defs_2g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_sys_defs_2g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_sys_defs_5g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_sys_defs_5g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_txpwr_ctrl_bb_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_txpwr_ctrl_bb_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_txpwr_ctrl_bb_he_tb_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_dck_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_dck_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_dck_defs_2g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_dck_defs_2g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_dck_defs_5g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_dck_defs_5g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_bbgain_split_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_bbgain_split_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_slope_cal_org_defs_2g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_slope_cal_org_defs_2g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_slope_cal_org_defs_5g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_slope_cal_org_defs_5g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_aligk_default_defs_2g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_aligk_default_defs_2g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_aligk_default_defs_5g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_aligk_default_defs_5g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_aligk_default_defs_6g_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_set_aligk_default_defs_6g_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_slope_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_slope_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_run_slope_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_run_slope_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_track_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_track_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_txagc_ofst_mv_avg_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_txagc_ofst_mv_avg_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_enable_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_enable_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_disable_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852c_tssi_disable_defs_b_tbl;
+
+#endif
-- 
2.25.1

