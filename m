Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A200732709
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 08:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbjFPGGH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 02:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjFPGGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 02:06:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA12D5F
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 23:05:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35G65Wx84032650, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35G65Wx84032650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 14:05:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 16 Jun 2023 14:05:51 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 14:05:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: TX power stuffs replace confusing naming of _max with _num
Date:   Fri, 16 Jun 2023 14:05:23 +0800
Message-ID: <20230616060523.28396-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some old declarations about TX power stuffs were named with confusing
`_max`. But, they mean "the number of". So we change them to be named
with `_num`.

(No logic is changed.)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 34 ++++++++--------
 drivers/net/wireless/realtek/rtw89/phy.c      | 40 +++++++++----------
 .../wireless/realtek/rtw89/rtw8851b_table.c   |  2 +-
 .../wireless/realtek/rtw89/rtw8851b_table.h   |  2 +-
 .../wireless/realtek/rtw89/rtw8852b_table.c   |  2 +-
 .../wireless/realtek/rtw89/rtw8852b_table.h   |  2 +-
 .../wireless/realtek/rtw89/rtw8852c_table.c   |  2 +-
 .../wireless/realtek/rtw89/rtw8852c_table.h   |  2 +-
 8 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c085dff3ae35e..d2c67db97db1a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -251,7 +251,7 @@ enum rtw89_band {
 	RTW89_BAND_2G = 0,
 	RTW89_BAND_5G = 1,
 	RTW89_BAND_6G = 2,
-	RTW89_BAND_MAX,
+	RTW89_BAND_NUM,
 };
 
 enum rtw89_hw_rate {
@@ -434,27 +434,27 @@ enum rtw89_rate_section {
 	RTW89_RS_MCS, /* for HT/VHT/HE */
 	RTW89_RS_HEDCM,
 	RTW89_RS_OFFSET,
-	RTW89_RS_MAX,
+	RTW89_RS_NUM,
 	RTW89_RS_LMT_NUM = RTW89_RS_MCS + 1,
 	RTW89_RS_TX_SHAPE_NUM = RTW89_RS_OFDM + 1,
 };
 
-enum rtw89_rate_max {
-	RTW89_RATE_CCK_MAX	= 4,
-	RTW89_RATE_OFDM_MAX	= 8,
-	RTW89_RATE_MCS_MAX	= 12,
-	RTW89_RATE_HEDCM_MAX	= 4, /* for HEDCM MCS0/1/3/4 */
-	RTW89_RATE_OFFSET_MAX	= 5, /* for HE(HEDCM)/VHT/HT/OFDM/CCK offset */
+enum rtw89_rate_num {
+	RTW89_RATE_CCK_NUM	= 4,
+	RTW89_RATE_OFDM_NUM	= 8,
+	RTW89_RATE_MCS_NUM	= 12,
+	RTW89_RATE_HEDCM_NUM	= 4, /* for HEDCM MCS0/1/3/4 */
+	RTW89_RATE_OFFSET_NUM	= 5, /* for HE(HEDCM)/VHT/HT/OFDM/CCK offset */
 };
 
 enum rtw89_nss {
 	RTW89_NSS_1		= 0,
 	RTW89_NSS_2		= 1,
 	/* HE DCM only support 1ss and 2ss */
-	RTW89_NSS_HEDCM_MAX	= RTW89_NSS_2 + 1,
+	RTW89_NSS_HEDCM_NUM	= RTW89_NSS_2 + 1,
 	RTW89_NSS_3		= 2,
 	RTW89_NSS_4		= 3,
-	RTW89_NSS_MAX,
+	RTW89_NSS_NUM,
 };
 
 enum rtw89_ntx {
@@ -512,11 +512,11 @@ enum rtw89_fw_pkt_ofld_type {
 };
 
 struct rtw89_txpwr_byrate {
-	s8 cck[RTW89_RATE_CCK_MAX];
-	s8 ofdm[RTW89_RATE_OFDM_MAX];
-	s8 mcs[RTW89_NSS_MAX][RTW89_RATE_MCS_MAX];
-	s8 hedcm[RTW89_NSS_HEDCM_MAX][RTW89_RATE_HEDCM_MAX];
-	s8 offset[RTW89_RATE_OFFSET_MAX];
+	s8 cck[RTW89_RATE_CCK_NUM];
+	s8 ofdm[RTW89_RATE_OFDM_NUM];
+	s8 mcs[RTW89_NSS_NUM][RTW89_RATE_MCS_NUM];
+	s8 hedcm[RTW89_NSS_HEDCM_NUM][RTW89_RATE_HEDCM_NUM];
+	s8 offset[RTW89_RATE_OFFSET_NUM];
 };
 
 enum rtw89_bandwidth_section_num {
@@ -3815,7 +3815,7 @@ struct rtw89_power_trim_info {
 
 struct rtw89_regd {
 	char alpha2[3];
-	u8 txpwr_regd[RTW89_BAND_MAX];
+	u8 txpwr_regd[RTW89_BAND_NUM];
 };
 
 struct rtw89_regulatory_info {
@@ -4111,7 +4111,7 @@ struct rtw89_dev {
 	bool is_bt_iqk_timeout;
 
 	struct rtw89_fem_info fem;
-	struct rtw89_txpwr_byrate byr[RTW89_BAND_MAX];
+	struct rtw89_txpwr_byrate byr[RTW89_BAND_NUM];
 	struct rtw89_tssi_info tssi;
 	struct rtw89_power_trim_info pwr_trim;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e94390b248244..fb15c852fdd48 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1494,19 +1494,19 @@ void rtw89_phy_write_reg3_tbl(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_write_reg3_tbl);
 
-static const u8 rtw89_rs_idx_max[] = {
-	[RTW89_RS_CCK] = RTW89_RATE_CCK_MAX,
-	[RTW89_RS_OFDM] = RTW89_RATE_OFDM_MAX,
-	[RTW89_RS_MCS] = RTW89_RATE_MCS_MAX,
-	[RTW89_RS_HEDCM] = RTW89_RATE_HEDCM_MAX,
-	[RTW89_RS_OFFSET] = RTW89_RATE_OFFSET_MAX,
+static const u8 rtw89_rs_idx_num[] = {
+	[RTW89_RS_CCK] = RTW89_RATE_CCK_NUM,
+	[RTW89_RS_OFDM] = RTW89_RATE_OFDM_NUM,
+	[RTW89_RS_MCS] = RTW89_RATE_MCS_NUM,
+	[RTW89_RS_HEDCM] = RTW89_RATE_HEDCM_NUM,
+	[RTW89_RS_OFFSET] = RTW89_RATE_OFFSET_NUM,
 };
 
-static const u8 rtw89_rs_nss_max[] = {
+static const u8 rtw89_rs_nss_num[] = {
 	[RTW89_RS_CCK] = 1,
 	[RTW89_RS_OFDM] = 1,
-	[RTW89_RS_MCS] = RTW89_NSS_MAX,
-	[RTW89_RS_HEDCM] = RTW89_NSS_HEDCM_MAX,
+	[RTW89_RS_MCS] = RTW89_NSS_NUM,
+	[RTW89_RS_HEDCM] = RTW89_NSS_HEDCM_NUM,
 	[RTW89_RS_OFFSET] = 1,
 };
 
@@ -1519,9 +1519,9 @@ static const u8 _byr_of_rs[] = {
 };
 
 #define _byr_seek(rs, raw) ((s8 *)(raw) + _byr_of_rs[rs])
-#define _byr_idx(rs, nss, idx) ((nss) * rtw89_rs_idx_max[rs] + (idx))
+#define _byr_idx(rs, nss, idx) ((nss) * rtw89_rs_idx_num[rs] + (idx))
 #define _byr_chk(rs, nss, idx) \
-	((nss) < rtw89_rs_nss_max[rs] && (idx) < rtw89_rs_idx_max[rs])
+	((nss) < rtw89_rs_nss_num[rs] && (idx) < rtw89_rs_idx_num[rs])
 
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl)
@@ -2084,19 +2084,19 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr byrate with ch=%d\n", ch);
 
-	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_CCK] % 4);
-	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_OFDM] % 4);
-	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_MCS] % 4);
-	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_HEDCM] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_CCK] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_OFDM] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_MCS] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_HEDCM] % 4);
 
 	addr = R_AX_PWR_BY_RATE;
 	for (cur.nss = 0; cur.nss < max_nss_num; cur.nss++) {
 		for (i = 0; i < ARRAY_SIZE(rs); i++) {
-			if (cur.nss >= rtw89_rs_nss_max[rs[i]])
+			if (cur.nss >= rtw89_rs_nss_num[rs[i]])
 				continue;
 
 			cur.rs = rs[i];
-			for (cur.idx = 0; cur.idx < rtw89_rs_idx_max[rs[i]];
+			for (cur.idx = 0; cur.idx < rtw89_rs_idx_num[rs[i]];
 			     cur.idx++) {
 				v[cur.idx % 4] =
 					rtw89_phy_read_txpwr_byrate(rtwdev,
@@ -2129,15 +2129,15 @@ void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
 		.rs = RTW89_RS_OFFSET,
 	};
 	u8 band = chan->band_type;
-	s8 v[RTW89_RATE_OFFSET_MAX] = {};
+	s8 v[RTW89_RATE_OFFSET_NUM] = {};
 	u32 val;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr offset\n");
 
-	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_MAX; desc.idx++)
+	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_NUM; desc.idx++)
 		v[desc.idx] = rtw89_phy_read_txpwr_byrate(rtwdev, band, &desc);
 
-	BUILD_BUG_ON(RTW89_RATE_OFFSET_MAX != 5);
+	BUILD_BUG_ON(RTW89_RATE_OFFSET_NUM != 5);
 	val = FIELD_PREP(GENMASK(3, 0), v[0]) |
 	      FIELD_PREP(GENMASK(7, 4), v[1]) |
 	      FIELD_PREP(GENMASK(11, 8), v[2]) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index bb724140df4f7..0eccef574c35d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -3305,7 +3305,7 @@ static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4
 };
 
-const u8 rtw89_8851b_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
+const u8 rtw89_8851b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 			     [RTW89_REGD_NUM] = {
 	[0][0][RTW89_ACMA] = 0,
 	[0][0][RTW89_CN] = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
index f2e673ba39c8c..a8737de02f669 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
@@ -13,7 +13,7 @@ extern const struct rtw89_phy_table rtw89_8851b_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8851b_byr_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8851b_trk_cfg;
-extern const u8 rtw89_8851b_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
+extern const u8 rtw89_8851b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 				    [RTW89_REGD_NUM];
 extern const struct rtw89_rfe_parms rtw89_8851b_dflt_parms;
 extern const struct rtw89_rfe_parms_conf rtw89_8851b_rfe_parms_conf[];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index 904cdb9e56fa7..17124d851a228 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -14666,7 +14666,7 @@ static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
 	 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};
 
-const u8 rtw89_8852b_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
+const u8 rtw89_8852b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 			     [RTW89_REGD_NUM] = {
 	[0][0][RTW89_ACMA] = 0,
 	[0][0][RTW89_CHILE] = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
index 5f4161496a589..7ef217629f46f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
@@ -14,7 +14,7 @@ extern const struct rtw89_phy_table rtw89_8852b_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8852b_byr_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg;
-extern const u8 rtw89_8852b_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
+extern const u8 rtw89_8852b_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 				    [RTW89_REGD_NUM];
 extern const struct rtw89_rfe_parms rtw89_8852b_dflt_parms;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index 8fda2c2e9833d..4b272fdf1fd7a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -31525,7 +31525,7 @@ static const s8 _txpwr_track_delta_swingidx_2g_cck_a_p[] = {
 	 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 5, 5, 5
 };
 
-const u8 rtw89_8852c_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
+const u8 rtw89_8852c_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 			     [RTW89_REGD_NUM] = {
 	[0][0][RTW89_ACMA] = 0,
 	[0][0][RTW89_CHILE] = 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
index 6da1849fb1fac..3eb0c49951744 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
@@ -15,7 +15,7 @@ extern const struct rtw89_phy_table rtw89_8852c_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8852c_byr_table;
 extern const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg;
-extern const u8 rtw89_8852c_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
+extern const u8 rtw89_8852c_tx_shape[RTW89_BAND_NUM][RTW89_RS_TX_SHAPE_NUM]
 				    [RTW89_REGD_NUM];
 extern const struct rtw89_rfe_parms rtw89_8852c_dflt_parms;
 
-- 
2.25.1

