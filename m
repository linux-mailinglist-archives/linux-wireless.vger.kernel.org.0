Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB9A6731BF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjASGZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASGZb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:25:31 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5C35654CB
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:25:29 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J6PEhW4005735, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J6PEhW4005735
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 14:25:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 19 Jan 2023 14:25:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 14:25:14 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: correct unit for port offset and refine macro
Date:   Thu, 19 Jan 2023 14:24:51 +0800
Message-ID: <20230119062453.58341-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119062453.58341-1-pkshih@realtek.com>
References: <20230119062453.58341-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/19/2023 06:07:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwMzozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Strictly speaking, the unit of the offset should be TU instead of ms.
So, correct it and the macro for calculation. Then, to make the macro
generic, the factor n is moved outside.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 4 +++-
 drivers/net/wireless/realtek/rtw89/mac.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5ab0590485e0d..ea34b4df21a75 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3930,10 +3930,12 @@ static void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 
 	/* adjust offset randomly to avoid beacon conflict */
 	offset = offset - offset / 4 + get_random_u32() % (offset / 2);
-	val = RTW89_PORT_OFFSET_MS_TO_32US((*n_offset)++, offset);
+	val = (*n_offset) * RTW89_PORT_OFFSET_TU_TO_32US(offset);
 	reg = rtw89_mac_reg_by_idx(R_AX_PORT0_TSF_SYNC + rtwvif->port * 4,
 				   rtwvif->mac_idx);
 
+	(*n_offset)++;
+
 	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_SRC, rtwvif_src->port);
 	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_OFFSET_VAL, val);
 	rtw89_write32_set(rtwdev, reg, B_AX_SYNC_NOW);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index f0b684b205f10..2556271597441 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -168,7 +168,7 @@ enum rtw89_mac_ax_l0_to_l1_event {
 	MAC_AX_L0_TO_L1_EVENT_MAX = 15,
 };
 
-#define RTW89_PORT_OFFSET_MS_TO_32US(n, shift_ms) ((n) * (shift_ms) * 1000 / 32)
+#define RTW89_PORT_OFFSET_TU_TO_32US(shift_tu) ((shift_tu) * 1024 / 32)
 
 enum rtw89_mac_dbg_port_sel {
 	/* CMAC 0 related */
-- 
2.25.1

