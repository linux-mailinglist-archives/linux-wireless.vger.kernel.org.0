Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E055ED827
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiI1IsA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiI1IrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97A363D5B3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:44:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28S8i7kuD013397, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28S8i7kuD013397
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Sep 2022 16:44:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Sep 2022 16:44:32 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 28 Sep
 2022 16:44:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/9] wifi: rtw89: phy: make generic txpwr setting functions
Date:   Wed, 28 Sep 2022 16:43:31 +0800
Message-ID: <20220928084336.34981-5-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Previously, we thought control registers or setting things for TX power
series may change according to chip. So, setting functions are implemented
chip by chip. However, until now, the functions keep the same among chips,
at least 8852A, 8852C, and 8852B. There is a sufficient number of chips to
share generic setting functions. So, we now remake them including TX power
by rate, TX power offset, TX power limit, and TX power limit RU as generic
ones in phy.c.

Besides, there are some code refinements in the generic ones, but almost
all of the logic doesn't change.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 167 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |  25 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 145 +--------------
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |   1 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 145 +--------------
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |   1 -
 7 files changed, 184 insertions(+), 304 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index db041b32a8c2c..be39d2200e054 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -490,6 +490,8 @@ enum rtw89_bandwidth_section_num {
 	RTW89_BW80_SEC_NUM = 2,
 };
 
+#define RTW89_TXPWR_LMT_PAGE_SIZE 40
+
 struct rtw89_txpwr_limit {
 	s8 cck_20m[RTW89_BF_NUM];
 	s8 cck_40m[RTW89_BF_NUM];
@@ -504,6 +506,8 @@ struct rtw89_txpwr_limit {
 
 #define RTW89_RU_SEC_NUM 8
 
+#define RTW89_TXPWR_LMT_RU_PAGE_SIZE 24
+
 struct rtw89_txpwr_limit_ru {
 	s8 ru26[RTW89_RU_SEC_NUM];
 	s8 ru52[RTW89_RU_SEC_NUM];
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 6a6bdc652e09e..12a297f6bf50c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1443,23 +1443,21 @@ void rtw89_phy_write_reg3_tbl(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_write_reg3_tbl);
 
-const u8 rtw89_rs_idx_max[] = {
+static const u8 rtw89_rs_idx_max[] = {
 	[RTW89_RS_CCK] = RTW89_RATE_CCK_MAX,
 	[RTW89_RS_OFDM] = RTW89_RATE_OFDM_MAX,
 	[RTW89_RS_MCS] = RTW89_RATE_MCS_MAX,
 	[RTW89_RS_HEDCM] = RTW89_RATE_HEDCM_MAX,
 	[RTW89_RS_OFFSET] = RTW89_RATE_OFFSET_MAX,
 };
-EXPORT_SYMBOL(rtw89_rs_idx_max);
 
-const u8 rtw89_rs_nss_max[] = {
+static const u8 rtw89_rs_nss_max[] = {
 	[RTW89_RS_CCK] = 1,
 	[RTW89_RS_OFDM] = 1,
 	[RTW89_RS_MCS] = RTW89_NSS_MAX,
 	[RTW89_RS_HEDCM] = RTW89_NSS_HEDCM_MAX,
 	[RTW89_RS_OFFSET] = 1,
 };
-EXPORT_SYMBOL(rtw89_rs_nss_max);
 
 static const u8 _byr_of_rs[] = {
 	[RTW89_RS_CCK] = offsetof(struct rtw89_txpwr_byrate, cck),
@@ -1501,6 +1499,7 @@ EXPORT_SYMBOL(rtw89_phy_load_txpwr_byrate);
 	(txpwr_rf) >> (__c->txpwr_factor_rf - __c->txpwr_factor_mac);	\
 })
 
+static
 s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
 			       const struct rtw89_rate_desc *rate_desc)
 {
@@ -1523,7 +1522,6 @@ s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
 
 	return _phy_txpwr_rf_to_mac(rtwdev, byr[idx]);
 }
-EXPORT_SYMBOL(rtw89_phy_read_txpwr_byrate);
 
 static u8 rtw89_channel_6g_to_idx(struct rtw89_dev *rtwdev, u8 channel_6g)
 {
@@ -1783,6 +1781,7 @@ static void rtw89_phy_fill_txpwr_limit_160m(struct rtw89_dev *rtwdev,
 		lmt->mcs_40m_2p5[i] = min_t(s8, val_2p5_n[i], val_2p5_p[i]);
 }
 
+static
 void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
 				struct rtw89_txpwr_limit *lmt,
@@ -1813,7 +1812,6 @@ void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 		break;
 	}
 }
-EXPORT_SYMBOL(rtw89_phy_fill_txpwr_limit);
 
 static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 					u8 ru, u8 ntx, u8 ch)
@@ -1962,6 +1960,7 @@ rtw89_phy_fill_txpwr_limit_ru_160m(struct rtw89_dev *rtwdev,
 	}
 }
 
+static
 void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 				   const struct rtw89_chan *chan,
 				   struct rtw89_txpwr_limit_ru *lmt_ru,
@@ -1992,7 +1991,161 @@ void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 		break;
 	}
 }
-EXPORT_SYMBOL(rtw89_phy_fill_txpwr_limit_ru);
+
+void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
+				enum rtw89_phy_idx phy_idx)
+{
+	static const u8 rs[] = {
+		RTW89_RS_CCK,
+		RTW89_RS_OFDM,
+		RTW89_RS_MCS,
+		RTW89_RS_HEDCM,
+	};
+	struct rtw89_rate_desc cur;
+	u8 band = chan->band_type;
+	u8 ch = chan->channel;
+	u32 addr, val;
+	s8 v[4] = {};
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] set txpwr byrate with ch=%d\n", ch);
+
+	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_CCK] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_OFDM] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_MCS] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_max[RTW89_RS_HEDCM] % 4);
+
+	addr = R_AX_PWR_BY_RATE;
+	for (cur.nss = 0; cur.nss <= RTW89_NSS_2; cur.nss++) {
+		for (i = 0; i < ARRAY_SIZE(rs); i++) {
+			if (cur.nss >= rtw89_rs_nss_max[rs[i]])
+				continue;
+
+			cur.rs = rs[i];
+			for (cur.idx = 0; cur.idx < rtw89_rs_idx_max[rs[i]];
+			     cur.idx++) {
+				v[cur.idx % 4] =
+					rtw89_phy_read_txpwr_byrate(rtwdev,
+								    band,
+								    &cur);
+
+				if ((cur.idx + 1) % 4)
+					continue;
+
+				val = FIELD_PREP(GENMASK(7, 0), v[0]) |
+				      FIELD_PREP(GENMASK(15, 8), v[1]) |
+				      FIELD_PREP(GENMASK(23, 16), v[2]) |
+				      FIELD_PREP(GENMASK(31, 24), v[3]);
+
+				rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr,
+							val);
+				addr += 4;
+			}
+		}
+	}
+}
+EXPORT_SYMBOL(rtw89_phy_set_txpwr_byrate);
+
+void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
+				enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_rate_desc desc = {
+		.nss = RTW89_NSS_1,
+		.rs = RTW89_RS_OFFSET,
+	};
+	u8 band = chan->band_type;
+	s8 v[RTW89_RATE_OFFSET_MAX] = {};
+	u32 val;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr offset\n");
+
+	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_MAX; desc.idx++)
+		v[desc.idx] = rtw89_phy_read_txpwr_byrate(rtwdev, band, &desc);
+
+	BUILD_BUG_ON(RTW89_RATE_OFFSET_MAX != 5);
+	val = FIELD_PREP(GENMASK(3, 0), v[0]) |
+	      FIELD_PREP(GENMASK(7, 4), v[1]) |
+	      FIELD_PREP(GENMASK(11, 8), v[2]) |
+	      FIELD_PREP(GENMASK(15, 12), v[3]) |
+	      FIELD_PREP(GENMASK(19, 16), v[4]);
+
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_OFST_CTRL,
+				     GENMASK(19, 0), val);
+}
+EXPORT_SYMBOL(rtw89_phy_set_txpwr_offset);
+
+void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_txpwr_limit lmt;
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
+	const s8 *ptr;
+	u32 addr, val;
+	u8 i, j;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
+
+	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit) !=
+		     RTW89_TXPWR_LMT_PAGE_SIZE);
+
+	addr = R_AX_PWR_LMT;
+	for (i = 0; i < RTW89_NTX_NUM; i++) {
+		rtw89_phy_fill_txpwr_limit(rtwdev, chan, &lmt, i);
+
+		ptr = (s8 *)&lmt;
+		for (j = 0; j < RTW89_TXPWR_LMT_PAGE_SIZE;
+		     j += 4, addr += 4, ptr += 4) {
+			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
+			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
+			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
+			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
+
+			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
+		}
+	}
+}
+EXPORT_SYMBOL(rtw89_phy_set_txpwr_limit);
+
+void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_txpwr_limit_ru lmt_ru;
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
+	const s8 *ptr;
+	u32 addr, val;
+	u8 i, j;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
+
+	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit_ru) !=
+		     RTW89_TXPWR_LMT_RU_PAGE_SIZE);
+
+	addr = R_AX_PWR_RU_LMT;
+	for (i = 0; i < RTW89_NTX_NUM; i++) {
+		rtw89_phy_fill_txpwr_limit_ru(rtwdev, chan, &lmt_ru, i);
+
+		ptr = (s8 *)&lmt_ru;
+		for (j = 0; j < RTW89_TXPWR_LMT_RU_PAGE_SIZE;
+		     j += 4, addr += 4, ptr += 4) {
+			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
+			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
+			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
+			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
+
+			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
+		}
+	}
+}
+EXPORT_SYMBOL(rtw89_phy_set_txpwr_limit_ru);
 
 struct rtw89_phy_iter_ra_data {
 	struct rtw89_dev *rtwdev;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index ee3bc5e111e16..030a7c904a28d 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -317,9 +317,6 @@ struct rtw89_nbi_reg_def {
 	struct rtw89_reg_def notch2_en;
 };
 
-extern const u8 rtw89_rs_idx_max[RTW89_RS_MAX];
-extern const u8 rtw89_rs_nss_max[RTW89_RS_MAX];
-
 static inline void rtw89_phy_write8(struct rtw89_dev *rtwdev,
 				    u32 addr, u8 data)
 {
@@ -460,18 +457,20 @@ void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
-s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band,
-			       const struct rtw89_rate_desc *rate_desc);
-void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
-				const struct rtw89_chan *chan,
-				struct rtw89_txpwr_limit *lmt,
-				u8 ntx);
-void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
-				   const struct rtw89_chan *chan,
-				   struct rtw89_txpwr_limit_ru *lmt_ru,
-				   u8 ntx);
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch);
+void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
+				enum rtw89_phy_idx phy_idx);
+void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
+				enum rtw89_phy_idx phy_idx);
+void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx);
+void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx);
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
 void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 7841476803535..5678683ec02a5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1410,151 +1410,14 @@ static void rtw8852a_set_txpwr_ref(struct rtw89_dev *rtwdev,
 				      phy_idx);
 }
 
-static void rtw8852a_set_txpwr_byrate(struct rtw89_dev *rtwdev,
-				      const struct rtw89_chan *chan,
-				      enum rtw89_phy_idx phy_idx)
-{
-	u8 band = chan->band_type;
-	u8 ch = chan->channel;
-	static const u8 rs[] = {
-		RTW89_RS_CCK,
-		RTW89_RS_OFDM,
-		RTW89_RS_MCS,
-		RTW89_RS_HEDCM,
-	};
-	s8 tmp;
-	u8 i, j;
-	u32 val, shf, addr = R_AX_PWR_BY_RATE;
-	struct rtw89_rate_desc cur;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-		    "[TXPWR] set txpwr byrate with ch=%d\n", ch);
-
-	for (cur.nss = 0; cur.nss <= RTW89_NSS_2; cur.nss++) {
-		for (i = 0; i < ARRAY_SIZE(rs); i++) {
-			if (cur.nss >= rtw89_rs_nss_max[rs[i]])
-				continue;
-
-			val = 0;
-			cur.rs = rs[i];
-
-			for (j = 0; j < rtw89_rs_idx_max[rs[i]]; j++) {
-				cur.idx = j;
-				shf = (j % 4) * 8;
-				tmp = rtw89_phy_read_txpwr_byrate(rtwdev, band,
-								  &cur);
-				val |= (tmp << shf);
-
-				if ((j + 1) % 4)
-					continue;
-
-				rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
-				val = 0;
-				addr += 4;
-			}
-		}
-	}
-}
-
-static void rtw8852a_set_txpwr_offset(struct rtw89_dev *rtwdev,
-				      const struct rtw89_chan *chan,
-				      enum rtw89_phy_idx phy_idx)
-{
-	u8 band = chan->band_type;
-	struct rtw89_rate_desc desc = {
-		.nss = RTW89_NSS_1,
-		.rs = RTW89_RS_OFFSET,
-	};
-	u32 val = 0;
-	s8 v;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr offset\n");
-
-	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_MAX; desc.idx++) {
-		v = rtw89_phy_read_txpwr_byrate(rtwdev, band, &desc);
-		val |= ((v & 0xf) << (4 * desc.idx));
-	}
-
-	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_OFST_CTRL,
-				     GENMASK(19, 0), val);
-}
-
-static void rtw8852a_set_txpwr_limit(struct rtw89_dev *rtwdev,
-				     const struct rtw89_chan *chan,
-				     enum rtw89_phy_idx phy_idx)
-{
-#define __MAC_TXPWR_LMT_PAGE_SIZE 40
-	u8 ch = chan->channel;
-	u8 bw = chan->band_width;
-	struct rtw89_txpwr_limit lmt[NTX_NUM_8852A];
-	u32 addr, val;
-	const s8 *ptr;
-	u8 i, j;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
-
-	for (i = 0; i < NTX_NUM_8852A; i++) {
-		rtw89_phy_fill_txpwr_limit(rtwdev, chan, &lmt[i], i);
-
-		for (j = 0; j < __MAC_TXPWR_LMT_PAGE_SIZE; j += 4) {
-			addr = R_AX_PWR_LMT + j + __MAC_TXPWR_LMT_PAGE_SIZE * i;
-			ptr = (s8 *)&lmt[i] + j;
-
-			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
-			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
-			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
-			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
-
-			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
-		}
-	}
-#undef __MAC_TXPWR_LMT_PAGE_SIZE
-}
-
-static void rtw8852a_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
-					const struct rtw89_chan *chan,
-					enum rtw89_phy_idx phy_idx)
-{
-#define __MAC_TXPWR_LMT_RU_PAGE_SIZE 24
-	u8 ch = chan->channel;
-	u8 bw = chan->band_width;
-	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852A];
-	u32 addr, val;
-	const s8 *ptr;
-	u8 i, j;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
-
-	for (i = 0; i < NTX_NUM_8852A; i++) {
-		rtw89_phy_fill_txpwr_limit_ru(rtwdev, chan, &lmt_ru[i], i);
-
-		for (j = 0; j < __MAC_TXPWR_LMT_RU_PAGE_SIZE; j += 4) {
-			addr = R_AX_PWR_RU_LMT + j +
-			       __MAC_TXPWR_LMT_RU_PAGE_SIZE * i;
-			ptr = (s8 *)&lmt_ru[i] + j;
-
-			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
-			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
-			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
-			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
-
-			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
-		}
-	}
-
-#undef __MAC_TXPWR_LMT_RU_PAGE_SIZE
-}
-
 static void rtw8852a_set_txpwr(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
 			       enum rtw89_phy_idx phy_idx)
 {
-	rtw8852a_set_txpwr_byrate(rtwdev, chan, phy_idx);
-	rtw8852a_set_txpwr_offset(rtwdev, chan, phy_idx);
-	rtw8852a_set_txpwr_limit(rtwdev, chan, phy_idx);
-	rtw8852a_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 }
 
 static void rtw8852a_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.h b/drivers/net/wireless/realtek/rtw89/rtw8852a.h
index fcff1194c0096..ea82fed7b7bec 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.h
@@ -8,7 +8,6 @@
 #include "core.h"
 
 #define RF_PATH_NUM_8852A 2
-#define NTX_NUM_8852A 2
 
 enum rtw8852a_pmac_mode {
 	NONE_TEST,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 67653b3e1a356..a6a9fe3d0b565 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2006,75 +2006,6 @@ static void rtw8852c_set_txpwr_ref(struct rtw89_dev *rtwdev,
 				      phy_idx);
 }
 
-static void rtw8852c_set_txpwr_byrate(struct rtw89_dev *rtwdev,
-				      const struct rtw89_chan *chan,
-				      enum rtw89_phy_idx phy_idx)
-{
-	u8 band = chan->band_type;
-	u8 ch = chan->channel;
-	static const u8 rs[] = {
-		RTW89_RS_CCK,
-		RTW89_RS_OFDM,
-		RTW89_RS_MCS,
-		RTW89_RS_HEDCM,
-	};
-	s8 tmp;
-	u8 i, j;
-	u32 val, shf, addr = R_AX_PWR_BY_RATE;
-	struct rtw89_rate_desc cur;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-		    "[TXPWR] set txpwr byrate with ch=%d\n", ch);
-
-	for (cur.nss = 0; cur.nss <= RTW89_NSS_2; cur.nss++) {
-		for (i = 0; i < ARRAY_SIZE(rs); i++) {
-			if (cur.nss >= rtw89_rs_nss_max[rs[i]])
-				continue;
-
-			val = 0;
-			cur.rs = rs[i];
-
-			for (j = 0; j < rtw89_rs_idx_max[rs[i]]; j++) {
-				cur.idx = j;
-				shf = (j % 4) * 8;
-				tmp = rtw89_phy_read_txpwr_byrate(rtwdev, band,
-								  &cur);
-				val |= (tmp << shf);
-
-				if ((j + 1) % 4)
-					continue;
-
-				rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
-				val = 0;
-				addr += 4;
-			}
-		}
-	}
-}
-
-static void rtw8852c_set_txpwr_offset(struct rtw89_dev *rtwdev,
-				      const struct rtw89_chan *chan,
-				      enum rtw89_phy_idx phy_idx)
-{
-	u8 band = chan->band_type;
-	struct rtw89_rate_desc desc = {
-		.nss = RTW89_NSS_1,
-		.rs = RTW89_RS_OFFSET,
-	};
-	u32 val = 0;
-	s8 v;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr offset\n");
-
-	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_MAX; desc.idx++) {
-		v = rtw89_phy_read_txpwr_byrate(rtwdev, band, &desc);
-		val |= ((v & 0xf) << (4 * desc.idx));
-	}
-
-	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_OFST_CTRL,
-				     GENMASK(19, 0), val);
-}
-
 static void rtw8852c_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
 					  u8 tx_shape_idx,
 					  enum rtw89_phy_idx phy_idx)
@@ -2147,83 +2078,15 @@ static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 					     tx_shape_ofdm);
 }
 
-static void rtw8852c_set_txpwr_limit(struct rtw89_dev *rtwdev,
-				     const struct rtw89_chan *chan,
-				     enum rtw89_phy_idx phy_idx)
-{
-#define __MAC_TXPWR_LMT_PAGE_SIZE 40
-	u8 ch = chan->channel;
-	u8 bw = chan->band_width;
-	struct rtw89_txpwr_limit lmt[NTX_NUM_8852C];
-	u32 addr, val;
-	const s8 *ptr;
-	u8 i, j;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
-
-	for (i = 0; i < NTX_NUM_8852C; i++) {
-		rtw89_phy_fill_txpwr_limit(rtwdev, chan, &lmt[i], i);
-
-		for (j = 0; j < __MAC_TXPWR_LMT_PAGE_SIZE; j += 4) {
-			addr = R_AX_PWR_LMT + j + __MAC_TXPWR_LMT_PAGE_SIZE * i;
-			ptr = (s8 *)&lmt[i] + j;
-
-			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
-			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
-			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
-			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
-
-			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
-		}
-	}
-#undef __MAC_TXPWR_LMT_PAGE_SIZE
-}
-
-static void rtw8852c_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
-					const struct rtw89_chan *chan,
-					enum rtw89_phy_idx phy_idx)
-{
-#define __MAC_TXPWR_LMT_RU_PAGE_SIZE 24
-	u8 ch = chan->channel;
-	u8 bw = chan->band_width;
-	struct rtw89_txpwr_limit_ru lmt_ru[NTX_NUM_8852C];
-	u32 addr, val;
-	const s8 *ptr;
-	u8 i, j;
-
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
-		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
-
-	for (i = 0; i < NTX_NUM_8852C; i++) {
-		rtw89_phy_fill_txpwr_limit_ru(rtwdev, chan, &lmt_ru[i], i);
-
-		for (j = 0; j < __MAC_TXPWR_LMT_RU_PAGE_SIZE; j += 4) {
-			addr = R_AX_PWR_RU_LMT + j +
-			       __MAC_TXPWR_LMT_RU_PAGE_SIZE * i;
-			ptr = (s8 *)&lmt_ru[i] + j;
-
-			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
-			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
-			      FIELD_PREP(GENMASK(23, 16), ptr[2]) |
-			      FIELD_PREP(GENMASK(31, 24), ptr[3]);
-
-			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
-		}
-	}
-
-#undef __MAC_TXPWR_LMT_RU_PAGE_SIZE
-}
-
 static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
 			       enum rtw89_phy_idx phy_idx)
 {
-	rtw8852c_set_txpwr_byrate(rtwdev, chan, phy_idx);
-	rtw8852c_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
 	rtw8852c_set_tx_shape(rtwdev, chan, phy_idx);
-	rtw8852c_set_txpwr_limit(rtwdev, chan, phy_idx);
-	rtw8852c_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 }
 
 static void rtw8852c_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 558dd0f048f2b..ac642808a81ff 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -9,7 +9,6 @@
 
 #define RF_PATH_NUM_8852C 2
 #define BB_PATH_NUM_8852C 2
-#define NTX_NUM_8852C 2
 
 struct rtw8852c_u_efuse {
 	u8 rsvd[0x38];
-- 
2.25.1

