Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1659958E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 08:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbiHSGsv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 02:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346468AbiHSGsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 02:48:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD291491D3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 23:48:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27J6mFWA1001747, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27J6mFWA1001747
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 19 Aug 2022 14:48:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 14:48:29 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 Aug
 2022 14:48:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/5] wifi: rtw89: 8852c: set TBTT shift configuration
Date:   Fri, 19 Aug 2022 14:48:08 +0800
Message-ID: <20220819064811.37700-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819064811.37700-1-pkshih@realtek.com>
References: <20220819064811.37700-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/19/2022 06:25:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTkgpFekyCAwMTo1MzowMA==?=
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

It is found that 8852ce loses some beacon after
enabling deep ps mode. We set TBTT shift to wake up
firmware early to open RF/BB for receiving beacon in time.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 21 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 61c7e79714925..c27b1e1aed37d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3535,6 +3535,26 @@ static void rtw89_mac_port_cfg_bcn_early(struct rtw89_dev *rtwdev,
 				BCN_ERLY_DEF);
 }
 
+static void rtw89_mac_port_cfg_tbtt_shift(struct rtw89_dev *rtwdev,
+					  struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_port_reg *p = &rtw_port_base;
+	u16 val;
+
+	if (rtwdev->chip->chip_id != RTL8852C)
+		return;
+
+	if (rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT &&
+	    rtwvif->wifi_role != RTW89_WIFI_ROLE_STATION)
+		return;
+
+	val = FIELD_PREP(B_AX_TBTT_SHIFT_OFST_MAG, 1) |
+			 B_AX_TBTT_SHIFT_OFST_SIGN;
+
+	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_shift,
+				B_AX_TBTT_SHIFT_OFST_MASK, val);
+}
+
 int rtw89_mac_vif_init(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	int ret;
@@ -3609,6 +3629,7 @@ int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_mac_port_cfg_bcn_hold_time(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bcn_mask_area(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_tbtt_early(rtwdev, rtwvif);
+	rtw89_mac_port_cfg_tbtt_shift(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_bss_color(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_mbssid(rtwdev, rtwvif);
 	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 76d3d9aa8745b..497c1e9263fc0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2093,6 +2093,8 @@
 #define R_AX_TBTT_SHIFT_P3 0xC4E8
 #define R_AX_TBTT_SHIFT_P4 0xC528
 #define B_AX_TBTT_SHIFT_OFST_MASK GENMASK(11, 0)
+#define B_AX_TBTT_SHIFT_OFST_SIGN BIT(11)
+#define B_AX_TBTT_SHIFT_OFST_MAG GENMASK(10, 0)
 
 #define R_AX_BCN_CNT_TMR_P0 0xC434
 #define R_AX_BCN_CNT_TMR_P1 0xC474
-- 
2.25.1

