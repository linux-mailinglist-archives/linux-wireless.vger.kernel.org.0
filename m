Return-Path: <linux-wireless+bounces-30795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5449D1BF6D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3636300909D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E229238D27;
	Wed, 14 Jan 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aNraVOei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEFF2874E1
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354840; cv=none; b=RBc3ALPuM0zd8S7nepqpsNQRBd6YeP2v1rqcvb/or1Va1+GIQoVrp38or2u9JwXJLq6x1eJhqv7/T2Mj8hXcb91oFV87Dfv8uPur81lTLKrYC/XQ0GyyjT/eF4F4JDw6+Gy8Gu9PJv/7+zuyLJZ3zLehiOgYaoDXiZN6NUt8N2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354840; c=relaxed/simple;
	bh=lwChkmHQQy/z3fsz1OY9EXauQQ4+1xI6PqInhDMhglw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaMXEo7+5crMrjy7IUVHzlbpBYc1iOIa32qFUbDDnHIlwxxyFvnMmOMt0HEE44OthGi9adgvLOsmA6jOhR4Ex5PCm94J+QiTZtk3zSiLaabFBdentN6Zgxx6SzudaQPwCo6jUCboQTLAu/CD97PAU8envLO/Iy398giaVwHc/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aNraVOei; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1eZ3C14168559, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354835; bh=URKxv27d4/81/N1el161yLqSBKis311cyimFDx2Ew+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aNraVOeidp5PJtFZLnRUirHB/UOTNkanG34ekG1uUUca7KxTWEF4pa1MpkcF9d7lt
	 t5ZGeJAvtQAzbNlXInVl+UhGnOImcx4XbOZ05OEn7Sq80xHVlBWLcbLU9T8Fn+OjtI
	 Btvwf7qwxdg6w1jwtddwU/ySqywLMp45kK8qrbo7DbIhCxzzV5zUxlhvwiTndikV8w
	 JkXWmrGJ4ux2ahLokPPZIaNTMxXWhZWmx7KgKBscq8oef6so3v3CxaKQm1p5R2LPZ5
	 +/+YNs5nDEG5ZLkxurVK2IY35kimquTIAMbMdExnDdsWUxpxzLlpe2CQ1INYWK+0P6
	 ByMqifV4h+B9g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1eZ3C14168559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:35 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 03/12] wifi: rtw89: phy: add ops rtw89_phy_gen_be_v1 for RTL8922D
Date: Wed, 14 Jan 2026 09:39:41 +0800
Message-ID: <20260114013950.19704-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Define RTL8922D specific registers, including PHY base control register,
PHY status, CFO registers, and TX power registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h    |   1 +
 drivers/net/wireless/realtek/rtw89/phy_be.c | 134 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h    |  58 ++++++++-
 3 files changed, 185 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 444b4ff86ebc..02bbb975ce65 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -559,6 +559,7 @@ struct rtw89_phy_gen_def {
 
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
 extern const struct rtw89_phy_gen_def rtw89_phy_gen_be;
+extern const struct rtw89_phy_gen_def rtw89_phy_gen_be_v1;
 
 static inline void rtw89_phy_write8(struct rtw89_dev *rtwdev,
 				    u32 addr, u8 data)
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index bd17714f13d1..895615df5d7e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -74,17 +74,88 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_be = {
 	.nhm_pwr_method_msk = B_NHM_PWDB_METHOD_MSK,
 };
 
+static const struct rtw89_ccx_regs rtw89_ccx_regs_be_v1 = {
+	.setting_addr = R_CCX_BE4,
+	.edcca_opt_mask = B_CCX_EDCCA_OPT_MSK_V1,
+	.measurement_trig_mask = B_MEASUREMENT_TRIG_MSK,
+	.trig_opt_mask = B_CCX_TRIG_OPT_MSK,
+	.en_mask = B_CCX_EN_MSK,
+	.ifs_cnt_addr = R_IFS_COUNTER_BE4,
+	.ifs_clm_period_mask = B_IFS_CLM_PERIOD_MSK,
+	.ifs_clm_cnt_unit_mask = B_IFS_CLM_COUNTER_UNIT_MSK,
+	.ifs_clm_cnt_clear_mask = B_IFS_COUNTER_CLR_MSK,
+	.ifs_collect_en_mask = B_IFS_COLLECT_EN,
+	.ifs_t1_addr = R_IFS_T1_BE4,
+	.ifs_t1_th_h_mask = B_IFS_T1_TH_HIGH_MSK,
+	.ifs_t1_en_mask = B_IFS_T1_EN_MSK,
+	.ifs_t1_th_l_mask = B_IFS_T1_TH_LOW_MSK,
+	.ifs_t2_addr = R_IFS_T2_BE4,
+	.ifs_t2_th_h_mask = B_IFS_T2_TH_HIGH_MSK,
+	.ifs_t2_en_mask = B_IFS_T2_EN_MSK,
+	.ifs_t2_th_l_mask = B_IFS_T2_TH_LOW_MSK,
+	.ifs_t3_addr = R_IFS_T3_BE4,
+	.ifs_t3_th_h_mask = B_IFS_T3_TH_HIGH_MSK,
+	.ifs_t3_en_mask = B_IFS_T3_EN_MSK,
+	.ifs_t3_th_l_mask = B_IFS_T3_TH_LOW_MSK,
+	.ifs_t4_addr = R_IFS_T4_BE4,
+	.ifs_t4_th_h_mask = B_IFS_T4_TH_HIGH_MSK,
+	.ifs_t4_en_mask = B_IFS_T4_EN_MSK,
+	.ifs_t4_th_l_mask = B_IFS_T4_TH_LOW_MSK,
+	.ifs_clm_tx_cnt_addr = R_IFS_CLM_TX_CNT_BE4,
+	.ifs_clm_edcca_excl_cca_fa_mask = B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK,
+	.ifs_clm_tx_cnt_msk = B_IFS_CLM_TX_CNT_MSK,
+	.ifs_clm_cca_addr = R_IFS_CLM_CCA_BE4,
+	.ifs_clm_ofdmcca_excl_fa_mask = B_IFS_CLM_OFDMCCA_EXCLUDE_FA_MSK,
+	.ifs_clm_cckcca_excl_fa_mask = B_IFS_CLM_CCKCCA_EXCLUDE_FA_MSK,
+	.ifs_clm_fa_addr = R_IFS_CLM_FA_BE4,
+	.ifs_clm_ofdm_fa_mask = B_IFS_CLM_OFDM_FA_MSK,
+	.ifs_clm_cck_fa_mask = B_IFS_CLM_CCK_FA_MSK,
+	.ifs_his_addr = R_IFS_T1_HIS_BE4,
+	.ifs_t4_his_mask = B_IFS_T4_HIS_BE4,
+	.ifs_t3_his_mask = B_IFS_T3_HIS_BE4,
+	.ifs_t2_his_mask = B_IFS_T2_HIS_BE4,
+	.ifs_t1_his_mask = B_IFS_T1_HIS_BE4,
+	.ifs_avg_l_addr = R_IFS_T1_AVG_BE4,
+	.ifs_t2_avg_mask = B_IFS_T2_AVG_BE4,
+	.ifs_t1_avg_mask = B_IFS_T1_AVG_BE4,
+	.ifs_avg_h_addr = R_IFS_T3_AVG_BE4,
+	.ifs_t4_avg_mask = B_IFS_T4_AVG_BE4,
+	.ifs_t3_avg_mask = B_IFS_T3_AVG_BE4,
+	.ifs_cca_l_addr = R_IFS_T1_CLM_BE4,
+	.ifs_t2_cca_mask = B_IFS_T2_CLM_BE4,
+	.ifs_t1_cca_mask = B_IFS_T1_CLM_BE4,
+	.ifs_cca_h_addr = R_IFS_T3_CLM_BE4,
+	.ifs_t4_cca_mask = B_IFS_T4_CLM_BE4,
+	.ifs_t3_cca_mask = B_IFS_T3_CLM_BE4,
+	.ifs_total_addr = R_IFS_TOTAL_BE4,
+	.ifs_cnt_done_mask = B_IFS_CNT_DONE_BE4,
+	.ifs_total_mask = B_IFS_TOTAL_BE4,
+};
+
 static const struct rtw89_physts_regs rtw89_physts_regs_be = {
 	.setting_addr = R_PLCP_HISTOGRAM,
 	.dis_trigger_fail_mask = B_STS_DIS_TRIG_BY_FAIL,
 	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
 };
 
+static const struct rtw89_physts_regs rtw89_physts_regs_be_v1 = {
+	.setting_addr = R_PLCP_HISTOGRAM_BE_V1,
+	.dis_trigger_fail_mask = B_STS_DIS_TRIG_BY_FAIL,
+	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
+};
+
 static const struct rtw89_cfo_regs rtw89_cfo_regs_be = {
-	.comp = R_DCFO_WEIGHT_V1,
-	.weighting_mask = B_DCFO_WEIGHT_MSK_V1,
-	.comp_seg0 = R_DCFO_OPT_V1,
-	.valid_0_mask = B_DCFO_OPT_EN_V1,
+	.comp = R_DCFO_WEIGHT_BE,
+	.weighting_mask = B_DCFO_WEIGHT_MSK_BE,
+	.comp_seg0 = R_DCFO_OPT_BE,
+	.valid_0_mask = B_DCFO_OPT_EN_BE,
+};
+
+static const struct rtw89_cfo_regs rtw89_cfo_regs_be_v1 = {
+	.comp = R_DCFO_WEIGHT_BE_V1,
+	.weighting_mask = B_DCFO_WEIGHT_MSK_BE,
+	.comp_seg0 = R_DCFO_OPT_BE_V1,
+	.valid_0_mask = B_DCFO_OPT_EN_BE,
 };
 
 static u32 rtw89_phy0_phy1_offset_be(struct rtw89_dev *rtwdev, u32 addr)
@@ -105,6 +176,25 @@ static u32 rtw89_phy0_phy1_offset_be(struct rtw89_dev *rtwdev, u32 addr)
 	return ofst;
 }
 
+static u32 rtw89_phy0_phy1_offset_be_v1(struct rtw89_dev *rtwdev, u32 addr)
+{
+	u32 phy_page = addr >> 8;
+	u32 ofst = 0;
+
+	if ((phy_page >= 0x204 && phy_page <= 0x20F) ||
+	    (phy_page >= 0x220 && phy_page <= 0x22F) ||
+	    (phy_page >= 0x240 && phy_page <= 0x24f) ||
+	    (phy_page >= 0x260 && phy_page <= 0x26f) ||
+	    (phy_page >= 0x2C0 && phy_page <= 0x2C9) ||
+	    (phy_page >= 0x2E4 && phy_page <= 0x2E8) ||
+	    phy_page == 0x2EE)
+		ofst = 0x1000;
+	else
+		ofst = 0x0;
+
+	return ofst;
+}
+
 union rtw89_phy_bb_gain_arg_be {
 	u32 addr;
 	struct {
@@ -301,6 +391,16 @@ static void rtw89_phy_preinit_rf_nctl_be(struct rtw89_dev *rtwdev)
 	}
 }
 
+static void rtw89_phy_preinit_rf_nctl_be_v1(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_mask(rtwdev, R_GOTX_IQKDPK_C0_BE4, B_GOTX_IQKDPK, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_GOTX_IQKDPK_C1_BE4, B_GOTX_IQKDPK, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_IOQ_IQK_DPK_BE4, B_IOQ_IQK_DPK_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_RST_BE4, B_IQK_DPK_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_PRST_BE4, B_IQK_DPK_PRST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_PRST_C1_BE4, B_IQK_DPK_PRST, 0x1);
+}
+
 static
 void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
 {
@@ -441,6 +541,14 @@ static void rtw89_phy_ch_info_init_be(struct rtw89_dev *rtwdev)
 	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_TYPE_SCAL, B_CHINFO_SCAL, 0x0);
 }
 
+static void rtw89_phy_ch_info_init_be_v1(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_mask(rtwdev, R_CHINFO_SEG_BE4, B_CHINFO_SEG_LEN_BE4, 0);
+	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_OPT_BE4, B_CHINFO_OPT_BE4, 0x3);
+	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_NX_BE4, B_CHINFO_NX_BE4, 0x669);
+	rtw89_phy_set_phy_regs(rtwdev, R_CHINFO_ALG_BE4, B_CHINFO_ALG_BE4, 0);
+}
+
 struct rtw89_byr_spec_ent_be {
 	struct rtw89_rate_desc init;
 	u8 num_of_idx;
@@ -1019,3 +1127,21 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.set_txpwr_limit_ru = rtw89_phy_set_txpwr_limit_ru_be,
 };
 EXPORT_SYMBOL(rtw89_phy_gen_be);
+
+const struct rtw89_phy_gen_def rtw89_phy_gen_be_v1 = {
+	.cr_base = 0x0,
+	.ccx = &rtw89_ccx_regs_be_v1,
+	.physts = &rtw89_physts_regs_be_v1,
+	.cfo = &rtw89_cfo_regs_be_v1,
+	.phy0_phy1_offset = rtw89_phy0_phy1_offset_be_v1,
+	.config_bb_gain = rtw89_phy_config_bb_gain_be,
+	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be_v1,
+	.bb_wrap_init = rtw89_phy_bb_wrap_init_be,
+	.ch_info_init = rtw89_phy_ch_info_init_be_v1,
+
+	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
+	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
+	.set_txpwr_limit = rtw89_phy_set_txpwr_limit_be,
+	.set_txpwr_limit_ru = rtw89_phy_set_txpwr_limit_ru_be,
+};
+EXPORT_SYMBOL(rtw89_phy_gen_be_v1);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c06723fdb4d3..928b8cb644b8 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8459,6 +8459,7 @@
 #define R_MAC_PIN_SEL 0x0734
 #define B_CH_IDX_SEG0 GENMASK(23, 16)
 #define R_PLCP_HISTOGRAM 0x0738
+#define R_PLCP_HISTOGRAM_BE_V1 0x20738
 #define B_STS_PARSING_TIME GENMASK(19, 16)
 #define B_STS_DIS_TRIG_BY_FAIL BIT(3)
 #define B_STS_DIS_TRIG_BY_BRK BIT(2)
@@ -8511,6 +8512,7 @@
 #define R_DBCC_80P80_SEL_EVM_RPT 0x0A10
 #define B_DBCC_80P80_SEL_EVM_RPT_EN BIT(0)
 #define R_CCX 0x0C00
+#define R_CCX_BE4 0x20C00
 #define B_CCX_EDCCA_OPT_MSK GENMASK(6, 4)
 #define B_CCX_EDCCA_OPT_MSK_V1 GENMASK(7, 4)
 #define B_MEASUREMENT_TRIG_MSK BIT(2)
@@ -8539,34 +8541,42 @@
 #define R_FAHM 0x0C1C
 #define B_RXTD_CKEN BIT(2)
 #define R_IFS_COUNTER 0x0C28
+#define R_IFS_COUNTER_BE4 0x20C28
 #define B_IFS_CLM_PERIOD_MSK GENMASK(31, 16)
 #define B_IFS_CLM_COUNTER_UNIT_MSK GENMASK(15, 14)
 #define B_IFS_COUNTER_CLR_MSK BIT(13)
 #define B_IFS_COLLECT_EN BIT(12)
 #define R_IFS_T1 0x0C2C
+#define R_IFS_T1_BE4 0x20C2C
 #define B_IFS_T1_TH_HIGH_MSK GENMASK(31, 16)
 #define B_IFS_T1_EN_MSK BIT(15)
 #define B_IFS_T1_TH_LOW_MSK GENMASK(14, 0)
 #define R_IFS_T2 0x0C30
+#define R_IFS_T2_BE4 0x20C30
 #define B_IFS_T2_TH_HIGH_MSK GENMASK(31, 16)
 #define B_IFS_T2_EN_MSK BIT(15)
 #define B_IFS_T2_TH_LOW_MSK GENMASK(14, 0)
 #define R_IFS_T3 0x0C34
+#define R_IFS_T3_BE4 0x20C34
 #define B_IFS_T3_TH_HIGH_MSK GENMASK(31, 16)
 #define B_IFS_T3_EN_MSK BIT(15)
 #define B_IFS_T3_TH_LOW_MSK GENMASK(14, 0)
 #define R_IFS_T4 0x0C38
+#define R_IFS_T4_BE4 0x20C38
 #define B_IFS_T4_TH_HIGH_MSK GENMASK(31, 16)
 #define B_IFS_T4_EN_MSK BIT(15)
 #define B_IFS_T4_TH_LOW_MSK GENMASK(14, 0)
 #define R_PD_CTRL 0x0C3C
 #define B_PD_HIT_DIS BIT(9)
 #define R_IOQ_IQK_DPK 0x0C60
+#define R_IOQ_IQK_DPK_BE4 0x20C60
 #define B_IOQ_IQK_DPK_CLKEN GENMASK(1, 0)
 #define B_IOQ_IQK_DPK_EN BIT(1)
+#define B_IOQ_IQK_DPK_RST BIT(0)
 #define R_GNT_BT_WGT_EN 0x0C6C
 #define B_GNT_BT_WGT_EN BIT(21)
 #define R_IQK_DPK_RST 0x0C6C
+#define R_IQK_DPK_RST_BE4 0x20C6C
 #define R_IQK_DPK_RST_C1 0x1C6C
 #define B_IQK_DPK_RST BIT(0)
 #define R_TX_COLLISION_T2R_ST 0x0C70
@@ -8684,14 +8694,17 @@
 #define B_NHM_READY_MSK BIT(16)
 #define R_IFS_CLM_TX_CNT 0x1ACC
 #define R_IFS_CLM_TX_CNT_V1 0x0ECC
+#define R_IFS_CLM_TX_CNT_BE4 0x20ECC
 #define B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK GENMASK(31, 16)
 #define B_IFS_CLM_TX_CNT_MSK GENMASK(15, 0)
 #define R_IFS_CLM_CCA 0x1AD0
 #define R_IFS_CLM_CCA_V1 0x0ED0
+#define R_IFS_CLM_CCA_BE4 0x20ED0
 #define B_IFS_CLM_OFDMCCA_EXCLUDE_FA_MSK GENMASK(31, 16)
 #define B_IFS_CLM_CCKCCA_EXCLUDE_FA_MSK GENMASK(15, 0)
 #define R_IFS_CLM_FA 0x1AD4
 #define R_IFS_CLM_FA_V1 0x0ED4
+#define R_IFS_CLM_FA_BE4 0x20ED4
 #define B_IFS_CLM_OFDM_FA_MSK GENMASK(31, 16)
 #define B_IFS_CLM_CCK_FA_MSK GENMASK(15, 0)
 #define R_IFS_HIS 0x1AD8
@@ -9348,12 +9361,14 @@
 #define B_S0_DACKQ7_K GENMASK(15, 8)
 #define R_S0_DACKQ8 0x5E98
 #define B_S0_DACKQ8_K GENMASK(15, 8)
-#define R_DCFO_WEIGHT_V1 0x6244
-#define B_DCFO_WEIGHT_MSK_V1 GENMASK(31, 28)
+#define R_DCFO_WEIGHT_BE 0x6244
+#define R_DCFO_WEIGHT_BE_V1 0x24808
+#define B_DCFO_WEIGHT_MSK_BE GENMASK(31, 28)
 #define R_DAC_CLK 0x625C
 #define B_DAC_CLK GENMASK(31, 30)
-#define R_DCFO_OPT_V1 0x6260
-#define B_DCFO_OPT_EN_V1 BIT(17)
+#define R_DCFO_OPT_BE 0x6260
+#define R_DCFO_OPT_BE_V1 0x24824
+#define B_DCFO_OPT_EN_BE BIT(17)
 #define R_TXFCTR 0x627C
 #define B_TXFCTR_THD GENMASK(19, 10)
 #define R_TXSCALE 0x6284
@@ -9863,10 +9878,14 @@
 #define R_GAIN_MAP1 0xE54C
 #define B_GAIN_MAP1_EN BIT(0)
 #define R_GOTX_IQKDPK_C0 0xE464
+#define R_GOTX_IQKDPK_C0_BE4 0x2E464
 #define R_GOTX_IQKDPK_C1 0xE564
+#define R_GOTX_IQKDPK_C1_BE4 0x2E564
 #define B_GOTX_IQKDPK GENMASK(28, 27)
 #define R_IQK_DPK_PRST 0xE4AC
+#define R_IQK_DPK_PRST_BE4 0x2E4AC
 #define R_IQK_DPK_PRST_C1 0xE5AC
+#define R_IQK_DPK_PRST_C1_BE4 0x2E5AC
 #define B_IQK_DPK_PRST BIT(27)
 #define R_TXPWR_RSTA 0xE60C
 #define B_TXPWR_RSTA BIT(16)
@@ -9893,12 +9912,43 @@
 #define R_TSSI_K_P1 0xE7A0
 #define B_TSSI_K_OFDM_P1 GENMASK(29, 20)
 
+#define R_CHINFO_SEG_BE4 0x200B4
+#define B_CHINFO_SEG_LEN_BE4 GENMASK(12, 10)
+
 #define R_SW_SI_WDATA_BE4 0x20370
 #define B_SW_SI_DATA_PATH_BE4 GENMASK(31, 28)
 #define B_SW_SI_DATA_ADR_BE4 GENMASK(27, 20)
 #define B_SW_SI_DATA_DAT_BE4 GENMASK(19, 0)
 #define R_SW_SI_READ_ADDR_BE4 0x20378
 #define B_SW_SI_READ_ADDR_BE4 GENMASK(10, 0)
+#define R_IFS_T1_AVG_BE4 0x20EDC
+#define B_IFS_T1_AVG_BE4 GENMASK(15, 0)
+#define B_IFS_T2_AVG_BE4 GENMASK(31, 16)
+#define R_IFS_T3_AVG_BE4 0x20EE0
+#define B_IFS_T3_AVG_BE4 GENMASK(15, 0)
+#define B_IFS_T4_AVG_BE4 GENMASK(31, 16)
+#define R_IFS_T1_CLM_BE4 0x20EE4
+#define B_IFS_T1_CLM_BE4 GENMASK(15, 0)
+#define B_IFS_T2_CLM_BE4 GENMASK(31, 16)
+#define R_IFS_T3_CLM_BE4 0x20EE8
+#define B_IFS_T3_CLM_BE4 GENMASK(15, 0)
+#define B_IFS_T4_CLM_BE4 GENMASK(31, 16)
+#define R_IFS_TOTAL_BE4 0x20EEC
+#define B_IFS_TOTAL_BE4 GENMASK(15, 0)
+#define B_IFS_CNT_DONE_BE4 BIT(16)
+#define R_IFS_T1_HIS_BE4 0x20F50
+#define B_IFS_T1_HIS_BE4 GENMASK(15, 0)
+#define B_IFS_T2_HIS_BE4 GENMASK(31, 16)
+#define R_IFS_T3_HIS_BE4 0x20F54
+#define B_IFS_T3_HIS_BE4 GENMASK(15, 0)
+#define B_IFS_T4_HIS_BE4 GENMASK(31, 16)
+
+#define R_CHINFO_OPT_BE4 0x267C8
+#define B_CHINFO_OPT_BE4 GENMASK(14, 13)
+#define R_CHINFO_NX_BE4 0x267D0
+#define B_CHINFO_NX_BE4 GENMASK(16, 6)
+#define R_CHINFO_ALG_BE4 0x267C8
+#define B_CHINFO_ALG_BE4 GENMASK(31, 30)
 
 #define R_SW_SI_DATA_BE4 0x2CF4C
 #define B_SW_SI_READ_DATA_BE4 GENMASK(19, 0)
-- 
2.25.1


