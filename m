Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FD878D9DA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjH3SeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbjH3JaF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 05:30:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85408CCB
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 02:30:00 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37U9TKgqC014800, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37U9TKgqC014800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 17:29:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 30 Aug 2023 17:29:45 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 30 Aug
 2023 17:29:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: 8852c: Update bandedge parameters for better performance
Date:   Wed, 30 Aug 2023 17:28:48 +0800
Message-ID: <20230830092849.153251-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830092849.153251-1-pkshih@realtek.com>
References: <20230830092849.153251-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kuan-Chung Chen <damon.chen@realtek.com>

TSSI configures bandedge to TX proper waveform, these new bandedge
parameters improve the accuracy of transmit power compensation.
This helps to avoid throughput degradation.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h            | 4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c       | 5 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852c_table.c | 9 ++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c0aac4d3678a..f9b15a1cc790 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4619,6 +4619,8 @@
 #define R_TXGAIN_SCALE 0x58F0
 #define B_TXGAIN_SCALE_EN BIT(19)
 #define B_TXGAIN_SCALE_OFT GENMASK(31, 24)
+#define R_P0_DAC_COMP_POST_DPD_EN 0x58F8
+#define B_P0_DAC_COMP_POST_DPD_EN BIT(31)
 #define R_P0_TSSI_BASE 0x5C00
 #define R_S0_DACKI 0x5E00
 #define B_S0_DACKI_AR GENMASK(31, 28)
@@ -4675,6 +4677,8 @@
 #define B_P1_TSSI_MV_MIX GENMASK(19, 11)
 #define B_P1_TSSI_MV_AVG GENMASK(13, 11)
 #define B_P1_TSSI_MV_CLR BIT(14)
+#define R_P1_DAC_COMP_POST_DPD_EN 0x78F8
+#define B_P1_DAC_COMP_POST_DPD_EN BIT(31)
 #define R_TSSI_THOF 0x7C00
 #define R_S1_DACKI 0x7E00
 #define B_S1_DACKI_AR GENMASK(31, 28)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 1e16cc0a05dc..00f1236e2193 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1975,6 +1975,11 @@ static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 	rtw89_phy_tssi_ctrl_set_bandedge_cfg(rtwdev,
 					     (enum rtw89_mac_idx)phy_idx,
 					     tx_shape_ofdm);
+
+	rtw89_phy_write32_set(rtwdev, R_P0_DAC_COMP_POST_DPD_EN,
+			      B_P0_DAC_COMP_POST_DPD_EN);
+	rtw89_phy_write32_set(rtwdev, R_P1_DAC_COMP_POST_DPD_EN,
+			      B_P1_DAC_COMP_POST_DPD_EN);
 }
 
 static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index 4b272fdf1fd7..2ffd979750e3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -56452,9 +56452,12 @@ const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg = {
 
 const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table = {
 	.data[RTW89_TSSI_BANDEDGE_FLAT] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
-	.data[RTW89_TSSI_BANDEDGE_LOW] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
-	.data[RTW89_TSSI_BANDEDGE_MID] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
-	.data[RTW89_TSSI_BANDEDGE_HIGH] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+	.data[RTW89_TSSI_BANDEDGE_LOW] = {0x1d, 0x1d, 0x1d, 0x2f, 0xf, 0xf, 0x2f, 0x38,
+					  0x28, 0x18, 0x8, 0x8, 0x18, 0x28, 0x38},
+	.data[RTW89_TSSI_BANDEDGE_MID] = {0x24, 0x24, 0x24, 0x3b, 0x13, 0x13, 0x3b, 0x46,
+					  0x32, 0x1e, 0xa, 0xa, 0x1e, 0x32, 0x46},
+	.data[RTW89_TSSI_BANDEDGE_HIGH] = {0x2a, 0x2a, 0x2a, 0x46, 0x17, 0x17, 0x46, 0x53,
+					   0x3b, 0x24, 0xc, 0xc, 0x24, 0x3b, 0x53},
 };
 
 const struct rtw89_rfe_parms rtw89_8852c_dflt_parms = {
-- 
2.25.1

