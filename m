Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98887B5ED6
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbjJCBzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjJCBzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324A99B
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:14 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931t7OT11334499, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931t7OT11334499
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 09:55:07 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: phy: set TX power offset according to chip gen
Date:   Tue, 3 Oct 2023 09:54:42 +0800
Message-ID: <20231003015446.14658-4-pkshih@realtek.com>
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

We have a register to control TX power of each rate section to increase
or decrease an offset. But, Wi-Fi 6 chips and Wi-Fi 7 chips have different
address and format for this control register. We rename original setting
stuffs with a suffix `_ax` and implement setting flow for Wi-Fi 7 chips.
Then, we set TX power offset according to chip generation.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    |  9 +++---
 drivers/net/wireless/realtek/rtw89/phy.h    | 12 +++++++-
 drivers/net/wireless/realtek/rtw89/phy_be.c | 31 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  1 +
 4 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ec2d5e2f17ee..d77c71060bc1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2153,9 +2153,10 @@ static void rtw89_phy_set_txpwr_byrate_ax(struct rtw89_dev *rtwdev,
 	}
 }
 
-void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
-				const struct rtw89_chan *chan,
-				enum rtw89_phy_idx phy_idx)
+static
+void rtw89_phy_set_txpwr_offset_ax(struct rtw89_dev *rtwdev,
+				   const struct rtw89_chan *chan,
+				   enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_rate_desc desc = {
 		.nss = RTW89_NSS_1,
@@ -2180,7 +2181,6 @@ void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
 	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_OFST_CTRL,
 				     GENMASK(19, 0), val);
 }
-EXPORT_SYMBOL(rtw89_phy_set_txpwr_offset);
 
 void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
@@ -4836,5 +4836,6 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.physts = &rtw89_physts_regs_ax,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
+	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 78beafda3726..d69054c52df1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -408,6 +408,9 @@ struct rtw89_phy_gen_def {
 	void (*set_txpwr_byrate)(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
 				 enum rtw89_phy_idx phy_idx);
+	void (*set_txpwr_offset)(struct rtw89_dev *rtwdev,
+				 const struct rtw89_chan *chan,
+				 enum rtw89_phy_idx phy_idx);
 };
 
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
@@ -637,9 +640,16 @@ void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 	phy->set_txpwr_byrate(rtwdev, chan, phy_idx);
 }
 
+static inline
 void rtw89_phy_set_txpwr_offset(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
-				enum rtw89_phy_idx phy_idx);
+				enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	phy->set_txpwr_offset(rtwdev, chan, phy_idx);
+}
+
 void rtw89_phy_set_txpwr_limit(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
 			       enum rtw89_phy_idx phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 7b43bcd0952c..8ff875f3fec8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -174,11 +174,42 @@ static void rtw89_phy_set_txpwr_byrate_be(struct rtw89_dev *rtwdev,
 						  &addr, phy_idx);
 }
 
+static void rtw89_phy_set_txpwr_offset_be(struct rtw89_dev *rtwdev,
+					  const struct rtw89_chan *chan,
+					  enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_rate_desc desc = {
+		.nss = RTW89_NSS_1,
+		.rs = RTW89_RS_OFFSET,
+	};
+	u8 band = chan->band_type;
+	s8 v[RTW89_RATE_OFFSET_NUM_BE] = {};
+	u32 val;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] set txpwr offset on band %d\n", band);
+
+	for (desc.idx = 0; desc.idx < RTW89_RATE_OFFSET_NUM_BE; desc.idx++)
+		v[desc.idx] = rtw89_phy_read_txpwr_byrate(rtwdev, band, 0, &desc);
+
+	val = u32_encode_bits(v[RTW89_RATE_OFFSET_CCK], GENMASK(3, 0)) |
+	      u32_encode_bits(v[RTW89_RATE_OFFSET_OFDM], GENMASK(7, 4)) |
+	      u32_encode_bits(v[RTW89_RATE_OFFSET_HT], GENMASK(11, 8)) |
+	      u32_encode_bits(v[RTW89_RATE_OFFSET_VHT], GENMASK(15, 12)) |
+	      u32_encode_bits(v[RTW89_RATE_OFFSET_HE], GENMASK(19, 16)) |
+	      u32_encode_bits(v[RTW89_RATE_OFFSET_EHT], GENMASK(23, 20)) |
+	      u32_encode_bits(v[RTW89_RATE_OFFSET_DLRU_HE], GENMASK(27, 24)) |
+	      u32_encode_bits(v[RTW89_RATE_OFFSET_DLRU_EHT], GENMASK(31, 28));
+
+	rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_BE_PWR_RATE_OFST_CTRL, val);
+}
+
 const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cr_base = 0x20000,
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
+	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5c4c76ce7d2b..51b074d0782e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3937,6 +3937,7 @@
 #define R_BE_PWR_MODULE 0x11900
 #define R_BE_PWR_MODULE_C1 0x15900
 
+#define R_BE_PWR_RATE_OFST_CTRL 0x11A30
 #define R_BE_PWR_BY_RATE 0x11E00
 
 #define CMAC1_START_ADDR_BE 0x14000
-- 
2.25.1

