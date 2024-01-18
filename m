Return-Path: <linux-wireless+bounces-2146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98DA831571
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638D81F23953
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A51E885;
	Thu, 18 Jan 2024 09:05:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED33134A8
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568703; cv=none; b=eS+Y3X6m1ZmkxqgdaGJnt18IyeoQIn/2mpbj2z2IYGOF/xuoXqmBMAsBleGDP2ToKNAQtH5MZhYVigSuyQrLT6abQWin97j+ZKStFVyo+2swb5pkm0IO1+DF9UqqvwD0fGutExgPKSjvhdzEInGIaOjlDFOW6BoYeVViI4TmiqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568703; c=relaxed/simple;
	bh=NKgxBN5JCdyYMxVrPAiePDSOV544Wsgt5kIbweAaCag=;
	h=X-SpamFilter-By:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy; b=sctxMjXK5P6OI7MfPhhcWR6SeuV5pK7Hv0cVBBrcb5+AQSJaWV5kIIWoFL9ndKuJjcIJWgxSrwdYl6KhC58ZbJlw+ySBEx4JGq+PyQkTCqSewf4AzuOIQjdeHDZzcH4H8mDVojbh8Www+CEDezsj6yd+FQVajWFBN5b+s2CrdLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40I94uuK61580105, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40I94uuK61580105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:04:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 18 Jan 2024 17:04:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jan
 2024 17:04:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/6] wifi: rtw89: 8922a: add register definitions of H2C, C2H, page, RRSR and EDCCA
Date: Thu, 18 Jan 2024 17:04:11 +0800
Message-ID: <20240118090413.130989-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118090413.130989-1-pkshih@realtek.com>
References: <20240118090413.130989-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Firmware H2C commands and C2H events can go via registers, so define them
accordingly. The page registers are to arrange local buffer of WiFi chip.
RRSR is to define rate selection to transmit BA or ACK. EDCCA is to set
threshold of engine detection mechanism by BB hardware.

Like other chips, define these registers and we can share the same flow.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 22 ++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 55 +++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c4c886fd1941..741e2b0329a4 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4425,6 +4425,19 @@
 #define R_BE_LTR_LATENCY_IDX2_V1 0x361C
 #define R_BE_LTR_LATENCY_IDX3_V1 0x3620
 
+#define R_BE_H2CREG_DATA0 0x7140
+#define R_BE_H2CREG_DATA1 0x7144
+#define R_BE_H2CREG_DATA2 0x7148
+#define R_BE_H2CREG_DATA3 0x714C
+#define R_BE_C2HREG_DATA0 0x7150
+#define R_BE_C2HREG_DATA1 0x7154
+#define R_BE_C2HREG_DATA2 0x7158
+#define R_BE_C2HREG_DATA3 0x715C
+#define R_BE_H2CREG_CTRL 0x7160
+#define B_BE_H2CREG_TRIGGER BIT(0)
+#define R_BE_C2HREG_CTRL 0x7164
+#define B_BE_C2HREG_TRIGGER BIT(0)
+
 #define R_BE_HCI_FUNC_EN 0x7880
 #define B_BE_HCI_CR_PROTECT BIT(31)
 #define B_BE_HCI_TRXBUF_EN BIT(2)
@@ -5837,6 +5850,15 @@
 #define B_BE_PREC_PAGE_CH12_V1_MASK GENMASK(21, 16)
 #define B_BE_PREC_PAGE_CH011_V1_MASK GENMASK(5, 0)
 
+#define R_BE_CH0_PAGE_CTRL 0xB718
+#define B_BE_CH0_GRP BIT(31)
+#define B_BE_CH0_MAX_PG_MASK GENMASK(28, 16)
+#define B_BE_CH0_MIN_PG_MASK GENMASK(12, 0)
+
+#define R_BE_CH0_PAGE_INFO 0xB750
+#define B_BE_CH0_AVAL_PG_MASK GENMASK(28, 16)
+#define B_BE_CH0_USE_PG_MASK GENMASK(12, 0)
+
 #define R_BE_PUB_PAGE_INFO3 0xB78C
 #define B_BE_G1_AVAL_PG_MASK GENMASK(28, 16)
 #define B_BE_G0_AVAL_PG_MASK GENMASK(12, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index b546ea8a690e..a1687c9470de 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -63,6 +63,31 @@ static const struct rtw89_dle_mem rtw8922a_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const u32 rtw8922a_h2c_regs[RTW89_H2CREG_MAX] = {
+	R_BE_H2CREG_DATA0, R_BE_H2CREG_DATA1, R_BE_H2CREG_DATA2,
+	R_BE_H2CREG_DATA3
+};
+
+static const u32 rtw8922a_c2h_regs[RTW89_H2CREG_MAX] = {
+	R_BE_C2HREG_DATA0, R_BE_C2HREG_DATA1, R_BE_C2HREG_DATA2,
+	R_BE_C2HREG_DATA3
+};
+
+static const struct rtw89_page_regs rtw8922a_page_regs = {
+	.hci_fc_ctrl	= R_BE_HCI_FC_CTRL,
+	.ch_page_ctrl	= R_BE_CH_PAGE_CTRL,
+	.ach_page_ctrl	= R_BE_CH0_PAGE_CTRL,
+	.ach_page_info	= R_BE_CH0_PAGE_INFO,
+	.pub_page_info3	= R_BE_PUB_PAGE_INFO3,
+	.pub_page_ctrl1	= R_BE_PUB_PAGE_CTRL1,
+	.pub_page_ctrl2	= R_BE_PUB_PAGE_CTRL2,
+	.pub_page_info1	= R_BE_PUB_PAGE_INFO1,
+	.pub_page_info2 = R_BE_PUB_PAGE_INFO2,
+	.wp_page_ctrl1	= R_BE_WP_PAGE_CTRL1,
+	.wp_page_ctrl2	= R_BE_WP_PAGE_CTRL2,
+	.wp_page_info1	= R_BE_WP_PAGE_INFO1,
+};
+
 static const struct rtw89_reg_imr rtw8922a_imr_dmac_regs[] = {
 	{R_BE_DISP_HOST_IMR, B_BE_DISP_HOST_IMR_CLR, B_BE_DISP_HOST_IMR_SET},
 	{R_BE_DISP_CPU_IMR, B_BE_DISP_CPU_IMR_CLR, B_BE_DISP_CPU_IMR_SET},
@@ -119,6 +144,11 @@ static const struct rtw89_imr_table rtw8922a_imr_cmac_table = {
 	.n_regs = ARRAY_SIZE(rtw8922a_imr_cmac_regs),
 };
 
+static const struct rtw89_rrsr_cfgs rtw8922a_rrsr_cfgs = {
+	.ref_rate = {R_BE_TRXPTCL_RESP_1, B_BE_WMAC_RESP_REF_RATE_SEL, 0},
+	.rsc = {R_BE_PTCL_RRSR1, B_BE_RSC_MASK, 2},
+};
+
 static const struct rtw89_dig_regs rtw8922a_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V2,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -143,6 +173,22 @@ static const struct rtw89_dig_regs rtw8922a_dig_regs = {
 			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
 };
 
+static const struct rtw89_edcca_regs rtw8922a_edcca_regs = {
+	.edcca_level			= R_SEG0R_EDCCA_LVL_BE,
+	.edcca_mask			= B_EDCCA_LVL_MSK0,
+	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
+	.ppdu_level			= R_SEG0R_PPDU_LVL_BE,
+	.ppdu_mask			= B_EDCCA_LVL_MSK1,
+	.rpt_a				= R_EDCCA_RPT_A_BE,
+	.rpt_b				= R_EDCCA_RPT_B_BE,
+	.rpt_sel			= R_EDCCA_RPT_SEL_BE,
+	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.rpt_sel_be			= R_EDCCA_RPTREG_SEL_BE,
+	.rpt_sel_be_mask		= B_EDCCA_RPTREG_SEL_BE_MSK,
+	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST_BE,
+	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_BE_M,
+};
+
 static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_SYS]			= {.offset = 0x00000, .size = 0x310},
 	[RTW89_EFUSE_BLOCK_RF]			= {.offset = 0x10000, .size = 0x240},
@@ -1109,6 +1155,13 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short_v2),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v2),
 	.txwd_info_size		= sizeof(struct rtw89_txwd_info_v2),
+	.h2c_ctrl_reg		= R_BE_H2CREG_CTRL,
+	.h2c_counter_reg	= {R_BE_UDM1 + 1, B_BE_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
+	.h2c_regs		= rtw8922a_h2c_regs,
+	.c2h_ctrl_reg		= R_BE_C2HREG_CTRL,
+	.c2h_counter_reg	= {R_BE_UDM1 + 1, B_BE_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
+	.c2h_regs		= rtw8922a_c2h_regs,
+	.page_regs		= &rtw8922a_page_regs,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp            = true,
 	.dcfo_comp		= NULL,
@@ -1116,9 +1169,11 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.imr_info		= NULL,
 	.imr_dmac_table		= &rtw8922a_imr_dmac_table,
 	.imr_cmac_table		= &rtw8922a_imr_cmac_table,
+	.rrsr_cfgs		= &rtw8922a_rrsr_cfgs,
 	.bss_clr_vld		= {R_BSS_CLR_VLD_V2, B_BSS_CLR_VLD0_V2},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V2,
 	.dma_ch_mask		= 0,
+	.edcca_regs		= &rtw8922a_edcca_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8922a,
 #endif
-- 
2.25.1


