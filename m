Return-Path: <linux-wireless+bounces-35626-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNesH3kH8mkimwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35626-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:28:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D47494D1A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 15:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF1FE3017DAA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF883FD142;
	Wed, 29 Apr 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="duJlCuWq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DC3D1CDF
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469226; cv=none; b=GzQG8skX81xfRk9+08X3KTZj1BmZUUQShkJdVSmcsmzM69/zBVKni6i9tvYdBB4kTSerUdhKdc5LtD+0E5PUU3/lXMnhtNfIhUQaNy0ioNLpxOo9hyVOXlwKyDvw8FnvUsstSzKhsmT8L0vNv4XfpoULjxXKmmtVJZCrEbPQP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469226; c=relaxed/simple;
	bh=4VsD7Upeyw3ImHAvidOEsEwhH4mhzVOmZNbl9oE6jm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaaP7P+ZBdx9JA659jK6eNvuoCUGEDoQBXwzm2I5ugYhJ3RZTIxjLXr0qN/uMiA14ZdO+usYGefeLoHpaBCdMvATCdd68eaY4fiRfNMFIZaU+SEyjrySaauFOafD0DRnpH640Q06DokyLcVIFGQj9Wq2XcvCm3khwggthQasVbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=duJlCuWq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63TDR28f81223116, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1777469222; bh=ROhgfrblxkZXYvsKDLIw2tN81R2qfZMCYR09ktPD8LM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=duJlCuWqbIFHcAeYlzVpK0De+UWybmgjkwG9axmly/a0KWJjEpYFSGYwzUyMZntEe
	 0FCN3fffPsDoOhFc3WzJ0WXF6Kllxq9zFlAKfDJMiYit4GBwepHIV7WfNYuG+wfMXd
	 05thmn3IyjF2Y14EQRTx7qU0KmzgpnKTTbABX5Goj85O5dr9thnedyxiH7afIeBn7E
	 KknerlXOpBx1XoWwPkzdO8sPb0UnqGMkFUjP78XTBBtbAXbsp1VNr9LC7jsnUvnYyj
	 b0GhAawGzBjMi5iDftUrE19NO9+OEcGKnTDAfhFB8SgEmJAHK/Pwh5VT3/PRER0aXn
	 w2cbvky1S4s2A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 63TDR28f81223116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:27:02 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 29 Apr 2026 21:27:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 29 Apr 2026 21:27:02 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Apr 2026 21:27:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 7/7] wifi: rtw89: debug: add BB diagnose
Date: Wed, 29 Apr 2026 21:26:25 +0800
Message-ID: <20260429132625.1659182-8-pkshih@realtek.com>
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
X-Rspamd-Queue-Id: 40D47494D1A
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
	TAGGED_FROM(0.00)[bounces-35626-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:email,realtek.com:dkim,realtek.com:mid];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]

From: Kuan-Chung Chen <damon.chen@realtek.com>

Add BB diagnostic to track potential abnormal conditions. Currently,
five diagnostic metrics are monitored: 1) Hang detection monitors
consecutive absence of TX and RX activity. 2) PD maximum triggers
when PD stays at its maximum threshold for a period. 3) No RX
occurs when no CCA activity is detected over multiple consecutive
cycles. 4) High FA indicates a high false alarm ratio, reflecting
severe environmental interference. 5) EDCCA alerts when high EDCCA
ratio, signaling a potential TX hang.

These metrics are exposed via debugfs diag_bb.

Output:

  [PHY 0]
  Diag bitmap = 0x0
  Event{Hang, PD MAX, No RX, High FA, High EDCCA Ratio} = {0, 0, 0, 0, 0}
  consecutive_no_tx_cnt=0, consecutive_no_rx_cnt=0

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  23 ++++
 drivers/net/wireless/realtek/rtw89/debug.c  |  43 ++++++
 drivers/net/wireless/realtek/rtw89/phy.c    | 144 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h    |   4 +
 drivers/net/wireless/realtek/rtw89/phy_be.c |   8 ++
 drivers/net/wireless/realtek/rtw89/reg.h    |   8 ++
 6 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c0e176c4c3a6..bccfee7535a7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5578,6 +5578,7 @@ struct rtw89_pmac_stat_info {
 	u32 ofdm_phy_txon;
 	u32 cnt_ofdm_cca;
 	u32 cnt_cck_cca;
+	u32 cnt_cca_all;
 	u32 cnt_cck_spoofing;
 	u32 cnt_ofdm_spoofing;
 	u32 cnt_ampdu_miss;
@@ -5601,6 +5602,7 @@ struct rtw89_pmac_stat_info {
 	u32 cnt_sig_gg;
 	u32 cnt_cck_fail;
 	u32 cnt_ofdm_fail;
+	u32 cnt_fail_all;
 	u32 cnt_lsig_brk_s_th;
 	u32 cnt_lsig_brk_l_th;
 	u32 cnt_parity_fail;
@@ -5624,6 +5626,23 @@ struct rtw89_tx_stat_info {
 	bool stbc;
 };
 
+enum rtw89_diag_bb_type {
+	RTW89_DIAG_BB_HANG,
+	RTW89_DIAG_BB_PD,
+	RTW89_DIAG_BB_NO_RX,
+	RTW89_DIAG_BB_FA,
+	RTW89_DIAG_BB_EDCCA,
+
+	RTW89_DIAG_BB_NR,
+};
+
+struct rtw89_diag_bb {
+	u32 diag_bb_bitmap; /* bitmap of enum rtw89_diag_bb_type */
+	u32 diag_bb_cnt[RTW89_DIAG_BB_NR];
+	u16 consecutive_no_tx_cnt;
+	u16 consecutive_no_rx_cnt;
+};
+
 struct rtw89_agc_gaincode_set {
 	u8 lna_idx;
 	u8 tia_idx;
@@ -5639,6 +5658,7 @@ struct rtw89_dig_info {
 	struct rtw89_agc_gaincode_set cur_gaincode;
 	bool force_gaincode_idx_en;
 	struct rtw89_agc_gaincode_set force_gaincode;
+	enum rtw89_dig_noisy_level noisy_lv;
 	u8 igi_rssi_th[IGI_RSSI_TH_NUM];
 	u16 fa_th[FA_TH_NUM];
 	u8 igi_rssi;
@@ -5648,6 +5668,7 @@ struct rtw89_dig_info {
 	u8 dyn_igi_min;
 	bool dyn_pd_th_en;
 	u8 dyn_pd_th_max;
+	u8 dyn_pd_max_cnt;
 	u8 pd_low_th_ofst;
 	u8 ib_pbk;
 	s8 ib_pkpwr;
@@ -5912,6 +5933,7 @@ struct rtw89_env_monitor_info {
 	u8 nhm_th[RTW89_NHM_RPT_NUM];
 	struct rtw89_nhm_report *nhm_his[RTW89_BAND_NUM];
 	struct list_head nhm_rpt_list;
+	u8 edcca_clm_ratio;
 };
 
 enum rtw89_ser_rcvy_step {
@@ -6452,6 +6474,7 @@ struct rtw89_dev {
 		struct rtw89_pkt_stat last_pkt_stat;
 		struct rtw89_pmac_stat_info pmac_stat;
 		struct rtw89_tx_stat_info tx_stat;
+		struct rtw89_diag_bb diag;
 	} bbs[RTW89_PHY_NUM];
 
 	struct wiphy_delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 103948aee5cb..597052261974 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -92,6 +92,7 @@ struct rtw89_debugfs {
 	struct rtw89_debugfs_priv mlo_mode;
 	struct rtw89_debugfs_priv beacon_info;
 	struct rtw89_debugfs_priv diag_mac;
+	struct rtw89_debugfs_priv diag_bb;
 };
 
 struct rtw89_debugfs_iter_data {
@@ -5214,6 +5215,46 @@ rtw89_debug_priv_diag_mac_get(struct rtw89_dev *rtwdev,
 	return rtw89_mac_diag_iter_all(rtwdev, buf, bufsz);
 }
 
+static int rtw89_get_diag_bb(struct rtw89_dev *rtwdev,  struct rtw89_bb_ctx *bb,
+			     char *buf, size_t bufsz)
+{
+	struct rtw89_diag_bb *diag = &bb->diag;
+	char *p = buf, *end = buf + bufsz;
+
+	p += scnprintf(p, end - p, "[PHY %u]\n", bb->phy_idx);
+	p += scnprintf(p, end - p, "Diag bitmap = 0x%x\n", diag->diag_bb_bitmap);
+	p += scnprintf(p, end - p,
+		       "Event{Hang, PD MAX, No RX, High FA, High EDCCA Ratio} = ");
+	p += scnprintf(p, end - p, "{%d, %d, %d, %d, %d}\n",
+		       diag->diag_bb_cnt[RTW89_DIAG_BB_HANG],
+		       diag->diag_bb_cnt[RTW89_DIAG_BB_PD],
+		       diag->diag_bb_cnt[RTW89_DIAG_BB_NO_RX],
+		       diag->diag_bb_cnt[RTW89_DIAG_BB_FA],
+		       diag->diag_bb_cnt[RTW89_DIAG_BB_EDCCA]);
+	p += scnprintf(p, end - p,
+		       "consecutive_no_tx_cnt=%d, consecutive_no_rx_cnt=%d\n\n",
+		       diag->consecutive_no_tx_cnt,
+		       diag->consecutive_no_rx_cnt);
+
+	return p - buf;
+}
+
+static ssize_t
+rtw89_debug_priv_diag_bb_get(struct rtw89_dev *rtwdev,
+			     struct rtw89_debugfs_priv *debugfs_priv,
+			     char *buf, size_t bufsz)
+{
+	char *p = buf, *end = buf + bufsz;
+	struct rtw89_bb_ctx *bb;
+
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
+	rtw89_for_each_active_bb(rtwdev, bb)
+		p += rtw89_get_diag_bb(rtwdev, bb, p, end - p);
+
+	return p - buf;
+}
+
 static int rtw89_get_beacon_info(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb,
 				 char *buf, size_t bufsz)
 {
@@ -5348,6 +5389,7 @@ static const struct rtw89_debugfs rtw89_debugfs_templ = {
 	.mlo_mode = rtw89_debug_priv_set_and_get(mlo_mode, RWLOCK),
 	.beacon_info = rtw89_debug_priv_get(beacon_info),
 	.diag_mac = rtw89_debug_priv_get(diag_mac, RSIZE_16K, RLOCK),
+	.diag_bb = rtw89_debug_priv_get(diag_bb, RSIZE_8K, RLOCK),
 };
 
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
@@ -5398,6 +5440,7 @@ void rtw89_debugfs_add_sec1(struct rtw89_dev *rtwdev, struct dentry *debugfs_top
 	rtw89_debugfs_add_rw(mlo_mode);
 	rtw89_debugfs_add_r(beacon_info);
 	rtw89_debugfs_add_r(diag_mac);
+	rtw89_debugfs_add_r(diag_bb);
 }
 
 void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index cf7382e36b75..f98a77f9fc1a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5847,6 +5847,50 @@ static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 	rtwdev->hal.thermal_prot_lv = 0;
 }
 
+static void rtw89_phy_pmac_diag(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+#define RTW89_DIAG_BB_FA_RATIO_TH 80
+#define RTW89_DIAG_BB_NO_RX_TH 5
+#define RTW89_DIAG_BB_HANG_TH 30
+	struct rtw89_pmac_stat_info *pmac_stat = &bb->pmac_stat;
+	bool is_linked = rtwdev->total_sta_assoc > 0;
+	struct rtw89_diag_bb *diag = &bb->diag;
+	u8 fa_ratio = 0;
+
+	if (!(pmac_stat->cck_mac_txen || pmac_stat->ofdm_mac_txen))
+		diag->consecutive_no_tx_cnt++;
+	else
+		diag->consecutive_no_tx_cnt = 0;
+
+	if (!pmac_stat->cnt_cca_all)
+		diag->consecutive_no_rx_cnt++;
+	else
+		diag->consecutive_no_rx_cnt = 0;
+
+	if (pmac_stat->cnt_cca_all)
+		fa_ratio = pmac_stat->cnt_fail_all * PERCENT / pmac_stat->cnt_cca_all;
+
+	diag->diag_bb_bitmap &= ~(BIT(RTW89_DIAG_BB_NO_RX) |
+				  BIT(RTW89_DIAG_BB_HANG) |
+				  BIT(RTW89_DIAG_BB_FA));
+
+	if (diag->consecutive_no_rx_cnt >= RTW89_DIAG_BB_NO_RX_TH && is_linked) {
+		diag->diag_bb_bitmap |= BIT(RTW89_DIAG_BB_NO_RX);
+		diag->diag_bb_cnt[RTW89_DIAG_BB_NO_RX]++;
+	}
+
+	if (fa_ratio >= RTW89_DIAG_BB_FA_RATIO_TH && is_linked) {
+		diag->diag_bb_bitmap |= BIT(RTW89_DIAG_BB_FA);
+		diag->diag_bb_cnt[RTW89_DIAG_BB_FA]++;
+	}
+
+	if (diag->consecutive_no_tx_cnt > RTW89_DIAG_BB_HANG_TH &&
+	    diag->consecutive_no_rx_cnt > RTW89_DIAG_BB_HANG_TH) {
+		diag->diag_bb_bitmap |= BIT(RTW89_DIAG_BB_HANG);
+		diag->diag_bb_cnt[RTW89_DIAG_BB_HANG]++;
+	}
+}
+
 static void rtw89_phy_pmac_stat_reset(struct rtw89_dev *rtwdev,
 				      struct rtw89_bb_ctx *bb, bool cck)
 {
@@ -6017,6 +6061,14 @@ static void rtw89_phy_pmac_stat_update(struct rtw89_dev *rtwdev,
 
 	rtw89_phy_pmac_stat_ofdm(rtwdev, bb);
 
+	pmac->cnt_fail_all = pmac->cnt_ofdm_fail;
+	pmac->cnt_cca_all = pmac->cnt_ofdm_cca;
+
+	if (cck) {
+		pmac->cnt_fail_all += pmac->cnt_cck_fail;
+		pmac->cnt_cca_all += pmac->cnt_cck_cca;
+	}
+
 	pmac->cnt_crc32_error_all = pmac->cnt_he_crc32_error +
 				    pmac->cnt_vht_crc32_error +
 				    pmac->cnt_ht_crc32_error +
@@ -6034,6 +6086,7 @@ static void rtw89_phy_pmac_stat_update(struct rtw89_dev *rtwdev,
 		pmac->cnt_crc32_ok_all += pmac->cnt_eht_crc32_ok;
 	}
 
+	rtw89_phy_pmac_diag(rtwdev, bb);
 	rtw89_phy_pmac_stat_reset(rtwdev, bb, cck);
 }
 
@@ -6722,6 +6775,29 @@ static bool rtw89_phy_ifs_clm_get_result(struct rtw89_dev *rtwdev,
 	return true;
 }
 
+static bool rtw89_phy_edcca_clm_get_result(struct rtw89_dev *rtwdev,
+					   struct rtw89_bb_ctx *bb)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	const struct rtw89_ccx_regs *ccx = phy->ccx;
+	u32 val;
+
+	val = rtw89_phy_read32_idx(rtwdev, ccx->edcca_clm_rdy,
+				   ccx->edcca_clm_rdy_mask, bb->phy_idx);
+	if (!val) {
+		rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
+			    "Get EDCCA_CLM report Fail\n");
+		return false;
+	}
+
+	val = rtw89_phy_read32_idx(rtwdev, ccx->edcca_clm_cnt,
+				   ccx->edcca_clm_cnt_mask, bb->phy_idx);
+	env->edcca_clm_ratio = rtw89_phy_ccx_get_report(rtwdev, bb, val, PERCENT);
+
+	return true;
+}
+
 static void rtw89_phy_nhm_th_update(struct rtw89_dev *rtwdev,
 				    struct rtw89_bb_ctx *bb)
 {
@@ -6889,6 +6965,9 @@ static void __rtw89_phy_env_monitor_track(struct rtw89_dev *rtwdev,
 	if (rtw89_phy_ifs_clm_get_result(rtwdev, bb))
 		env->ccx_watchdog_result |= RTW89_PHY_ENV_MON_IFS_CLM;
 
+	if (rtw89_phy_edcca_clm_get_result(rtwdev, bb))
+		env->ccx_watchdog_result |= RTW89_PHY_ENV_MON_EDCCA_CLM;
+
 	rtw89_phy_ccx_racing_release(rtwdev, bb);
 	para.mntr_time = 1900;
 	para.rac_lv = RTW89_RAC_LV_1;
@@ -7195,6 +7274,7 @@ static void rtw89_phy_dig_para_reset(struct rtw89_dev *rtwdev,
 	dig->dyn_igi_max = igi_max_performance_mode;
 	dig->dyn_igi_min = dynamic_igi_min;
 	dig->dyn_pd_th_max = dynamic_pd_threshold_max;
+	dig->dyn_pd_max_cnt = 0;
 	dig->pd_low_th_ofst = pd_low_th_offset;
 	dig->is_linked_pre = false;
 }
@@ -7318,6 +7398,7 @@ static void rtw89_phy_dig_igi_offset_by_env(struct rtw89_dev *rtwdev,
 
 	igi_offset = min_t(u8, igi_offset, IGI_OFFSET_MAX);
 	dig->fa_rssi_ofst = igi_offset;
+	dig->noisy_lv = noisy_lv;
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG,
 		    "fa_th: [+6 (%d) +4 (%d) +2 (%d) 0 (%d) -2 ]\n",
@@ -7548,10 +7629,33 @@ void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 	rtw89_phy_dig_update_para(rtwdev, bb);
 }
 
+static void rtw89_phy_dig_diag(struct rtw89_dev *rtwdev,
+			       struct rtw89_bb_ctx *bb, bool is_linked)
+{
+#define RTW89_DIAG_BB_PD_MAX_PERIOD 5
+	struct rtw89_diag_bb *diag = &bb->diag;
+	struct rtw89_dig_info *dig = &bb->dig;
+
+	diag->diag_bb_bitmap &= ~BIT(RTW89_DIAG_BB_PD);
+
+	if (dig->dyn_igi_max != dig->igi_fa_rssi ||
+	    dig->noisy_lv < RTW89_DIG_NOISY_LEVEL_MAX) {
+		dig->dyn_pd_max_cnt = 0;
+		return;
+	}
+
+	if (++dig->dyn_pd_max_cnt < RTW89_DIAG_BB_PD_MAX_PERIOD || !is_linked)
+		return;
+
+	diag->diag_bb_bitmap |= BIT(RTW89_DIAG_BB_PD);
+	diag->diag_bb_cnt[RTW89_DIAG_BB_PD]++;
+}
+
 #define IGI_RSSI_MIN 10
 #define ABS_IGI_MIN 0xc
 static
-void rtw89_phy_cal_igi_fa_rssi(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+void rtw89_phy_cal_igi_fa_rssi(struct rtw89_dev *rtwdev,
+			       struct rtw89_bb_ctx *bb, bool is_linked)
 {
 	struct rtw89_dig_info *dig = &bb->dig;
 	u8 igi_min;
@@ -7569,6 +7673,8 @@ void rtw89_phy_cal_igi_fa_rssi(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb
 	} else {
 		dig->igi_fa_rssi = dig->dyn_igi_max;
 	}
+
+	rtw89_phy_dig_diag(rtwdev, bb, is_linked);
 }
 
 struct rtw89_phy_iter_mcc_dig {
@@ -7597,7 +7703,7 @@ static void rtw89_phy_set_mcc_dig(struct rtw89_dev *rtwdev,
 	}
 
 	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
-	rtw89_phy_cal_igi_fa_rssi(rtwdev, bb);
+	rtw89_phy_cal_igi_fa_rssi(rtwdev, bb, is_linked);
 	pd_val = __rtw89_phy_dig_dyn_pd_th(rtwdev, bb, dig->igi_fa_rssi,
 					   is_linked, chan);
 	rtw89_fw_h2c_mcc_dig(rtwdev, rtwvif_link->chanctx_idx,
@@ -7742,7 +7848,7 @@ static void __rtw89_phy_dig(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 	}
 	dig->is_linked_pre = is_linked;
 
-	rtw89_phy_cal_igi_fa_rssi(rtwdev, bb);
+	rtw89_phy_cal_igi_fa_rssi(rtwdev, bb, is_linked);
 
 	rtw89_debug(rtwdev, RTW89_DBG_DIG,
 		    "rssi=%03d, dyn_joint(max,min)=(%d,%d), final_rssi=%d\n",
@@ -7997,6 +8103,14 @@ static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 		__rtw89_phy_env_monitor_init(rtwdev, bb);
 }
 
+static void rtw89_phy_diag_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_capab_bb(rtwdev, bb)
+		memset(&bb->diag, 0, sizeof(bb->diag));
+}
+
 static void __rtw89_phy_edcca_init(struct rtw89_dev *rtwdev,
 				   struct rtw89_bb_ctx *bb)
 {
@@ -8037,6 +8151,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 
 	rtw89_chip_bb_sethw(rtwdev);
 
+	rtw89_phy_diag_init(rtwdev);
 	rtw89_phy_env_monitor_init(rtwdev);
 	rtw89_phy_nhm_setting_init(rtwdev);
 	rtw89_physts_parsing_init(rtwdev);
@@ -8613,6 +8728,24 @@ void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb
 			      edcca_regs->ppdu_mask, th, bb->phy_idx);
 }
 
+static void rtw89_phy_edcca_diag(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+#define RTW89_DIAG_BB_EDCCA_RATIO_TH 50
+#define RTW89_DIAG_BB_EDCCA_TX_TH 10
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	struct rtw89_traffic_stats *stats = &rtwdev->stats;
+	struct rtw89_diag_bb *diag = &bb->diag;
+
+	diag->diag_bb_bitmap &= ~BIT(RTW89_DIAG_BB_EDCCA);
+
+	if (stats->tx_throughput <= RTW89_DIAG_BB_EDCCA_TX_TH ||
+	    env->edcca_clm_ratio <= RTW89_DIAG_BB_EDCCA_RATIO_TH)
+		return;
+
+	diag->diag_bb_bitmap |= BIT(RTW89_DIAG_BB_EDCCA);
+	diag->diag_bb_cnt[RTW89_DIAG_BB_EDCCA]++;
+}
+
 static
 void __rtw89_phy_edcca_track(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
@@ -8620,6 +8753,7 @@ void __rtw89_phy_edcca_track(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 
 	rtw89_phy_edcca_thre_calc(rtwdev, bb);
 	rtw89_phy_edcca_log(rtwdev, bb);
+	rtw89_phy_edcca_diag(rtwdev, bb);
 }
 
 void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev)
@@ -8770,6 +8904,10 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_ax = {
 	.nhm_en_mask = B_NHM_EN_MSK,
 	.nhm_method = R_NHM_TH9,
 	.nhm_pwr_method_msk = B_NHM_PWDB_METHOD_MSK,
+	.edcca_clm_rdy = R_CLM_EDCCA_RDY,
+	.edcca_clm_rdy_mask = B_CLM_EDCCA_RDY,
+	.edcca_clm_cnt = R_CLM_EDCCA_RESULT,
+	.edcca_clm_cnt_mask = B_CLM_EDCCA_RESULT,
 };
 
 static const u32 rtw89_txinfo_reg_ax[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 830cabefca39..a6e685654037 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -471,6 +471,10 @@ struct rtw89_ccx_regs {
 	u32 nhm_en_mask;
 	u32 nhm_method;
 	u32 nhm_pwr_method_msk;
+	u32 edcca_clm_rdy;
+	u32 edcca_clm_rdy_mask;
+	u32 edcca_clm_cnt;
+	u32 edcca_clm_cnt_mask;
 };
 
 struct rtw89_physts_regs {
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 9caddd19384c..5cd298a2c91b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -74,6 +74,10 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_be = {
 	.nhm_en_mask = B_NHM_EN_MSK,
 	.nhm_method = R_NHM_TH9,
 	.nhm_pwr_method_msk = B_NHM_PWDB_METHOD_MSK,
+	.edcca_clm_rdy = R_CLM_EDCCA_RDY_V1,
+	.edcca_clm_rdy_mask = B_CLM_EDCCA_RDY,
+	.edcca_clm_cnt = R_CLM_EDCCA_RESULT_V1,
+	.edcca_clm_cnt_mask = B_CLM_EDCCA_RESULT,
 };
 
 static const struct rtw89_ccx_regs rtw89_ccx_regs_be_v1 = {
@@ -133,6 +137,10 @@ static const struct rtw89_ccx_regs rtw89_ccx_regs_be_v1 = {
 	.ifs_total_addr = R_IFS_TOTAL_BE4,
 	.ifs_cnt_done_mask = B_IFS_CNT_DONE_BE4,
 	.ifs_total_mask = B_IFS_TOTAL_BE4,
+	.edcca_clm_rdy = R_CLM_EDCCA_RDY_BE4,
+	.edcca_clm_rdy_mask = B_CLM_EDCCA_RDY,
+	.edcca_clm_cnt = R_CLM_EDCCA_RESULT_BE4,
+	.edcca_clm_cnt_mask = B_CLM_EDCCA_RESULT,
 };
 
 static const u32 rtw89_tx_info_reg_be[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index f5151e1ad58d..716747c3a10e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9146,6 +9146,14 @@
 #define B_NHM_CNT11_MSK GENMASK(31, 16)
 #define R_NHM_AX 0x1AA4
 #define B_NHM_READY_MSK BIT(16)
+#define R_CLM_EDCCA_RESULT 0x1AC8
+#define R_CLM_EDCCA_RESULT_V1 0x0EC8
+#define R_CLM_EDCCA_RESULT_BE4 0x20EC8
+#define B_CLM_EDCCA_RESULT GENMASK(15, 0)
+#define R_CLM_EDCCA_RDY 0x1AC8
+#define R_CLM_EDCCA_RDY_V1 0x0EC8
+#define R_CLM_EDCCA_RDY_BE4 0x20EC8
+#define B_CLM_EDCCA_RDY BIT(16)
 #define R_IFS_CLM_TX_CNT 0x1ACC
 #define R_IFS_CLM_TX_CNT_V1 0x0ECC
 #define R_IFS_CLM_TX_CNT_BE4 0x20ECC
-- 
2.25.1


