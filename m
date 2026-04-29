Return-Path: <linux-wireless+bounces-35623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AcqEFgH8mkimwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:27:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 028EF494CBF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED57F3014FCE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF62C159A;
	Wed, 29 Apr 2026 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jJqstlUB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279963FE652
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469213; cv=none; b=o144noSxH/pJPkAYInxOHGTXYS73b1D1hz6WpqWZJUjPAH1Uc5jHVnI5RjEg+HlTty/yJnFM4Ye6tZgUUn5jDhjCVFUPjfQqKhVpRarULlZ35cjMTZ67V3g5ULFMXHk+xYkx+JCd8Ag8NgSqZ+4N12JK6VbLkFmcHMsJq0Uklr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469213; c=relaxed/simple;
	bh=HZP2rOA9VSCyVehoOIMpGJDzd1NwmKkeBbBQtXDWJ18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zy6ZVKgfo5mJVLRY//wBv87PaPT9zpsen5M23Khhx0isjqQ2m3cxD5HBv8+BEppraOTrI2UnjXgtdYydwGQHCCqncWAsH3f2M0fY5oDEPi8bpL+9bs7CilwB/tnD02xZYfwbVj0BVa9jauww7NEWlEQf45xLSARp/ElNQsXciyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jJqstlUB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDQlLaA1223064, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469207; bh=SAqGUsNxPGIgQ6NjNlGuo93wAwHhB36mkhWOdPJ+F10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jJqstlUBKYZ6fLnHHZ1Yt5UO+fcoOJ6ACjkYyk60I0o5ivh5CkkCf3yRNMl417ba1
	 wbaWSvg400agyiJ3Yudi29BqwMwNrPPv6eV7u488i4M6NkOQCPDM6uUGShNpeZ5hoi
	 tgczToWvJlIiGm1iVfz+ZKZULqVjhe35ZPpMGtt2d5e/Z3wtV1EWxn5P9pSX3Lpyo7
	 +2kQ0NI08uGRESeXRii+UZj6g8GQM+QfdrpT7d4tCvB6E9/PN6CkxtO7AGhsVO7u97
	 8RrrfzpRLyOnQx4ZZ96T+C8zyPk1bVdXHJmc8bkgz4ahLXr5mg4ldNayVeHpb7TDCP
	 Q0Sn7yGxMjR+g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDQlLaA1223064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:26:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:47 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:26:46 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:26:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 4/7] wifi: rtw89: debug: add PMAC counter in bb_info
Date: Wed, 29 Apr 2026 21:26:22 +0800
Message-ID: <20260429132625.1659182-5-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 028EF494CBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35623-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Kuan-Chung Chen <damon.chen@realtek.com>

PMAC (Pseudo MAC) is a circuit within the baseband that can report
various packet-related counters through registers, such as TX ON,
TX EN, CCA, FA, CRC, etc. The driver periodically collects per
PHY PMAC counters in track_work and exposes them through the
bb_info debugfs for easier debugging.

The output of PMAC counter:

  == PMAC
  TX [CCK_TXEN, CCK_TXON, OFDM_TXEN, OFDM_TXON]: [0, 0, 17, 17]
  CRC  [CCK, OFDM, HT, VHT, HE, EHT, ALL, MPDU]
   ok: [0, 301, 0, 0, 5, 0, 306, 5]
  err: [0, 4, 0, 0, 0, 0, 4, 0]
  CCA [CCK, OFDM]: [0, 353]
  FA  [CCK, OFDM]: [0, 39]
  CCA spoofing [CCK, OFDM]: [0, 0]
  CCK SFD: 0, SIG_GG: 0
  OFDM Parity: 4, Rate: 2, LSIG_BRK_S: 0, LSIG_BRK_L: 7, SBD: 5
  AMPDU miss: 0

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  87 ++++++++
 drivers/net/wireless/realtek/rtw89/debug.c    |  33 +++
 drivers/net/wireless/realtek/rtw89/phy.c      | 195 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 127 ++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  49 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  49 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  49 +++++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  49 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  49 +++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  49 +++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  49 +++++
 11 files changed, 785 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c4396f0100be..7f869a339ee6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4487,6 +4487,54 @@ struct rtw89_edcca_regs {
 	u32 tx_collision_t2r_st_mask;
 };
 
+struct rtw89_pmac_regs {
+	struct rtw89_reg_def cck_txon;
+	struct rtw89_reg_def cck_txen;
+	struct rtw89_reg_def cck_cca;
+	struct rtw89_reg_def cck_sfd_gg;
+	struct rtw89_reg_def cck_sig_gg;
+	struct rtw89_reg_def cck_spoofing;
+	struct rtw89_reg_def cck_brk;
+	struct rtw89_reg_def brk;
+	struct rtw89_reg_def brk_option;
+	struct rtw89_reg_def search_fail;
+	struct rtw89_reg_def lsig_brk_s_th;
+	struct rtw89_reg_def lsig_brk_l_th;
+	struct rtw89_reg_def rxl_err_parity;
+	struct rtw89_reg_def rxl_err_rate;
+	struct rtw89_reg_def ofdm_cca;
+	struct rtw89_reg_def cca_spoofing;
+	struct rtw89_reg_def ampdu_miss;
+	struct rtw89_reg_def r1b_rx_rpt_rst;
+	struct rtw89_reg_def r1b_rr_sel;
+	struct rtw89_reg_def enable_all_cnt;
+	struct rtw89_reg_def rst_all_cnt;
+	u32 cck_crc32;
+	u32 cck_crc32_ok_mask;
+	u32 cck_crc32_fail_mask;
+	u32 ofdm_txon;
+	u32 ofdm_txon_mask;
+	u32 ofdm_txen_mask;
+	u32 l_crc;
+	u32 l_crc_ok_mask;
+	u32 l_crc_err_mask;
+	u32 ht_crc;
+	u32 ht_crc_ok_mask;
+	u32 ht_crc_err_mask;
+	u32 vht_crc;
+	u32 vht_crc_ok_mask;
+	u32 vht_crc_err_mask;
+	u32 he_crc;
+	u32 he_crc_ok_mask;
+	u32 he_crc_err_mask;
+	u32 eht_crc;
+	u32 eht_crc_ok_mask;
+	u32 eht_crc_err_mask;
+	u32 ampdu_crc;
+	u32 ampdu_crc_ok_mask;
+	u32 ampdu_crc_err_mask;
+};
+
 struct rtw89_phy_ul_tb_info {
 	bool dyn_tb_tri_en;
 	u8 def_if_bandedge;
@@ -4682,6 +4730,7 @@ struct rtw89_chip_info {
 	struct rtw89_sb_regs btc_sb;
 	u32 dma_ch_mask;
 	const struct rtw89_edcca_regs *edcca_regs;
+	const struct rtw89_pmac_regs *pmac_regs;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const struct rtw89_xtal_info *xtal_info;
 	unsigned long default_quirks; /* bitmap of rtw89_quirks */
@@ -5505,6 +5554,43 @@ struct rtw89_phy_ch_info {
 	u8 is_noisy;
 };
 
+struct rtw89_pmac_stat_info {
+	u32 cck_phy_txon;
+	u32 cck_mac_txen;
+	u32 ofdm_mac_txen;
+	u32 ofdm_phy_txon;
+	u32 cnt_ofdm_cca;
+	u32 cnt_cck_cca;
+	u32 cnt_cck_spoofing;
+	u32 cnt_ofdm_spoofing;
+	u32 cnt_ampdu_miss;
+	u32 cnt_ampdu_crc_error;
+	u32 cnt_ampdu_crc_ok;
+	u32 cnt_cck_crc32_error;
+	u32 cnt_cck_crc32_ok;
+	u32 cnt_ofdm_crc32_error;
+	u32 cnt_ofdm_crc32_ok;
+	u32 cnt_ht_crc32_error;
+	u32 cnt_ht_crc32_ok;
+	u32 cnt_vht_crc32_error;
+	u32 cnt_vht_crc32_ok;
+	u32 cnt_he_crc32_ok;
+	u32 cnt_he_crc32_error;
+	u32 cnt_eht_crc32_ok;
+	u32 cnt_eht_crc32_error;
+	u32 cnt_crc32_error_all;
+	u32 cnt_crc32_ok_all;
+	u32 cnt_sfd_gg;
+	u32 cnt_sig_gg;
+	u32 cnt_cck_fail;
+	u32 cnt_ofdm_fail;
+	u32 cnt_lsig_brk_s_th;
+	u32 cnt_lsig_brk_l_th;
+	u32 cnt_parity_fail;
+	u32 cnt_rate_illegal;
+	u32 cnt_sb_search_fail;
+};
+
 struct rtw89_agc_gaincode_set {
 	u8 lna_idx;
 	u8 tia_idx;
@@ -6331,6 +6417,7 @@ struct rtw89_dev {
 		struct ewma_rssi bcn_rssi;
 		struct rtw89_pkt_stat cur_pkt_stat;
 		struct rtw89_pkt_stat last_pkt_stat;
+		struct rtw89_pmac_stat_info pmac_stat;
 	} bbs[RTW89_PHY_NUM];
 
 	struct wiphy_delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index b82b13645fb0..d8a183bfc6da 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4141,10 +4141,43 @@ static ssize_t rtw89_debug_priv_phy_info_get(struct rtw89_dev *rtwdev,
 static int rtw89_get_bb_stat(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
 			     char *buf, size_t bufsz)
 {
+	struct rtw89_pmac_stat_info *pmac = &bb->pmac_stat;
 	char *p = buf, *end = buf + bufsz;
 
 	p += scnprintf(p, end - p, "\n[PHY %u]\n", bb->phy_idx);
 
+	p += scnprintf(p, end - p, "== PMAC\n");
+	p += scnprintf(p, end - p,
+		       "TX [CCK_TXEN, CCK_TXON, OFDM_TXEN, OFDM_TXON]: [%d, %d, %d, %d]\n",
+		       pmac->cck_mac_txen, pmac->cck_phy_txon,
+		       pmac->ofdm_mac_txen, pmac->ofdm_phy_txon);
+	p += scnprintf(p, end - p, "CRC  [CCK, OFDM, HT, VHT, HE, EHT, ALL, MPDU]\n");
+	p += scnprintf(p, end - p, " ok: [%d, %d, %d, %d, %d, %d, %d, %d]\n",
+		       pmac->cnt_cck_crc32_ok, pmac->cnt_ofdm_crc32_ok,
+		       pmac->cnt_ht_crc32_ok, pmac->cnt_vht_crc32_ok,
+		       pmac->cnt_he_crc32_ok, pmac->cnt_eht_crc32_ok,
+		       pmac->cnt_crc32_ok_all, pmac->cnt_ampdu_crc_ok);
+	p += scnprintf(p, end - p, "err: [%d, %d, %d, %d, %d, %d, %d, %d]\n",
+		       pmac->cnt_cck_crc32_error, pmac->cnt_ofdm_crc32_error,
+		       pmac->cnt_ht_crc32_error, pmac->cnt_vht_crc32_error,
+		       pmac->cnt_he_crc32_error, pmac->cnt_eht_crc32_error,
+		       pmac->cnt_crc32_error_all, pmac->cnt_ampdu_crc_error);
+	p += scnprintf(p, end - p, "CCA [CCK, OFDM]: [%d, %d]\n",
+		       pmac->cnt_cck_cca, pmac->cnt_ofdm_cca);
+	p += scnprintf(p, end - p, "FA  [CCK, OFDM]: [%d, %d]\n",
+		       pmac->cnt_cck_fail, pmac->cnt_ofdm_fail);
+
+	p += scnprintf(p, end - p, "CCA spoofing [CCK, OFDM]: [%d, %d]\n",
+		       pmac->cnt_cck_spoofing, pmac->cnt_ofdm_spoofing);
+	p += scnprintf(p, end - p, "CCK SFD: %d, SIG_GG: %d\n",
+		       pmac->cnt_sfd_gg, pmac->cnt_sig_gg);
+	p += scnprintf(p, end - p,
+		       "OFDM Parity: %d, Rate: %d, LSIG_BRK_S: %d, LSIG_BRK_L: %d, SBD: %d\n",
+		       pmac->cnt_parity_fail, pmac->cnt_rate_illegal,
+		       pmac->cnt_lsig_brk_s_th, pmac->cnt_lsig_brk_l_th,
+		       pmac->cnt_sb_search_fail);
+	p += scnprintf(p, end - p, "AMPDU miss: %d\n\n", pmac->cnt_ampdu_miss);
+
 	p += scnprintf(p, end - p, "== RSSI/RX Rate\n");
 	p += rtw89_get_rx_pkt_stat(rtwdev, bb, p, end - p);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 3124a99d5381..80d358d80a38 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5844,6 +5844,196 @@ static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 	rtwdev->hal.thermal_prot_lv = 0;
 }
 
+static void rtw89_phy_pmac_stat_reset(struct rtw89_dev *rtwdev,
+				      struct rtw89_bb_ctx *bb, bool cck)
+{
+	const struct rtw89_pmac_regs *regs = rtwdev->chip->pmac_regs;
+
+	if (cck) {
+		rtw89_phy_write32_clr(rtwdev, regs->r1b_rx_rpt_rst.addr,
+				      regs->r1b_rx_rpt_rst.mask);
+		rtw89_phy_write32_set(rtwdev, regs->r1b_rx_rpt_rst.addr,
+				      regs->r1b_rx_rpt_rst.mask);
+	}
+
+	rtw89_phy_write32_idx_set(rtwdev, regs->enable_all_cnt.addr,
+				  regs->enable_all_cnt.mask, bb->phy_idx);
+	rtw89_phy_write32_idx_set(rtwdev, regs->rst_all_cnt.addr,
+				  regs->rst_all_cnt.mask, bb->phy_idx);
+	rtw89_phy_write32_idx_clr(rtwdev, regs->rst_all_cnt.addr,
+				  regs->rst_all_cnt.mask, bb->phy_idx);
+}
+
+static void rtw89_phy_pmac_stat_cck(struct rtw89_dev *rtwdev,
+				    struct rtw89_bb_ctx *bb)
+{
+	const struct rtw89_pmac_regs *regs = rtwdev->chip->pmac_regs;
+	struct rtw89_pmac_stat_info *pmac = &bb->pmac_stat;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 val;
+
+	pmac->cck_phy_txon =
+		rtw89_phy_read32_mask(rtwdev, regs->cck_txon.addr, regs->cck_txon.mask);
+	pmac->cck_mac_txen =
+		rtw89_phy_read32_mask(rtwdev, regs->cck_txen.addr, regs->cck_txen.mask);
+
+	if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
+		rtw89_phy_write32_mask(rtwdev, regs->r1b_rr_sel.addr,
+				       regs->r1b_rr_sel.mask, 0x2);
+
+	if (bb->phy_idx == RTW89_PHY_1)
+		pmac->cnt_cck_cca =
+			rtw89_phy_read32_mask(rtwdev, regs->cck_cca.addr + 8,
+					      regs->cck_cca.mask);
+	else
+		pmac->cnt_cck_cca =
+			rtw89_phy_read32_mask(rtwdev, regs->cck_cca.addr,
+					      regs->cck_cca.mask);
+
+	if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
+		rtw89_phy_write32_mask(rtwdev, regs->r1b_rr_sel.addr,
+				       regs->r1b_rr_sel.mask, 0x1);
+
+	if (bb->phy_idx == RTW89_PHY_1)
+		val = rtw89_phy_read32(rtwdev, regs->cck_crc32 + 8);
+	else
+		val = rtw89_phy_read32(rtwdev, regs->cck_crc32);
+	pmac->cnt_cck_crc32_ok = field_get(regs->cck_crc32_ok_mask, val);
+	pmac->cnt_cck_crc32_error = field_get(regs->cck_crc32_fail_mask, val);
+
+	pmac->cnt_sfd_gg =
+		rtw89_phy_read32_idx(rtwdev, regs->cck_sfd_gg.addr,
+				     regs->cck_sfd_gg.mask, bb->phy_idx);
+	pmac->cnt_sig_gg =
+		rtw89_phy_read32_idx(rtwdev, regs->cck_sig_gg.addr,
+				     regs->cck_sig_gg.mask, bb->phy_idx);
+	pmac->cnt_cck_spoofing =
+		rtw89_phy_read32_idx(rtwdev, regs->cck_spoofing.addr,
+				     regs->cck_spoofing.mask, bb->phy_idx);
+
+	if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
+		pmac->cnt_cck_fail =
+			pmac->cnt_cck_cca - pmac->cnt_cck_crc32_ok -
+			pmac->cnt_cck_crc32_error - pmac->cnt_cck_spoofing;
+	else
+		pmac->cnt_cck_fail =
+			rtw89_phy_read32_idx(rtwdev, regs->cck_brk.addr,
+					     regs->cck_brk.mask, bb->phy_idx);
+}
+
+static void rtw89_phy_pmac_stat_ofdm(struct rtw89_dev *rtwdev,
+				     struct rtw89_bb_ctx *bb)
+{
+	const struct rtw89_pmac_regs *regs = rtwdev->chip->pmac_regs;
+	struct rtw89_pmac_stat_info *pmac = &bb->pmac_stat;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 val;
+
+	val = rtw89_phy_read32_idx(rtwdev, regs->ofdm_txon, MASKDWORD, bb->phy_idx);
+	pmac->ofdm_phy_txon = field_get(regs->ofdm_txon_mask, val);
+	pmac->ofdm_mac_txen = field_get(regs->ofdm_txen_mask, val);
+
+	val = rtw89_phy_read32_idx(rtwdev, regs->l_crc, MASKDWORD, bb->phy_idx);
+	pmac->cnt_ofdm_crc32_ok = field_get(regs->l_crc_ok_mask, val);
+	pmac->cnt_ofdm_crc32_error = field_get(regs->l_crc_err_mask, val);
+
+	val = rtw89_phy_read32_idx(rtwdev, regs->ht_crc, MASKDWORD, bb->phy_idx);
+	pmac->cnt_ht_crc32_ok = field_get(regs->ht_crc_ok_mask, val);
+	pmac->cnt_ht_crc32_error = field_get(regs->ht_crc_err_mask, val);
+
+	val = rtw89_phy_read32_idx(rtwdev, regs->vht_crc, MASKDWORD, bb->phy_idx);
+	pmac->cnt_vht_crc32_ok = field_get(regs->vht_crc_ok_mask, val);
+	pmac->cnt_vht_crc32_error = field_get(regs->vht_crc_err_mask, val);
+
+	val = rtw89_phy_read32_idx(rtwdev, regs->he_crc, MASKDWORD, bb->phy_idx);
+	pmac->cnt_he_crc32_ok = field_get(regs->he_crc_ok_mask, val);
+	pmac->cnt_he_crc32_error = field_get(regs->he_crc_err_mask, val);
+
+	if (chip->chip_gen == RTW89_CHIP_BE) {
+		val = rtw89_phy_read32_idx(rtwdev, regs->eht_crc,
+					   MASKDWORD, bb->phy_idx);
+		pmac->cnt_eht_crc32_ok = field_get(regs->eht_crc_ok_mask, val);
+		pmac->cnt_eht_crc32_error = field_get(regs->eht_crc_err_mask, val);
+	}
+
+	val = rtw89_phy_read32_idx(rtwdev, regs->ampdu_crc, MASKDWORD, bb->phy_idx);
+	pmac->cnt_ampdu_crc_ok = field_get(regs->ampdu_crc_ok_mask, val);
+	pmac->cnt_ampdu_crc_error = field_get(regs->ampdu_crc_err_mask, val);
+
+	val = rtw89_phy_read32_idx(rtwdev, regs->brk.addr, regs->brk.mask, bb->phy_idx);
+	if (chip->chip_id == RTL8852C &&
+	    rtw89_phy_read32_idx(rtwdev, regs->brk_option.addr,
+				 regs->brk_option.mask, bb->phy_idx) == 1) {
+		u32 tmp = pmac->ofdm_phy_txon + pmac->cck_phy_txon;
+
+		val = (val > tmp) ? (val - tmp) : 0;
+	}
+	pmac->cnt_ofdm_fail = val;
+
+	pmac->cnt_sb_search_fail =
+		rtw89_phy_read32_idx(rtwdev, regs->search_fail.addr,
+				     regs->search_fail.mask, bb->phy_idx);
+	pmac->cnt_lsig_brk_s_th =
+		rtw89_phy_read32_idx(rtwdev, regs->lsig_brk_s_th.addr,
+				     regs->lsig_brk_s_th.mask, bb->phy_idx);
+	pmac->cnt_lsig_brk_l_th =
+		rtw89_phy_read32_idx(rtwdev, regs->lsig_brk_l_th.addr,
+				     regs->lsig_brk_l_th.mask, bb->phy_idx);
+	pmac->cnt_parity_fail =
+		rtw89_phy_read32_idx(rtwdev, regs->rxl_err_parity.addr,
+				     regs->rxl_err_parity.mask, bb->phy_idx);
+	pmac->cnt_rate_illegal =
+		rtw89_phy_read32_idx(rtwdev, regs->rxl_err_rate.addr,
+				     regs->rxl_err_rate.mask, bb->phy_idx);
+	pmac->cnt_ofdm_cca =
+		rtw89_phy_read32_idx(rtwdev, regs->ofdm_cca.addr,
+				     regs->ofdm_cca.mask, bb->phy_idx);
+	pmac->cnt_ofdm_spoofing =
+		rtw89_phy_read32_idx(rtwdev, regs->cca_spoofing.addr,
+				     regs->cca_spoofing.mask, bb->phy_idx);
+	pmac->cnt_ampdu_miss =
+		rtw89_phy_read32_idx(rtwdev, regs->ampdu_miss.addr,
+				     regs->ampdu_miss.mask, bb->phy_idx);
+}
+
+static void rtw89_phy_pmac_stat_update(struct rtw89_dev *rtwdev,
+				       struct rtw89_bb_ctx *bb)
+{
+	struct rtw89_pmac_stat_info *pmac = &bb->pmac_stat;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_entity_conf conf;
+	const struct rtw89_chan *chan;
+	bool cck;
+
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[bb->phy_idx];
+	cck = chan->band_type == RTW89_BAND_2G;
+
+	if (cck)
+		rtw89_phy_pmac_stat_cck(rtwdev, bb);
+
+	rtw89_phy_pmac_stat_ofdm(rtwdev, bb);
+
+	pmac->cnt_crc32_error_all = pmac->cnt_he_crc32_error +
+				    pmac->cnt_vht_crc32_error +
+				    pmac->cnt_ht_crc32_error +
+				    pmac->cnt_ofdm_crc32_error +
+				    pmac->cnt_cck_crc32_error;
+
+	pmac->cnt_crc32_ok_all = pmac->cnt_he_crc32_ok +
+				 pmac->cnt_vht_crc32_ok +
+				 pmac->cnt_ht_crc32_ok +
+				 pmac->cnt_ofdm_crc32_ok +
+				 pmac->cnt_cck_crc32_ok;
+
+	if (chip->chip_gen == RTW89_CHIP_BE) {
+		pmac->cnt_crc32_error_all += pmac->cnt_eht_crc32_error;
+		pmac->cnt_crc32_ok_all += pmac->cnt_eht_crc32_ok;
+	}
+
+	rtw89_phy_pmac_stat_reset(rtwdev, bb, cck);
+}
+
 static void rtw89_phy_trigger_tx_count(struct rtw89_dev *rtwdev)
 {
 	if (RTW89_CHK_FW_FEATURE(TX_HISTORY_V1, &rtwdev->fw))
@@ -5854,10 +6044,15 @@ static void rtw89_phy_trigger_tx_count(struct rtw89_dev *rtwdev)
 
 static void rtw89_phy_stat_update(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_bb_ctx *bb;
+
 	if (!rtwdev->phy_info.bb_stat_cfg.enable)
 		return;
 
 	rtw89_phy_trigger_tx_count(rtwdev);
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		rtw89_phy_pmac_stat_update(rtwdev, bb);
 }
 
 void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 1e1125235f0c..c054a402bd20 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8799,6 +8799,12 @@
 #define R_P0_ANT_SW 0x0728
 #define B_P0_HW_ANTSW_DIS_BY_GNT_BT BIT(12)
 #define B_P0_TRSW_TX_EXTEND GENMASK(3, 0)
+#define R_RST_ALL_CNT 0x0730
+#define R_RST_ALL_CNT_BE4 0x20730
+#define B_RST_ALL_CNT BIT(0)
+#define R_ENABLE_ALL_CNT 0x0730
+#define R_ENABLE_ALL_CNT_BE4 0x20730
+#define B_ENABLE_ALL_CNT BIT(1)
 #define R_MAC_PIN_SEL 0x0734
 #define R_MAC_PIN_SEL_BE4 0x20734
 #define B_CH_IDX_SEG0 GENMASK(23, 16)
@@ -8949,6 +8955,8 @@
 #define B_RXHT_MCS_LIMIT GENMASK(9, 8)
 #define R_RXVHT_MCS_LIMIT 0x0D18
 #define B_RXVHT_MCS_LIMIT GENMASK(22, 21)
+#define R_BRK_OPT 0x0D44
+#define B_BRK_OPT BIT(31)
 #define R_P0_EN_SOUND_WO_NDP 0x0D7C
 #define B_P0_EN_SOUND_WO_NDP BIT(1)
 #define R_RXHE 0x0D80
@@ -9004,6 +9012,21 @@
 #define R_CFO_COMP_SEG0_L 0x1384
 #define R_CFO_COMP_SEG0_H 0x1388
 #define R_CFO_COMP_SEG0_CTRL 0x138C
+#define R_CNT_CCKTXEN 0x1700
+#define R_CNT_CCKTXEN_V1 0x2E00
+#define R_CNT_CCKTXEN_BE4 0x2CF00
+#define B_CNT_CCKTXEN GENMASK(31, 16)
+#define R_CNT_CCKTXON 0x1704
+#define R_CNT_CCKTXON_V1 0x2E04
+#define R_CNT_CCKTXON_BE4 0x2CF04
+#define B_CNT_CCKTXON GENMASK(15, 0)
+#define R_CNT_CCK_CCA_P0 0x1710
+#define R_CNT_CCK_CCA_P0_V1 0x2E10
+#define B_CNT_CCK_CCA_P0 GENMASK(15, 0)
+#define R_CNT_CCK_CRC32_P0 0x1714
+#define R_CNT_CCK_CRC32_P0_V1 0x2E14
+#define B_CNT_CCK_CRC32OK_P0 GENMASK(15, 0)
+#define B_CNT_CCK_CRC32FAIL_P0 GENMASK(31, 16)
 #define R_DBG32_D 0x1730
 #define R_EDCCA_RPT_A 0x1738
 #define R_EDCCA_RPT_B 0x173c
@@ -9019,7 +9042,73 @@
 #define B_SWSI_W_BUSY_V1 BIT(24)
 #define B_SWSI_R_BUSY_V1 BIT(25)
 #define B_SWSI_R_DATA_DONE_V1 BIT(26)
+#define R_CNT_LSIG_BRK_S_TH 0x1A00
+#define R_CNT_LSIG_BRK_S_TH_V1 0x0E00
+#define R_CNT_LSIG_BRK_S_TH_BE4 0x20E00
+#define B_CNT_LSIG_BRK_S_TH GENMASK(31, 16)
+#define R_CNT_CCA_SPOOFING 0x1A00
+#define R_CNT_CCA_SPOOFING_V1 0x0E00
+#define R_CNT_CCA_SPOOFING_BE4 0x20E00
+#define B_CNT_CCA_SPOOFING GENMASK(15, 0)
+#define R_CNT_LSIG_BRK_L_TH 0x1A04
+#define R_CNT_LSIG_BRK_L_TH_V1 0x0E04
+#define R_CNT_LSIG_BRK_L_TH_BE4 0x20E04
+#define B_CNT_LSIG_BRK_L_TH GENMASK(15, 0)
+#define R_CNT_BRK 0x1A08
+#define R_CNT_BRK_V1 0x0E08
+#define R_CNT_BRK_BE4 0x20E08
+#define B_CNT_BRK GENMASK(31, 16)
+#define R_CNT_RXL_ERR_PARITY 0x1A0C
+#define R_CNT_RXL_ERR_PARITY_V1 0x0E0C
+#define R_CNT_RXL_ERR_PARITY_BE4 0x20E0C
+#define B_CNT_RXL_ERR_PARITY GENMASK(31, 16)
+#define R_CNT_RXL_ERR_RATE 0x1A10
+#define R_CNT_RXL_ERR_RATE_V1 0x0E10
+#define R_CNT_RXL_ERR_RATE_BE4 0x20E10
+#define B_CNT_RXL_ERR_RATE GENMASK(15, 0)
+#define R_CNT_SEARCH_FAIL 0x1A20
+#define R_CNT_SEARCH_FAIL_V1 0x0E20
+#define R_CNT_SEARCH_FAIL_BE4 0x20E20
+#define B_CNT_SEARCH_FAIL GENMASK(31, 16)
+#define R_CNT_OFDM_CCA 0x1A24
+#define R_CNT_OFDM_CCA_V1 0x0E24
+#define R_CNT_OFDM_CCA_BE4 0x20E24
+#define B_CNT_OFDM_CCA GENMASK(15, 0)
 #define R_TX_COUNTER 0x1A40
+#define R_CNT_OFDMTXON 0x1A40
+#define R_CNT_OFDMTXON_V1 0x0E40
+#define R_CNT_OFDMTXON_BE4 0x20E40
+#define B_CNT_OFDMTXON GENMASK(15, 0)
+#define B_CNT_OFDMTXEN GENMASK(31, 16)
+#define R_CNT_HE_CRC 0x1A58
+#define R_CNT_HE_CRC_V1 0x0E58
+#define R_CNT_HE_CRC_BE4 0x20E58
+#define B_CNT_HE_CRC_OK GENMASK(15, 0)
+#define B_CNT_HE_CRC_ERR GENMASK(31, 16)
+#define R_CNT_VHT_CRC 0x1A5C
+#define R_CNT_VHT_CRC_V1 0x0E5C
+#define R_CNT_VHT_CRC_BE4 0x20E5C
+#define B_CNT_VHT_CRC_OK GENMASK(15, 0)
+#define B_CNT_VHT_CRC_ERR GENMASK(31, 16)
+#define R_CNT_HT_CRC 0x1A60
+#define R_CNT_HT_CRC_V1 0x0E60
+#define R_CNT_HT_CRC_BE4 0x20E60
+#define B_CNT_HT_CRC_OK GENMASK(15, 0)
+#define B_CNT_HT_CRC_ERR GENMASK(31, 16)
+#define R_CNT_L_CRC 0x1A64
+#define R_CNT_L_CRC_V1 0x0E64
+#define R_CNT_L_CRC_BE4 0x20E64
+#define B_CNT_L_CRC_OK GENMASK(15, 0)
+#define B_CNT_L_CRC_ERR GENMASK(31, 16)
+#define R_CNT_AMPDU_MISS 0x1A7C
+#define R_CNT_AMPDU_MISS_V1 0x0E7C
+#define R_CNT_AMPDU_MISS_BE4 0x20E7C
+#define B_CNT_AMPDU_MISS GENMASK(31, 16)
+#define R_CNT_AMPDU_RX_CRC32 0x1A80
+#define R_CNT_AMPDU_RX_CRC32_V1 0x0E80
+#define R_CNT_AMPDU_RX_CRC32_BE4 0x20E80
+#define B_CNT_AMPDU_RX_CRC32_OK GENMASK(15, 0)
+#define B_CNT_AMPDU_RX_CRC32_ERR GENMASK(31, 16)
 #define R_NHM_CNT0 0x1A88
 #define B_NHM_CNT0_MSK GENMASK(15, 0)
 #define B_NHM_CNT1_MSK GENMASK(31, 16)
@@ -9137,12 +9226,41 @@
 #define B_RXCCA_DIS_V1 BIT(0)
 #define R_RXSC 0x237C
 #define B_RXSC_EN BIT(0)
+#define R_R1B_RR_SEL 0x2388
+#define B_R1B_RR_SEL GENMASK(24, 23)
+#define R_R1B_RX_RPT_RST 0x2388
+#define R_R1B_RX_RPT_RST_V1 0x2340
+#define R_R1B_RX_RPT_RST_BE 0x0540
+#define R_R1B_RX_RPT_RST_BE4 0x20540
+#define B_R1B_RX_RPT_RST BIT(15)
+#define B_R1B_RX_RPT_RST_V1 BIT(7)
+#define R_BRK_CNT 0x239C
+#define R_BRK_CNT_V1 0x059C
+#define R_BRK_CNT_BE4 0x2059C
+#define B_BRK_CNT GENMASK(31, 16)
 #define R_RX_RPL_OFST 0x23AC
 #define B_RX_RPL_OFST_CCK_MASK GENMASK(6, 0)
 #define R_RXSCOBC 0x23B0
 #define B_RXSCOBC_TH GENMASK(18, 0)
 #define R_RXSCOCCK 0x23B4
 #define B_RXSCOCCK_TH GENMASK(18, 0)
+#define R_SFD_GG_CNT 0x23E0
+#define R_SFD_GG_CNT_V1 0x23A0
+#define R_SFD_GG_CNT_V2 0x05A0
+#define R_SFD_GG_CNT_BE4 0x205A0
+#define B_SFD_GG_CNT GENMASK(15, 0)
+#define R_SIG_GG_CNT 0x23E8
+#define R_SIG_GG_CNT_V1 0x23AC
+#define R_SIG_GG_CNT_V2 0x05AC
+#define R_SIG_GG_CNT_BE4 0x205AC
+#define B_SIG_GG_CNT GENMASK(15, 0)
+#define B_SIG_GG_CNT_V1 GENMASK(15, 8)
+#define R_SPOOF_CNT 0x23EC
+#define R_SPOOF_CNT_V1 0x23A8
+#define R_SPOOF_CNT_V2 0x05A8
+#define R_SPOOF_CNT_BE4 0x205A8
+#define B_SPOOF_CNT GENMASK(7, 0)
+#define B_SPOOF_CNT_V1 GENMASK(31, 16)
 #define R_P80_AT_HIGH_FREQ_RU_ALLOC 0x2410
 #define B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY1 BIT(14)
 #define B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY0 BIT(13)
@@ -9179,6 +9297,10 @@
 #define R_EDCCA_RPT_B_BE4_C1 0x2FE34
 #define R_EDCCA_RPT_P1_A_BE 0x2E40
 #define R_EDCCA_RPT_P1_B_BE 0x2E44
+#define R_CNT_EHT_CRC 0x2F00
+#define R_CNT_EHT_CRC_BE4 0x22F00
+#define B_CNT_EHT_CRC_OK GENMASK(15, 0)
+#define B_CNT_EHT_CRC_ERR GENMASK(31, 16)
 #define R_S1_HW_SI_DIS 0x3200
 #define B_S1_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
 #define R_P1_RXCK 0x32A0
@@ -10547,6 +10669,11 @@
 #define R_IFS_T3_HIS_BE4 0x20F54
 #define B_IFS_T3_HIS_BE4 GENMASK(15, 0)
 #define B_IFS_T4_HIS_BE4 GENMASK(31, 16)
+#define R_CNT_CCK_CCA_BE4 0x20FE8
+#define B_CNT_CCK_CCA_BE4 GENMASK(15, 0)
+#define R_CNT_CCK_CRC32_BE4 0x20FEC
+#define B_CNT_CCK_CRC32OK_BE4 GENMASK(15, 0)
+#define B_CNT_CCK_CRC32FAIL_BE4 GENMASK(31, 16)
 
 #define R_TX_ERROR_SEL_BE4 0x21254
 #define B_TX_ERROR_PSDU_BE4 BIT(11)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d9a144b4bf58..e047e716d9e3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -307,6 +307,54 @@ static const struct rtw89_edcca_regs rtw8851b_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
 
+static const struct rtw89_pmac_regs rtw8851b_pmac_regs = {
+	.cck_txon = {R_CNT_CCKTXON, B_CNT_CCKTXON},
+	.cck_txen = {R_CNT_CCKTXEN, B_CNT_CCKTXEN},
+	.cck_cca = {R_CNT_CCK_CCA_P0, B_CNT_CCK_CCA_P0},
+	.cck_sfd_gg = {R_SFD_GG_CNT, B_SFD_GG_CNT},
+	.cck_sig_gg = {R_SIG_GG_CNT, B_SIG_GG_CNT},
+	.cck_spoofing = {R_SPOOF_CNT, B_SPOOF_CNT},
+	.cck_brk = {},
+	.brk = {R_CNT_BRK, B_CNT_BRK},
+	.brk_option = {},
+	.search_fail = {R_CNT_SEARCH_FAIL, B_CNT_SEARCH_FAIL},
+	.lsig_brk_s_th = {R_CNT_LSIG_BRK_S_TH, B_CNT_LSIG_BRK_S_TH},
+	.lsig_brk_l_th = {R_CNT_LSIG_BRK_L_TH, B_CNT_LSIG_BRK_L_TH},
+	.rxl_err_parity = {R_CNT_RXL_ERR_PARITY, B_CNT_RXL_ERR_PARITY},
+	.rxl_err_rate = {R_CNT_RXL_ERR_RATE, B_CNT_RXL_ERR_RATE},
+	.ofdm_cca = {R_CNT_OFDM_CCA, B_CNT_OFDM_CCA},
+	.cca_spoofing = {R_CNT_CCA_SPOOFING, B_CNT_CCA_SPOOFING},
+	.ampdu_miss = {R_CNT_AMPDU_MISS, B_CNT_AMPDU_MISS},
+	.r1b_rx_rpt_rst = {R_R1B_RX_RPT_RST, B_R1B_RX_RPT_RST},
+	.r1b_rr_sel = {R_R1B_RR_SEL, B_R1B_RR_SEL},
+	.enable_all_cnt = {R_ENABLE_ALL_CNT, B_ENABLE_ALL_CNT},
+	.rst_all_cnt = {R_RST_ALL_CNT, B_RST_ALL_CNT},
+	.cck_crc32 = R_CNT_CCK_CRC32_P0,
+	.cck_crc32_ok_mask = B_CNT_CCK_CRC32OK_P0,
+	.cck_crc32_fail_mask = B_CNT_CCK_CRC32FAIL_P0,
+	.ofdm_txon = R_CNT_OFDMTXON,
+	.ofdm_txon_mask = B_CNT_OFDMTXON,
+	.ofdm_txen_mask = B_CNT_OFDMTXEN,
+	.l_crc = R_CNT_L_CRC,
+	.l_crc_ok_mask = B_CNT_L_CRC_OK,
+	.l_crc_err_mask = B_CNT_L_CRC_ERR,
+	.ht_crc = R_CNT_HT_CRC,
+	.ht_crc_ok_mask = B_CNT_HT_CRC_OK,
+	.ht_crc_err_mask = B_CNT_HT_CRC_ERR,
+	.vht_crc = R_CNT_VHT_CRC,
+	.vht_crc_ok_mask = B_CNT_VHT_CRC_OK,
+	.vht_crc_err_mask = B_CNT_VHT_CRC_ERR,
+	.he_crc = R_CNT_HE_CRC,
+	.he_crc_ok_mask = B_CNT_HE_CRC_OK,
+	.he_crc_err_mask = B_CNT_HE_CRC_ERR,
+	.eht_crc = 0,
+	.eht_crc_ok_mask = 0,
+	.eht_crc_err_mask = 0,
+	.ampdu_crc = R_CNT_AMPDU_RX_CRC32,
+	.ampdu_crc_ok_mask = B_CNT_AMPDU_RX_CRC32_OK,
+	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
+};
+
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8851b_rf_ul[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
@@ -2722,6 +2770,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
 	.edcca_regs		= &rtw8851b_edcca_regs,
+	.pmac_regs		= &rtw8851b_pmac_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8851b,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index b81eeb59be60..686e489d42f2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -621,6 +621,54 @@ static const struct rtw89_edcca_regs rtw8852a_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
 
+static const struct rtw89_pmac_regs rtw8852a_pmac_regs = {
+	.cck_txon = {R_CNT_CCKTXON, B_CNT_CCKTXON},
+	.cck_txen = {R_CNT_CCKTXEN, B_CNT_CCKTXEN},
+	.cck_cca = {R_CNT_CCK_CCA_P0, B_CNT_CCK_CCA_P0},
+	.cck_sfd_gg = {R_SFD_GG_CNT, B_SFD_GG_CNT},
+	.cck_sig_gg = {R_SIG_GG_CNT, B_SIG_GG_CNT},
+	.cck_spoofing = {R_SPOOF_CNT, B_SPOOF_CNT},
+	.cck_brk = {},
+	.brk = {R_CNT_BRK, B_CNT_BRK},
+	.brk_option = {},
+	.search_fail = {R_CNT_SEARCH_FAIL, B_CNT_SEARCH_FAIL},
+	.lsig_brk_s_th = {R_CNT_LSIG_BRK_S_TH, B_CNT_LSIG_BRK_S_TH},
+	.lsig_brk_l_th = {R_CNT_LSIG_BRK_L_TH, B_CNT_LSIG_BRK_L_TH},
+	.rxl_err_parity = {R_CNT_RXL_ERR_PARITY, B_CNT_RXL_ERR_PARITY},
+	.rxl_err_rate = {R_CNT_RXL_ERR_RATE, B_CNT_RXL_ERR_RATE},
+	.ofdm_cca = {R_CNT_OFDM_CCA, B_CNT_OFDM_CCA},
+	.cca_spoofing = {R_CNT_CCA_SPOOFING, B_CNT_CCA_SPOOFING},
+	.ampdu_miss = {R_CNT_AMPDU_MISS, B_CNT_AMPDU_MISS},
+	.r1b_rx_rpt_rst = {R_R1B_RX_RPT_RST, B_R1B_RX_RPT_RST},
+	.r1b_rr_sel = {R_R1B_RR_SEL, B_R1B_RR_SEL},
+	.enable_all_cnt = {R_ENABLE_ALL_CNT, B_ENABLE_ALL_CNT},
+	.rst_all_cnt = {R_RST_ALL_CNT, B_RST_ALL_CNT},
+	.cck_crc32 = R_CNT_CCK_CRC32_P0,
+	.cck_crc32_ok_mask = B_CNT_CCK_CRC32OK_P0,
+	.cck_crc32_fail_mask = B_CNT_CCK_CRC32FAIL_P0,
+	.ofdm_txon = R_CNT_OFDMTXON,
+	.ofdm_txon_mask = B_CNT_OFDMTXON,
+	.ofdm_txen_mask = B_CNT_OFDMTXEN,
+	.l_crc = R_CNT_L_CRC,
+	.l_crc_ok_mask = B_CNT_L_CRC_OK,
+	.l_crc_err_mask = B_CNT_L_CRC_ERR,
+	.ht_crc = R_CNT_HT_CRC,
+	.ht_crc_ok_mask = B_CNT_HT_CRC_OK,
+	.ht_crc_err_mask = B_CNT_HT_CRC_ERR,
+	.vht_crc = R_CNT_VHT_CRC,
+	.vht_crc_ok_mask = B_CNT_VHT_CRC_OK,
+	.vht_crc_err_mask = B_CNT_VHT_CRC_ERR,
+	.he_crc = R_CNT_HE_CRC,
+	.he_crc_ok_mask = B_CNT_HE_CRC_OK,
+	.he_crc_err_mask = B_CNT_HE_CRC_ERR,
+	.eht_crc = 0,
+	.eht_crc_ok_mask = 0,
+	.eht_crc_err_mask = 0,
+	.ampdu_crc = R_CNT_AMPDU_RX_CRC32,
+	.ampdu_crc_ok_mask = B_CNT_AMPDU_RX_CRC32_OK,
+	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
+};
+
 static void rtw8852a_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 					struct rtw8852a_efuse *map)
 {
@@ -2459,6 +2507,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.btc_sb			= {{{R_AX_SCOREBOARD, R_AX_SCOREBOARD},}},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8852a_edcca_regs,
+	.pmac_regs		= &rtw8852a_pmac_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852a,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 13c942127225..6ab99f72fda7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -259,6 +259,54 @@ static const struct rtw89_edcca_regs rtw8852b_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
 
+static const struct rtw89_pmac_regs rtw8852b_pmac_regs = {
+	.cck_txon = {R_CNT_CCKTXON, B_CNT_CCKTXON},
+	.cck_txen = {R_CNT_CCKTXEN, B_CNT_CCKTXEN},
+	.cck_cca = {R_CNT_CCK_CCA_P0, B_CNT_CCK_CCA_P0},
+	.cck_sfd_gg = {R_SFD_GG_CNT, B_SFD_GG_CNT},
+	.cck_sig_gg = {R_SIG_GG_CNT, B_SIG_GG_CNT},
+	.cck_spoofing = {R_SPOOF_CNT, B_SPOOF_CNT},
+	.cck_brk = {},
+	.brk = {R_CNT_BRK, B_CNT_BRK},
+	.brk_option = {},
+	.search_fail = {R_CNT_SEARCH_FAIL, B_CNT_SEARCH_FAIL},
+	.lsig_brk_s_th = {R_CNT_LSIG_BRK_S_TH, B_CNT_LSIG_BRK_S_TH},
+	.lsig_brk_l_th = {R_CNT_LSIG_BRK_L_TH, B_CNT_LSIG_BRK_L_TH},
+	.rxl_err_parity = {R_CNT_RXL_ERR_PARITY, B_CNT_RXL_ERR_PARITY},
+	.rxl_err_rate = {R_CNT_RXL_ERR_RATE, B_CNT_RXL_ERR_RATE},
+	.ofdm_cca = {R_CNT_OFDM_CCA, B_CNT_OFDM_CCA},
+	.cca_spoofing = {R_CNT_CCA_SPOOFING, B_CNT_CCA_SPOOFING},
+	.ampdu_miss = {R_CNT_AMPDU_MISS, B_CNT_AMPDU_MISS},
+	.r1b_rx_rpt_rst = {R_R1B_RX_RPT_RST, B_R1B_RX_RPT_RST},
+	.r1b_rr_sel = {R_R1B_RR_SEL, B_R1B_RR_SEL},
+	.enable_all_cnt = {R_ENABLE_ALL_CNT, B_ENABLE_ALL_CNT},
+	.rst_all_cnt = {R_RST_ALL_CNT, B_RST_ALL_CNT},
+	.cck_crc32 = R_CNT_CCK_CRC32_P0,
+	.cck_crc32_ok_mask = B_CNT_CCK_CRC32OK_P0,
+	.cck_crc32_fail_mask = B_CNT_CCK_CRC32FAIL_P0,
+	.ofdm_txon = R_CNT_OFDMTXON,
+	.ofdm_txon_mask = B_CNT_OFDMTXON,
+	.ofdm_txen_mask = B_CNT_OFDMTXEN,
+	.l_crc = R_CNT_L_CRC,
+	.l_crc_ok_mask = B_CNT_L_CRC_OK,
+	.l_crc_err_mask = B_CNT_L_CRC_ERR,
+	.ht_crc = R_CNT_HT_CRC,
+	.ht_crc_ok_mask = B_CNT_HT_CRC_OK,
+	.ht_crc_err_mask = B_CNT_HT_CRC_ERR,
+	.vht_crc = R_CNT_VHT_CRC,
+	.vht_crc_ok_mask = B_CNT_VHT_CRC_OK,
+	.vht_crc_err_mask = B_CNT_VHT_CRC_ERR,
+	.he_crc = R_CNT_HE_CRC,
+	.he_crc_ok_mask = B_CNT_HE_CRC_OK,
+	.he_crc_err_mask = B_CNT_HE_CRC_ERR,
+	.eht_crc = 0,
+	.eht_crc_ok_mask = 0,
+	.eht_crc_err_mask = 0,
+	.ampdu_crc = R_CNT_AMPDU_RX_CRC32,
+	.ampdu_crc_ok_mask = B_CNT_AMPDU_RX_CRC32_OK,
+	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
+};
+
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_ul[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
@@ -1056,6 +1104,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
 	.edcca_regs		= &rtw8852b_edcca_regs,
+	.pmac_regs		= &rtw8852b_pmac_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852b,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 3fd5990a8bc4..83de26273100 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -202,6 +202,54 @@ static const struct rtw89_edcca_regs rtw8852bt_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
 
+static const struct rtw89_pmac_regs rtw8852bt_pmac_regs = {
+	.cck_txon = {R_CNT_CCKTXON, B_CNT_CCKTXON},
+	.cck_txen = {R_CNT_CCKTXEN, B_CNT_CCKTXEN},
+	.cck_cca = {R_CNT_CCK_CCA_P0, B_CNT_CCK_CCA_P0},
+	.cck_sfd_gg = {R_SFD_GG_CNT, B_SFD_GG_CNT},
+	.cck_sig_gg = {R_SIG_GG_CNT, B_SIG_GG_CNT},
+	.cck_spoofing = {R_SPOOF_CNT, B_SPOOF_CNT},
+	.cck_brk = {},
+	.brk = {R_CNT_BRK, B_CNT_BRK},
+	.brk_option = {},
+	.search_fail = {R_CNT_SEARCH_FAIL, B_CNT_SEARCH_FAIL},
+	.lsig_brk_s_th = {R_CNT_LSIG_BRK_S_TH, B_CNT_LSIG_BRK_S_TH},
+	.lsig_brk_l_th = {R_CNT_LSIG_BRK_L_TH, B_CNT_LSIG_BRK_L_TH},
+	.rxl_err_parity = {R_CNT_RXL_ERR_PARITY, B_CNT_RXL_ERR_PARITY},
+	.rxl_err_rate = {R_CNT_RXL_ERR_RATE, B_CNT_RXL_ERR_RATE},
+	.ofdm_cca = {R_CNT_OFDM_CCA, B_CNT_OFDM_CCA},
+	.cca_spoofing = {R_CNT_CCA_SPOOFING, B_CNT_CCA_SPOOFING},
+	.ampdu_miss = {R_CNT_AMPDU_MISS, B_CNT_AMPDU_MISS},
+	.r1b_rx_rpt_rst = {R_R1B_RX_RPT_RST, B_R1B_RX_RPT_RST},
+	.r1b_rr_sel = {R_R1B_RR_SEL, B_R1B_RR_SEL},
+	.enable_all_cnt = {R_ENABLE_ALL_CNT, B_ENABLE_ALL_CNT},
+	.rst_all_cnt = {R_RST_ALL_CNT, B_RST_ALL_CNT},
+	.cck_crc32 = R_CNT_CCK_CRC32_P0,
+	.cck_crc32_ok_mask = B_CNT_CCK_CRC32OK_P0,
+	.cck_crc32_fail_mask = B_CNT_CCK_CRC32FAIL_P0,
+	.ofdm_txon = R_CNT_OFDMTXON,
+	.ofdm_txon_mask = B_CNT_OFDMTXON,
+	.ofdm_txen_mask = B_CNT_OFDMTXEN,
+	.l_crc = R_CNT_L_CRC,
+	.l_crc_ok_mask = B_CNT_L_CRC_OK,
+	.l_crc_err_mask = B_CNT_L_CRC_ERR,
+	.ht_crc = R_CNT_HT_CRC,
+	.ht_crc_ok_mask = B_CNT_HT_CRC_OK,
+	.ht_crc_err_mask = B_CNT_HT_CRC_ERR,
+	.vht_crc = R_CNT_VHT_CRC,
+	.vht_crc_ok_mask = B_CNT_VHT_CRC_OK,
+	.vht_crc_err_mask = B_CNT_VHT_CRC_ERR,
+	.he_crc = R_CNT_HE_CRC,
+	.he_crc_ok_mask = B_CNT_HE_CRC_OK,
+	.he_crc_err_mask = B_CNT_HE_CRC_ERR,
+	.eht_crc = 0,
+	.eht_crc_ok_mask = 0,
+	.eht_crc_err_mask = 0,
+	.ampdu_crc = R_CNT_AMPDU_RX_CRC32,
+	.ampdu_crc_ok_mask = B_CNT_AMPDU_RX_CRC32_OK,
+	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
+};
+
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8852bt_rf_ul[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
@@ -893,6 +941,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
 	.edcca_regs		= &rtw8852bt_edcca_regs,
+	.pmac_regs		= &rtw8852bt_pmac_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852bt,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9ef469c1080e..cc278587b532 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -270,6 +270,54 @@ static const struct rtw89_edcca_regs rtw8852c_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
 };
 
+static const struct rtw89_pmac_regs rtw8852c_pmac_regs = {
+	.cck_txon = {R_CNT_CCKTXON, B_CNT_CCKTXON},
+	.cck_txen = {R_CNT_CCKTXEN, B_CNT_CCKTXEN},
+	.cck_cca = {R_CNT_CCK_CCA_P0, B_CNT_CCK_CCA_P0},
+	.cck_sfd_gg = {R_SFD_GG_CNT_V1, B_SFD_GG_CNT},
+	.cck_sig_gg = {R_SIG_GG_CNT_V1, B_SIG_GG_CNT_V1},
+	.cck_spoofing = {R_SPOOF_CNT_V1, B_SPOOF_CNT_V1},
+	.cck_brk = {R_BRK_CNT, B_BRK_CNT},
+	.brk = {R_CNT_BRK, B_CNT_BRK},
+	.brk_option = {R_BRK_OPT, B_BRK_OPT},
+	.search_fail = {R_CNT_SEARCH_FAIL, B_CNT_SEARCH_FAIL},
+	.lsig_brk_s_th = {R_CNT_LSIG_BRK_S_TH, B_CNT_LSIG_BRK_S_TH},
+	.lsig_brk_l_th = {R_CNT_LSIG_BRK_L_TH, B_CNT_LSIG_BRK_L_TH},
+	.rxl_err_parity = {R_CNT_RXL_ERR_PARITY, B_CNT_RXL_ERR_PARITY},
+	.rxl_err_rate = {R_CNT_RXL_ERR_RATE, B_CNT_RXL_ERR_RATE},
+	.ofdm_cca = {R_CNT_OFDM_CCA, B_CNT_OFDM_CCA},
+	.cca_spoofing = {R_CNT_CCA_SPOOFING, B_CNT_CCA_SPOOFING},
+	.ampdu_miss = {R_CNT_AMPDU_MISS, B_CNT_AMPDU_MISS},
+	.r1b_rx_rpt_rst = {R_R1B_RX_RPT_RST_V1, B_R1B_RX_RPT_RST_V1},
+	.r1b_rr_sel = {},
+	.enable_all_cnt = {R_ENABLE_ALL_CNT, B_ENABLE_ALL_CNT},
+	.rst_all_cnt = {R_RST_ALL_CNT, B_RST_ALL_CNT},
+	.cck_crc32 = R_CNT_CCK_CRC32_P0,
+	.cck_crc32_ok_mask = B_CNT_CCK_CRC32OK_P0,
+	.cck_crc32_fail_mask = B_CNT_CCK_CRC32FAIL_P0,
+	.ofdm_txon = R_CNT_OFDMTXON,
+	.ofdm_txon_mask = B_CNT_OFDMTXON,
+	.ofdm_txen_mask = B_CNT_OFDMTXEN,
+	.l_crc = R_CNT_L_CRC,
+	.l_crc_ok_mask = B_CNT_L_CRC_OK,
+	.l_crc_err_mask = B_CNT_L_CRC_ERR,
+	.ht_crc = R_CNT_HT_CRC,
+	.ht_crc_ok_mask = B_CNT_HT_CRC_OK,
+	.ht_crc_err_mask = B_CNT_HT_CRC_ERR,
+	.vht_crc = R_CNT_VHT_CRC,
+	.vht_crc_ok_mask = B_CNT_VHT_CRC_OK,
+	.vht_crc_err_mask = B_CNT_VHT_CRC_ERR,
+	.he_crc = R_CNT_HE_CRC,
+	.he_crc_ok_mask = B_CNT_HE_CRC_OK,
+	.he_crc_err_mask = B_CNT_HE_CRC_ERR,
+	.eht_crc = 0,
+	.eht_crc_ok_mask = 0,
+	.eht_crc_err_mask = 0,
+	.ampdu_crc = R_CNT_AMPDU_RX_CRC32,
+	.ampdu_crc_ok_mask = B_CNT_AMPDU_RX_CRC32_OK,
+	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
+};
+
 static void rtw8852c_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
 				    enum rtw89_phy_idx phy_idx);
 
@@ -3252,6 +3300,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.btc_sb			= {{{R_AX_SCOREBOARD, R_AX_SCOREBOARD},}},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8852c_edcca_regs,
+	.pmac_regs		= &rtw8852c_pmac_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852c,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 3c453b93c52e..e6f15ee2a86b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -383,6 +383,54 @@ static const struct rtw89_edcca_regs rtw8922a_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_BE_M,
 };
 
+static const struct rtw89_pmac_regs rtw8922a_pmac_regs = {
+	.cck_txon = {R_CNT_CCKTXON_V1, B_CNT_CCKTXON},
+	.cck_txen = {R_CNT_CCKTXEN_V1, B_CNT_CCKTXEN},
+	.cck_cca = {R_CNT_CCK_CCA_P0_V1, B_CNT_CCK_CCA_P0},
+	.cck_sfd_gg = {R_SFD_GG_CNT_V2, B_SFD_GG_CNT},
+	.cck_sig_gg = {R_SIG_GG_CNT_V2, B_SIG_GG_CNT_V1},
+	.cck_spoofing = {R_SPOOF_CNT_V2, B_SPOOF_CNT_V1},
+	.cck_brk = {R_BRK_CNT_V1, B_BRK_CNT},
+	.brk = {R_CNT_BRK_V1, B_CNT_BRK},
+	.brk_option = {},
+	.search_fail = {R_CNT_SEARCH_FAIL_V1, B_CNT_SEARCH_FAIL},
+	.lsig_brk_s_th = {R_CNT_LSIG_BRK_S_TH_V1, B_CNT_LSIG_BRK_S_TH},
+	.lsig_brk_l_th = {R_CNT_LSIG_BRK_L_TH_V1, B_CNT_LSIG_BRK_L_TH},
+	.rxl_err_parity = {R_CNT_RXL_ERR_PARITY_V1, B_CNT_RXL_ERR_PARITY},
+	.rxl_err_rate = {R_CNT_RXL_ERR_RATE_V1, B_CNT_RXL_ERR_RATE},
+	.ofdm_cca = {R_CNT_OFDM_CCA_V1, B_CNT_OFDM_CCA},
+	.cca_spoofing = {R_CNT_CCA_SPOOFING_V1, B_CNT_CCA_SPOOFING},
+	.ampdu_miss = {R_CNT_AMPDU_MISS_V1, B_CNT_AMPDU_MISS},
+	.r1b_rx_rpt_rst = {R_R1B_RX_RPT_RST_BE, B_R1B_RX_RPT_RST_V1},
+	.r1b_rr_sel = {},
+	.enable_all_cnt = {R_ENABLE_ALL_CNT, B_ENABLE_ALL_CNT},
+	.rst_all_cnt = {R_RST_ALL_CNT, B_RST_ALL_CNT},
+	.cck_crc32 = R_CNT_CCK_CRC32_P0_V1,
+	.cck_crc32_ok_mask = B_CNT_CCK_CRC32OK_P0,
+	.cck_crc32_fail_mask = B_CNT_CCK_CRC32FAIL_P0,
+	.ofdm_txon = R_CNT_OFDMTXON_V1,
+	.ofdm_txon_mask = B_CNT_OFDMTXON,
+	.ofdm_txen_mask = B_CNT_OFDMTXEN,
+	.l_crc = R_CNT_L_CRC_V1,
+	.l_crc_ok_mask = B_CNT_L_CRC_OK,
+	.l_crc_err_mask = B_CNT_L_CRC_ERR,
+	.ht_crc = R_CNT_HT_CRC_V1,
+	.ht_crc_ok_mask = B_CNT_HT_CRC_OK,
+	.ht_crc_err_mask = B_CNT_HT_CRC_ERR,
+	.vht_crc = R_CNT_VHT_CRC_V1,
+	.vht_crc_ok_mask = B_CNT_VHT_CRC_OK,
+	.vht_crc_err_mask = B_CNT_VHT_CRC_ERR,
+	.he_crc = R_CNT_HE_CRC_V1,
+	.he_crc_ok_mask = B_CNT_HE_CRC_OK,
+	.he_crc_err_mask = B_CNT_HE_CRC_ERR,
+	.eht_crc = R_CNT_EHT_CRC,
+	.eht_crc_ok_mask = B_CNT_EHT_CRC_OK,
+	.eht_crc_err_mask = B_CNT_EHT_CRC_ERR,
+	.ampdu_crc = R_CNT_AMPDU_RX_CRC32_V1,
+	.ampdu_crc_ok_mask = B_CNT_AMPDU_RX_CRC32_OK,
+	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
+};
+
 static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_SYS]			= {.offset = 0x00000, .size = 0x310},
 	[RTW89_EFUSE_BLOCK_RF]			= {.offset = 0x10000, .size = 0x240},
@@ -3245,6 +3293,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.btc_sb			= {{{R_BE_SCOREBOARD, R_BE_SCOREBOARD},}},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8922a_edcca_regs,
+	.pmac_regs		= &rtw8922a_pmac_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8922a,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index ba736b967880..b8b75fca0a1b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -227,6 +227,54 @@ static const struct rtw89_edcca_regs rtw8922d_edcca_regs = {
 	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_BE_M,
 };
 
+static const struct rtw89_pmac_regs rtw8922d_pmac_regs = {
+	.cck_txon = {R_CNT_CCKTXON_BE4, B_CNT_CCKTXON},
+	.cck_txen = {R_CNT_CCKTXEN_BE4, B_CNT_CCKTXEN},
+	.cck_cca = {R_CNT_CCK_CCA_BE4, B_CNT_CCK_CCA_BE4},
+	.cck_sfd_gg = {R_SFD_GG_CNT_BE4, B_SFD_GG_CNT},
+	.cck_sig_gg = {R_SIG_GG_CNT_BE4, B_SIG_GG_CNT_V1},
+	.cck_spoofing = {R_SPOOF_CNT_BE4, B_SPOOF_CNT_V1},
+	.cck_brk = {R_BRK_CNT_BE4, B_BRK_CNT},
+	.brk = {R_CNT_BRK_BE4, B_CNT_BRK},
+	.brk_option = {},
+	.search_fail = {R_CNT_SEARCH_FAIL_BE4, B_CNT_SEARCH_FAIL},
+	.lsig_brk_s_th = {R_CNT_LSIG_BRK_S_TH_BE4, B_CNT_LSIG_BRK_S_TH},
+	.lsig_brk_l_th = {R_CNT_LSIG_BRK_L_TH_BE4, B_CNT_LSIG_BRK_L_TH},
+	.rxl_err_parity = {R_CNT_RXL_ERR_PARITY_BE4, B_CNT_RXL_ERR_PARITY},
+	.rxl_err_rate = {R_CNT_RXL_ERR_RATE_BE4, B_CNT_RXL_ERR_RATE},
+	.ofdm_cca = {R_CNT_OFDM_CCA_BE4, B_CNT_OFDM_CCA},
+	.cca_spoofing = {R_CNT_CCA_SPOOFING_BE4, B_CNT_CCA_SPOOFING},
+	.ampdu_miss = {R_CNT_AMPDU_MISS_BE4, B_CNT_AMPDU_MISS},
+	.r1b_rx_rpt_rst = {R_R1B_RX_RPT_RST_BE4, B_R1B_RX_RPT_RST_V1},
+	.r1b_rr_sel = {},
+	.enable_all_cnt = {R_ENABLE_ALL_CNT_BE4, B_ENABLE_ALL_CNT},
+	.rst_all_cnt = {R_RST_ALL_CNT_BE4, B_RST_ALL_CNT},
+	.cck_crc32 = R_CNT_CCK_CRC32_BE4,
+	.cck_crc32_ok_mask = B_CNT_CCK_CRC32OK_BE4,
+	.cck_crc32_fail_mask = B_CNT_CCK_CRC32FAIL_BE4,
+	.ofdm_txon = R_CNT_OFDMTXON_BE4,
+	.ofdm_txon_mask = B_CNT_OFDMTXON,
+	.ofdm_txen_mask = B_CNT_OFDMTXEN,
+	.l_crc = R_CNT_L_CRC_BE4,
+	.l_crc_ok_mask = B_CNT_L_CRC_OK,
+	.l_crc_err_mask = B_CNT_L_CRC_ERR,
+	.ht_crc = R_CNT_HT_CRC_BE4,
+	.ht_crc_ok_mask = B_CNT_HT_CRC_OK,
+	.ht_crc_err_mask = B_CNT_HT_CRC_ERR,
+	.vht_crc = R_CNT_VHT_CRC_BE4,
+	.vht_crc_ok_mask = B_CNT_VHT_CRC_OK,
+	.vht_crc_err_mask = B_CNT_VHT_CRC_ERR,
+	.he_crc = R_CNT_HE_CRC_BE4,
+	.he_crc_ok_mask = B_CNT_HE_CRC_OK,
+	.he_crc_err_mask = B_CNT_HE_CRC_ERR,
+	.eht_crc = R_CNT_EHT_CRC_BE4,
+	.eht_crc_ok_mask = B_CNT_EHT_CRC_OK,
+	.eht_crc_err_mask = B_CNT_EHT_CRC_ERR,
+	.ampdu_crc = R_CNT_AMPDU_RX_CRC32_BE4,
+	.ampdu_crc_ok_mask = B_CNT_AMPDU_RX_CRC32_OK,
+	.ampdu_crc_err_mask = B_CNT_AMPDU_RX_CRC32_ERR,
+};
+
 static const struct rtw89_efuse_block_cfg rtw8922d_efuse_blocks[] = {
 	[RTW89_EFUSE_BLOCK_SYS]			= {.offset = 0x00000, .size = 0x310},
 	[RTW89_EFUSE_BLOCK_RF]			= {.offset = 0x10000, .size = 0x240},
@@ -3085,6 +3133,7 @@ const struct rtw89_chip_info rtw8922d_chip_info = {
 				  BIT(RTW89_DMA_ACH5) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B0HI) | BIT(RTW89_DMA_B1HI),
 	.edcca_regs		= &rtw8922d_edcca_regs,
+	.pmac_regs		= &rtw8922d_pmac_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8922d,
 #endif
-- 
2.25.1


