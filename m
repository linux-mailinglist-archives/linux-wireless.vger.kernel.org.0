Return-Path: <linux-wireless+bounces-35624-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO0NFPoI8mnhmwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35624-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:34:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0CA494E99
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06EBD3151960
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5623C1961;
	Wed, 29 Apr 2026 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="vE8whwdo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C03FCB27
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469216; cv=none; b=U+YqBreOIGI26fDH5YqjWXv8Qs4Ds3ieUjmYW4L2Vcdvy/bCsVu8jDg16C5Q60AfdJGhVsC1qwSeYtEcdOpENYLq9skUBPI/6CauR25gSOyqK3aRMEuZtiUqgA6WoBEgj4IM+kVbPAFdS9jrWPyPFAO5z/R+04n7iDHzo9r0nDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469216; c=relaxed/simple;
	bh=EqiWMlfxEx04GlQ/nDG4ernsQBPozXJab4GujDQKTwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzvZPyrLIJiJWbCKGp+TQxeQXNh9EmZkPVqoNRSGyzKGnTsuSZ63wQSuUqAPuKJS1Smw8jouiTXtTCvM2QPJGJNOwbNnV5cg94oonjRLXd0SLxDLaaF1UlPAlTID5bWwvZ8CpSZyKT/ms8NGrJoYmK/hHrdq1IoT3JNk1G4TOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=vE8whwdo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDQqSsA1223075, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469212; bh=kN/vFGoOCQxdZXjYhVgOUxoDDqDJakqYdZTsOQlX6Jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vE8whwdoMv6pHTdgh8eYjTIpgNkEGlUC/DMCP0wuJcJFqH/ootmnZBaIJY/pRYCj+
	 +45goKSEFPXBt5rB6W10IXdbkAaadUtvTQdzY/FIs0QttnDdhiuG4YVojAob8Ej7y2
	 +A+Uuy+j3ZJDqhrQyMtAUm0O0tm7aJT+2YMutQEOB7GCG9857Rz+2d42rWOCeMWWZZ
	 pBewJEmgDhuL0At0WbUwN/Jsd9jA1yiq0ehH4n72eTUigTpKyGxVj/EaUPbP5Tg887
	 Ie9vG+BGl4qtSbkaBd2+U68wvaTFTX+0OtMsb/bJOvmN55l0S+CKAdin0Dm3GRrt2f
	 gU+tm0TwjRMSg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDQqSsA1223075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:26:52 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:51 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:26:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 5/7] wifi: rtw89: debug: extend bb_info with TX status and PER
Date: Wed, 29 Apr 2026 21:26:23 +0800
Message-ID: <20260429132625.1659182-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429132625.1659182-1-pkshih@realtek.com>
References: <20260429132625.1659182-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: CB0CA494E99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35624-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]

From: Kuan-Chung Chen <damon.chen@realtek.com>

Enhance bb_info debugfs by adding TX status information to aid
debugging and performance analysis.

A snapshot of TX-related registers, including PPDU type and subtype,
bandwidth, TX power, STBC, etc. The information is collected per
PHY during track_work and displayed via bb_info debugfs.

TX status output:

  == TX General
  EHT_MU_SU DATA
  BW: 160, TX_SC: 0, TX_PATH_EN: 3, PATH_MAP: 0xe4
  TXPWR TMAC: 11, P0: 11, P1: 11 dBm
  MCS: 9, STBC: 0
  Info: [0x0000000b, 0xc1702c30, 0x0ff1e430, 0xc0000000, 0x99000009, 0x40000000]
  Common ctrl: [0x00000150, 0x40190140]

In addition, include the retry ratio from RA reports and display it
as PER (packet error rate) in station debug information.

PER output:

  TX rate [0, 0]: HE 2SS MCS-4 GI:0.8 BW:20 (hw_rate=0x324) PER:23

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  24 +++
 drivers/net/wireless/realtek/rtw89/debug.c  | 206 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.c    |  93 ++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h    |  23 +++
 drivers/net/wireless/realtek/rtw89/phy_be.c |  46 +++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  29 +++
 6 files changed, 420 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7f869a339ee6..e8b03716d41e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3488,6 +3488,7 @@ struct rtw89_ra_report {
 	struct rate_info txrate;
 	u32 bit_rate;
 	u16 hw_rate;
+	u8 retry_ratio;
 	bool might_fallback_legacy;
 };
 
@@ -4175,6 +4176,12 @@ struct rtw89_reg5_def {
 	u32 data;
 };
 
+#define RTW89_REGS_DEF(x) {x, ARRAY_SIZE(x)}
+struct rtw89_regs_def {
+	const u32 *regs;
+	u32 reg_nr;
+};
+
 struct rtw89_reg_imr {
 	u32 addr;
 	u32 clr;
@@ -5591,6 +5598,22 @@ struct rtw89_pmac_stat_info {
 	u32 cnt_sb_search_fail;
 };
 
+struct rtw89_tx_stat_info {
+	u32 info[6];
+	u32 common_ctrl[2];
+	u32 txpwr[2];
+	u8 type;
+	u8 subtype;
+	u8 txcmd;
+	u8 txsc;
+	u8 bw;
+	u16 tmac_txpwr;
+	u8 tx_path_en;
+	u8 path_map;
+	u8 max_mcs;
+	bool stbc;
+};
+
 struct rtw89_agc_gaincode_set {
 	u8 lna_idx;
 	u8 tia_idx;
@@ -6418,6 +6441,7 @@ struct rtw89_dev {
 		struct rtw89_pkt_stat cur_pkt_stat;
 		struct rtw89_pkt_stat last_pkt_stat;
 		struct rtw89_pmac_stat_info pmac_stat;
+		struct rtw89_tx_stat_info tx_stat;
 	} bbs[RTW89_PHY_NUM];
 
 	struct wiphy_delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index d8a183bfc6da..d9a5bbae11f2 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3926,6 +3926,7 @@ static int rtw89_sta_link_info_get_iter(struct rtw89_dev *rtwdev,
 		       rtw89_rate_info_bw_to_mhz(rate->bw));
 	p += scnprintf(p, end - p, " (hw_rate=0x%x)",
 		       rtwsta_link->ra_report.hw_rate);
+	p += scnprintf(p, end - p, " PER:%d", rtwsta_link->ra_report.retry_ratio);
 	p += scnprintf(p, end - p, " ==> agg_wait=%d (%d)\n",
 		       rtwsta_link->max_agg_wait,
 		       max_rc_amsdu_len);
@@ -4138,11 +4139,179 @@ static ssize_t rtw89_debug_priv_phy_info_get(struct rtw89_dev *rtwdev,
 	return p - buf;
 }
 
+static const char *const lcck[] = {"L_CCK"};
+static const char *const scck[] = {"S_CCK"};
+static const char *const ht_gf[] = {"HT_GF"};
+static const char *const vht_mu[] = {"VHT_MU"};
+static const char *const he_er_su[] = {"HE_ER_SU"};
+static const char *const eht_tb[] = {"EHT_TB"};
+static const char *const legacy_ax[] = {"LEGACY"};
+static const char *const ht_ax[] = {"HT"};
+static const char *const vht_su_ax[] = {"VHT_SU"};
+static const char *const he_su_ax[] = {"HE_SU"};
+static const char *const he_mu_ax[] = {"HE_MU"};
+static const char *const he_tb_ax[] = {"HE_TB"};
+static const char *const legacy_be[] = {
+	"LEGACY", "LEGACY_DUP", "LEGACY_DUP_PUNC"
+};
+
+static const char *const ht_be[] = {
+	"HT_MF", "HT_SND_NDP"
+};
+
+static const char *const vht_su_be[] = {
+	"VHT_SU", "VHT_SND_NDP"
+};
+
+static const char *const he_su_be[] = {
+	"HE_SU", "HE_SND_NDP", "HE_SND_NDP_PUNC", "HE_RANG_NDP"
+};
+
+static const char *const he_mu_be[] = {
+	"HE_MU_RU", "HE_MU_MU", "HE_MU_RU_PUNC"
+};
+
+static const char *const he_tb_be[] = {
+	"HE_TB", "HE_TB_FB_NDP", "HE_MU_RANG_NDP"
+};
+
+static const char *const eht_mu[] = {
+	"EHT_MU_SU", "EHT_MU_ER", "EHT_MU_RU", "EHT_MU_MU",
+	"EHT_MU_SND_NDP", "EHT_MU_SU_PUNC", "EHT_MU_RU_PUNC",
+	"EHT_SND_NDP_PUNC", "EHT_MU_MU_PUNC"
+};
+
+#define PPDU_SAME(ppdu) \
+	{.str = {ppdu, ppdu}, \
+	 .cnt = {ARRAY_SIZE(ppdu), ARRAY_SIZE(ppdu)} }
+#define PPDU_VARIANT(ppdu) \
+	{.str = {ppdu##_ax, ppdu##_be}, \
+	 .cnt = {ARRAY_SIZE(ppdu##_ax), ARRAY_SIZE(ppdu##_be)} }
+#define PPDU_GEV1(ppdu) \
+	{.str = {NULL, ppdu}, \
+	 .cnt = {0, ARRAY_SIZE(ppdu)} }
+
+static const struct rtw89_ppdu_info {
+	const char *const *str[RTW89_CHIP_GEN_NUM];
+	u8 cnt[RTW89_CHIP_GEN_NUM];
+} rtw89_ppdu_infos[] = {
+	[0] = PPDU_SAME(lcck),
+	[1] = PPDU_SAME(scck),
+	[2] = PPDU_VARIANT(legacy),
+	[3] = PPDU_VARIANT(ht),
+	[4] = PPDU_SAME(ht_gf),
+	[5] = PPDU_VARIANT(vht_su),
+	[6] = PPDU_SAME(vht_mu),
+	[7] = PPDU_VARIANT(he_su),
+	[8] = PPDU_SAME(he_er_su),
+	[9] = PPDU_VARIANT(he_mu),
+	[10] = PPDU_VARIANT(he_tb),
+	[11] = PPDU_GEV1(eht_mu),
+	[12] = PPDU_GEV1(eht_tb),
+};
+
+#define TXCMD_SAME(txcmd) {txcmd, txcmd}
+#define TXCMD_DIFF(txcmd, txcmd_v1) {txcmd, txcmd_v1}
+#define TXCMD_GEV1(txcmd) {"RSVD", txcmd}
+
+static const struct rtw89_txcmd_info {
+	const char *str[RTW89_CHIP_GEN_NUM];
+} rtw89_txcmd_infos[] = {
+	[0] = {TXCMD_SAME("DATA")},
+	[1] = {TXCMD_SAME("BCN")},
+	[2] = {TXCMD_SAME("HT_NDPA")},
+	[3] = {TXCMD_SAME("VHT_NDPA")},
+	[4] = {TXCMD_SAME("HE_NDPA")},
+	[5] = {TXCMD_GEV1("EHT_NDPA")},
+	[6] = {TXCMD_GEV1("11MC_FTM")},
+	[7] = {TXCMD_GEV1("11MC_FTM_ACK")},
+	[8] = {TXCMD_SAME("RTS")},
+	[9] = {TXCMD_SAME("CTS2S")},
+	[10] = {TXCMD_SAME("CF_END")},
+	[11] = {TXCMD_SAME("CMP_BAR")},
+	[12] = {TXCMD_SAME("BFRP")},
+	[13] = {TXCMD_SAME("NDP")},
+	[14] = {TXCMD_SAME("QoS_NULL")},
+	[15] = {TXCMD_GEV1("CTS_2_MURTS")},
+	[16] = {TXCMD_SAME("ACK")},
+	[17] = {TXCMD_SAME("CTS")},
+	[18] = {TXCMD_SAME("CMP_BA")},
+	[19] = {TXCMD_SAME("MSTA_BA")},
+	[20] = {TXCMD_SAME("HT_CSI")},
+	[21] = {TXCMD_SAME("VHT_CSI")},
+	[22] = {TXCMD_SAME("HE_CSI")},
+	[23] = {TXCMD_GEV1("EHT_CSI")},
+	[24] = {TXCMD_GEV1("NTB_I2R_NDPA")},
+	[25] = {TXCMD_GEV1("NTB_I2R_NDP")},
+	[26] = {TXCMD_GEV1("NTB_I2R_LMR")},
+	[27] = {TXCMD_GEV1("NTB_I2R_NDP")},
+	[28] = {TXCMD_GEV1("NTB_I2R_LMR")},
+	[29] = {TXCMD_GEV1("NTB_R2I_RANG_NDPA")},
+	[30] = {TXCMD_GEV1("NTB_R2I_NDP")},
+	[31] = {TXCMD_DIFF("TB_PPDU", "NTB_R2I_LMR")},
+	[32] = {TXCMD_SAME("TRIG_BASIC")},
+	[33] = {TXCMD_SAME("TRIG_BFRP")},
+	[34] = {TXCMD_SAME("TRIG_MUBAR")},
+	[35] = {TXCMD_SAME("TRIG_MURTS")},
+	[36] = {TXCMD_SAME("TRIG_BSRP")},
+	[37] = {TXCMD_SAME("TRIG_BQRP")},
+	[38] = {TXCMD_SAME("TRIG_NFRP")},
+	[39] = {TXCMD_GEV1("TRIG_BASIC_DATA")},
+	[40] = {TXCMD_GEV1("TRIG_RANG_POLL")},
+	[41] = {TXCMD_GEV1("TRIG_RANG_SNR")},
+	[42] = {TXCMD_GEV1("TRIG_RANG_LMR")},
+	[48] = {TXCMD_DIFF("TRIG_BASIC_DATA", "TRIG_TB_CSI")},
+	[49] = {TXCMD_GEV1("TRIG_TB_CBA")},
+	[50] = {TXCMD_GEV1("TRIG_TB_MBA")},
+	[51] = {TXCMD_GEV1("TRIG_TB_BSR")},
+	[52] = {TXCMD_GEV1("TRIG_TB_BQR")},
+	[53] = {TXCMD_GEV1("TRIG_TB_ACK")},
+	[54] = {TXCMD_GEV1("TRIG_TB_PPDU")},
+	[55] = {TXCMD_GEV1("TRIG_TB_I2R_CTS2S")},
+	[56] = {TXCMD_GEV1("TRIG_TB_I2R_NDP")},
+	[57] = {TXCMD_GEV1("TRIG_TB_I2R_LMR")},
+};
+
+static const char *rtw89_ppdu_str(struct rtw89_dev *rtwdev, u8 type, u8 subtype)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_ppdu_info *ppdu_info;
+
+	if (type > ARRAY_SIZE(rtw89_ppdu_infos))
+		return "RSVD";
+
+	ppdu_info = &rtw89_ppdu_infos[type];
+
+	if (!ppdu_info->str[chip->chip_gen] ||
+	    subtype >= ppdu_info->cnt[chip->chip_gen])
+		return "RSVD";
+
+	return ppdu_info->str[chip->chip_gen][subtype];
+}
+
+static const char *rtw89_txcmd_str(struct rtw89_dev *rtwdev, u8 txcmd)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (txcmd < ARRAY_SIZE(rtw89_txcmd_infos))
+		return rtw89_txcmd_infos[txcmd].str[chip->chip_gen] ?: "RSVD";
+
+	return "RSVD";
+}
+
 static int rtw89_get_bb_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
 			     char *buf, size_t bufsz)
 {
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const struct rtw89_physts_regs *physts = phy->physts;
 	struct rtw89_pmac_stat_info *pmac = &bb->pmac_stat;
+	struct rtw89_tx_stat_info *tx_stat = &bb->tx_stat;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	char *p = buf, *end = buf + bufsz;
+	u8 factor = chip->txpwr_factor_rf;
+	u32 reg_nr;
+	s32 val;
+	int i;
 
 	p += scnprintf(p, end - p, "\n[PHY %u]\n", bb->phy_idx);
 
@@ -4178,6 +4347,43 @@ static int rtw89_get_bb_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
 		       pmac->cnt_sb_search_fail);
 	p += scnprintf(p, end - p, "AMPDU miss: %d\n\n", pmac->cnt_ampdu_miss);
 
+	p += scnprintf(p, end - p, "== TX General\n");
+	p += scnprintf(p, end - p, "%s %s\n",
+		       rtw89_ppdu_str(rtwdev, tx_stat->type, tx_stat->subtype),
+		       rtw89_txcmd_str(rtwdev, tx_stat->txcmd));
+
+	p += scnprintf(p, end - p, "BW: %d, TX_SC: %d, TX_PATH_EN: %d, PATH_MAP: 0x%x\n",
+		       20 << tx_stat->bw, tx_stat->txsc,
+		       tx_stat->tx_path_en, tx_stat->path_map);
+
+	val = sign_extend32(tx_stat->tmac_txpwr, 8);
+	p += scnprintf(p, end - p, "TXPWR TMAC: %d,", val >> factor);
+
+	reg_nr = min(chip->rf_path_num, ARRAY_SIZE(tx_stat->txpwr));
+	for (i = 0; i < reg_nr; i++) {
+		val = sign_extend32(tx_stat->txpwr[i], 8);
+		p += scnprintf(p, end - p, " P%d: %d%s",
+			       i, val >> factor, (i < reg_nr - 1) ? "," : "");
+	}
+	p += scnprintf(p, end - p, " dBm\n");
+
+	p += scnprintf(p, end - p, "MCS: %d, STBC: %d\n",
+		       tx_stat->max_mcs, tx_stat->stbc);
+
+	p += scnprintf(p, end - p, "Info: [");
+	reg_nr = min(physts->tx_info.reg_nr, ARRAY_SIZE(tx_stat->info));
+	for (i = 0; i < reg_nr; i++)
+		p += scnprintf(p, end - p, "0x%08x%s",
+			       tx_stat->info[i], (i < reg_nr - 1) ? ", " : "");
+	p += scnprintf(p, end - p, "]\n");
+
+	p += scnprintf(p, end - p, "Common ctrl: [");
+	reg_nr = min(physts->tx_common_ctrl.reg_nr, ARRAY_SIZE(tx_stat->common_ctrl));
+	for (i = 0; i < reg_nr; i++)
+		p += scnprintf(p, end - p, "0x%08x%s",
+			       tx_stat->common_ctrl[i], (i < reg_nr - 1) ? ", " : "");
+	p += scnprintf(p, end - p, "]\n\n");
+
 	p += scnprintf(p, end - p, "== RSSI/RX Rate\n");
 	p += rtw89_get_rx_pkt_stat(rtwdev, bb, p, end - p);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 80d358d80a38..cf7382e36b75 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3239,6 +3239,7 @@ static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 	bool format_v1 = chip->chip_gen == RTW89_CHIP_BE;
 	u8 mode, rate, bw, giltf, mac_id;
 	u16 legacy_bitrate, amsdu_len;
+	u8 retry_ratio = 0;
 	bool valid;
 	u8 mcs = 0;
 	u8 t;
@@ -3259,6 +3260,7 @@ static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 		bw |= u8_encode_bits(t, BIT(2));
 		t = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_MD_SEL_B2);
 		mode |= u8_encode_bits(t, BIT(2));
+		retry_ratio = le32_get_bits(c2h->w2, RTW89_C2H_RA_RPT_W2_RETRY_RATIO);
 	}
 
 	if (mode == RTW89_RA_RPT_MODE_LEGACY) {
@@ -3334,6 +3336,7 @@ static void __rtw89_phy_c2h_ra_rpt_iter(struct rtw89_sta_link *rtwsta_link,
 			     u16_encode_bits(rate, RTW89_HW_RATE_V1_MASK_VAL) :
 			     u16_encode_bits(mode, RTW89_HW_RATE_MASK_MOD) |
 			     u16_encode_bits(rate, RTW89_HW_RATE_MASK_VAL);
+	ra_report->retry_ratio = retry_ratio;
 	ra_report->might_fallback_legacy = mcs <= 2;
 
 	amsdu_len = get_max_amsdu_len(rtwdev, ra_report);
@@ -6034,6 +6037,71 @@ static void rtw89_phy_pmac_stat_update(struct rtw89_dev *rtwdev,
 	rtw89_phy_pmac_stat_reset(rtwdev, bb, cck);
 }
 
+static void rtw89_phy_tx_stat_update(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const struct rtw89_physts_regs *physts = phy->physts;
+	struct rtw89_tx_stat_info *tx_stat = &bb->tx_stat;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 reg_nr;
+	u32 val;
+	u32 i;
+
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF &&
+	    bb->phy_idx != RTW89_PHY_0)
+		val = 1;
+	else
+		val = 0;
+
+	rtw89_phy_write32_mask(rtwdev, physts->mac_phy_intf_sel.addr,
+			       physts->mac_phy_intf_sel.mask, val);
+
+	reg_nr = min(physts->tx_info.reg_nr, ARRAY_SIZE(tx_stat->info));
+	for (i = 0; i < reg_nr; i++)
+		tx_stat->info[i] = rtw89_phy_read32(rtwdev, physts->tx_info.regs[i]);
+
+	reg_nr = min(physts->tx_common_ctrl.reg_nr, ARRAY_SIZE(tx_stat->common_ctrl));
+	for (i = 0; i < reg_nr; i++)
+		tx_stat->common_ctrl[i] =
+			rtw89_phy_read32(rtwdev, physts->tx_common_ctrl.regs[i]);
+
+	reg_nr = min(chip->rf_path_num, ARRAY_SIZE(tx_stat->txpwr));
+	for (i = 0; i < reg_nr; i++)
+		tx_stat->txpwr[i] = rtw89_phy_read32_mask(rtwdev, physts->txpwr[i].addr,
+							  physts->txpwr[i].mask);
+
+	tx_stat->type = u32_get_bits(tx_stat->info[0], TX_STATUS_TYPE);
+
+	if (chip->chip_gen == RTW89_CHIP_AX) {
+		tx_stat->tx_path_en = u32_get_bits(tx_stat->info[0], TX_STATUS_TX_PATH_EN);
+		tx_stat->path_map = u32_get_bits(tx_stat->info[0], TX_STATUS_PATH_MAP);
+		tx_stat->txcmd = u32_get_bits(tx_stat->info[0], TX_STATUS_TXCMD);
+		tx_stat->txsc = u32_get_bits(tx_stat->info[1], TX_STATUS_TXSC);
+		tx_stat->bw = u32_get_bits(tx_stat->info[1], TX_STATUS_BW);
+		tx_stat->tmac_txpwr = u32_get_bits(tx_stat->info[1], TX_STATUS_TMAC_TXPWR);
+
+		if (!(chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)))
+			tx_stat->max_mcs = u32_get_bits(tx_stat->info[3], TX_STATUS_MAX_MCS);
+	} else {
+		tx_stat->type = u32_get_bits(tx_stat->info[0], TX_STATUS_TYPE);
+		tx_stat->subtype = u32_get_bits(tx_stat->info[0], TX_STATUS_SUBTYPE);
+
+		if (chip->chip_id == RTL8922A)
+			tx_stat->txcmd = u32_get_bits(tx_stat->info[0], TX_STATUS_TXCMD_V1);
+		else
+			tx_stat->txcmd = u32_get_bits(tx_stat->info[0], TX_STATUS_TXCMD_V2);
+
+		tx_stat->txsc = u32_get_bits(tx_stat->info[0], TX_STATUS_TXSC_V1);
+		tx_stat->bw = u32_get_bits(tx_stat->info[1], TX_STATUS_BW_V1);
+		tx_stat->tmac_txpwr = u32_get_bits(tx_stat->info[1], TX_STATUS_TMAC_TXPWR_V1);
+		tx_stat->tx_path_en = u32_get_bits(tx_stat->info[2], TX_STATUS_TX_PATH_EN_V1);
+		tx_stat->path_map = u32_get_bits(tx_stat->info[2], TX_STATUS_PATH_MAP_V1);
+		tx_stat->max_mcs = u32_get_bits(tx_stat->info[4], TX_STATUS_MAX_MCS_V1);
+	}
+
+	tx_stat->stbc = !!(tx_stat->common_ctrl[0] & TX_STATUS_STBC);
+}
+
 static void rtw89_phy_trigger_tx_count(struct rtw89_dev *rtwdev)
 {
 	if (RTW89_CHK_FW_FEATURE(TX_HISTORY_V1, &rtwdev->fw))
@@ -6051,8 +6119,10 @@ static void rtw89_phy_stat_update(struct rtw89_dev *rtwdev)
 
 	rtw89_phy_trigger_tx_count(rtwdev);
 
-	rtw89_for_each_active_bb(rtwdev, bb)
+	rtw89_for_each_active_bb(rtwdev, bb) {
 		rtw89_phy_pmac_stat_update(rtwdev, bb);
+		rtw89_phy_tx_stat_update(rtwdev, bb);
+	}
 }
 
 void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
@@ -8702,10 +8772,31 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_ax = {
 	.nhm_pwr_method_msk = B_NHM_PWDB_METHOD_MSK,
 };
 
+static const u32 rtw89_txinfo_reg_ax[] = {
+	R_TX_INFO_0_0_COMB,
+	R_TX_INFO_0_1_COMB,
+	R_TX_INFO_1_0_COMB,
+	R_TX_INFO_1_1_COMB
+};
+
+static const u32 rtw89_tx_common_ctrl_reg_ax[] = {
+	R_TX_COMMON_CTRL_0_0_COMB,
+	R_TX_COMMON_CTRL_0_1_COMB
+};
+
+static const struct rtw89_reg_def rtw89_txpwr_ax[] = {
+	{.addr = R_PATH0_TXPWR, .mask = B_PATH0_TXPWR},
+	{.addr = R_PATH1_TXPWR, .mask = B_PATH1_TXPWR}
+};
+
 static const struct rtw89_physts_regs rtw89_physts_regs_ax = {
 	.setting_addr = R_PLCP_HISTOGRAM,
 	.dis_trigger_fail_mask = B_STS_DIS_TRIG_BY_FAIL,
 	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
+	.mac_phy_intf_sel = {R_INTF_R_INTF_RPT_SEL, B_INTF_R_INTF_RPT_SEL},
+	.txpwr = rtw89_txpwr_ax,
+	.tx_info = RTW89_REGS_DEF(rtw89_txinfo_reg_ax),
+	.tx_common_ctrl = RTW89_REGS_DEF(rtw89_tx_common_ctrl_reg_ax),
 };
 
 static const struct rtw89_cfo_regs rtw89_cfo_regs_ax = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index c6761cedc5a5..830cabefca39 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -57,6 +57,25 @@
 #define RA_MASK_EHT_4SS_MCS0_11	GENMASK_ULL(62, 60)
 #define RA_MASK_EHT_RATES	GENMASK_ULL(62, 12)
 
+#define TX_STATUS_TYPE GENMASK(3, 0)
+#define TX_STATUS_SUBTYPE GENMASK(7, 4)
+#define TX_STATUS_TXCMD GENMASK(29, 24)
+#define TX_STATUS_TXCMD_V1 GENMASK(13, 8)
+#define TX_STATUS_TXCMD_V2 GENMASK(15, 8)
+#define TX_STATUS_TXSC GENMASK(7, 4)
+#define TX_STATUS_TXSC_V1 GENMASK(27, 24)
+#define TX_STATUS_BW GENMASK(17, 16)
+#define TX_STATUS_BW_V1 GENMASK(6, 4)
+#define TX_STATUS_TMAC_TXPWR GENMASK(26, 18)
+#define TX_STATUS_TMAC_TXPWR_V1 GENMASK(16, 8)
+#define TX_STATUS_TX_PATH_EN GENMASK(15, 12)
+#define TX_STATUS_TX_PATH_EN_V1 GENMASK(7, 4)
+#define TX_STATUS_PATH_MAP GENMASK(23, 16)
+#define TX_STATUS_PATH_MAP_V1 GENMASK(15, 8)
+#define TX_STATUS_MAX_MCS GENMASK(7, 4)
+#define TX_STATUS_MAX_MCS_V1 GENMASK(3, 0)
+#define TX_STATUS_STBC BIT(0)
+
 #define CFO_TRK_ENABLE_TH (2 << 2)
 #define CFO_TRK_STOP_TH_4 (30 << 2)
 #define CFO_TRK_STOP_TH_3 (20 << 2)
@@ -458,6 +477,10 @@ struct rtw89_physts_regs {
 	u32 setting_addr;
 	u32 dis_trigger_fail_mask;
 	u32 dis_trigger_brk_mask;
+	struct rtw89_reg_def mac_phy_intf_sel;
+	const struct rtw89_reg_def *txpwr;
+	struct rtw89_regs_def tx_info;
+	struct rtw89_regs_def tx_common_ctrl;
 };
 
 struct rtw89_cfo_regs {
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 25f1b068daa2..9caddd19384c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -135,16 +135,62 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_be_v1 = {
 	.ifs_total_mask = B_IFS_TOTAL_BE4,
 };
 
+static const u32 rtw89_tx_info_reg_be[] = {
+	R_TX_INFO_0_0_COMB_V1,
+	R_TX_INFO_0_1_COMB_V1,
+	R_TX_INFO_1_0_COMB_V1,
+	R_TX_INFO_1_1_COMB_V1,
+	R_TX_INFO_2_0_COMB_V1,
+	R_TX_INFO_2_1_COMB_V1
+};
+
+static const u32 rtw89_tx_common_ctrl_reg_be[] = {
+	R_TX_COMMON_CTRL_0_0_COMB_V1,
+	R_TX_COMMON_CTRL_0_1_COMB_V1
+};
+
+static const struct rtw89_reg_def rtw89_txpwr_be[] = {
+	{.addr = R_PATH0_TXPWR_V1, .mask = B_PATH0_TXPWR},
+	{.addr = R_PATH1_TXPWR_V1, .mask = B_PATH1_TXPWR}
+};
+
 static const struct rtw89_physts_regs rtw89_physts_regs_be = {
 	.setting_addr = R_PLCP_HISTOGRAM,
 	.dis_trigger_fail_mask = B_STS_DIS_TRIG_BY_FAIL,
 	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
+	.mac_phy_intf_sel = {R_INTF_R_INTF_RPT_SEL, B_INTF_R_INTF_RPT_SEL},
+	.txpwr = rtw89_txpwr_be,
+	.tx_info = RTW89_REGS_DEF(rtw89_tx_info_reg_be),
+	.tx_common_ctrl = RTW89_REGS_DEF(rtw89_tx_common_ctrl_reg_be),
+};
+
+static const u32 rtw89_tx_info_reg_be_v1[] = {
+	R_TX_INFO_0_0_COMB_BE4,
+	R_TX_INFO_0_1_COMB_BE4,
+	R_TX_INFO_1_0_COMB_BE4,
+	R_TX_INFO_1_1_COMB_BE4,
+	R_TX_INFO_2_0_COMB_BE4,
+	R_TX_INFO_2_1_COMB_BE4
+};
+
+static const u32 rtw89_tx_common_ctrl_reg_be_v1[] = {
+	R_TX_COMMON_CTRL_0_0_COMB_BE4,
+	R_TX_COMMON_CTRL_0_1_COMB_BE4
+};
+
+static const struct rtw89_reg_def rtw89_txpwr_be_v1[] = {
+	{.addr = R_PATH0_TXPWR_BE4, .mask = B_PATH0_TXPWR},
+	{.addr = R_PATH1_TXPWR_BE4, .mask = B_PATH1_TXPWR}
 };
 
 static const struct rtw89_physts_regs rtw89_physts_regs_be_v1 = {
 	.setting_addr = R_PLCP_HISTOGRAM_BE_V1,
 	.dis_trigger_fail_mask = B_STS_DIS_TRIG_BY_FAIL,
 	.dis_trigger_brk_mask = B_STS_DIS_TRIG_BY_BRK,
+	.mac_phy_intf_sel = {R_INTF_R_INTF_RPT_SEL_BE4, B_INTF_R_INTF_RPT_SEL},
+	.txpwr = rtw89_txpwr_be_v1,
+	.tx_info = RTW89_REGS_DEF(rtw89_tx_info_reg_be_v1),
+	.tx_common_ctrl = RTW89_REGS_DEF(rtw89_tx_common_ctrl_reg_be_v1),
 };
 
 static const struct rtw89_cfo_regs rtw89_cfo_regs_be = {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c054a402bd20..f5151e1ad58d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8741,6 +8741,9 @@
 #define B_DFS_FFT_EN BIT(0)
 #define R_CHINFO_DATA 0x00C0
 #define B_CHINFO_DATA_BITMAP GENMASK(22, 0)
+#define R_INTF_R_INTF_RPT_SEL 0x0200
+#define R_INTF_R_INTF_RPT_SEL_BE4 0x20200
+#define B_INTF_R_INTF_RPT_SEL BIT(12)
 #define R_ANAPAR_PW15 0x030C
 #define B_ANAPAR_PW15 GENMASK(31, 24)
 #define B_ANAPAR_PW15_H GENMASK(27, 24)
@@ -9042,6 +9045,20 @@
 #define B_SWSI_W_BUSY_V1 BIT(24)
 #define B_SWSI_R_BUSY_V1 BIT(25)
 #define B_SWSI_R_DATA_DONE_V1 BIT(26)
+#define R_TX_INFO_0_0_COMB 0x1800
+#define R_TX_INFO_0_0_COMB_V1 0x3E00
+#define R_TX_INFO_0_1_COMB 0x1804
+#define R_TX_INFO_0_1_COMB_V1 0x3E04
+#define R_TX_INFO_1_0_COMB 0x1808
+#define R_TX_INFO_1_0_COMB_V1 0x3E08
+#define R_TX_INFO_1_1_COMB 0x180C
+#define R_TX_INFO_1_1_COMB_V1 0x3E0C
+#define R_TX_INFO_2_0_COMB_V1 0x3E10
+#define R_TX_INFO_2_1_COMB_V1 0x3E14
+#define R_TX_COMMON_CTRL_0_0_COMB 0x1810
+#define R_TX_COMMON_CTRL_0_0_COMB_V1 0x3E20
+#define R_TX_COMMON_CTRL_0_1_COMB 0x1814
+#define R_TX_COMMON_CTRL_0_1_COMB_V1 0x3E24
 #define R_CNT_LSIG_BRK_S_TH 0x1A00
 #define R_CNT_LSIG_BRK_S_TH_V1 0x0E00
 #define R_CNT_LSIG_BRK_S_TH_BE4 0x20E00
@@ -9184,6 +9201,8 @@
 #define B_TXAGC_BB GENMASK(31, 24)
 #define B_TXAGC_RF GENMASK(5, 0)
 #define R_PATH0_TXPWR 0x1C78
+#define R_PATH0_TXPWR_V1 0xEE0C
+#define R_PATH0_TXPWR_BE4 0x2F90C
 #define B_PATH0_TXPWR GENMASK(8, 0)
 #define R_S0_ADDCK 0x1E00
 #define B_S0_ADDCK_I GENMASK(9, 0)
@@ -9328,6 +9347,8 @@
 #define B_TXAGC_BB_S1_OFT GENMASK(31, 16)
 #define B_TXAGC_BB_S1 GENMASK(31, 24)
 #define R_PATH1_TXPWR 0x3C78
+#define R_PATH1_TXPWR_V1 0xEF0C
+#define R_PATH1_TXPWR_BE4 0x2FA0C
 #define B_PATH1_TXPWR GENMASK(8, 0)
 #define R_S1_ADDCK 0x3E00
 #define B_S1_ADDCK_I GENMASK(9, 0)
@@ -10813,6 +10834,14 @@
 #define B_SW_SI_R_BUSY_BE4 BIT(25)
 #define B_SW_SI_READ_DATA_DONE_BE4 BIT(26)
 
+#define R_TX_INFO_0_0_COMB_BE4 0x2DF00
+#define R_TX_INFO_0_1_COMB_BE4 0x2DF04
+#define R_TX_INFO_1_0_COMB_BE4 0x2DF08
+#define R_TX_INFO_1_1_COMB_BE4 0x2DF0C
+#define R_TX_INFO_2_0_COMB_BE4 0x2DF10
+#define R_TX_INFO_2_1_COMB_BE4 0x2DF14
+#define R_TX_COMMON_CTRL_0_0_COMB_BE4 0x2DF20
+#define R_TX_COMMON_CTRL_0_1_COMB_BE4 0x2DF24
 #define R_RX_PATH0_TBL0_BE4 0x2E028
 #define R_RX_PATH1_TBL0_BE4 0x2E128
 
-- 
2.25.1


