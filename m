Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFDF4CCE0B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 07:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiCDGse (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 01:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbiCDGsV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 01:48:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EF618CC50
        for <linux-wireless@vger.kernel.org>; Thu,  3 Mar 2022 22:47:22 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2246lGCi9011675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2246lGCi9011675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 4 Mar 2022 14:47:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 4 Mar 2022 14:47:16 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 4 Mar
 2022 14:47:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/13] rtw89: add page_regs to handle v1 chips
Date:   Fri, 4 Mar 2022 14:46:15 +0800
Message-ID: <20220304064619.23662-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304064619.23662-1-pkshih@realtek.com>
References: <20220304064619.23662-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/04/2022 06:29:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNCCkV6TIIDA0OjM0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These registers are used to configure and access page size of HCI.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 16 +++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 60 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/reg.h      | 39 ++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 16 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 16 +++++
 5 files changed, 124 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 14e8f48520b71..2dc19b530db62 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2217,6 +2217,21 @@ struct rtw89_txpwr_table {
 		     const struct rtw89_txpwr_table *tbl);
 };
 
+struct rtw89_page_regs {
+	u32 hci_fc_ctrl;
+	u32 ch_page_ctrl;
+	u32 ach_page_ctrl;
+	u32 ach_page_info;
+	u32 pub_page_info3;
+	u32 pub_page_ctrl1;
+	u32 pub_page_ctrl2;
+	u32 pub_page_info1;
+	u32 pub_page_info2;
+	u32 wp_page_ctrl1;
+	u32 wp_page_ctrl2;
+	u32 wp_page_info1;
+};
+
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	const struct rtw89_chip_ops *ops;
@@ -2288,6 +2303,7 @@ struct rtw89_chip_info {
 	const u32 *h2c_regs;
 	u32 c2h_ctrl_reg;
 	const u32 *c2h_regs;
+	const struct rtw89_page_regs *page_regs;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9ba47a72812f9..df657df6b1493 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -569,6 +569,8 @@ static int hfc_pub_cfg_chk(struct rtw89_dev *rtwdev)
 
 static int hfc_ch_ctrl(struct rtw89_dev *rtwdev, u8 ch)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_page_regs *regs = chip->page_regs;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	const struct rtw89_hfc_ch_cfg *cfg = param->ch_cfg;
 	int ret = 0;
@@ -588,13 +590,15 @@ static int hfc_ch_ctrl(struct rtw89_dev *rtwdev, u8 ch)
 	val = u32_encode_bits(cfg[ch].min, B_AX_MIN_PG_MASK) |
 	      u32_encode_bits(cfg[ch].max, B_AX_MAX_PG_MASK) |
 	      (cfg[ch].grp ? B_AX_GRP : 0);
-	rtw89_write32(rtwdev, R_AX_ACH0_PAGE_CTRL + ch * 4, val);
+	rtw89_write32(rtwdev, regs->ach_page_ctrl + ch * 4, val);
 
 	return 0;
 }
 
 static int hfc_upd_ch_info(struct rtw89_dev *rtwdev, u8 ch)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_page_regs *regs = chip->page_regs;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	struct rtw89_hfc_ch_info *info = param->ch_info;
 	const struct rtw89_hfc_ch_cfg *cfg = param->ch_cfg;
@@ -608,7 +612,7 @@ static int hfc_upd_ch_info(struct rtw89_dev *rtwdev, u8 ch)
 	if (ch > RTW89_DMA_H2C)
 		return -EINVAL;
 
-	val = rtw89_read32(rtwdev, R_AX_ACH0_PAGE_INFO + ch * 4);
+	val = rtw89_read32(rtwdev, regs->ach_page_info + ch * 4);
 	info[ch].aval = u32_get_bits(val, B_AX_AVAL_PG_MASK);
 	if (ch < RTW89_DMA_H2C)
 		info[ch].used = u32_get_bits(val, B_AX_USE_PG_MASK);
@@ -620,6 +624,8 @@ static int hfc_upd_ch_info(struct rtw89_dev *rtwdev, u8 ch)
 
 static int hfc_pub_ctrl(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_page_regs *regs = chip->page_regs;
 	const struct rtw89_hfc_pub_cfg *cfg = &rtwdev->mac.hfc_param.pub_cfg;
 	u32 val;
 	int ret;
@@ -634,16 +640,18 @@ static int hfc_pub_ctrl(struct rtw89_dev *rtwdev)
 
 	val = u32_encode_bits(cfg->grp0, B_AX_PUBPG_G0_MASK) |
 	      u32_encode_bits(cfg->grp1, B_AX_PUBPG_G1_MASK);
-	rtw89_write32(rtwdev, R_AX_PUB_PAGE_CTRL1, val);
+	rtw89_write32(rtwdev, regs->pub_page_ctrl1, val);
 
 	val = u32_encode_bits(cfg->wp_thrd, B_AX_WP_THRD_MASK);
-	rtw89_write32(rtwdev, R_AX_WP_PAGE_CTRL2, val);
+	rtw89_write32(rtwdev, regs->wp_page_ctrl2, val);
 
 	return 0;
 }
 
 static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_page_regs *regs = chip->page_regs;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
 	struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
@@ -655,20 +663,20 @@ static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_INFO1);
+	val = rtw89_read32(rtwdev, regs->pub_page_info1);
 	info->g0_used = u32_get_bits(val, B_AX_G0_USE_PG_MASK);
 	info->g1_used = u32_get_bits(val, B_AX_G1_USE_PG_MASK);
-	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_INFO3);
+	val = rtw89_read32(rtwdev, regs->pub_page_info3);
 	info->g0_aval = u32_get_bits(val, B_AX_G0_AVAL_PG_MASK);
 	info->g1_aval = u32_get_bits(val, B_AX_G1_AVAL_PG_MASK);
 	info->pub_aval =
-		u32_get_bits(rtw89_read32(rtwdev, R_AX_PUB_PAGE_INFO2),
+		u32_get_bits(rtw89_read32(rtwdev, regs->pub_page_info2),
 			     B_AX_PUB_AVAL_PG_MASK);
 	info->wp_aval =
-		u32_get_bits(rtw89_read32(rtwdev, R_AX_WP_PAGE_INFO1),
+		u32_get_bits(rtw89_read32(rtwdev, regs->wp_page_info1),
 			     B_AX_WP_AVAL_PG_MASK);
 
-	val = rtw89_read32(rtwdev, R_AX_HCI_FC_CTRL);
+	val = rtw89_read32(rtwdev, regs->hci_fc_ctrl);
 	param->en = val & B_AX_HCI_FC_EN ? 1 : 0;
 	param->h2c_en = val & B_AX_HCI_FC_CH12_EN ? 1 : 0;
 	param->mode = u32_get_bits(val, B_AX_HCI_FC_MODE_MASK);
@@ -681,21 +689,21 @@ static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 	prec_cfg->wp_ch811_full_cond =
 		u32_get_bits(val, B_AX_HCI_FC_WP_CH811_FULL_COND_MASK);
 
-	val = rtw89_read32(rtwdev, R_AX_CH_PAGE_CTRL);
+	val = rtw89_read32(rtwdev, regs->ch_page_ctrl);
 	prec_cfg->ch011_prec = u32_get_bits(val, B_AX_PREC_PAGE_CH011_MASK);
 	prec_cfg->h2c_prec = u32_get_bits(val, B_AX_PREC_PAGE_CH12_MASK);
 
-	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_CTRL2);
+	val = rtw89_read32(rtwdev, regs->pub_page_ctrl2);
 	pub_cfg->pub_max = u32_get_bits(val, B_AX_PUBPG_ALL_MASK);
 
-	val = rtw89_read32(rtwdev, R_AX_WP_PAGE_CTRL1);
+	val = rtw89_read32(rtwdev, regs->wp_page_ctrl1);
 	prec_cfg->wp_ch07_prec = u32_get_bits(val, B_AX_PREC_PAGE_WP_CH07_MASK);
 	prec_cfg->wp_ch811_prec = u32_get_bits(val, B_AX_PREC_PAGE_WP_CH811_MASK);
 
-	val = rtw89_read32(rtwdev, R_AX_WP_PAGE_CTRL2);
+	val = rtw89_read32(rtwdev, regs->wp_page_ctrl2);
 	pub_cfg->wp_thrd = u32_get_bits(val, B_AX_WP_THRD_MASK);
 
-	val = rtw89_read32(rtwdev, R_AX_PUB_PAGE_CTRL1);
+	val = rtw89_read32(rtwdev, regs->pub_page_ctrl1);
 	pub_cfg->grp0 = u32_get_bits(val, B_AX_PUBPG_G0_MASK);
 	pub_cfg->grp1 = u32_get_bits(val, B_AX_PUBPG_G1_MASK);
 
@@ -708,20 +716,24 @@ static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 
 static void hfc_h2c_cfg(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_page_regs *regs = chip->page_regs;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	const struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
 	u32 val;
 
 	val = u32_encode_bits(prec_cfg->h2c_prec, B_AX_PREC_PAGE_CH12_MASK);
-	rtw89_write32(rtwdev, R_AX_CH_PAGE_CTRL, val);
+	rtw89_write32(rtwdev, regs->ch_page_ctrl, val);
 
-	rtw89_write32_mask(rtwdev, R_AX_HCI_FC_CTRL,
+	rtw89_write32_mask(rtwdev, regs->hci_fc_ctrl,
 			   B_AX_HCI_FC_CH12_FULL_COND_MASK,
 			   prec_cfg->h2c_full_cond);
 }
 
 static void hfc_mix_cfg(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_page_regs *regs = chip->page_regs;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	const struct rtw89_hfc_pub_cfg *pub_cfg = &param->pub_cfg;
 	const struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
@@ -729,18 +741,18 @@ static void hfc_mix_cfg(struct rtw89_dev *rtwdev)
 
 	val = u32_encode_bits(prec_cfg->ch011_prec, B_AX_PREC_PAGE_CH011_MASK) |
 	      u32_encode_bits(prec_cfg->h2c_prec, B_AX_PREC_PAGE_CH12_MASK);
-	rtw89_write32(rtwdev, R_AX_CH_PAGE_CTRL, val);
+	rtw89_write32(rtwdev, regs->ch_page_ctrl, val);
 
 	val = u32_encode_bits(pub_cfg->pub_max, B_AX_PUBPG_ALL_MASK);
-	rtw89_write32(rtwdev, R_AX_PUB_PAGE_CTRL2, val);
+	rtw89_write32(rtwdev, regs->pub_page_ctrl2, val);
 
 	val = u32_encode_bits(prec_cfg->wp_ch07_prec,
 			      B_AX_PREC_PAGE_WP_CH07_MASK) |
 	      u32_encode_bits(prec_cfg->wp_ch811_prec,
 			      B_AX_PREC_PAGE_WP_CH811_MASK);
-	rtw89_write32(rtwdev, R_AX_WP_PAGE_CTRL1, val);
+	rtw89_write32(rtwdev, regs->wp_page_ctrl1, val);
 
-	val = u32_replace_bits(rtw89_read32(rtwdev, R_AX_HCI_FC_CTRL),
+	val = u32_replace_bits(rtw89_read32(rtwdev, regs->hci_fc_ctrl),
 			       param->mode, B_AX_HCI_FC_MODE_MASK);
 	val = u32_replace_bits(val, prec_cfg->ch011_full_cond,
 			       B_AX_HCI_FC_WD_FULL_COND_MASK);
@@ -750,21 +762,23 @@ static void hfc_mix_cfg(struct rtw89_dev *rtwdev)
 			       B_AX_HCI_FC_WP_CH07_FULL_COND_MASK);
 	val = u32_replace_bits(val, prec_cfg->wp_ch811_full_cond,
 			       B_AX_HCI_FC_WP_CH811_FULL_COND_MASK);
-	rtw89_write32(rtwdev, R_AX_HCI_FC_CTRL, val);
+	rtw89_write32(rtwdev, regs->hci_fc_ctrl, val);
 }
 
 static void hfc_func_en(struct rtw89_dev *rtwdev, bool en, bool h2c_en)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_page_regs *regs = chip->page_regs;
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
 	u32 val;
 
-	val = rtw89_read32(rtwdev, R_AX_HCI_FC_CTRL);
+	val = rtw89_read32(rtwdev, regs->hci_fc_ctrl);
 	param->en = en;
 	param->h2c_en = h2c_en;
 	val = en ? (val | B_AX_HCI_FC_EN) : (val & ~B_AX_HCI_FC_EN);
 	val = h2c_en ? (val | B_AX_HCI_FC_CH12_EN) :
 			 (val & ~B_AX_HCI_FC_CH12_EN);
-	rtw89_write32(rtwdev, R_AX_HCI_FC_CTRL, val);
+	rtw89_write32(rtwdev, regs->hci_fc_ctrl, val);
 }
 
 static int hfc_init(struct rtw89_dev *rtwdev, bool reset, bool en, bool h2c_en)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 61f9899f02fc6..30e05abc7b55f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -217,6 +217,45 @@
 #define B_AX_ASFF_FULL_NO_STK BIT(1)
 #define B_AX_EN_STUCK_DBG BIT(0)
 
+#define R_AX_HCI_FC_CTRL_V1 0x1700
+#define R_AX_CH_PAGE_CTRL_V1 0x1704
+
+#define R_AX_ACH0_PAGE_CTRL_V1 0x1710
+#define R_AX_ACH1_PAGE_CTRL_V1 0x1714
+#define R_AX_ACH2_PAGE_CTRL_V1 0x1718
+#define R_AX_ACH3_PAGE_CTRL_V1 0x171C
+#define R_AX_ACH4_PAGE_CTRL_V1 0x1720
+#define R_AX_ACH5_PAGE_CTRL_V1 0x1724
+#define R_AX_ACH6_PAGE_CTRL_V1 0x1728
+#define R_AX_ACH7_PAGE_CTRL_V1 0x172C
+#define R_AX_CH8_PAGE_CTRL_V1 0x1730
+#define R_AX_CH9_PAGE_CTRL_V1 0x1734
+#define R_AX_CH10_PAGE_CTRL_V1 0x1738
+#define R_AX_CH11_PAGE_CTRL_V1 0x173C
+
+#define R_AX_ACH0_PAGE_INFO_V1 0x1750
+#define R_AX_ACH1_PAGE_INFO_V1 0x1754
+#define R_AX_ACH2_PAGE_INFO_V1 0x1758
+#define R_AX_ACH3_PAGE_INFO_V1 0x175C
+#define R_AX_ACH4_PAGE_INFO_V1 0x1760
+#define R_AX_ACH5_PAGE_INFO_V1 0x1764
+#define R_AX_ACH6_PAGE_INFO_V1 0x1768
+#define R_AX_ACH7_PAGE_INFO_V1 0x176C
+#define R_AX_CH8_PAGE_INFO_V1 0x1770
+#define R_AX_CH9_PAGE_INFO_V1 0x1774
+#define R_AX_CH10_PAGE_INFO_V1 0x1778
+#define R_AX_CH11_PAGE_INFO_V1 0x177C
+#define R_AX_CH12_PAGE_INFO_V1 0x1780
+
+#define R_AX_PUB_PAGE_INFO3_V1 0x178C
+#define R_AX_PUB_PAGE_CTRL1_V1 0x1790
+#define R_AX_PUB_PAGE_CTRL2_V1 0x1794
+#define R_AX_PUB_PAGE_INFO1_V1 0x1798
+#define R_AX_PUB_PAGE_INFO2_V1 0x179C
+#define R_AX_WP_PAGE_CTRL1_V1 0x17A0
+#define R_AX_WP_PAGE_CTRL2_V1 0x17A4
+#define R_AX_WP_PAGE_INFO1_V1 0x17A8
+
 #define R_AX_H2CREG_DATA0_V1 0x7140
 #define R_AX_H2CREG_DATA1_V1 0x7144
 #define R_AX_H2CREG_DATA2_V1 0x7148
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9db8a8f9dd180..4eb03dde34130 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -387,6 +387,21 @@ static const u32 rtw8852a_c2h_regs[RTW89_C2HREG_MAX] = {
 	R_AX_C2HREG_DATA3
 };
 
+static const struct rtw89_page_regs rtw8852a_page_regs = {
+	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL,
+	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL,
+	.ach_page_ctrl	= R_AX_ACH0_PAGE_CTRL,
+	.ach_page_info	= R_AX_ACH0_PAGE_INFO,
+	.pub_page_info3	= R_AX_PUB_PAGE_INFO3,
+	.pub_page_ctrl1	= R_AX_PUB_PAGE_CTRL1,
+	.pub_page_ctrl2	= R_AX_PUB_PAGE_CTRL2,
+	.pub_page_info1	= R_AX_PUB_PAGE_INFO1,
+	.pub_page_info2 = R_AX_PUB_PAGE_INFO2,
+	.wp_page_ctrl1	= R_AX_WP_PAGE_CTRL1,
+	.wp_page_ctrl2	= R_AX_WP_PAGE_CTRL2,
+	.wp_page_info1	= R_AX_WP_PAGE_INFO1,
+};
+
 static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
 				    struct rtw8852a_efuse *map)
 {
@@ -2073,6 +2088,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.h2c_regs		= rtw8852a_h2c_regs,
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
 	.c2h_regs		= rtw8852a_c2h_regs,
+	.page_regs		= &rtw8852a_page_regs,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c08e0aebc6460..0b2f4595d1323 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -17,6 +17,21 @@ static const u32 rtw8852c_c2h_regs[RTW89_H2CREG_MAX] = {
 	R_AX_C2HREG_DATA3_V1
 };
 
+static const struct rtw89_page_regs rtw8852c_page_regs = {
+	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL_V1,
+	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL_V1,
+	.ach_page_ctrl	= R_AX_ACH0_PAGE_CTRL_V1,
+	.ach_page_info	= R_AX_ACH0_PAGE_INFO_V1,
+	.pub_page_info3	= R_AX_PUB_PAGE_INFO3_V1,
+	.pub_page_ctrl1	= R_AX_PUB_PAGE_CTRL1_V1,
+	.pub_page_ctrl2	= R_AX_PUB_PAGE_CTRL2_V1,
+	.pub_page_info1	= R_AX_PUB_PAGE_INFO1_V1,
+	.pub_page_info2 = R_AX_PUB_PAGE_INFO2_V1,
+	.wp_page_ctrl1	= R_AX_WP_PAGE_CTRL1_V1,
+	.wp_page_ctrl2	= R_AX_WP_PAGE_CTRL2_V1,
+	.wp_page_info1	= R_AX_WP_PAGE_INFO1_V1,
+};
+
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -202,6 +217,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.h2c_regs		= rtw8852c_h2c_regs,
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL_V1,
 	.c2h_regs		= rtw8852c_c2h_regs,
+	.page_regs		= &rtw8852c_page_regs,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

