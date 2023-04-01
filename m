Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0436D314B
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjDAO11 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjDAO1X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 10:27:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC91CB81
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 07:27:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 331EQsD22013323, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 331EQsD22013323
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 1 Apr 2023 22:26:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 1 Apr 2023 22:27:12 +0800
Received: from localhost (172.16.16.15) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 1 Apr 2023
 22:27:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: 8851b: add tables for RFK
Date:   Sat, 1 Apr 2023 22:25:48 +0800
Message-ID: <20230401142548.55466-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230401142548.55466-1-pkshih@realtek.com>
References: <20230401142548.55466-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.15]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These tables are used by RF calibrations to assist to configure PHY and
RF registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../realtek/rtw89/rtw8851b_rfk_table.c        | 534 ++++++++++++++++++
 .../realtek/rtw89/rtw8851b_rfk_table.h        |  38 ++
 2 files changed, 572 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
new file mode 100644
index 0000000000000..0abf7978ccab1
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2022-2023  Realtek Corporation
+ */
+
+#include "rtw8851b_rfk_table.h"
+
+static const struct rtw89_reg5_def rtw8851b_dadck_setup_defs[] = {
+	RTW89_DECL_RFK_WM(0xc210, 0x003fc000, 0x80),
+	RTW89_DECL_RFK_WM(0xc224, 0x003fc000, 0x80),
+	RTW89_DECL_RFK_WM(0xc0f8, 0x30000000, 0x3),
+	RTW89_DECL_RFK_WM(0x12b8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x030c, 0x1f000000, 0x1f),
+	RTW89_DECL_RFK_WM(0x032c, 0xc0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x032c, BIT(22), 0x0),
+	RTW89_DECL_RFK_WM(0x032c, BIT(22), 0x1),
+	RTW89_DECL_RFK_WM(0x032c, BIT(16), 0x0),
+	RTW89_DECL_RFK_WM(0x032c, BIT(20), 0x1),
+	RTW89_DECL_RFK_WM(0x030c, 0x0f000000, 0x3),
+	RTW89_DECL_RFK_WM(0xc0f4, BIT(2), 0x0),
+	RTW89_DECL_RFK_WM(0xc0f4, BIT(4), 0x0),
+	RTW89_DECL_RFK_WM(0xc0f4, BIT(11), 0x1),
+	RTW89_DECL_RFK_WM(0xc0f4, BIT(11), 0x0),
+	RTW89_DECL_RFK_DELAY(1),
+	RTW89_DECL_RFK_WM(0xc0f4, 0x300, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_dadck_setup_defs);
+
+static const struct rtw89_reg5_def rtw8851b_dadck_post_defs[] = {
+	RTW89_DECL_RFK_WM(0x032c, BIT(16), 0x1),
+	RTW89_DECL_RFK_WM(0x032c, BIT(20), 0x0),
+	RTW89_DECL_RFK_WM(0x030c, 0x1f000000, 0xc),
+	RTW89_DECL_RFK_WM(0x032c, 0xc0000000, 0x1),
+	RTW89_DECL_RFK_WM(0x12b8, BIT(30), 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_dadck_post_defs);
+
+static const struct rtw89_reg5_def rtw8851b_dack_s0_1_defs[] = {
+	RTW89_DECL_RFK_WM(0x12a0, BIT(15), 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x7000, 0x3),
+	RTW89_DECL_RFK_WM(0x12b8, BIT(30), 0x1),
+	RTW89_DECL_RFK_WM(0x030c, BIT(28), 0x1),
+	RTW89_DECL_RFK_WM(0x032c, 0x80000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_dack_s0_1_defs);
+
+static const struct rtw89_reg5_def rtw8851b_dack_s0_2_defs[] = {
+	RTW89_DECL_RFK_WM(0xc004, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0x12a0, BIT(15), 0x0),
+	RTW89_DECL_RFK_WM(0x12a0, 0x7000, 0x7),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_dack_s0_2_defs);
+
+static const struct rtw89_reg5_def rtw8851b_dack_manual_off_defs[] = {
+	RTW89_DECL_RFK_WM(0xc0f8, 0x30000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc210, BIT(0), 0x0),
+	RTW89_DECL_RFK_WM(0xc224, BIT(0), 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_dack_manual_off_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_rxclk_80_defs[] = {
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x0101),
+	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x2),
+	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x1),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x8),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x2),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x2),
+	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x5),
+	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xf),
+	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x0),
+	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x0f),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x03),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0001),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x1101),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_rxclk_80_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_rxclk_others_defs[] = {
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x0101),
+	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x2),
+	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x8),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x2),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x2),
+	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x5),
+	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xf),
+	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x2),
+	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x0f),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x03),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0001),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+	RTW89_DECL_RFK_WM(0x20fc, 0xffff0000, 0x1101),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_rxclk_others_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_txk_2ghz_defs[] = {
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x51, 0x80000, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x51, 0x00800, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x52, 0x00800, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x55, 0x0001f, 0x4),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0xef, 0x00004, 0x1),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x00, 0xffff0, 0x403e),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x11, 0x00003, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x11, 0x00070, 0x6),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x11, 0x1f000, 0x10),
+	RTW89_DECL_RFK_DELAY(1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_txk_2ghz_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_txk_5ghz_defs[] = {
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x60, 0x00007, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x55, 0x0001f, 0x4),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0xef, 0x00004, 0x1),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x00, 0xffff0, 0x403e),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x11, 0x00003, 0x0),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x11, 0x00070, 0x7),
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x11, 0x1f000, 0x7),
+	RTW89_DECL_RFK_DELAY(1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_txk_5ghz_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_afebb_restore_defs[] = {
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
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_afebb_restore_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_macbb_defs[] = {
+	RTW89_DECL_RFK_WRF(RF_PATH_A, 0x10005, 0x00001, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00010000, 0x1),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00100000, 0x0),
+	RTW89_DECL_RFK_WM(0x20fc, 0x01000000, 0x1),
+	RTW89_DECL_RFK_WM(0x20fc, 0x10000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5670, MASKDWORD, 0xf801fffd),
+	RTW89_DECL_RFK_WM(0x5670, 0x00004000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00008000, 0x1),
+	RTW89_DECL_RFK_WM(0x5670, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00007000, 0x7),
+	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x3),
+	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x2),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x9),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x1),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x3),
+	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xa),
+	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x0),
+	RTW89_DECL_RFK_WM(0xc0e8, 0x00000040, 0x1),
+	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x1f),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x13),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0001),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+	RTW89_DECL_RFK_WM(0x20fc, 0x00100000, 0x1),
+	RTW89_DECL_RFK_WM(0x20fc, 0x10000000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_macbb_defs);
+
+static const struct rtw89_reg5_def rtw8851b_iqk_bb_afe_defs[] = {
+	RTW89_DECL_RFK_WM(0x5670, 0x00004000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00008000, 0x1),
+	RTW89_DECL_RFK_WM(0x5670, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00007000, 0x7),
+	RTW89_DECL_RFK_WM(0x5670, 0x00002000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00080000, 0x1),
+	RTW89_DECL_RFK_WM(0x12a0, 0x00070000, 0x3),
+	RTW89_DECL_RFK_WM(0x5670, 0x60000000, 0x2),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00000780, 0x9),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x00007800, 0x1),
+	RTW89_DECL_RFK_WM(0xc0d4, 0x0c000000, 0x0),
+	RTW89_DECL_RFK_WM(0xc0d8, 0x000001e0, 0x3),
+	RTW89_DECL_RFK_WM(0xc0c4, 0x003e0000, 0xa),
+	RTW89_DECL_RFK_WM(0xc0ec, 0x00006000, 0x0),
+	RTW89_DECL_RFK_WM(0xc0e8, 0x00000040, 0x1),
+	RTW89_DECL_RFK_WM(0x12b8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x030c, MASKBYTE3, 0x1f),
+	RTW89_DECL_RFK_WM(0x030c, MASKBYTE3, 0x13),
+	RTW89_DECL_RFK_WM(0x032c, MASKHWORD, 0x0001),
+	RTW89_DECL_RFK_WM(0x032c, MASKHWORD, 0x0041),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_iqk_bb_afe_defs);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_sys_defs[] = {
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
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_sys_defs);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_sys_a_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x33),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x33),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x20000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_sys_a_defs_2g);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_sys_a_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x120c, 0x000000ff, 0x44),
+	RTW89_DECL_RFK_WM(0x12c0, 0x0ff00000, 0x44),
+	RTW89_DECL_RFK_WM(0x58f8, 0x40000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5814, 0x20000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_sys_a_defs_5g);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_init_txpwr_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x566c, 0x00001000, 0x0),
+	RTW89_DECL_RFK_WM(0x5800, 0xffffffff, 0x003f807f),
+	RTW89_DECL_RFK_WM(0x580c, 0x0000007f, 0x40),
+	RTW89_DECL_RFK_WM(0x580c, 0x0fffff00, 0x00040),
+	RTW89_DECL_RFK_WM(0x5810, 0xffffffff, 0x59010000),
+	RTW89_DECL_RFK_WM(0x5814, 0x01ffffff, 0x026d000),
+	RTW89_DECL_RFK_WM(0x5814, 0xf8000000, 0x00),
+	RTW89_DECL_RFK_WM(0x5818, 0x00ffffff, 0x2c18e8),
+	RTW89_DECL_RFK_WM(0x5818, 0x07000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5818, 0xf0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x581c, 0x3fffffff, 0x3dc80280),
+	RTW89_DECL_RFK_WM(0x5820, 0xffffffff, 0x00000080),
+	RTW89_DECL_RFK_WM(0x58e8, 0x0000003f, 0x04),
+	RTW89_DECL_RFK_WM(0x580c, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x580c, 0x40000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5834, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x5838, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x5854, 0x3fffffff, 0x000115f2),
+	RTW89_DECL_RFK_WM(0x5858, 0x7fffffff, 0x0000121),
+	RTW89_DECL_RFK_WM(0x5860, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5864, 0x07ffffff, 0x00801ff),
+	RTW89_DECL_RFK_WM(0x5898, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x589c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58a4, 0x000000ff, 0x16),
+	RTW89_DECL_RFK_WM(0x58b0, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58b4, 0x7fffffff, 0x0a002000),
+	RTW89_DECL_RFK_WM(0x58b8, 0x7fffffff, 0x00007628),
+	RTW89_DECL_RFK_WM(0x58bc, 0x07ffffff, 0x7a7807f),
+	RTW89_DECL_RFK_WM(0x58c0, 0xfffe0000, 0x003f),
+	RTW89_DECL_RFK_WM(0x58c4, 0xffffffff, 0x0003ffff),
+	RTW89_DECL_RFK_WM(0x58c8, 0x00ffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x58c8, 0xf0000000, 0x0),
+	RTW89_DECL_RFK_WM(0x58cc, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x58d0, 0x07ffffff, 0x2008101),
+	RTW89_DECL_RFK_WM(0x58d4, 0x000000ff, 0x00),
+	RTW89_DECL_RFK_WM(0x58d4, 0x0003fe00, 0x0ff),
+	RTW89_DECL_RFK_WM(0x58d4, 0x07fc0000, 0x100),
+	RTW89_DECL_RFK_WM(0x58d8, 0xffffffff, 0x8008016c),
+	RTW89_DECL_RFK_WM(0x58dc, 0x0001ffff, 0x0807f),
+	RTW89_DECL_RFK_WM(0x58dc, 0xfff00000, 0x800),
+	RTW89_DECL_RFK_WM(0x58f0, 0x0003ffff, 0x001ff),
+	RTW89_DECL_RFK_WM(0x58f4, 0x000fffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x58f8, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_init_txpwr_defs_a);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_init_txpwr_he_tb_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58a0, MASKDWORD, 0x000000fe),
+	RTW89_DECL_RFK_WM(0x58e4, 0x0000007f, 0x1f),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_init_txpwr_he_tb_defs_a);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_dck_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x580c, 0x0fff0000, 0x000),
+	RTW89_DECL_RFK_WM(0x5814, 0x00001000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x00002000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x00004000, 0x1),
+	RTW89_DECL_RFK_WM(0x5814, 0x00038000, 0x3),
+	RTW89_DECL_RFK_WM(0x5814, 0x003c0000, 0x5),
+	RTW89_DECL_RFK_WM(0x5814, 0x18000000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_dck_defs_a);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_dac_gain_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58b0, 0x00000fff, 0x000),
+	RTW89_DECL_RFK_WM(0x5a00, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a04, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a08, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a0c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a10, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a14, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a18, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a1c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a20, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a24, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a28, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a2c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a30, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a34, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a38, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a3c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a40, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a44, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a48, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a4c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a50, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a54, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a58, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a5c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a60, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a64, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a68, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a6c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a70, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a74, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a78, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a7c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a80, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a84, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a88, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a8c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a90, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a94, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a98, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5a9c, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa0, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa4, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aa8, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5aac, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab0, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab4, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ab8, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5abc, MASKDWORD, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5ac0, MASKDWORD, 0x00000000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_dac_gain_defs_a);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_slope_a_defs_2g[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0200e08),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x007),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_slope_a_defs_2g);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_slope_a_defs_5g[] = {
+	RTW89_DECL_RFK_WM(0x5608, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x560c, 0x07ffffff, 0x0341a08),
+	RTW89_DECL_RFK_WM(0x5610, 0x07ffffff, 0x0201417),
+	RTW89_DECL_RFK_WM(0x5614, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x5618, 0x07ffffff, 0x0201008),
+	RTW89_DECL_RFK_WM(0x561c, 0x000001ff, 0x008),
+	RTW89_DECL_RFK_WM(0x561c, 0xffff0000, 0x0808),
+	RTW89_DECL_RFK_WM(0x5620, 0xffffffff, 0x0e0e0808),
+	RTW89_DECL_RFK_WM(0x5624, 0xffffffff, 0x08080d18),
+	RTW89_DECL_RFK_WM(0x5628, 0xffffffff, 0x08080808),
+	RTW89_DECL_RFK_WM(0x562c, 0x0000ffff, 0x0808),
+	RTW89_DECL_RFK_WM(0x581c, 0x00100000, 0x1),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_slope_a_defs_5g);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_align_a_2g_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x2d2400),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000ffc00, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x3ff00000, 0x3fa),
+	RTW89_DECL_RFK_WM(0x5638, 0x000003ff, 0x02e),
+	RTW89_DECL_RFK_WM(0x5638, 0x000ffc00, 0x09c),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x3fb00000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000003ff, 0x02f),
+	RTW89_DECL_RFK_WM(0x5644, 0x000ffc00, 0x09c),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_align_a_2g_defs);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_align_a_5g_defs[] = {
+	RTW89_DECL_RFK_WM(0x5604, 0x80000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5600, 0x3fffffff, 0x000000),
+	RTW89_DECL_RFK_WM(0x5604, 0x003fffff, 0x3b2d24),
+	RTW89_DECL_RFK_WM(0x5630, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000003ff, 0x000),
+	RTW89_DECL_RFK_WM(0x5634, 0x000ffc00, 0x3cb),
+	RTW89_DECL_RFK_WM(0x5634, 0x3ff00000, 0x030),
+	RTW89_DECL_RFK_WM(0x5638, 0x000003ff, 0x73),
+	RTW89_DECL_RFK_WM(0x5638, 0x000ffc00, 0xd4),
+	RTW89_DECL_RFK_WM(0x563c, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5640, 0x3fffffff, 0x00000000),
+	RTW89_DECL_RFK_WM(0x5644, 0x000fffff, 0x00000),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_align_a_5g_defs);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_slope_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x5820, 0x80000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5818, 0x10000000, 0x0),
+	RTW89_DECL_RFK_WM(0x5814, 0x00000800, 0x1),
+	RTW89_DECL_RFK_WM(0x581c, 0x20000000, 0x1),
+	RTW89_DECL_RFK_WM(0x5820, 0x0000f000, 0xf),
+	RTW89_DECL_RFK_WM(0x581c, 0x000003ff, 0x280),
+	RTW89_DECL_RFK_WM(0x581c, 0x000ffc00, 0x200),
+	RTW89_DECL_RFK_WM(0x58b8, 0x007f0000, 0x00),
+	RTW89_DECL_RFK_WM(0x58b8, 0x7f000000, 0x00),
+	RTW89_DECL_RFK_WM(0x58b4, 0x7f000000, 0x0a),
+	RTW89_DECL_RFK_WM(0x58b8, 0x0000007f, 0x28),
+	RTW89_DECL_RFK_WM(0x58b8, 0x00007f00, 0x76),
+	RTW89_DECL_RFK_WM(0x5810, 0x20000000, 0x0),
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
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_slope_defs_a);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_track_defs_a[] = {
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
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_track_defs_a);
+
+static const struct rtw89_reg5_def rtw8851b_tssi_mv_avg_defs_a[] = {
+	RTW89_DECL_RFK_WM(0x58e4, 0x00003800, 0x1),
+	RTW89_DECL_RFK_WM(0x58e4, 0x00004000, 0x0),
+	RTW89_DECL_RFK_WM(0x58e4, 0x00008000, 0x1),
+	RTW89_DECL_RFK_WM(0x58e4, 0x000f0000, 0x0),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_tssi_mv_avg_defs_a);
+
+static const struct rtw89_reg5_def rtw8851b_nctl_post_defs[] = {
+	RTW89_DECL_RFK_WM(0x5864, 0x18000000, 0x3),
+	RTW89_DECL_RFK_WM(0x7864, 0x18000000, 0x3),
+	RTW89_DECL_RFK_WM(0x030c, 0xff000000, 0x13),
+	RTW89_DECL_RFK_WM(0x032c, 0xffff0000, 0x0041),
+	RTW89_DECL_RFK_WM(0x12b8, 0x10000000, 0x1),
+	RTW89_DECL_RFK_WM(0x2008, 0x01ffffff, 0x00fffff),
+	RTW89_DECL_RFK_WM(0x0c60, 0x00000003, 0x3),
+	RTW89_DECL_RFK_WM(0x0c6c, 0x00000001, 0x1),
+	RTW89_DECL_RFK_WM(0x58ac, 0x08000000, 0x1),
+	RTW89_DECL_RFK_WM(0x78ac, 0x08000000, 0x1),
+	RTW89_DECL_RFK_WM(0x0730, 0x00003800, 0x7),
+	RTW89_DECL_RFK_WM(0x2730, 0x00003800, 0x7),
+	RTW89_DECL_RFK_WM(0x0c7c, 0x00e00000, 0x1),
+	RTW89_DECL_RFK_WM(0x58c0, 0x0001ffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x78c0, 0x0001ffff, 0x00000),
+	RTW89_DECL_RFK_WM(0x58fc, 0x3f000000, 0x00),
+	RTW89_DECL_RFK_WM(0x78fc, 0x3f000000, 0x00),
+};
+
+RTW89_DECLARE_RFK_TBL(rtw8851b_nctl_post_defs);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
new file mode 100644
index 0000000000000..febfbecb691c1
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk_table.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2022-2023  Realtek Corporation
+ */
+
+#ifndef __RTW89_8851B_RFK_TABLE_H__
+#define __RTW89_8851B_RFK_TABLE_H__
+
+#include "phy.h"
+
+extern const struct rtw89_rfk_tbl rtw8851b_dadck_setup_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_dadck_post_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_dack_s0_1_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_dack_s0_2_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_dack_manual_off_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_rxclk_80_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_rxclk_others_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_txk_2ghz_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_txk_5ghz_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_afebb_restore_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_bb_afe_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_iqk_macbb_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_a_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_sys_a_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_init_txpwr_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_init_txpwr_he_tb_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_dck_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_dac_gain_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_slope_a_defs_2g_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_slope_a_defs_5g_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_align_a_2g_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_align_a_5g_defs_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_slope_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_track_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_tssi_mv_avg_defs_a_tbl;
+extern const struct rtw89_rfk_tbl rtw8851b_nctl_post_defs_tbl;
+
+#endif
-- 
2.25.1

