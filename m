Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269777B5ED7
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbjJCBzU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjJCBzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E745BD
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:16 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931t7dK51334477, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931t7dK51334477
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 3 Oct 2023 09:55:05 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: phy: set TX power by rate according to chip gen
Date:   Tue, 3 Oct 2023 09:54:41 +0800
Message-ID: <20231003015446.14658-3-pkshih@realtek.com>
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
TX power by rate. We rename original setting stuffs with a suffix
`_ax` and implement setting flow for Wi-Fi 7 chips. Then, we set TX
power by rate according to chip generation.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    |  26 ++---
 drivers/net/wireless/realtek/rtw89/phy.h    |  16 ++-
 drivers/net/wireless/realtek/rtw89/phy_be.c | 107 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |   2 +
 4 files changed, 137 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 6e1f4d6c345c..ec2d5e2f17ee 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1519,7 +1519,7 @@ void rtw89_phy_write_reg3_tbl(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_write_reg3_tbl);
 
-static const u8 rtw89_rs_idx_num[] = {
+static const u8 rtw89_rs_idx_num_ax[] = {
 	[RTW89_RS_CCK] = RTW89_RATE_CCK_NUM,
 	[RTW89_RS_OFDM] = RTW89_RATE_OFDM_NUM,
 	[RTW89_RS_MCS] = RTW89_RATE_MCS_NUM_AX,
@@ -1527,7 +1527,7 @@ static const u8 rtw89_rs_idx_num[] = {
 	[RTW89_RS_OFFSET] = RTW89_RATE_OFFSET_NUM_AX,
 };
 
-static const u8 rtw89_rs_nss_num[] = {
+static const u8 rtw89_rs_nss_num_ax[] = {
 	[RTW89_RS_CCK] = 1,
 	[RTW89_RS_OFDM] = 1,
 	[RTW89_RS_MCS] = RTW89_NSS_NUM,
@@ -1589,7 +1589,6 @@ static s8 rtw89_phy_txpwr_rf_to_mac(struct rtw89_dev *rtwdev, s8 txpwr_rf)
 	return txpwr_rf >> (chip->txpwr_factor_rf - chip->txpwr_factor_mac);
 }
 
-static
 s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
 			       const struct rtw89_rate_desc *rate_desc)
 {
@@ -2098,9 +2097,9 @@ void rtw89_phy_fill_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	}
 }
 
-void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
-				const struct rtw89_chan *chan,
-				enum rtw89_phy_idx phy_idx)
+static void rtw89_phy_set_txpwr_byrate_ax(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan,
+					  enum rtw89_phy_idx phy_idx)
 {
 	u8 max_nss_num = rtwdev->chip->rf_path_num;
 	static const u8 rs[] = {
@@ -2119,19 +2118,19 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] set txpwr byrate with ch=%d\n", ch);
 
-	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_CCK] % 4);
-	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_OFDM] % 4);
-	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_MCS] % 4);
-	BUILD_BUG_ON(rtw89_rs_idx_num[RTW89_RS_HEDCM] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num_ax[RTW89_RS_CCK] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num_ax[RTW89_RS_OFDM] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num_ax[RTW89_RS_MCS] % 4);
+	BUILD_BUG_ON(rtw89_rs_idx_num_ax[RTW89_RS_HEDCM] % 4);
 
 	addr = R_AX_PWR_BY_RATE;
 	for (cur.nss = 0; cur.nss < max_nss_num; cur.nss++) {
 		for (i = 0; i < ARRAY_SIZE(rs); i++) {
-			if (cur.nss >= rtw89_rs_nss_num[rs[i]])
+			if (cur.nss >= rtw89_rs_nss_num_ax[rs[i]])
 				continue;
 
 			cur.rs = rs[i];
-			for (cur.idx = 0; cur.idx < rtw89_rs_idx_num[rs[i]];
+			for (cur.idx = 0; cur.idx < rtw89_rs_idx_num_ax[rs[i]];
 			     cur.idx++) {
 				v[cur.idx % 4] =
 					rtw89_phy_read_txpwr_byrate(rtwdev,
@@ -2153,7 +2152,6 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 		}
 	}
 }
-EXPORT_SYMBOL(rtw89_phy_set_txpwr_byrate);
 
 void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
@@ -4836,5 +4834,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.cr_base = 0x10000,
 	.ccx = &rtw89_ccx_regs_ax,
 	.physts = &rtw89_physts_regs_ax,
+
+	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 4684feac97b2..78beafda3726 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -404,6 +404,10 @@ struct rtw89_phy_gen_def {
 	u32 cr_base;
 	const struct rtw89_ccx_regs *ccx;
 	const struct rtw89_physts_regs *physts;
+
+	void (*set_txpwr_byrate)(struct rtw89_dev *rtwdev,
+				 const struct rtw89_chan *chan,
+				 enum rtw89_phy_idx phy_idx);
 };
 
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
@@ -616,13 +620,23 @@ u32 rtw89_phy_read32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
 			   struct rtw89_txpwr_byrate *head,
 			   const struct rtw89_rate_desc *desc);
+s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
+			       const struct rtw89_rate_desc *rate_desc);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 				 const struct rtw89_txpwr_table *tbl);
 s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch);
+
+static inline
 void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
-				enum rtw89_phy_idx phy_idx);
+				enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	phy->set_txpwr_byrate(rtwdev, chan, phy_idx);
+}
+
 void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
 				enum rtw89_phy_idx phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 778e4b0c8e87..7b43bcd0952c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2023  Realtek Corporation
  */
 
+#include "debug.h"
+#include "mac.h"
 #include "phy.h"
 #include "reg.h"
 
@@ -69,9 +71,114 @@ static const struct rtw89_physts_regs rtw89_physts_regs_be = {
 	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
 };
 
+struct rtw89_byr_spec_ent_be {
+	struct rtw89_rate_desc init;
+	u8 num_of_idx;
+	bool no_over_bw40;
+	bool no_multi_nss;
+};
+
+static const struct rtw89_byr_spec_ent_be rtw89_byr_spec_be[] = {
+	{
+		.init = { .rs = RTW89_RS_CCK },
+		.num_of_idx = RTW89_RATE_CCK_NUM,
+		.no_over_bw40 = true,
+		.no_multi_nss = true,
+	},
+	{
+		.init = { .rs = RTW89_RS_OFDM },
+		.num_of_idx = RTW89_RATE_OFDM_NUM,
+		.no_multi_nss = true,
+	},
+	{
+		.init = { .rs = RTW89_RS_MCS, .idx = 14, .ofdma = RTW89_NON_OFDMA },
+		.num_of_idx = 2,
+		.no_multi_nss = true,
+	},
+	{
+		.init = { .rs = RTW89_RS_MCS, .idx = 14, .ofdma = RTW89_OFDMA },
+		.num_of_idx = 2,
+		.no_multi_nss = true,
+	},
+	{
+		.init = { .rs = RTW89_RS_MCS, .ofdma = RTW89_NON_OFDMA },
+		.num_of_idx = 14,
+	},
+	{
+		.init = { .rs = RTW89_RS_HEDCM, .ofdma = RTW89_NON_OFDMA },
+		.num_of_idx = RTW89_RATE_HEDCM_NUM,
+	},
+	{
+		.init = { .rs = RTW89_RS_MCS, .ofdma = RTW89_OFDMA },
+		.num_of_idx = 14,
+	},
+	{
+		.init = { .rs = RTW89_RS_HEDCM, .ofdma = RTW89_OFDMA },
+		.num_of_idx = RTW89_RATE_HEDCM_NUM,
+	},
+};
+
+static
+void __phy_set_txpwr_byrate_be(struct rtw89_dev *rtwdev, u8 band, u8 bw,
+			       u8 nss, u32 *addr, enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_byr_spec_ent_be *ent;
+	struct rtw89_rate_desc desc;
+	int pos = 0;
+	int i, j;
+	u32 val;
+	s8 v[4];
+
+	for (i = 0; i < ARRAY_SIZE(rtw89_byr_spec_be); i++) {
+		ent = &rtw89_byr_spec_be[i];
+
+		if (bw > RTW89_CHANNEL_WIDTH_40 && ent->no_over_bw40)
+			continue;
+		if (nss > RTW89_NSS_1 && ent->no_multi_nss)
+			continue;
+
+		desc = ent->init;
+		desc.nss = nss;
+		for (j = 0; j < ent->num_of_idx; j++, desc.idx++) {
+			v[pos] = rtw89_phy_read_txpwr_byrate(rtwdev, band, bw,
+							     &desc);
+			pos = (pos + 1) % 4;
+			if (pos)
+				continue;
+
+			val = u32_encode_bits(v[0], GENMASK(7, 0)) |
+			      u32_encode_bits(v[1], GENMASK(15, 8)) |
+			      u32_encode_bits(v[2], GENMASK(23, 16)) |
+			      u32_encode_bits(v[3], GENMASK(31, 24));
+
+			rtw89_mac_txpwr_write32(rtwdev, phy_idx, *addr, val);
+			*addr += 4;
+		}
+	}
+}
+
+static void rtw89_phy_set_txpwr_byrate_be(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan,
+					  enum rtw89_phy_idx phy_idx)
+{
+	u32 addr = R_BE_PWR_BY_RATE;
+	u8 band = chan->band_type;
+	u8 bw, nss;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] set txpwr byrate on band %d\n", band);
+
+	for (bw = 0; bw <= RTW89_CHANNEL_WIDTH_320; bw++)
+		for (nss = 0; nss <= RTW89_NSS_2; nss++)
+			__phy_set_txpwr_byrate_be(rtwdev, band, bw, nss,
+						  &addr, phy_idx);
+}
+
 const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cr_base = 0x20000,
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
+
+	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7b0408246fd4..5c4c76ce7d2b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3937,6 +3937,8 @@
 #define R_BE_PWR_MODULE 0x11900
 #define R_BE_PWR_MODULE_C1 0x15900
 
+#define R_BE_PWR_BY_RATE 0x11E00
+
 #define CMAC1_START_ADDR_BE 0x14000
 #define CMAC1_END_ADDR_BE 0x17FFF
 
-- 
2.25.1

