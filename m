Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3060F5ED824
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiI1IsD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiI1IrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1EE53C176
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:44:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28S8i6dL5013391, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28S8i6dL5013391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Sep 2022 16:44:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Sep 2022 16:44:31 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 28 Sep
 2022 16:44:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/9] wifi: rtw89: 8852b: add tables for RFK
Date:   Wed, 28 Sep 2022 16:43:30 +0800
Message-ID: <20220928084336.34981-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928084336.34981-1-pkshih@realtek.com>
References: <20220928084336.34981-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/28/2022 08:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjggpFekyCAwNzowMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

These tables are used by RFK to assist to configure PHY and RF registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../realtek/rtw89/rtw8852b_rfk_table.c        | 794 ++++++++++++++++++
 .../realtek/rtw89/rtw8852b_rfk_table.h        |  62 ++
 2 files changed, 856 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.h

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.c
new file mode 100644
index 0000000000000..0b8a210bb10b7
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.c
@@ -0,0 +1,794 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "rtw8852b_rfk_table.h"
+
+static const struct rtw89_reg5_def rtw8852b_afe_init_defs[] = {
+	RTW89_DECL_RFK_WM(0xC0D4, 0xffffffff, 0x4486888c),
+	RTW89_DECL_RFK_WM(0xC0D8, 0xffffffff, 0xc6ba10e0),
+	RTW89_DECL_RFK_WM(0xc0dc, 0xffffffff, 0x30c52868),
+	RTW89_DECL_RFK_WM(0xc0e0, 0xffffffff, 0x05008128),
+	RTW89_DECL_RFK_WM(0xc0e4, 0xffffffff, 0x0000272b),
+	RTW89_DECL_RFK_WM(0xC1D4, 0xffffffff, 0x4486888c),
+	RTW89_DECL_RFK_WM(0xC1D8, 0xffffffff, 0xc6ba10e0),
+	RTW89_DECL_RFK_WM(0xc1dc, 0xffffffff, 0x30c52868),
+	RTW89_DECL_RFK_WM(0xc1e0, 0xffffffff, 0x05008128),
+	RTW89_DECL_RFK_WM(0xc1e4, 0xffffffff, 0x0000272b),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_afe_init_defs);
+
+static const struct rtw89_reg5_def rtw8852b_check_addc_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x20f4, BIT(24), 0x0),
+	RTW89_DECL_RFK_WM(0x20f8, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x20f0, 0xff0000, 0x1),
+	RTW89_DECL_RFK_WM(0x20f0, 0xf00, 0x2),
+	RTW89_DECL_RFK_WM(0x20f0, 0xf, 0x0),
+	RTW89_DECL_RFK_WM(0x20f0, 0xc0, 0x2),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_check_addc_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_check_addc_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x20f4, BIT(24), 0x0),
+	RTW89_DECL_RFK_WM(0x20f8, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x20f0, 0xff0000, 0x1),
+	RTW89_DECL_RFK_WM(0x20f0, 0xf00, 0x2),
+	RTW89_DECL_RFK_WM(0x20f0, 0xf, 0x0),
+	RTW89_DECL_RFK_WM(0x20f0, 0xc0, 0x3),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_check_addc_defs_b);
+
+static const struct rtw89_reg5_def rtw8852b_check_dadc_en_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x032C, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0x030C, 0x0f000000, 0xf),
+	RTW89_DECL_RFK_WM(0x030C, 0x0f000000, 0x3),
+	RTW89_DECL_RFK_WM(0x032C, BIT(16), 0x0),
+	RTW89_DECL_RFK_WM(0x12dc, BIT(0), 0x1),
+	RTW89_DECL_RFK_WM(0x12e8, BIT(2), 0x1),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x8f, BIT(13), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_check_dadc_en_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_check_dadc_en_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x032C, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0x030C, 0x0f000000, 0xf),
+	RTW89_DECL_RFK_WM(0x030C, 0x0f000000, 0x3),
+	RTW89_DECL_RFK_WM(0x032C, BIT(16), 0x0),
+	RTW89_DECL_RFK_WM(0x32dc, BIT(0), 0x1),
+	RTW89_DECL_RFK_WM(0x32e8, BIT(2), 0x1),
+	RTW89_DECL_RFK_WRF(RF_PATH_B, 0x8f, BIT(13), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_check_dadc_en_defs_b);
+
+static const struct rtw89_reg5_def rtw8852b_check_dadc_dis_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x12dc, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0x12e8, BIT(2), 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x8f, BIT(13), 0x0),
+	RTW89_DECL_RFK_WM(0x032C, BIT(16), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_check_dadc_dis_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_check_dadc_dis_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x32dc, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0x32e8, BIT(2), 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_B, 0x8f, BIT(13), 0x0),
+	RTW89_DECL_RFK_WM(0x032C, BIT(16), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_check_dadc_dis_defs_b);
+
+static const struct rtw89_reg5_def rtw8852b_dack_s0_1_defs[] = {
+	RTW89_DECL_RFK_WM(0x12A0, BIT(15), 0x1),
+	RTW89_DECL_RFK_WM(0x12A0, 0x00007000, 0x3),
+	RTW89_DECL_RFK_WM(0x12B8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x030C, BIT(28), 0x1),
+	RTW89_DECL_RFK_WM(0x032C, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0xC0D8, BIT(16), 0x1),
+	RTW89_DECL_RFK_WM(0xc0dc, 0x0c000000, 0x3),
+	RTW89_DECL_RFK_WM(0xC004, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0xc024, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0xC004, 0x3ff00000, 0x30),
+	RTW89_DECL_RFK_WM(0xC004, 0xc0000000, 0x0),
+	RTW89_DECL_RFK_WM(0xC004, BIT(17), 0x1),
+	RTW89_DECL_RFK_WM(0xc024, BIT(17), 0x1),
+	RTW89_DECL_RFK_WM(0xc00c, BIT(2), 0x0),
+	RTW89_DECL_RFK_WM(0xc02c, BIT(2), 0x0),
+	RTW89_DECL_RFK_WM(0xC004, BIT(0), 0x1),
+	RTW89_DECL_RFK_WM(0xc024, BIT(0), 0x1),
+	RTW89_DECL_RFK_DELAY(1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dack_s0_1_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dack_s0_2_defs[] = {
+	RTW89_DECL_RFK_WM(0xc0dc, 0x0c000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc00c, BIT(2), 0x1),
+	RTW89_DECL_RFK_WM(0xc02c, BIT(2), 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dack_s0_2_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dack_s0_3_defs[] = {
+	RTW89_DECL_RFK_WM(0xC004, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0xc024, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0xC0D8, BIT(16), 0x0),
+	RTW89_DECL_RFK_WM(0x12A0, BIT(15), 0x0),
+	RTW89_DECL_RFK_WM(0x12A0, 0x00007000, 0x7),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dack_s0_3_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dack_s1_1_defs[] = {
+	RTW89_DECL_RFK_WM(0x32a0, BIT(15), 0x1),
+	RTW89_DECL_RFK_WM(0x32a0, 0x7000, 0x3),
+	RTW89_DECL_RFK_WM(0x32B8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x030C, BIT(28), 0x1),
+	RTW89_DECL_RFK_WM(0x032C, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0xC1D8, BIT(16), 0x1),
+	RTW89_DECL_RFK_WM(0xc1dc, 0x0c000000, 0x3),
+	RTW89_DECL_RFK_WM(0xc104, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0xc124, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0xc104, 0x3ff00000, 0x30),
+	RTW89_DECL_RFK_WM(0xc104, 0xc0000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc104, BIT(17), 0x1),
+	RTW89_DECL_RFK_WM(0xc124, BIT(17), 0x1),
+	RTW89_DECL_RFK_WM(0xc10c, BIT(2), 0x0),
+	RTW89_DECL_RFK_WM(0xc12c, BIT(2), 0x0),
+	RTW89_DECL_RFK_WM(0xc104, BIT(0), 0x1),
+	RTW89_DECL_RFK_WM(0xc124, BIT(0), 0x1),
+	RTW89_DECL_RFK_DELAY(1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dack_s1_1_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dack_s1_2_defs[] = {
+	RTW89_DECL_RFK_WM(0xc1dc, 0x0c000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc10c, BIT(2), 0x1),
+	RTW89_DECL_RFK_WM(0xc12c, BIT(2), 0x1),
+	RTW89_DECL_RFK_DELAY(1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dack_s1_2_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dack_s1_3_defs[] = {
+	RTW89_DECL_RFK_WM(0xc104, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0xc124, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0xC1D8, BIT(16), 0x0),
+	RTW89_DECL_RFK_WM(0x32a0, BIT(15), 0x0),
+	RTW89_DECL_RFK_WM(0x32a0, 0x7000, 0x7),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dack_s1_3_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dpk_afe_defs[] = {
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x0303),
+	RTW89_DECL_RFK_WM(0x12b8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x32b8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x13),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+	RTW89_DECL_RFK_WM(0x12b8, BIT(28), 0x1),
+	RTW89_DECL_RFK_WM(0x58c8, BIT(24), 0x1),
+	RTW89_DECL_RFK_WM(0x78c8, BIT(24), 0x1),
+	RTW89_DECL_RFK_WM(0x5864, 0xc0000000, 0x3),
+	RTW89_DECL_RFK_WM(0x7864, 0xc0000000, 0x3),
+	RTW89_DECL_RFK_WM(0x2008, 0x01FFFFFF, 0x1ffffff),
+	RTW89_DECL_RFK_WM(0x0c1c, BIT(2), 0x1),
+	RTW89_DECL_RFK_WM(0x0700, BIT(27), 0x1),
+	RTW89_DECL_RFK_WM(0x0c70, 0x000003FF, 0x3ff),
+	RTW89_DECL_RFK_WM(0x0c60, 0x00000003, 0x3),
+	RTW89_DECL_RFK_WM(0x0c6c, BIT(0), 0x1),
+	RTW89_DECL_RFK_WM(0x58ac, BIT(27), 0x1),
+	RTW89_DECL_RFK_WM(0x78ac, BIT(27), 0x1),
+	RTW89_DECL_RFK_WM(0x0c3c, BIT(9), 0x1),
+	RTW89_DECL_RFK_WM(0x2344, BIT(31), 0x1),
+	RTW89_DECL_RFK_WM(0x4490, BIT(31), 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x000ff000, 0xbf),
+	RTW89_DECL_RFK_WM(0x32a0, 0x000f0000, 0xb),
+	RTW89_DECL_RFK_WM(0x0700, 0x07000000, 0x5),
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x3333),
+	RTW89_DECL_RFK_WM(0x580c, BIT(15), 0x1),
+	RTW89_DECL_RFK_WM(0x5800, 0x0000ffff, 0x0000),
+	RTW89_DECL_RFK_WM(0x780c, BIT(15), 0x1),
+	RTW89_DECL_RFK_WM(0x7800, 0x0000ffff, 0x0000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dpk_afe_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dpk_afe_restore_defs[] = {
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x0303),
+	RTW89_DECL_RFK_WM(0x12b8, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0x32b8, BIT(30), 0x0),
+	RTW89_DECL_RFK_WM(0x5864, 0xc0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x7864, 0xc0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x2008, 0x01FFFFFF, 0x0),
+	RTW89_DECL_RFK_WM(0x0c1c, BIT(2), 0x0),
+	RTW89_DECL_RFK_WM(0x0700, BIT(27), 0x0),
+	RTW89_DECL_RFK_WM(0x0c70, 0x000003FF, 0x63),
+	RTW89_DECL_RFK_WM(0x12a0, 0x000FF000, 0x00),
+	RTW89_DECL_RFK_WM(0x32a0, 0x000FF000, 0x00),
+	RTW89_DECL_RFK_WM(0x0700, 0x07000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5864, BIT(29), 0x0),
+	RTW89_DECL_RFK_WM(0x7864, BIT(29), 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x0000),
+	RTW89_DECL_RFK_WM(0x58c8, BIT(24), 0x0),
+	RTW89_DECL_RFK_WM(0x78c8, BIT(24), 0x0),
+	RTW89_DECL_RFK_WM(0x0c3c, BIT(9), 0x0),
+	RTW89_DECL_RFK_WM(0x580c, BIT(15), 0x0),
+	RTW89_DECL_RFK_WM(0x58e4, 0x18000000, 0x1),
+	RTW89_DECL_RFK_WM(0x58e4, 0x18000000, 0x2),
+	RTW89_DECL_RFK_WM(0x780c, BIT(15), 0x0),
+	RTW89_DECL_RFK_WM(0x78e4, 0x18000000, 0x1),
+	RTW89_DECL_RFK_WM(0x78e4, 0x18000000, 0x2),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dpk_afe_restore_defs);
+
+static const struct rtw89_reg5_def rtw8852b_dpk_kip_defs[] = {
+	RTW89_DECL_RFK_WM(0x8008, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x8088, 0xffffffff, 0x80000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_dpk_kip_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_sys_defs[] = {
+	RTW89_DECL_RFK_WM(0x12a8, 0x0000000f, 0x5),
+	RTW89_DECL_RFK_WM(0x32a8, 0x0000000f, 0x5),
+	RTW89_DECL_RFK_WM(0x12bc, 0x000ffff0, 0x5555),
+	RTW89_DECL_RFK_WM(0x32bc, 0x000ffff0, 0x5555),
+	RTW89_DECL_RFK_WM(0x0300, 0xff000000, 0x16),
+	RTW89_DECL_RFK_WM(0x0304, 0x000000ff, 0x19),
+	RTW89_DECL_RFK_WM(0x0314, 0xffff0000, 0x2041),
+	RTW89_DECL_RFK_WM(0x0318, 0xffffffff, 0x2041),
+	RTW89_DECL_RFK_WM(0x0318, 0xffffffff, 0x20012041),
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
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_sys_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_sys_a_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x33),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x33),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1e),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_sys_a_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_sys_a_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x44),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x44),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x0),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1d),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_sys_a_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_sys_b_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x32c0, 0x0ff00000, 0x33),
+	RTW89_DECL_RFK_WM(0x320c, 0x000000ff, 0x33),
+	RTW89_DECL_RFK_WM(0x78f8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1e),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_sys_b_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_sys_b_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x32c0, 0x0ff00000, 0x44),
+	RTW89_DECL_RFK_WM(0x320c, 0x000000ff, 0x44),
+	RTW89_DECL_RFK_WM(0x78f8, 0x40000000, 0x0),
+	RTW89_DECL_RFK_WM(0x0304, 0x0000ff00, 0x1d),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_sys_b_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_init_txpwr_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x5800, 0xffffffff, 0x003f807f),
+	RTW89_DECL_RFK_WM(0x580c, 0x0000007f, 0x40),
+	RTW89_DECL_RFK_WM(0x580c, 0x0fffff00, 0x00040),
+	RTW89_DECL_RFK_WM(0x5810, 0xffffffff, 0x59010000),
+	RTW89_DECL_RFK_WM(0x5814, 0x01ffffff, 0x002d000),
+	RTW89_DECL_RFK_WM(0x5814, 0xf8000000, 0x00),
+	RTW89_DECL_RFK_WM(0x5818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x581c, 0x3fffffff, 0x1dc80280),
+	RTW89_DECL_RFK_WM(0x5820, 0xffffffff, 0x00002080),
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
+	RTW89_DECL_RFK_WM(0x58b0, 0xffffffff, 0x00000000),
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
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_init_txpwr_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_init_txpwr_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x7800, 0xffffffff, 0x003f807f),
+	RTW89_DECL_RFK_WM(0x780c, 0x0000007f, 0x40),
+	RTW89_DECL_RFK_WM(0x780c, 0x0fffff00, 0x00040),
+	RTW89_DECL_RFK_WM(0x7810, 0xffffffff, 0x59010000),
+	RTW89_DECL_RFK_WM(0x7814, 0x01ffffff, 0x002d000),
+	RTW89_DECL_RFK_WM(0x7814, 0xf8000000, 0x00),
+	RTW89_DECL_RFK_WM(0x7818, 0xffffffff, 0x002c1800),
+	RTW89_DECL_RFK_WM(0x781c, 0x3fffffff, 0x1dc80280),
+	RTW89_DECL_RFK_WM(0x7820, 0xffffffff, 0x00002080),
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
+	RTW89_DECL_RFK_WM(0x78b0, 0xffffffff, 0x00000000),
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
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_init_txpwr_defs_b);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_init_txpwr_he_tb_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58a0, 0xffffffff, 0x000000fe),
+	RTW89_DECL_RFK_WM(0x58e4, 0x0000007f, 0x1f),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_init_txpwr_he_tb_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_init_txpwr_he_tb_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78a0, 0xffffffff, 0x000000fe),
+	RTW89_DECL_RFK_WM(0x78e4, 0x0000007f, 0x1f),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_init_txpwr_he_tb_defs_b);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_dck_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x580c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5814, 0x003ff000, 0x0ef),
+	RTW89_DECL_RFK_WM(0x5814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_dck_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_dck_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x780c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x7814, 0x003ff000, 0x0ef),
+	RTW89_DECL_RFK_WM(0x7814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_dck_defs_b);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_dac_gain_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58b0, 0x00000400, 0x1),
+	RTW89_DECL_RFK_WM(0x58b0, 0x00000fff, 0x000),
+	RTW89_DECL_RFK_WM(0x58b0, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x5a00, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a04, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a08, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a0c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a10, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a14, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a18, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a1c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a20, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a24, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a28, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a2c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a30, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a34, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a38, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a3c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a40, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a44, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a48, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a4c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a50, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a54, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a58, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a5c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a60, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a64, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a68, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a6c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a70, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a74, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a78, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a7c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a80, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a84, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a88, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a8c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a90, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a94, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a98, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a9c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aac, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5abc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ac0, 0xffffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_dac_gain_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_dac_gain_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x78b0, 0x00000fff, 0x000),
+	RTW89_DECL_RFK_WM(0x78b0, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x7a00, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a04, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a08, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a0c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a10, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a14, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a18, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a1c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a20, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a24, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a28, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a2c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a30, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a34, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a38, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a3c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a40, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a44, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a48, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a4c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a50, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a54, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a58, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a5c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a60, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a64, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a68, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a6c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a70, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a74, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a78, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a7c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a80, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a84, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a88, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a8c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a90, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a94, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a98, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7a9c, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aa0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aa4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aa8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7aac, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ab0, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ab4, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ab8, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7abc, 0xffffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7ac0, 0xffffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_dac_gain_defs_b);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_slope_a_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0801008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0201020),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0804008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_slope_a_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_slope_a_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0201020),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x08081e08),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_slope_a_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_slope_b_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x7608, 0x07ffffff, 0x0801008),
+	RTW89_DECL_RFK_WM(0x760c, 0x07ffffff, 0x0201020),
+	RTW89_DECL_RFK_WM(0x7610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7614, 0x07ffffff, 0x0804008),
+	RTW89_DECL_RFK_WM(0x7618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x761c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x761c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x7620, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x7624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x7628, 0xffffffff, 0x08081e28),
+	RTW89_DECL_RFK_WM(0x762c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x781c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_slope_b_defs_2g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_slope_b_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x7608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x760c, 0x07ffffff, 0x0201020),
+	RTW89_DECL_RFK_WM(0x7610, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x7618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x761c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x761c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x7620, 0xffffffff, 0x08081e08),
+	RTW89_DECL_RFK_WM(0x7624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x7628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x762c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x781c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_slope_b_defs_5g);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_2g_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x01ef27af),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000075),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x017f13ae),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x0000006e),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_2g_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_2g_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x01ef27af),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000075),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x017f13ae),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x0000006e),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_2g_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_5g1_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x016037e7),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x0000006f),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_5g1_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_5g1_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x016037e7),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x0000006f),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_5g1_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_5g2_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x01f053f1),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000070),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_5g2_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_5g2_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x01f053f1),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000070),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_5g2_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_5g3_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x01c047ee),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000070),
+	RTW89_DECL_RFK_WM(0x5638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_5g3_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_a_5g3_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x01c047ee),
+	RTW89_DECL_RFK_WM(0x5634, 0x3fffffff, 0x00000070),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_a_5g3_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_2g_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x01ff2bb5),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000078),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x018f2bb0),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000072),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_2g_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_2g_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x01ff2bb5),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000078),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x018f2bb0),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000072),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_2g_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_5g1_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x009003da),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000069),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_5g1_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_5g1_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x009003da),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000069),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_5g1_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_5g2_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x013027e6),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000069),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_5g2_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_5g2_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x013027e6),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000069),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_5g2_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_5g3_all_defs[] = {
+	RTW89_DECL_RFK_WM(0x7604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7600, 0x3fffffff, 0x3f2d2721),
+	RTW89_DECL_RFK_WM(0x7604, 0x003fffff, 0x010101),
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x009003da),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000069),
+	RTW89_DECL_RFK_WM(0x7638, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_5g3_all_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_align_b_5g3_part_defs[] = {
+	RTW89_DECL_RFK_WM(0x7630, 0x3fffffff, 0x009003da),
+	RTW89_DECL_RFK_WM(0x7634, 0x3fffffff, 0x00000069),
+	RTW89_DECL_RFK_WM(0x763c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x7640, 0x3fffffff, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_align_b_5g3_part_defs);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_slope_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x5814, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x581c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x20000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_slope_defs_a);
+
+static const struct rtw89_reg5_def rtw8852b_tssi_slope_defs_b[] = {
+	RTW89_DECL_RFK_WM(0x7814, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x781c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x7814, 0x20000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8852b_tssi_slope_defs_b);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.h
new file mode 100644
index 0000000000000..b4d6e9851ff99
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_8852B_RFK_TABLE_H__
+#define __RTW89_8852B_RFK_TABLE_H__
+
+#include "phy.h"
+
+extern const struct rtw89_rfk_tbl rtw8852b_afe_init_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_check_addc_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_check_addc_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_check_dadc_en_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_check_dadc_en_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_check_dadc_dis_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_check_dadc_dis_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dack_s0_1_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dack_s0_2_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dack_s0_3_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dack_s1_1_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dack_s1_2_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dack_s1_3_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dpk_afe_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dpk_afe_restore_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_dpk_kip_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_sys_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_sys_a_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_sys_a_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_sys_b_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_sys_b_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_init_txpwr_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_init_txpwr_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_init_txpwr_he_tb_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_init_txpwr_he_tb_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_dck_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_dck_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_dac_gain_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_dac_gain_defs_b_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_slope_a_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_slope_a_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_slope_b_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_slope_b_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_2g_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_2g_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_5g1_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_5g1_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_5g2_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_5g2_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_5g3_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_a_5g3_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_2g_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_2g_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_5g1_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_5g1_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_5g2_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_5g2_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_5g3_all_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_align_b_5g3_part_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_slope_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8852b_tssi_slope_defs_b_tbl;
+
+#endif
-- 
2.25.1

