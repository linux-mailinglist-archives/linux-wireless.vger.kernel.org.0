Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE177B5ED8
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbjJCBzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238962AbjJCBzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ED69B
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:16 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931t8dK51334477, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931t8dK51334477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 3 Oct 2023 09:55:08 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: phy: set TX power limit according to chip gen
Date:   Tue, 3 Oct 2023 09:54:43 +0800
Message-ID: <20231003015446.14658-5-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Wi-Fi 6 chips and Wi-Fi 7 chips have different register design for
TX power limit. We rename original setting stuffs with a suffix `_ax`,
concentrate related enum declaration in phy.h, and implement setting
flow for Wi-Fi 7 chips. Then, we set TX power limit according to chip
generation.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  20 --
 drivers/net/wireless/realtek/rtw89/phy.c    |  64 ++---
 drivers/net/wireless/realtek/rtw89/phy.h    |  56 +++-
 drivers/net/wireless/realtek/rtw89/phy_be.c | 289 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |   1 +
 5 files changed, 377 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 56cf47f2ae2b..7ef3ebe7f793 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -744,26 +744,6 @@ struct rtw89_txpwr_byrate {
 	s8 trap;
 };
 
-enum rtw89_bandwidth_section_num {
-	RTW89_BW20_SEC_NUM = 8,
-	RTW89_BW40_SEC_NUM = 4,
-	RTW89_BW80_SEC_NUM = 2,
-};
-
-#define RTW89_TXPWR_LMT_PAGE_SIZE 40
-
-struct rtw89_txpwr_limit {
-	s8 cck_20m[RTW89_BF_NUM];
-	s8 cck_40m[RTW89_BF_NUM];
-	s8 ofdm[RTW89_BF_NUM];
-	s8 mcs_20m[RTW89_BW20_SEC_NUM][RTW89_BF_NUM];
-	s8 mcs_40m[RTW89_BW40_SEC_NUM][RTW89_BF_NUM];
-	s8 mcs_80m[RTW89_BW80_SEC_NUM][RTW89_BF_NUM];
-	s8 mcs_160m[RTW89_BF_NUM];
-	s8 mcs_40m_0p5[RTW89_BF_NUM];
-	s8 mcs_40m_2p5[RTW89_BF_NUM];
-};
-
 #define RTW89_RU_SEC_NUM 8
 
 #define RTW89_TXPWR_LMT_RU_PAGE_SIZE 24
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d77c71060bc1..8c5b73294a93 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1711,9 +1711,9 @@ EXPORT_SYMBOL(rtw89_phy_read_txpwr_limit);
 							      (ch));	\
 	} while (0)
 
-static void rtw89_phy_fill_txpwr_limit_20m(struct rtw89_dev *rtwdev,
-					   struct rtw89_txpwr_limit *lmt,
-					   u8 band, u8 ntx, u8 ch)
+static void rtw89_phy_fill_txpwr_limit_20m_ax(struct rtw89_dev *rtwdev,
+					      struct rtw89_txpwr_limit_ax *lmt,
+					      u8 band, u8 ntx, u8 ch)
 {
 	__fill_txpwr_limit_nonbf_bf(lmt->cck_20m, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_CCK, ch);
@@ -1726,9 +1726,9 @@ static void rtw89_phy_fill_txpwr_limit_20m(struct rtw89_dev *rtwdev,
 				    ntx, RTW89_RS_MCS, ch);
 }
 
-static void rtw89_phy_fill_txpwr_limit_40m(struct rtw89_dev *rtwdev,
-					   struct rtw89_txpwr_limit *lmt,
-					   u8 band, u8 ntx, u8 ch, u8 pri_ch)
+static void rtw89_phy_fill_txpwr_limit_40m_ax(struct rtw89_dev *rtwdev,
+					      struct rtw89_txpwr_limit_ax *lmt,
+					      u8 band, u8 ntx, u8 ch, u8 pri_ch)
 {
 	__fill_txpwr_limit_nonbf_bf(lmt->cck_20m, band, RTW89_CHANNEL_WIDTH_20,
 				    ntx, RTW89_RS_CCK, ch - 2);
@@ -1747,9 +1747,9 @@ static void rtw89_phy_fill_txpwr_limit_40m(struct rtw89_dev *rtwdev,
 				    ntx, RTW89_RS_MCS, ch);
 }
 
-static void rtw89_phy_fill_txpwr_limit_80m(struct rtw89_dev *rtwdev,
-					   struct rtw89_txpwr_limit *lmt,
-					   u8 band, u8 ntx, u8 ch, u8 pri_ch)
+static void rtw89_phy_fill_txpwr_limit_80m_ax(struct rtw89_dev *rtwdev,
+					      struct rtw89_txpwr_limit_ax *lmt,
+					      u8 band, u8 ntx, u8 ch, u8 pri_ch)
 {
 	s8 val_0p5_n[RTW89_BF_NUM];
 	s8 val_0p5_p[RTW89_BF_NUM];
@@ -1788,9 +1788,9 @@ static void rtw89_phy_fill_txpwr_limit_80m(struct rtw89_dev *rtwdev,
 		lmt->mcs_40m_0p5[i] = min_t(s8, val_0p5_n[i], val_0p5_p[i]);
 }
 
-static void rtw89_phy_fill_txpwr_limit_160m(struct rtw89_dev *rtwdev,
-					    struct rtw89_txpwr_limit *lmt,
-					    u8 band, u8 ntx, u8 ch, u8 pri_ch)
+static void rtw89_phy_fill_txpwr_limit_160m_ax(struct rtw89_dev *rtwdev,
+					       struct rtw89_txpwr_limit_ax *lmt,
+					       u8 band, u8 ntx, u8 ch, u8 pri_ch)
 {
 	s8 val_0p5_n[RTW89_BF_NUM];
 	s8 val_0p5_p[RTW89_BF_NUM];
@@ -1875,10 +1875,10 @@ static void rtw89_phy_fill_txpwr_limit_160m(struct rtw89_dev *rtwdev,
 }
 
 static
-void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
-				const struct rtw89_chan *chan,
-				struct rtw89_txpwr_limit *lmt,
-				u8 ntx)
+void rtw89_phy_fill_txpwr_limit_ax(struct rtw89_dev *rtwdev,
+				   const struct rtw89_chan *chan,
+				   struct rtw89_txpwr_limit_ax *lmt,
+				   u8 ntx)
 {
 	u8 band = chan->band_type;
 	u8 pri_ch = chan->primary_channel;
@@ -1889,19 +1889,19 @@ void rtw89_phy_fill_txpwr_limit(struct rtw89_dev *rtwdev,
 
 	switch (bw) {
 	case RTW89_CHANNEL_WIDTH_20:
-		rtw89_phy_fill_txpwr_limit_20m(rtwdev, lmt, band, ntx, ch);
+		rtw89_phy_fill_txpwr_limit_20m_ax(rtwdev, lmt, band, ntx, ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_40:
-		rtw89_phy_fill_txpwr_limit_40m(rtwdev, lmt, band, ntx, ch,
-					       pri_ch);
+		rtw89_phy_fill_txpwr_limit_40m_ax(rtwdev, lmt, band, ntx, ch,
+						  pri_ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		rtw89_phy_fill_txpwr_limit_80m(rtwdev, lmt, band, ntx, ch,
-					       pri_ch);
+		rtw89_phy_fill_txpwr_limit_80m_ax(rtwdev, lmt, band, ntx, ch,
+						  pri_ch);
 		break;
 	case RTW89_CHANNEL_WIDTH_160:
-		rtw89_phy_fill_txpwr_limit_160m(rtwdev, lmt, band, ntx, ch,
-						pri_ch);
+		rtw89_phy_fill_txpwr_limit_160m_ax(rtwdev, lmt, band, ntx, ch,
+						   pri_ch);
 		break;
 	}
 }
@@ -2182,12 +2182,12 @@ void rtw89_phy_set_txpwr_offset_ax(struct rtw89_dev *rtwdev,
 				     GENMASK(19, 0), val);
 }
 
-void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
-			       const struct rtw89_chan *chan,
-			       enum rtw89_phy_idx phy_idx)
+static void rtw89_phy_set_txpwr_limit_ax(struct rtw89_dev *rtwdev,
+					 const struct rtw89_chan *chan,
+					 enum rtw89_phy_idx phy_idx)
 {
 	u8 max_ntx_num = rtwdev->chip->rf_path_num;
-	struct rtw89_txpwr_limit lmt;
+	struct rtw89_txpwr_limit_ax lmt;
 	u8 ch = chan->channel;
 	u8 bw = chan->band_width;
 	const s8 *ptr;
@@ -2197,15 +2197,15 @@ void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr limit with ch=%d bw=%d\n", ch, bw);
 
-	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit) !=
-		     RTW89_TXPWR_LMT_PAGE_SIZE);
+	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit_ax) !=
+		     RTW89_TXPWR_LMT_PAGE_SIZE_AX);
 
 	addr = R_AX_PWR_LMT;
 	for (i = 0; i < max_ntx_num; i++) {
-		rtw89_phy_fill_txpwr_limit(rtwdev, chan, &lmt, i);
+		rtw89_phy_fill_txpwr_limit_ax(rtwdev, chan, &lmt, i);
 
 		ptr = (s8 *)&lmt;
-		for (j = 0; j < RTW89_TXPWR_LMT_PAGE_SIZE;
+		for (j = 0; j < RTW89_TXPWR_LMT_PAGE_SIZE_AX;
 		     j += 4, addr += 4, ptr += 4) {
 			val = FIELD_PREP(GENMASK(7, 0), ptr[0]) |
 			      FIELD_PREP(GENMASK(15, 8), ptr[1]) |
@@ -2216,7 +2216,6 @@ void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 		}
 	}
 }
-EXPORT_SYMBOL(rtw89_phy_set_txpwr_limit);
 
 void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
@@ -4837,5 +4836,6 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
+	.set_txpwr_limit = rtw89_phy_set_txpwr_limit_ax,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d69054c52df1..72bc00bcb04c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -400,6 +400,50 @@ struct rtw89_physts_regs {
 	u32 dis_trigger_brk_mask;
 };
 
+enum rtw89_bandwidth_section_num_ax {
+	RTW89_BW20_SEC_NUM_AX = 8,
+	RTW89_BW40_SEC_NUM_AX = 4,
+	RTW89_BW80_SEC_NUM_AX = 2,
+};
+
+enum rtw89_bandwidth_section_num_be {
+	RTW89_BW20_SEC_NUM_BE = 16,
+	RTW89_BW40_SEC_NUM_BE = 8,
+	RTW89_BW80_SEC_NUM_BE = 4,
+	RTW89_BW160_SEC_NUM_BE = 2,
+};
+
+#define RTW89_TXPWR_LMT_PAGE_SIZE_AX 40
+
+struct rtw89_txpwr_limit_ax {
+	s8 cck_20m[RTW89_BF_NUM];
+	s8 cck_40m[RTW89_BF_NUM];
+	s8 ofdm[RTW89_BF_NUM];
+	s8 mcs_20m[RTW89_BW20_SEC_NUM_AX][RTW89_BF_NUM];
+	s8 mcs_40m[RTW89_BW40_SEC_NUM_AX][RTW89_BF_NUM];
+	s8 mcs_80m[RTW89_BW80_SEC_NUM_AX][RTW89_BF_NUM];
+	s8 mcs_160m[RTW89_BF_NUM];
+	s8 mcs_40m_0p5[RTW89_BF_NUM];
+	s8 mcs_40m_2p5[RTW89_BF_NUM];
+};
+
+#define RTW89_TXPWR_LMT_PAGE_SIZE_BE 76
+
+struct rtw89_txpwr_limit_be {
+	s8 cck_20m[RTW89_BF_NUM];
+	s8 cck_40m[RTW89_BF_NUM];
+	s8 ofdm[RTW89_BF_NUM];
+	s8 mcs_20m[RTW89_BW20_SEC_NUM_BE][RTW89_BF_NUM];
+	s8 mcs_40m[RTW89_BW40_SEC_NUM_BE][RTW89_BF_NUM];
+	s8 mcs_80m[RTW89_BW80_SEC_NUM_BE][RTW89_BF_NUM];
+	s8 mcs_160m[RTW89_BW160_SEC_NUM_BE][RTW89_BF_NUM];
+	s8 mcs_320m[RTW89_BF_NUM];
+	s8 mcs_40m_0p5[RTW89_BF_NUM];
+	s8 mcs_40m_2p5[RTW89_BF_NUM];
+	s8 mcs_40m_4p5[RTW89_BF_NUM];
+	s8 mcs_40m_6p5[RTW89_BF_NUM];
+};
+
 struct rtw89_phy_gen_def {
 	u32 cr_base;
 	const struct rtw89_ccx_regs *ccx;
@@ -411,6 +455,9 @@ struct rtw89_phy_gen_def {
 	void (*set_txpwr_offset)(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
 				 enum rtw89_phy_idx phy_idx);
+	void (*set_txpwr_limit)(struct rtw89_dev *rtwdev,
+				const struct rtw89_chan *chan,
+				enum rtw89_phy_idx phy_idx);
 };
 
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
@@ -650,9 +697,16 @@ void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
 	phy->set_txpwr_offset(rtwdev, chan, phy_idx);
 }
 
+static inline
 void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
-			       enum rtw89_phy_idx phy_idx);
+			       enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	phy->set_txpwr_limit(rtwdev, chan, phy_idx);
+}
+
 void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
 				  enum rtw89_phy_idx phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 8ff875f3fec8..500f24b23d06 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -204,6 +204,294 @@ static void rtw89_phy_set_txpwr_offset_be(struct rtw89_dev *rtwdev,
 	rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_BE_PWR_RATE_OFST_CTRL, val);
 }
 
+static void
+fill_limit_nonbf_bf(struct rtw89_dev *rtwdev, s8 (*ptr)[RTW89_BF_NUM],
+		    u8 band, u8 bw, u8 ntx, u8 rs, u8 ch)
+{
+	int bf;
+
+	for (bf = 0; bf < RTW89_BF_NUM; bf++)
+		(*ptr)[bf] = rtw89_phy_read_txpwr_limit(rtwdev, band, bw, ntx,
+							rs, bf, ch);
+}
+
+static void
+fill_limit_nonbf_bf_min(struct rtw89_dev *rtwdev, s8 (*ptr)[RTW89_BF_NUM],
+			u8 band, u8 bw, u8 ntx, u8 rs, u8 ch1, u8 ch2)
+{
+	s8 v1[RTW89_BF_NUM];
+	s8 v2[RTW89_BF_NUM];
+	int bf;
+
+	fill_limit_nonbf_bf(rtwdev, &v1, band, bw, ntx, rs, ch1);
+	fill_limit_nonbf_bf(rtwdev, &v2, band, bw, ntx, rs, ch2);
+
+	for (bf = 0; bf < RTW89_BF_NUM; bf++)
+		(*ptr)[bf] = min(v1[bf], v2[bf]);
+}
+
+static void phy_fill_limit_20m_be(struct rtw89_dev *rtwdev,
+				  struct rtw89_txpwr_limit_be *lmt,
+				  u8 band, u8 ntx, u8 ch)
+{
+	fill_limit_nonbf_bf(rtwdev, &lmt->cck_20m, band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_CCK, ch);
+	fill_limit_nonbf_bf(rtwdev, &lmt->cck_40m, band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_CCK, ch);
+	fill_limit_nonbf_bf(rtwdev, &lmt->ofdm, band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_OFDM, ch);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[0], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch);
+}
+
+static void phy_fill_limit_40m_be(struct rtw89_dev *rtwdev,
+				  struct rtw89_txpwr_limit_be *lmt,
+				  u8 band, u8 ntx, u8 ch, u8 pri_ch)
+{
+	fill_limit_nonbf_bf(rtwdev, &lmt->cck_20m, band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_CCK, ch - 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->cck_40m, band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_CCK, ch);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->ofdm, band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_OFDM, pri_ch);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[0], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[1], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[0], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch);
+}
+
+static void phy_fill_limit_80m_be(struct rtw89_dev *rtwdev,
+				  struct rtw89_txpwr_limit_be *lmt,
+				  u8 band, u8 ntx, u8 ch, u8 pri_ch)
+{
+	fill_limit_nonbf_bf(rtwdev, &lmt->ofdm, band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_OFDM, pri_ch);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[0], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 6);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[1], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[2], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[3], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 6);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[0], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch - 4);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[1], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch + 4);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_80m[0], band,
+			    RTW89_CHANNEL_WIDTH_80, ntx, RTW89_RS_MCS, ch);
+
+	fill_limit_nonbf_bf_min(rtwdev, &lmt->mcs_40m_0p5, band,
+				RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS,
+				ch - 4, ch + 4);
+}
+
+static void phy_fill_limit_160m_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_txpwr_limit_be *lmt,
+				   u8 band, u8 ntx, u8 ch, u8 pri_ch)
+{
+	fill_limit_nonbf_bf(rtwdev, &lmt->ofdm, band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_OFDM, pri_ch);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[0], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 14);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[1], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 10);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[2], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 6);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[3], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[4], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[5], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 6);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[6], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 10);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[7], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 14);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[0], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch - 12);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[1], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch - 4);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[2], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch + 4);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[3], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch + 12);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_80m[0], band,
+			    RTW89_CHANNEL_WIDTH_80, ntx, RTW89_RS_MCS, ch - 8);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_80m[1], band,
+			    RTW89_CHANNEL_WIDTH_80, ntx, RTW89_RS_MCS, ch + 8);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_160m[0], band,
+			    RTW89_CHANNEL_WIDTH_160, ntx, RTW89_RS_MCS, ch);
+
+	fill_limit_nonbf_bf_min(rtwdev, &lmt->mcs_40m_0p5, band,
+				RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS,
+				ch - 12, ch - 4);
+	fill_limit_nonbf_bf_min(rtwdev, &lmt->mcs_40m_2p5, band,
+				RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS,
+				ch + 4, ch + 12);
+}
+
+static void phy_fill_limit_320m_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_txpwr_limit_be *lmt,
+				   u8 band, u8 ntx, u8 ch, u8 pri_ch)
+{
+	fill_limit_nonbf_bf(rtwdev, &lmt->ofdm, band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_OFDM, pri_ch);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[0], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 30);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[1], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 26);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[2], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 22);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[3], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 18);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[4], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 14);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[5], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 10);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[6], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 6);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[7], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch - 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[8], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 2);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[9], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 6);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[10], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 10);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[11], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 14);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[12], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 18);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[13], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 22);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[14], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 26);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_20m[15], band,
+			    RTW89_CHANNEL_WIDTH_20, ntx, RTW89_RS_MCS, ch + 30);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[0], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch - 28);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[1], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch - 20);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[2], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch - 12);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[3], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch - 4);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[4], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch + 4);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[5], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch + 12);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[6], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch + 20);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_40m[7], band,
+			    RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS, ch + 28);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_80m[0], band,
+			    RTW89_CHANNEL_WIDTH_80, ntx, RTW89_RS_MCS, ch - 24);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_80m[1], band,
+			    RTW89_CHANNEL_WIDTH_80, ntx, RTW89_RS_MCS, ch - 8);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_80m[2], band,
+			    RTW89_CHANNEL_WIDTH_80, ntx, RTW89_RS_MCS, ch + 8);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_80m[3], band,
+			    RTW89_CHANNEL_WIDTH_80, ntx, RTW89_RS_MCS, ch + 24);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_160m[0], band,
+			    RTW89_CHANNEL_WIDTH_160, ntx, RTW89_RS_MCS, ch - 16);
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_160m[1], band,
+			    RTW89_CHANNEL_WIDTH_160, ntx, RTW89_RS_MCS, ch + 16);
+
+	fill_limit_nonbf_bf(rtwdev, &lmt->mcs_320m, band,
+			    RTW89_CHANNEL_WIDTH_320, ntx, RTW89_RS_MCS, ch);
+
+	fill_limit_nonbf_bf_min(rtwdev, &lmt->mcs_40m_0p5, band,
+				RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS,
+				ch - 28, ch - 20);
+	fill_limit_nonbf_bf_min(rtwdev, &lmt->mcs_40m_2p5, band,
+				RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS,
+				ch - 12, ch - 4);
+	fill_limit_nonbf_bf_min(rtwdev, &lmt->mcs_40m_4p5, band,
+				RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS,
+				ch + 4, ch + 12);
+	fill_limit_nonbf_bf_min(rtwdev, &lmt->mcs_40m_6p5, band,
+				RTW89_CHANNEL_WIDTH_40, ntx, RTW89_RS_MCS,
+				ch + 20, ch + 28);
+}
+
+static void rtw89_phy_fill_limit_be(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    struct rtw89_txpwr_limit_be *lmt,
+				    u8 ntx)
+{
+	u8 band = chan->band_type;
+	u8 pri_ch = chan->primary_channel;
+	u8 ch = chan->channel;
+	u8 bw = chan->band_width;
+
+	memset(lmt, 0, sizeof(*lmt));
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_20:
+		phy_fill_limit_20m_be(rtwdev, lmt, band, ntx, ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		phy_fill_limit_40m_be(rtwdev, lmt, band, ntx, ch, pri_ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		phy_fill_limit_80m_be(rtwdev, lmt, band, ntx, ch, pri_ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		phy_fill_limit_160m_be(rtwdev, lmt, band, ntx, ch, pri_ch);
+		break;
+	case RTW89_CHANNEL_WIDTH_320:
+		phy_fill_limit_320m_be(rtwdev, lmt, band, ntx, ch, pri_ch);
+		break;
+	}
+}
+
+static void rtw89_phy_set_txpwr_limit_be(struct rtw89_dev *rtwdev,
+					 const struct rtw89_chan *chan,
+					 enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_txpwr_limit_be lmt;
+	const s8 *ptr;
+	u32 addr, val;
+	u8 i, j;
+
+	BUILD_BUG_ON(sizeof(struct rtw89_txpwr_limit_be) !=
+		     RTW89_TXPWR_LMT_PAGE_SIZE_BE);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] set txpwr limit on band %d bw %d\n",
+		    chan->band_type, chan->band_width);
+
+	addr = R_BE_PWR_LMT;
+	for (i = 0; i <= RTW89_NSS_2; i++) {
+		rtw89_phy_fill_limit_be(rtwdev, chan, &lmt, i);
+
+		ptr = (s8 *)&lmt;
+		for (j = 0; j < RTW89_TXPWR_LMT_PAGE_SIZE_BE;
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
@@ -211,5 +499,6 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
+	.set_txpwr_limit = rtw89_phy_set_txpwr_limit_be,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 51b074d0782e..62fc2cd12ae5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3939,6 +3939,7 @@
 
 #define R_BE_PWR_RATE_OFST_CTRL 0x11A30
 #define R_BE_PWR_BY_RATE 0x11E00
+#define R_BE_PWR_LMT 0x11FAC
 
 #define CMAC1_START_ADDR_BE 0x14000
 #define CMAC1_END_ADDR_BE 0x17FFF
-- 
2.25.1

