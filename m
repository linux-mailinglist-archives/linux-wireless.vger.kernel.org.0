Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732F57A7498
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjITHpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjITHo5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F72DCF
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 00:44:50 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38K7igTF3803304, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38K7igTF3803304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 15:44:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Sep 2023 15:44:42 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Sep
 2023 15:44:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/7] wifi: rtw89: phy: extend TX power common stuffs for Wi-Fi 7 chips
Date:   Wed, 20 Sep 2023 15:43:21 +0800
Message-ID: <20230920074322.42898-7-pkshih@realtek.com>
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

The following are introduced for Wi-Fi 7 chips.
1. take BW/OFDMA into account on TX power by rate
2. increase TX power offset types up to EHT
3. split TX shape into tx_shape_lmt and tx_shape_lmt_ru

If functions which are only for AX, they always access TX power by rate
with BW/OFDMA = 0/0, and they don't access tx_shape's lmt_ru section.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 48 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/phy.c      | 26 +++++-----
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  4 +-
 .../wireless/realtek/rtw89/rtw8851b_table.c   |  4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  4 +-
 .../wireless/realtek/rtw89/rtw8852b_table.c   |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  4 +-
 .../wireless/realtek/rtw89/rtw8852c_table.c   |  2 +-
 8 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 71ed4d59ef53..4ab7abfa8b1f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -640,12 +640,29 @@ enum rtw89_rate_section {
 	RTW89_RS_TX_SHAPE_NUM = RTW89_RS_OFDM + 1,
 };
 
+enum rtw89_rate_offset_indexes {
+	RTW89_RATE_OFFSET_HE,
+	RTW89_RATE_OFFSET_VHT,
+	RTW89_RATE_OFFSET_HT,
+	RTW89_RATE_OFFSET_OFDM,
+	RTW89_RATE_OFFSET_CCK,
+	RTW89_RATE_OFFSET_DLRU_EHT,
+	RTW89_RATE_OFFSET_DLRU_HE,
+	RTW89_RATE_OFFSET_EHT,
+	__RTW89_RATE_OFFSET_NUM,
+
+	RTW89_RATE_OFFSET_NUM_AX = RTW89_RATE_OFFSET_CCK + 1,
+	RTW89_RATE_OFFSET_NUM_BE = RTW89_RATE_OFFSET_EHT + 1,
+};
+
 enum rtw89_rate_num {
 	RTW89_RATE_CCK_NUM	= 4,
 	RTW89_RATE_OFDM_NUM	= 8,
-	RTW89_RATE_MCS_NUM	= 12,
 	RTW89_RATE_HEDCM_NUM	= 4, /* for HEDCM MCS0/1/3/4 */
-	RTW89_RATE_OFFSET_NUM	= 5, /* for HE(HEDCM)/VHT/HT/OFDM/CCK offset */
+
+	RTW89_RATE_MCS_NUM_AX	= 12,
+	RTW89_RATE_MCS_NUM_BE	= 16,
+	__RTW89_RATE_MCS_NUM	= 16,
 };
 
 enum rtw89_nss {
@@ -670,6 +687,12 @@ enum rtw89_beamforming_type {
 	RTW89_BF_NUM,
 };
 
+enum rtw89_ofdma_type {
+	RTW89_NON_OFDMA	= 0,
+	RTW89_OFDMA	= 1,
+	RTW89_OFDMA_NUM,
+};
+
 enum rtw89_regulation_type {
 	RTW89_WW	= 0,
 	RTW89_ETSI	= 1,
@@ -715,9 +738,9 @@ enum rtw89_fw_pkt_ofld_type {
 struct rtw89_txpwr_byrate {
 	s8 cck[RTW89_RATE_CCK_NUM];
 	s8 ofdm[RTW89_RATE_OFDM_NUM];
-	s8 mcs[RTW89_NSS_NUM][RTW89_RATE_MCS_NUM];
-	s8 hedcm[RTW89_NSS_HEDCM_NUM][RTW89_RATE_HEDCM_NUM];
-	s8 offset[RTW89_RATE_OFFSET_NUM];
+	s8 mcs[RTW89_OFDMA_NUM][RTW89_NSS_NUM][__RTW89_RATE_MCS_NUM];
+	s8 hedcm[RTW89_OFDMA_NUM][RTW89_NSS_HEDCM_NUM][RTW89_RATE_HEDCM_NUM];
+	s8 offset[__RTW89_RATE_OFFSET_NUM];
 	s8 trap;
 };
 
@@ -754,6 +777,7 @@ struct rtw89_txpwr_limit_ru {
 struct rtw89_rate_desc {
 	enum rtw89_nss nss;
 	enum rtw89_rate_section rs;
+	enum rtw89_ofdma_type ofdma;
 	u8 idx;
 };
 
@@ -861,13 +885,16 @@ enum rtw89_ps_mode {
 
 #define RTW89_2G_BW_NUM (RTW89_CHANNEL_WIDTH_40 + 1)
 #define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
-#define RTW89_6G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
+#define RTW89_6G_BW_NUM (RTW89_CHANNEL_WIDTH_320 + 1)
+#define RTW89_BYR_BW_NUM (RTW89_CHANNEL_WIDTH_320 + 1)
 #define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
 
 enum rtw89_ru_bandwidth {
 	RTW89_RU26 = 0,
 	RTW89_RU52 = 1,
 	RTW89_RU106 = 2,
+	RTW89_RU52_26 = 3,
+	RTW89_RU106_26 = 4,
 	RTW89_RU_NUM,
 };
 
@@ -3355,12 +3382,17 @@ struct rtw89_txpwr_rule_6ghz {
 			  [RTW89_6G_CH_NUM];
 };
 
+struct rtw89_tx_shape {
+	const u8 (*lmt)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
+	const u8 (*lmt_ru)[RTW89_BAND_NUM][RTW89_REGD_NUM];
+};
+
 struct rtw89_rfe_parms {
 	const struct rtw89_txpwr_table *byr_tbl;
 	struct rtw89_txpwr_rule_2ghz rule_2ghz;
 	struct rtw89_txpwr_rule_5ghz rule_5ghz;
 	struct rtw89_txpwr_rule_6ghz rule_6ghz;
-	const u8 (*tx_shape)[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM][RTW89_REGD_NUM];
+	struct rtw89_tx_shape tx_shape;
 };
 
 struct rtw89_rfe_parms_conf {
@@ -4597,7 +4629,7 @@ struct rtw89_dev {
 	bool is_bt_iqk_timeout;
 
 	struct rtw89_fem_info fem;
-	struct rtw89_txpwr_byrate byr[RTW89_BAND_NUM];
+	struct rtw89_txpwr_byrate byr[RTW89_BAND_NUM][RTW89_BYR_BW_NUM];
 	struct rtw89_tssi_info tssi;
 	struct rtw89_power_trim_info pwr_trim;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f9f203295ee4..03e79d80e32c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1522,9 +1522,9 @@ EXPORT_SYMBOL(rtw89_phy_write_reg3_tbl);
 static const u8 rtw89_rs_idx_num[] = {
 	[RTW89_RS_CCK] = RTW89_RATE_CCK_NUM,
 	[RTW89_RS_OFDM] = RTW89_RATE_OFDM_NUM,
-	[RTW89_RS_MCS] = RTW89_RATE_MCS_NUM,
+	[RTW89_RS_MCS] = RTW89_RATE_MCS_NUM_AX,
 	[RTW89_RS_HEDCM] = RTW89_RATE_HEDCM_NUM,
-	[RTW89_RS_OFFSET] = RTW89_RATE_OFFSET_NUM,
+	[RTW89_RS_OFFSET] = RTW89_RATE_OFFSET_NUM_AX,
 };
 
 static const u8 rtw89_rs_nss_num[] = {
@@ -1546,9 +1546,9 @@ s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
 	case RTW89_RS_OFDM:
 		return &head->ofdm[desc->idx];
 	case RTW89_RS_MCS:
-		return &head->mcs[desc->nss][desc->idx];
+		return &head->mcs[desc->ofdma][desc->nss][desc->idx];
 	case RTW89_RS_HEDCM:
-		return &head->hedcm[desc->nss][desc->idx];
+		return &head->hedcm[desc->ofdma][desc->nss][desc->idx];
 	case RTW89_RS_OFFSET:
 		return &head->offset[desc->idx];
 	default:
@@ -1569,7 +1569,7 @@ void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 	u8 i;
 
 	for (; cfg < end; cfg++) {
-		byr_head = &rtwdev->byr[cfg->band];
+		byr_head = &rtwdev->byr[cfg->band][0];
 		desc.rs = cfg->rs;
 		desc.nss = cfg->nss;
 		data = cfg->data;
@@ -1591,7 +1591,7 @@ static s8 rtw89_phy_txpwr_rf_to_mac(struct rtw89_dev *rtwdev, s8 txpwr_rf)
 }
 
 static
-s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
+s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
 			       const struct rtw89_rate_desc *rate_desc)
 {
 	struct rtw89_txpwr_byrate *byr_head;
@@ -1600,7 +1600,7 @@ s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
 	if (rate_desc->rs == RTW89_RS_CCK)
 		band = RTW89_BAND_2G;
 
-	byr_head = &rtwdev->byr[band];
+	byr_head = &rtwdev->byr[band][bw];
 	byr = rtw89_phy_raw_byr_seek(rtwdev, byr_head, rate_desc);
 
 	return rtw89_phy_txpwr_rf_to_mac(rtwdev, *byr);
@@ -2110,7 +2110,7 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 		RTW89_RS_MCS,
 		RTW89_RS_HEDCM,
 	};
-	struct rtw89_rate_desc cur;
+	struct rtw89_rate_desc cur = {};
 	u8 band = chan->band_type;
 	u8 ch = chan->channel;
 	u32 addr, val;
@@ -2136,7 +2136,7 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 			     cur.idx++) {
 				v[cur.idx % 4] =
 					rtw89_phy_read_txpwr_byrate(rtwdev,
-								    band,
+								    band, 0,
 								    &cur);
 
 				if ((cur.idx + 1) % 4)
@@ -2165,15 +2165,15 @@ void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
 		.rs = RTW89_RS_OFFSET,
 	};
 	u8 band = chan->band_type;
-	s8 v[RTW89_RATE_OFFSET_NUM] = {};
+	s8 v[RTW89_RATE_OFFSET_NUM_AX] = {};
 	u32 val;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr offset\n");
 
-	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_NUM; desc.idx++)
-		v[desc.idx] = rtw89_phy_read_txpwr_byrate(rtwdev, band, &desc);
+	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_NUM_AX; desc.idx++)
+		v[desc.idx] = rtw89_phy_read_txpwr_byrate(rtwdev, band, 0, &desc);
 
-	BUILD_BUG_ON(RTW89_RATE_OFFSET_NUM != 5);
+	BUILD_BUG_ON(RTW89_RATE_OFFSET_NUM_AX != 5);
 	val = FIELD_PREP(GENMASK(3, 0), v[0]) |
 	      FIELD_PREP(GENMASK(7, 4), v[1]) |
 	      FIELD_PREP(GENMASK(11, 8), v[2]) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 826228117160..f9599fcd5ac7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1707,8 +1707,8 @@ static void rtw8851b_set_tx_shape(struct rtw89_dev *rtwdev,
 	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
-	u8 tx_shape_cck = (*rfe_parms->tx_shape)[band][RTW89_RS_CCK][regd];
-	u8 tx_shape_ofdm = (*rfe_parms->tx_shape)[band][RTW89_RS_OFDM][regd];
+	u8 tx_shape_cck = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
 		rtw8851b_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index bd9655385318..888e5e75b40f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -14821,7 +14821,7 @@ const struct rtw89_rfe_parms rtw89_8851b_dflt_parms = {
 		.lmt = &rtw89_8851b_txpwr_lmt_5g,
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_5g,
 	},
-	.tx_shape = &rtw89_8851b_tx_shape,
+	.tx_shape.lmt = &rtw89_8851b_tx_shape,
 };
 
 static const struct rtw89_rfe_parms rtw89_8851b_rfe_parms_type2 = {
@@ -14834,7 +14834,7 @@ static const struct rtw89_rfe_parms rtw89_8851b_rfe_parms_type2 = {
 		.lmt = &rtw89_8851b_txpwr_lmt_5g_type2,
 		.lmt_ru = &rtw89_8851b_txpwr_lmt_ru_5g_type2,
 	},
-	.tx_shape = &rtw89_8851b_tx_shape,
+	.tx_shape.lmt = &rtw89_8851b_tx_shape,
 };
 
 const struct rtw89_rfe_parms_conf rtw89_8851b_rfe_parms_conf[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index eec421e88697..3c1f5a9284dc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1692,8 +1692,8 @@ static void rtw8852b_set_tx_shape(struct rtw89_dev *rtwdev,
 	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
-	u8 tx_shape_cck = (*rfe_parms->tx_shape)[band][RTW89_RS_CCK][regd];
-	u8 tx_shape_ofdm = (*rfe_parms->tx_shape)[band][RTW89_RS_OFDM][regd];
+	u8 tx_shape_cck = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
 		rtw8852b_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index e319e216f5c4..8aa6b978cbbf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -22892,5 +22892,5 @@ const struct rtw89_rfe_parms rtw89_8852b_dflt_parms = {
 		.lmt = &rtw89_8852b_txpwr_lmt_5g,
 		.lmt_ru = &rtw89_8852b_txpwr_lmt_ru_5g,
 	},
-	.tx_shape = &rtw89_8852b_tx_shape,
+	.tx_shape.lmt = &rtw89_8852b_tx_shape,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index aaed74135af2..2ec48fe3769f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1969,8 +1969,8 @@ static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
-	u8 tx_shape_cck = (*rfe_parms->tx_shape)[band][RTW89_RS_CCK][regd];
-	u8 tx_shape_ofdm = (*rfe_parms->tx_shape)[band][RTW89_RS_OFDM][regd];
+	u8 tx_shape_cck = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = (*rfe_parms->tx_shape.lmt)[band][RTW89_RS_OFDM][regd];
 
 	if (band == RTW89_BAND_2G)
 		rtw8852c_bb_set_tx_shape_dfir(rtwdev, chan, tx_shape_cck, phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index c42aa8778c4d..0c3850c90712 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -56476,5 +56476,5 @@ const struct rtw89_rfe_parms rtw89_8852c_dflt_parms = {
 		.lmt = &rtw89_8852c_txpwr_lmt_6g,
 		.lmt_ru = &rtw89_8852c_txpwr_lmt_ru_6g,
 	},
-	.tx_shape = &rtw89_8852c_tx_shape,
+	.tx_shape.lmt = &rtw89_8852c_tx_shape,
 };
-- 
2.25.1

