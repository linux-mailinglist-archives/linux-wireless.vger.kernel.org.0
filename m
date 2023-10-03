Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6E7B5ED9
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbjJCBzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbjJCBzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB17BD
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:18 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931tBseD1334533, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931tBseD1334533
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 09:55:09 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/7] wifi: rtw89: phy: set TX power RU limit according to chip gen
Date:   Tue, 3 Oct 2023 09:54:44 +0800
Message-ID: <20231003015446.14658-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003015446.14658-1-pkshih@realtek.com>
References: <20231003015446.14658-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

Wi-Fi 6 chips and Wi-Fi 7 chips have different register design for TX
power RU limit. We rename original setting stuffs with a suffix `_ax`,
concentrate related enum declaration in phy.h, and implement setting
flow for Wi-Fi 7 chips. Then, we set TX power RU limit according to
chip generation.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  10 --
 drivers/net/wireless/realtek/rtw89/phy.c    |  74 +++++-----
 drivers/net/wireless/realtek/rtw89/phy.h    |  36 ++++-
 drivers/net/wireless/realtek/rtw89/phy_be.c | 141 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |   1 +
 5 files changed, 214 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7ef3ebe7f793..06d3c026e1de 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -744,16 +744,6 @@ struct rtw89_txpwr_byrate {
 	s8 trap;
 };
 
-#define RTW89_RU_SEC_NUM 8
-
-#define RTW89_TXPWR_LMT_RU_PAGE_SIZE 24
-
-struct rtw89_txpwr_limit_ru {
-	s8 ru26[RTW89_RU_SEC_NUM];
-	s8 ru52[RTW89_RU_SEC_NUM];
-	s8 ru106[RTW89_RU_SEC_NUM];
-};
-
 struct rtw89_rate_desc {
 	enum rtw89_nss nss;
 	enum rtw89_rate_section rs;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 8c5b73294a93..ded15ffa30bb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1906,8 +1906,8 @@ void rtw89_phy_fill_txpwr_limit_ax(struct rtw89_dev *rtwdev,
 	}
 }
 
-static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
-					u8 ru, u8 ntx, u8 ch)
+s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
+				 u8 ru, u8 ntx, u8 ch)
 {
 	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	const struct rtw89_txpwr_rule_2ghz *rule_2ghz = &rfe_parms->rule_2ghz;
@@ -1957,9 +1957,9 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 }
 
 static void
-rtw89_phy_fill_txpwr_limit_ru_20m(struct rtw89_dev *rtwdev,
-				  struct rtw89_txpwr_limit_ru *lmt_ru,
-				  u8 band, u8 ntx, u8 ch)
+rtw89_phy_fill_txpwr_limit_ru_20m_ax(struct rtw89_dev *rtwdev,
+				     struct rtw89_txpwr_limit_ru_ax *lmt_ru,
+				     u8 band, u8 ntx, u8 ch)
 {
 	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
 							RTW89_RU26,
@@ -1973,9 +1973,9 @@ rtw89_phy_fill_txpwr_limit_ru_20m(struct rtw89_dev *rtwdev,
 }
 
 static void
-rtw89_phy_fill_txpwr_limit_ru_40m(struct rtw89_dev *rtwdev,
-				  struct rtw89_txpwr_limit_ru *lmt_ru,
-				  u8 band, u8 ntx, u8 ch)
+rtw89_phy_fill_txpwr_limit_ru_40m_ax(struct rtw89_dev *rtwdev,
+				     struct rtw89_txpwr_limit_ru_ax *lmt_ru,
+				     u8 band, u8 ntx, u8 ch)
 {
 	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
 							RTW89_RU26,
@@ -1998,9 +1998,9 @@ rtw89_phy_fill_txpwr_limit_ru_40m(struct rtw89_dev *rtwdev,
 }
 
 static void
-rtw89_phy_fill_txpwr_limit_ru_80m(struct rtw89_dev *rtwdev,
-				  struct rtw89_txpwr_limit_ru *lmt_ru,
-				  u8 band, u8 ntx, u8 ch)
+rtw89_phy_fill_txpwr_limit_ru_80m_ax(struct rtw89_dev *rtwdev,
+				     struct rtw89_txpwr_limit_ru_ax *lmt_ru,
+				     u8 band, u8 ntx, u8 ch)
 {
 	lmt_ru->ru26[0] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
 							RTW89_RU26,
@@ -2041,15 +2041,15 @@ rtw89_phy_fill_txpwr_limit_ru_80m(struct rtw89_dev *rtwdev,
 }
 
 static void
-rtw89_phy_fill_txpwr_limit_ru_160m(struct rtw89_dev *rtwdev,
-				   struct rtw89_txpwr_limit_ru *lmt_ru,
-				   u8 band, u8 ntx, u8 ch)
+rtw89_phy_fill_txpwr_limit_ru_160m_ax(struct rtw89_dev *rtwdev,
+				      struct rtw89_txpwr_limit_ru_ax *lmt_ru,
+				      u8 band, u8 ntx, u8 ch)
 {
 	static const int ofst[] = { -14, -10, -6, -2, 2, 6, 10, 14 };
 	int i;
 
-	static_assert(ARRAY_SIZE(ofst) == RTW89_RU_SEC_NUM);
-	for (i = 0; i < RTW89_RU_SEC_NUM; i++) {
+	static_assert(ARRAY_SIZE(ofst) == RTW89_RU_SEC_NUM_AX);
+	for (i = 0; i < RTW89_RU_SEC_NUM_AX; i++) {
 		lmt_ru->ru26[i] = rtw89_phy_read_txpwr_limit_ru(rtwdev, band,
 								RTW89_RU26,
 								ntx,
@@ -2066,10 +2066,10 @@ rtw89_phy_fill_txpwr_limit_ru_160m(struct rtw89_dev *rtwdev,
 }
 
 static
-void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
-				   const struct rtw89_chan *chan,
-				   struct rtw89_txpwr_limit_ru *lmt_ru,
-				   u8 ntx)
+void rtw89_phy_fill_txpwr_limit_ru_ax(struct rtw89_dev *rtwdev,
+				      const struct rtw89_chan *chan,
+				      struct rtw89_txpwr_limit_ru_ax *lmt_ru,
+				      u8 ntx)
 {
 	u8 band = chan->band_type;
 	u8 ch = chan->channel;
@@ -2079,20 +2079,20 @@ void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 
 	switch (bw) {
 	case RTW89_CHANNEL_WIDTH_20:
-		rtw89_phy_fill_txpwr_limit_ru_20m(rtwdev, lmt_ru, band, ntx,
-						  ch);
+		rtw89_phy_fill_txpwr_limit_ru_20m_ax(rtwdev, lmt_ru, band, ntx,
+						     ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_phy_fill_txpwr_limit_ru_40m(rtwdev, lmt_ru, band, ntx,
-						  ch);
+		rtw89_phy_fill_txpwr_limit_ru_40m_ax(rtwdev, lmt_ru, band, ntx,
+						     ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_phy_fill_txpwr_limit_ru_80m(rtwdev, lmt_ru, band, ntx,
-						  ch);
+		rtw89_phy_fill_txpwr_limit_ru_80m_ax(rtwdev, lmt_ru, band, ntx,
+						     ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_160:
-		rtw89_phy_fill_txpwr_limit_ru_160m(rtwdev, lmt_ru, band, ntx,
-						   ch);
+		rtw89_phy_fill_txpwr_limit_ru_160m_ax(rtwdev, lmt_ru, band, ntx,
+						      ch);
 		break;
 	}
 }
@@ -2217,12 +2217,12 @@ static void rtw89_phy_set_txpwr_limit_ax(struct rtw89_dev *rtwdev,
 	}
 }
 
-void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
-				  const struct rtw89_chan *chan,
-				  enum rtw89_phy_idx phy_idx)
+static void rtw89_phy_set_txpwr_limit_ru_ax(struct rtw89_dev *rtwdev,
+					    const struct rtw89_chan *chan,
+					    enum rtw89_phy_idx phy_idx)
 {
 	u8 max_ntx_num = rtwdev->chip->rf_path_num;
-	struct rtw89_txpwr_limit_ru lmt_ru;
+	struct rtw89_txpwr_limit_ru_ax lmt_ru;
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
 	const s8 *ptr;
@@ -2232,15 +2232,15 @@ void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr limit ru with ch=%d bw=%d\n", ch, bw);
 
-	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit_ru) !=
-		     RTW89_TXPWR_LMT_RU_PAGE_SIZE);
+	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit_ru_ax) !=
+		     RTW89_TXPWR_LMT_RU_PAGE_SIZE_AX);
 
 	addr = R_AX_PWR_RU_LMT;
 	for (i = 0; i < max_ntx_num; i++) {
-		rtw89_phy_fill_txpwr_limit_ru(rtwdev, chan, &lmt_ru, i);
+		rtw89_phy_fill_txpwr_limit_ru_ax(rtwdev, chan, &lmt_ru, i);
 
 		ptr = (s8 *)&lmt_ru;
-		for (j = 0; j < RTW89_TXPWR_LMT_RU_PAGE_SIZE;
+		for (j = 0; j < RTW89_TXPWR_LMT_RU_PAGE_SIZE_AX;
 		     j += 4, addr += 4, ptr += 4) {
 			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
 			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
@@ -2251,7 +2251,6 @@ void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 		}
 	}
 }
-EXPORT_SYMBOL(rtw89_phy_set_txpwr_limit_ru);
 
 struct rtw89_phy_iter_ra_data {
 	struct rtw89_dev *rtwdev;
@@ -4837,5 +4836,6 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
 	.set_txpwr_limit = rtw89_phy_set_txpwr_limit_ax,
+	.set_txpwr_limit_ru = rtw89_phy_set_txpwr_limit_ru_ax,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 72bc00bcb04c..9473798b9dac 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -444,6 +444,28 @@ struct rtw89_txpwr_limit_be {
 	s8 mcs_40m_6p5[RTW89_BF_NUM];
 };
 
+#define RTW89_RU_SEC_NUM_AX 8
+
+#define RTW89_TXPWR_LMT_RU_PAGE_SIZE_AX 24
+
+struct rtw89_txpwr_limit_ru_ax {
+	s8 ru26[RTW89_RU_SEC_NUM_AX];
+	s8 ru52[RTW89_RU_SEC_NUM_AX];
+	s8 ru106[RTW89_RU_SEC_NUM_AX];
+};
+
+#define RTW89_RU_SEC_NUM_BE 16
+
+#define RTW89_TXPWR_LMT_RU_PAGE_SIZE_BE 80
+
+struct rtw89_txpwr_limit_ru_be {
+	s8 ru26[RTW89_RU_SEC_NUM_BE];
+	s8 ru52[RTW89_RU_SEC_NUM_BE];
+	s8 ru106[RTW89_RU_SEC_NUM_BE];
+	s8 ru52_26[RTW89_RU_SEC_NUM_BE];
+	s8 ru106_26[RTW89_RU_SEC_NUM_BE];
+};
+
 struct rtw89_phy_gen_def {
 	u32 cr_base;
 	const struct rtw89_ccx_regs *ccx;
@@ -458,6 +480,9 @@ struct rtw89_phy_gen_def {
 	void (*set_txpwr_limit)(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
 				enum rtw89_phy_idx phy_idx);
+	void (*set_txpwr_limit_ru)(struct rtw89_dev *rtwdev,
+				   const struct rtw89_chan *chan,
+				   enum rtw89_phy_idx phy_idx);
 };
 
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
@@ -676,6 +701,8 @@ void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch);
+s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
+				 u8 ru, u8 ntx, u8 ch);
 
 static inline
 void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
@@ -707,9 +734,16 @@ void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 	phy->set_txpwr_limit(rtwdev, chan, phy_idx);
 }
 
+static inline
 void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
-				  enum rtw89_phy_idx phy_idx);
+				  enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	phy->set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+}
+
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
 void rtw89_phy_ra_updata_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 500f24b23d06..f0e1da2c2a91 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -492,6 +492,146 @@ static void rtw89_phy_set_txpwr_limit_be(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void fill_limit_ru_each(struct rtw89_dev *rtwdev, u8 index,
+			       struct rtw89_txpwr_limit_ru_be *lmt_ru,
+			       u8 band, u8 ntx, u8 ch)
+{
+	lmt_ru->ru26[index] =
+		rtw89_phy_read_txpwr_limit_ru(rtwdev, band, RTW89_RU26, ntx, ch);
+	lmt_ru->ru52[index] =
+		rtw89_phy_read_txpwr_limit_ru(rtwdev, band, RTW89_RU52, ntx, ch);
+	lmt_ru->ru106[index] =
+		rtw89_phy_read_txpwr_limit_ru(rtwdev, band, RTW89_RU106, ntx, ch);
+	lmt_ru->ru52_26[index] =
+		rtw89_phy_read_txpwr_limit_ru(rtwdev, band, RTW89_RU52_26, ntx, ch);
+	lmt_ru->ru106_26[index] =
+		rtw89_phy_read_txpwr_limit_ru(rtwdev, band, RTW89_RU106_26, ntx, ch);
+}
+
+static void phy_fill_limit_ru_20m_be(struct rtw89_dev *rtwdev,
+				     struct rtw89_txpwr_limit_ru_be *lmt_ru,
+				     u8 band, u8 ntx, u8 ch)
+{
+	fill_limit_ru_each(rtwdev, 0, lmt_ru, band, ntx, ch);
+}
+
+static void phy_fill_limit_ru_40m_be(struct rtw89_dev *rtwdev,
+				     struct rtw89_txpwr_limit_ru_be *lmt_ru,
+				     u8 band, u8 ntx, u8 ch)
+{
+	fill_limit_ru_each(rtwdev, 0, lmt_ru, band, ntx, ch - 2);
+	fill_limit_ru_each(rtwdev, 1, lmt_ru, band, ntx, ch + 2);
+}
+
+static void phy_fill_limit_ru_80m_be(struct rtw89_dev *rtwdev,
+				     struct rtw89_txpwr_limit_ru_be *lmt_ru,
+				     u8 band, u8 ntx, u8 ch)
+{
+	fill_limit_ru_each(rtwdev, 0, lmt_ru, band, ntx, ch - 6);
+	fill_limit_ru_each(rtwdev, 1, lmt_ru, band, ntx, ch - 2);
+	fill_limit_ru_each(rtwdev, 2, lmt_ru, band, ntx, ch + 2);
+	fill_limit_ru_each(rtwdev, 3, lmt_ru, band, ntx, ch + 6);
+}
+
+static void phy_fill_limit_ru_160m_be(struct rtw89_dev *rtwdev,
+				      struct rtw89_txpwr_limit_ru_be *lmt_ru,
+				      u8 band, u8 ntx, u8 ch)
+{
+	fill_limit_ru_each(rtwdev, 0, lmt_ru, band, ntx, ch - 14);
+	fill_limit_ru_each(rtwdev, 1, lmt_ru, band, ntx, ch - 10);
+	fill_limit_ru_each(rtwdev, 2, lmt_ru, band, ntx, ch - 6);
+	fill_limit_ru_each(rtwdev, 3, lmt_ru, band, ntx, ch - 2);
+	fill_limit_ru_each(rtwdev, 4, lmt_ru, band, ntx, ch + 2);
+	fill_limit_ru_each(rtwdev, 5, lmt_ru, band, ntx, ch + 6);
+	fill_limit_ru_each(rtwdev, 6, lmt_ru, band, ntx, ch + 10);
+	fill_limit_ru_each(rtwdev, 7, lmt_ru, band, ntx, ch + 14);
+}
+
+static void phy_fill_limit_ru_320m_be(struct rtw89_dev *rtwdev,
+				      struct rtw89_txpwr_limit_ru_be *lmt_ru,
+				      u8 band, u8 ntx, u8 ch)
+{
+	fill_limit_ru_each(rtwdev, 0, lmt_ru, band, ntx, ch - 30);
+	fill_limit_ru_each(rtwdev, 1, lmt_ru, band, ntx, ch - 26);
+	fill_limit_ru_each(rtwdev, 2, lmt_ru, band, ntx, ch - 22);
+	fill_limit_ru_each(rtwdev, 3, lmt_ru, band, ntx, ch - 18);
+	fill_limit_ru_each(rtwdev, 4, lmt_ru, band, ntx, ch - 14);
+	fill_limit_ru_each(rtwdev, 5, lmt_ru, band, ntx, ch - 10);
+	fill_limit_ru_each(rtwdev, 6, lmt_ru, band, ntx, ch - 6);
+	fill_limit_ru_each(rtwdev, 7, lmt_ru, band, ntx, ch - 2);
+	fill_limit_ru_each(rtwdev, 8, lmt_ru, band, ntx, ch + 2);
+	fill_limit_ru_each(rtwdev, 9, lmt_ru, band, ntx, ch + 6);
+	fill_limit_ru_each(rtwdev, 10, lmt_ru, band, ntx, ch + 10);
+	fill_limit_ru_each(rtwdev, 11, lmt_ru, band, ntx, ch + 14);
+	fill_limit_ru_each(rtwdev, 12, lmt_ru, band, ntx, ch + 18);
+	fill_limit_ru_each(rtwdev, 13, lmt_ru, band, ntx, ch + 22);
+	fill_limit_ru_each(rtwdev, 14, lmt_ru, band, ntx, ch + 26);
+	fill_limit_ru_each(rtwdev, 15, lmt_ru, band, ntx, ch + 30);
+}
+
+static void rtw89_phy_fill_limit_ru_be(struct rtw89_dev *rtwdev,
+				       const struct rtw89_chan *chan,
+				       struct rtw89_txpwr_limit_ru_be *lmt_ru,
+				       u8 ntx)
+{
+	u8 band = chan->band_type;
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
+
+	memset(lmt_ru, 0, sizeof(*lmt_ru));
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_20:
+		phy_fill_limit_ru_20m_be(rtwdev, lmt_ru, band, ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		phy_fill_limit_ru_40m_be(rtwdev, lmt_ru, band, ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		phy_fill_limit_ru_80m_be(rtwdev, lmt_ru, band, ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		phy_fill_limit_ru_160m_be(rtwdev, lmt_ru, band, ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		phy_fill_limit_ru_320m_be(rtwdev, lmt_ru, band, ntx, ch);
+		break;
+	}
+}
+
+static void rtw89_phy_set_txpwr_limit_ru_be(struct rtw89_dev *rtwdev,
+					    const struct rtw89_chan *chan,
+					    enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_txpwr_limit_ru_be lmt_ru;
+	const s8 *ptr;
+	u32 addr, val;
+	u8 i, j;
+
+	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit_ru_be) !=
+		     RTW89_TXPWR_LMT_RU_PAGE_SIZE_BE);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] set txpwr limit ru on band %d bw %d\n",
+		    chan->band_type, chan->band_width);
+
+	addr = R_BE_PWR_RU_LMT;
+	for (i = 0; i <= RTW89_NSS_2; i++) {
+		rtw89_phy_fill_limit_ru_be(rtwdev, chan, &lmt_ru, i);
+
+		ptr = (s8 *)&lmt_ru;
+		for (j = 0; j < RTW89_TXPWR_LMT_RU_PAGE_SIZE_BE;
+		     j += 4, addr += 4, ptr += 4) {
+			val = u32_encode_bits(ptr[0], GENMASK(7, 0)) |
+			      u32_encode_bits(ptr[1], GENMASK(15, 8)) |
+			      u32_encode_bits(ptr[2], GENMASK(23, 16)) |
+			      u32_encode_bits(ptr[3], GENMASK(31, 24));
+
+			rtw89_mac_txpwr_write32(rtwdev, phy_idx, addr, val);
+		}
+	}
+}
+
 const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cr_base = 0x20000,
 	.ccx = &rtw89_ccx_regs_be,
@@ -500,5 +640,6 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
 	.set_txpwr_limit = rtw89_phy_set_txpwr_limit_be,
+	.set_txpwr_limit_ru = rtw89_phy_set_txpwr_limit_ru_be,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 62fc2cd12ae5..27444801996f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3940,6 +3940,7 @@
 #define R_BE_PWR_RATE_OFST_CTRL 0x11A30
 #define R_BE_PWR_BY_RATE 0x11E00
 #define R_BE_PWR_LMT 0x11FAC
+#define R_BE_PWR_RU_LMT 0x12048
 
 #define CMAC1_START_ADDR_BE 0x14000
 #define CMAC1_END_ADDR_BE 0x17FFF
-- 
2.25.1

