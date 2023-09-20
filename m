Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C57A7499
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjITHpO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjITHo5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EE9DD
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:50 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7ibs27803226, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7ibs27803226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Sep 2023 15:44:37 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: indicate TX shape table inside RFE parameter
Date:   Wed, 20 Sep 2023 15:43:17 +0800
Message-ID: <20230920074322.42898-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920074322.42898-1-pkshih@realtek.com>
References: <20230920074322.42898-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

For next-generation chips, TX shape table comes from RFE (RF front end)
parameter. It can be different according to RFE type. So, we indicate
TX shape table inside RFE parameter ahead. For current chips, even with
different RFE types, a chip is configured with a single TX shape table.
So, this commit doesn't really affect these currently supported chips.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h           | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c       | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8851b_table.c | 3 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b_table.h | 2 --
 drivers/net/wireless/realtek/rtw89/rtw8852b.c       | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852b_table.c | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b_table.h | 2 --
 drivers/net/wireless/realtek/rtw89/rtw8852c.c       | 5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852c_table.c | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c_table.h | 2 --
 10 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index cafc1e09f4d6..61d46d130143 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3358,6 +3358,7 @@ struct rtw89_rfe_parms {
 	struct rtw89_txpwr_rule_2ghz rule_2ghz;
 	struct rtw89_txpwr_rule_5ghz rule_5ghz;
 	struct rtw89_txpwr_rule_6ghz rule_6ghz;
+	const u8 (*tx_shape)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
 };
 
 struct rtw89_rfe_parms_conf {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index f4ef2a7e4b1a..a6170c8f8813 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1704,10 +1704,11 @@ static void rtw8851b_set_tx_shape(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
 				  enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
-	u8 tx_shape_cck = rtw89_8851b_tx_shape[band][RTW89_RS_CCK][regd];
-	u8 tx_shape_ofdm = rtw89_8851b_tx_shape[band][RTW89_RS_OFDM][regd];
+	u8 tx_shape_cck = (*rfe_parms->tx_shape)[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = (*rfe_parms->tx_shape)[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
 		rtw8851b_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index c447f91a4bd0..58d413f61e98 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -3321,6 +3321,7 @@ static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4
 };
 
+static
 const u8 rtw89_8851b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 			     [RTW89_REGD_NUM] = {
 	[0][0][RTW89_ACMA] = 0,
@@ -14818,6 +14819,7 @@ const struct rtw89_rfe_parms rtw89_8851b_dflt_parms = {
 		.lmt = &rtw89_8851b_txpwr_lmt_5g,
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_5g,
 	},
+	.tx_shape = &rtw89_8851b_tx_shape,
 };
 
 static const struct rtw89_rfe_parms rtw89_8851b_rfe_parms_type2 = {
@@ -14829,6 +14831,7 @@ static const struct rtw89_rfe_parms rtw89_8851b_rfe_parms_type2 = {
 		.lmt = &rtw89_8851b_txpwr_lmt_5g_type2,
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_5g_type2,
 	},
+	.tx_shape = &rtw89_8851b_tx_shape,
 };
 
 const struct rtw89_rfe_parms_conf rtw89_8851b_rfe_parms_conf[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
index a8737de02f66..7967a98d830e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
@@ -13,8 +13,6 @@ extern const struct rtw89_phy_table rtw89_8851b_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8851b_byr_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8851b_trk_cfg;
-extern const u8 rtw89_8851b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
-				    [RTW89_REGD_NUM];
 extern const struct rtw89_rfe_parms rtw89_8851b_dflt_parms;
 extern const struct rtw89_rfe_parms_conf rtw89_8851b_rfe_parms_conf[];
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f6222e9c7eda..90764d8c539e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1689,10 +1689,11 @@ static void rtw8852b_set_tx_shape(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
 				  enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
-	u8 tx_shape_cck = rtw89_8852b_tx_shape[band][RTW89_RS_CCK][regd];
-	u8 tx_shape_ofdm = rtw89_8852b_tx_shape[band][RTW89_RS_OFDM][regd];
+	u8 tx_shape_cck = (*rfe_parms->tx_shape)[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = (*rfe_parms->tx_shape)[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
 		rtw8852b_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index 17124d851a22..0939e37a9c52 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -14666,6 +14666,7 @@ static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
 	 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
 
+static
 const u8 rtw89_8852b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 			     [RTW89_REGD_NUM] = {
 	[0][0][RTW89_ACMA] = 0,
@@ -22889,4 +22890,5 @@ const struct rtw89_rfe_parms rtw89_8852b_dflt_parms = {
 		.lmt = &rtw89_8852b_txpwr_lmt_5g,
 		.lmt_ru = &rtw89_8852b_txpwr_lmt_ru_5g,
 	},
+	.tx_shape = &rtw89_8852b_tx_shape,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
index 7ef217629f46..816b15285c66 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
@@ -14,8 +14,6 @@ extern const struct rtw89_phy_table rtw89_8852b_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8852b_byr_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg;
-extern const u8 rtw89_8852b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
-				    [RTW89_REGD_NUM];
 extern const struct rtw89_rfe_parms rtw89_8852b_dflt_parms;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9c38612eb068..4d88118f4f6e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1966,10 +1966,11 @@ static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
 				  enum rtw89_phy_idx phy_idx)
 {
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
-	u8 tx_shape_cck = rtw89_8852c_tx_shape[band][RTW89_RS_CCK][regd];
-	u8 tx_shape_ofdm = rtw89_8852c_tx_shape[band][RTW89_RS_OFDM][regd];
+	u8 tx_shape_cck = (*rfe_parms->tx_shape)[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = (*rfe_parms->tx_shape)[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
 		rtw8852c_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index 2ffd979750e3..3b393d17a08c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -31525,6 +31525,7 @@ static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5
 };
 
+static
 const u8 rtw89_8852c_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 			     [RTW89_REGD_NUM] = {
 	[0][0][RTW89_ACMA] = 0,
@@ -56473,4 +56474,5 @@ const struct rtw89_rfe_parms rtw89_8852c_dflt_parms = {
 		.lmt = &rtw89_8852c_txpwr_lmt_6g,
 		.lmt_ru = &rtw89_8852c_txpwr_lmt_ru_6g,
 	},
+	.tx_shape = &rtw89_8852c_tx_shape,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
index 3eb0c4995174..4cff36dbf087 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
@@ -15,8 +15,6 @@ extern const struct rtw89_phy_table rtw89_8852c_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8852c_byr_table;
 extern const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg;
-extern const u8 rtw89_8852c_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
-				    [RTW89_REGD_NUM];
 extern const struct rtw89_rfe_parms rtw89_8852c_dflt_parms;
 
 #endif
-- 
2.25.1

