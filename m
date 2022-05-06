Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C536451D73D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 14:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391622AbiEFMGh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 08:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378312AbiEFMGg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 08:06:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAF564734
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 05:02:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 246C2dMaA029464, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 246C2dMaA029464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 6 May 2022 20:02:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 20:02:39 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 6 May
 2022 20:02:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <hsuan8331@realtek.com>
Subject: [PATCH 1/5] rtw89: 8852c: add settings to decrease the effect of DC
Date:   Fri, 6 May 2022 20:02:12 +0800
Message-ID: <20220506120216.58567-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506120216.58567-1-pkshih@realtek.com>
References: <20220506120216.58567-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/06/2022 11:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvNiCkV6TIIDEwOjM5OjAw?=
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

From: Hsuan Hung <hsuan8331@realtek.com>

Modify NBI and PD boost settings according to different primary channels.
This setting can decrease the false alarm induced by DC.

Signed-off-by: Hsuan Hung <hsuan8331@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 14 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 63 +++++++++++++++++--
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5c4de043845b2..ebf28719d935e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3822,6 +3822,8 @@
 #define B_CHBW_MOD_SBW GENMASK(13, 12)
 #define B_CHBW_MOD_PRICH GENMASK(11, 8)
 #define B_ANT_RX_SEG0 GENMASK(3, 0)
+#define R_PD_BOOST_EN 0x49E8
+#define B_PD_BOOST_EN BIT(7)
 #define R_P1_BACKOFF_IBADC_V1 0x49F0
 #define B_P1_BACKOFF_IBADC_V1 GENMASK(31, 26)
 #define R_BK_FC0_INV_V1 0x4A1C
@@ -3840,6 +3842,12 @@
 #define B_PATH1_BT_BACKOFF_V1 GENMASK(23, 0)
 #define R_PATH0_FRC_FIR_TYPE_V1 0x4C00
 #define B_PATH0_FRC_FIR_TYPE_MSK_V1 GENMASK(1, 0)
+#define R_PATH0_NOTCH 0x4C14
+#define B_PATH0_NOTCH_EN BIT(12)
+#define B_PATH0_NOTCH_VAL GENMASK(11, 0)
+#define R_PATH0_NOTCH2 0x4C20
+#define B_PATH0_NOTCH2_EN BIT(12)
+#define B_PATH0_NOTCH2_VAL GENMASK(11, 0)
 #define R_PATH0_5MDET 0x4C4C
 #define B_PATH0_5MDET_EN BIT(12)
 #define B_PATH0_5MDET_SB2 BIT(8)
@@ -3847,6 +3855,12 @@
 #define B_PATH0_5MDET_TH GENMASK(5, 0)
 #define R_PATH1_FRC_FIR_TYPE_V1 0x4CC4
 #define B_PATH1_FRC_FIR_TYPE_MSK_V1 GENMASK(1, 0)
+#define R_PATH1_NOTCH 0x4CD8
+#define B_PATH1_NOTCH_EN BIT(12)
+#define B_PATH1_NOTCH_VAL GENMASK(11, 0)
+#define R_PATH1_NOTCH2 0x4CE4
+#define B_PATH1_NOTCH2_EN BIT(12)
+#define B_PATH1_NOTCH2_VAL GENMASK(11, 0)
 #define R_PATH1_5MDET 0x4D10
 #define B_PATH1_5MDET_EN BIT(12)
 #define B_PATH1_5MDET_SB2 BIT(8)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 295b824dbecc9..77dcdbd86c63a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1381,19 +1381,72 @@ static void rtw8852c_set_nbi_tone_idx(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw8852c_spur_notch(struct rtw89_dev *rtwdev, u32 val,
+				enum rtw89_phy_idx phy_idx)
+{
+	u32 notch;
+	u32 notch2;
+
+	if (phy_idx == RTW89_PHY_0) {
+		notch = R_PATH0_NOTCH;
+		notch2 = R_PATH0_NOTCH2;
+	} else {
+		notch = R_PATH1_NOTCH;
+		notch2 = R_PATH1_NOTCH2;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, notch,
+			       B_PATH0_NOTCH_VAL | B_PATH0_NOTCH_EN, val);
+	rtw89_phy_write32_set(rtwdev, notch, B_PATH0_NOTCH_EN);
+	rtw89_phy_write32_mask(rtwdev, notch2,
+			       B_PATH0_NOTCH2_VAL | B_PATH0_NOTCH2_EN, val);
+	rtw89_phy_write32_set(rtwdev, notch2, B_PATH0_NOTCH2_EN);
+}
+
 static void rtw8852c_spur_elimination(struct rtw89_dev *rtwdev,
 				      struct rtw89_channel_params *param,
+				      u8 pri_ch_idx,
 				      enum rtw89_phy_idx phy_idx)
 {
 	rtw8852c_set_csi_tone_idx(rtwdev, param, phy_idx);
 
 	if (phy_idx == RTW89_PHY_0) {
-		rtw8852c_set_nbi_tone_idx(rtwdev, param, RF_PATH_A);
-		if (!rtwdev->dbcc_en)
-			rtw8852c_set_nbi_tone_idx(rtwdev, param, RF_PATH_B);
+		if (param->bandwidth == RTW89_CHANNEL_WIDTH_160 &&
+		    (pri_ch_idx == RTW89_SC_20_LOWER ||
+		     pri_ch_idx == RTW89_SC_20_UP3X)) {
+			rtw8852c_spur_notch(rtwdev, 0xe7f, RTW89_PHY_0);
+			if (!rtwdev->dbcc_en)
+				rtw8852c_spur_notch(rtwdev, 0xe7f, RTW89_PHY_1);
+		} else if (param->bandwidth == RTW89_CHANNEL_WIDTH_160 &&
+			   (pri_ch_idx == RTW89_SC_20_UPPER ||
+			    pri_ch_idx == RTW89_SC_20_LOW3X)) {
+			rtw8852c_spur_notch(rtwdev, 0x280, RTW89_PHY_0);
+			if (!rtwdev->dbcc_en)
+				rtw8852c_spur_notch(rtwdev, 0x280, RTW89_PHY_1);
+		} else {
+			rtw8852c_set_nbi_tone_idx(rtwdev, param, RF_PATH_A);
+			if (!rtwdev->dbcc_en)
+				rtw8852c_set_nbi_tone_idx(rtwdev, param,
+							  RF_PATH_B);
+		}
 	} else {
-		rtw8852c_set_nbi_tone_idx(rtwdev, param, RF_PATH_B);
+		if (param->bandwidth == RTW89_CHANNEL_WIDTH_160 &&
+		    (pri_ch_idx == RTW89_SC_20_LOWER ||
+		     pri_ch_idx == RTW89_SC_20_UP3X)) {
+			rtw8852c_spur_notch(rtwdev, 0xe7f, RTW89_PHY_1);
+		} else if (param->bandwidth == RTW89_CHANNEL_WIDTH_160 &&
+			   (pri_ch_idx == RTW89_SC_20_UPPER ||
+			    pri_ch_idx == RTW89_SC_20_LOW3X)) {
+			rtw8852c_spur_notch(rtwdev, 0x280, RTW89_PHY_1);
+		} else {
+			rtw8852c_set_nbi_tone_idx(rtwdev, param, RF_PATH_B);
+		}
 	}
+
+	if (pri_ch_idx == RTW89_SC_20_UP3X || pri_ch_idx == RTW89_SC_20_LOW3X)
+		rtw89_phy_write32_idx(rtwdev, R_PD_BOOST_EN, B_PD_BOOST_EN, 0, phy_idx);
+	else
+		rtw89_phy_write32_idx(rtwdev, R_PD_BOOST_EN, B_PD_BOOST_EN, 1, phy_idx);
 }
 
 static void rtw8852c_5m_mask(struct rtw89_dev *rtwdev,
@@ -1664,7 +1717,7 @@ static void rtw8852c_set_channel_bb(struct rtw89_dev *rtwdev,
 				      B_PD_ARBITER_OFF, 0x1, phy_idx);
 	}
 
-	rtw8852c_spur_elimination(rtwdev, param, phy_idx);
+	rtw8852c_spur_elimination(rtwdev, param, pri_ch_idx, phy_idx);
 	rtw8852c_ctrl_btg(rtwdev, param->band_type == RTW89_BAND_2G);
 	rtw8852c_5m_mask(rtwdev, param, phy_idx);
 
-- 
2.25.1

