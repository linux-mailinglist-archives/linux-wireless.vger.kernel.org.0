Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178155B13E5
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 07:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIHFNw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 01:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIHFNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 01:13:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DE87B7ECA
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 22:13:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2885DEtsC009614, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2885DEtsC009614
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 13:13:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Sep 2022 13:13:33 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 13:13:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <echuang@realtek.com>,
        <phhuang@realtek.com>, <chiuyitang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/9] wifi: rtw89: set response rate selection
Date:   Thu, 8 Sep 2022 13:12:53 +0800
Message-ID: <20220908051257.25353-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908051257.25353-1-pkshih@realtek.com>
References: <20220908051257.25353-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/08/2022 04:54:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvOCCkV6TIIDEyOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chia-Yuan Li <leo.li@realtek.com>

With suitable response rate, it can acknowledge peer packets are received.
Otherwise, peer could re-transmit again due to missing of ACK frames.
To achieve this, refer to RX rate and CMAC table to choose the smaller
as initial response rate.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  6 ++++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 13 ++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 21 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  8 ++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  8 ++++++-
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ac148c4b547c8..e32900615bda0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2550,6 +2550,11 @@ struct rtw89_imr_info {
 	u32 tmac_imr_set;
 };
 
+struct rtw89_rrsr_cfgs {
+	struct rtw89_reg3_def ref_rate;
+	struct rtw89_reg3_def rsc;
+};
+
 struct rtw89_dig_regs {
 	u32 seg0_pd_reg;
 	u32 pd_lower_bound_mask;
@@ -2674,6 +2679,7 @@ struct rtw89_chip_info {
 	const struct rtw89_reg_def *dcfo_comp;
 	u8 dcfo_comp_sft;
 	const struct rtw89_imr_info *imr_info;
+	const struct rtw89_rrsr_cfgs *rrsr_cfgs;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f5bae0b282082..6621e98d514b2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1979,6 +1979,8 @@ static int tmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 static int trxptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_rrsr_cfgs *rrsr = chip->rrsr_cfgs;
 	u32 reg, val, sifs;
 	int ret;
 
@@ -2009,6 +2011,11 @@ static int trxptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(R_AX_RXTRIG_TEST_USER_2, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_RXTRIG_FCSCHK_EN);
 
+	reg = rtw89_mac_reg_by_idx(rrsr->ref_rate.addr, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, rrsr->ref_rate.mask, rrsr->ref_rate.data);
+	reg = rtw89_mac_reg_by_idx(rrsr->rsc.addr, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, rrsr->rsc.mask, rrsr->rsc.data);
+
 	return 0;
 }
 
@@ -2087,6 +2094,7 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 static int cmac_com_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val, reg;
 	int ret;
 
@@ -2101,6 +2109,11 @@ static int cmac_com_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	val = u32_replace_bits(val, 0, B_AX_TXSC_80M_MASK);
 	rtw89_write32(rtwdev, reg, val);
 
+	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+		reg = rtw89_mac_reg_by_idx(R_AX_PTCL_RRSR1, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_AX_RRSR_RATE_EN_MASK, RRSR_OFDM_CCK_EN);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 23823f03c5218..3a8dd81acfa6b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1833,6 +1833,13 @@
 #define B_AX_TXSC_40M_MASK GENMASK(7, 4)
 #define B_AX_TXSC_20M_MASK GENMASK(3, 0)
 
+#define R_AX_PTCL_RRSR1 0xC090
+#define R_AX_PTCL_RRSR1_C1 0xE090
+#define B_AX_RRSR_RATE_EN_MASK GENMASK(11, 8)
+#define RRSR_OFDM_CCK_EN 3
+#define B_AX_RSC_MASK GENMASK(7, 6)
+#define B_AX_RRSR_CCK_MASK GENMASK(3, 0)
+
 #define R_AX_CMAC_ERR_IMR 0xC160
 #define R_AX_CMAC_ERR_IMR_C1 0xE160
 #define B_AX_WMAC_TX_ERR_IND_EN BIT(7)
@@ -2563,6 +2570,20 @@
 #define WMAC_SPEC_SIFS_OFDM_52C 0x11
 #define WMAC_SPEC_SIFS_CCK	 0xA
 
+#define R_AX_TRXPTCL_RRSR_CTL_0 0xCC08
+#define R_AX_TRXPTCL_RRSR_CTL_0_C1 0xEC08
+#define B_AX_RESP_TX_MACID_CCA_TH_EN BIT(31)
+#define B_AX_RESP_TX_PWRMODE_MASK GENMASK(30, 28)
+#define B_AX_FTM_RRSR_RATE_EN_MASK GENMASK(27, 24)
+#define B_AX_NESS_MASK GENMASK(23, 22)
+#define B_AX_WMAC_RESP_DOPPLEB_AX_EN BIT(21)
+#define B_AX_WMAC_RESP_DCM_EN BIT(20)
+#define B_AX_WMAC_RRSB_AX_CCK_MASK GENMASK(19, 16)
+#define B_AX_WMAC_RESP_RATE_EN_MASK GENMASK(15, 12)
+#define B_AX_WMAC_RESP_RSC_MASK GENMASK(11, 10)
+#define B_AX_WMAC_RESP_REF_RATE_SEL BIT(9)
+#define B_AX_WMAC_RESP_REF_RATE_MASK GENMASK(8, 0)
+
 #define R_AX_MAC_LOOPBACK 0xCC20
 #define R_AX_MAC_LOOPBACK_C1 0xEC20
 #define B_AX_MACLBK_EN BIT(0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6cdecd833afbc..882c4bf1ace23 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -453,6 +453,11 @@ static const struct rtw89_imr_info rtw8852a_imr_info = {
 	.tmac_imr_set		= B_AX_TMAC_IMR_SET,
 };
 
+static const struct rtw89_rrsr_cfgs rtw8852a_rrsr_cfgs = {
+	.ref_rate = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_REF_RATE_SEL, 0},
+	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
+};
+
 static const struct rtw89_dig_regs rtw8852a_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -2224,7 +2229,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.page_regs		= &rtw8852a_page_regs,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
 	.dcfo_comp_sft		= 3,
-	.imr_info		= &rtw8852a_imr_info
+	.imr_info		= &rtw8852a_imr_info,
+	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a1747acd383d1..1d3b1776540f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -131,6 +131,11 @@ static const struct rtw89_imr_info rtw8852c_imr_info = {
 	.tmac_imr_set		= B_AX_TMAC_IMR_SET_V1,
 };
 
+static const struct rtw89_rrsr_cfgs rtw8852c_rrsr_cfgs = {
+	.ref_rate = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_REF_RATE_SEL, 0},
+	.rsc = {R_AX_PTCL_RRSR1, B_AX_RSC_MASK, 2},
+};
+
 static const struct rtw89_dig_regs rtw8852c_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -3068,7 +3073,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.page_regs		= &rtw8852c_page_regs,
 	.dcfo_comp		= &rtw8852c_dcfo_comp,
 	.dcfo_comp_sft		= 5,
-	.imr_info		= &rtw8852c_imr_info
+	.imr_info		= &rtw8852c_imr_info,
+	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

