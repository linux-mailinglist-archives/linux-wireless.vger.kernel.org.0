Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCCB4E6E0D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358396AbiCYGED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358413AbiCYGEA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:04:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A167C682E
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62GcT4011150, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62GcT4011150
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 14:02:15 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 13/16] rtw89: update scheduler setting
Date:   Fri, 25 Mar 2022 14:00:52 +0800
Message-ID: <20220325060055.58482-14-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
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

Update IC specific settings accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h | 12 ++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f542678b1c22d..569c390a03cb0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1807,6 +1807,17 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	reg = rtw89_mac_reg_by_idx(R_AX_PREBKF_CFG_1, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_SIFS_MACTXEN_T1_MASK, SIFS_MACTXEN_T1);
+
+	if (rtwdev->chip->chip_id == RTL8852B) {
+		reg = rtw89_mac_reg_by_idx(R_AX_SCH_EXT_CTRL, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_AX_PORT_RST_TSF_ADV);
+	}
+
+	reg = rtw89_mac_reg_by_idx(R_AX_CCA_CFG_0, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_AX_BTCCA_EN);
+
 	reg = rtw89_mac_reg_by_idx(R_AX_PREBKF_CFG_0, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PREBKF_TIME_MASK, SCH_PREBKF_24US);
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 3505c9dd8a793..dea7d2c8547be 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -977,6 +977,14 @@
 #define R_AX_PREBKF_CFG_0_C1 0xE338
 #define B_AX_PREBKF_TIME_MASK GENMASK(4, 0)
 
+#define R_AX_PREBKF_CFG_1 0xC33C
+#define R_AX_PREBKF_CFG_1_C1 0xE33C
+#define B_AX_SIFS_TIMEOUT_TB_AGGR_MASK GENMASK(30, 24)
+#define B_AX_SIFS_PREBKF_MASK GENMASK(23, 16)
+#define B_AX_SIFS_TIMEOUT_T2_MASK GENMASK(14, 8)
+#define B_AX_SIFS_MACTXEN_T1_MASK GENMASK(6, 0)
+#define SIFS_MACTXEN_T1 0x47
+
 #define R_AX_CCA_CFG_0 0xC340
 #define R_AX_CCA_CFG_0_C1 0xE340
 #define B_AX_BTCCA_BRK_TXOP_EN BIT(9)
@@ -1076,6 +1084,10 @@
 #define R_AX_SCH_DBG_C1 0xE3F8
 #define B_AX_SCHEDULER_DBG_MASK GENMASK(31, 0)
 
+#define R_AX_SCH_EXT_CTRL 0xC3FC
+#define R_AX_SCH_EXT_CTRL_C1 0xE3FC
+#define B_AX_PORT_RST_TSF_ADV BIT(1)
+
 #define R_AX_PORT_CFG_P0 0xC400
 #define R_AX_PORT_CFG_P1 0xC440
 #define R_AX_PORT_CFG_P2 0xC480
-- 
2.25.1

