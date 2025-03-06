Return-Path: <linux-wireless+bounces-19831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02D5A5405E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BB13AAC3E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18EB18DB05;
	Thu,  6 Mar 2025 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Pwp9ELX8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB918DB3C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227132; cv=none; b=isVNyU+OMIEbTcZMkx48EPxb2ZDmvceiUH1EitDjUbVetb1MbSm08n6tuVfi9geFEfrcLQPAmSz6TiPeOq46NQ7dY00rgAbHFslpHq6Nf22TFfSiabA8Gx5KwYHAjAFQ0qlkvKF+QCDHUxiAwkqe771Fp9zdKCoEEaqRWr/H0Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227132; c=relaxed/simple;
	bh=mAF1SRGYMjSJYqtXVLNkar0szmTcGflMCTWKHAIowQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+mc64seYOmNQh4PJCdFz1X4cdq5La5ckJChlRKJOpHlINrcimrCwwR8IavhGBYy/ZhbLH0nvRmiaTrp3HAt7LU//mcyYONgOpTXKpt2eB7KO0KYLJdGyVj5QohatDz0KdL/g1X3yJTAA5Yux59KE66WNbwFoL+6OXBuZRuO9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Pwp9ELX8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5262C7Vy82495398, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741227127; bh=mAF1SRGYMjSJYqtXVLNkar0szmTcGflMCTWKHAIowQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Pwp9ELX862axvPNaGwMooD8KszlA5g+eYVNxxeLmfojFvTBRQM3ZoNk45k8ctqTq1
	 0kFkAxrV5VCpuQq5UAkOxIwC30UTT9ZjzskqfcU22inmg53Hx31G1NuvMTDSlGCzM8
	 uNrDxwG9Ci+BN4oLIxkaW9pUdm5dvP7cf5EbsvXZuQQwwuvybkv9wyDu1IW7jLSe3e
	 TswFTBEJWHP6s+i3O8s6caLexgTHuwB5NREGE14lqoVPZHuqaDElI2+4Lm3d/kpnuj
	 057hYq3pRTgu2AOSynbCkkhH2LkFupIpkjQ8rsZ/ZGrF58+v1wAYZGgh3D4Nfe45Gb
	 94Xe/ESVC7WRQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5262C7Vy82495398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 10:12:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 10:12:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 6 Mar
 2025 10:12:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH rtw-next 2/5] wifi: rtw89: refine mechanism of TAS
Date: Thu, 6 Mar 2025 10:11:41 +0800
Message-ID: <20250306021144.12854-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306021144.12854-1-pkshih@realtek.com>
References: <20250306021144.12854-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

TAS state switching mechanism now incorporates the TX ratio as a
decision parameter. The average power calculation has been improved
by using a higher resolution conversion from dBm to linear. During
scan or MCC operations, TAS state is forced to static SAR and
suspend the average power calculation. Additionally, TAS window
size depends on the regulatory domain and band to ensure compliance.

TAS is enabled when permitted by the regulatory domain and is
currently supported on the 8852CE.

For debugging, add a flag to disable_dm that can stop TAS mechanism.

Co-developed-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |  10 +-
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  28 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |   1 +
 drivers/net/wireless/realtek/rtw89/fw.h       |   6 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  24 ++
 drivers/net/wireless/realtek/rtw89/regd.c     |  13 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 drivers/net/wireless/realtek/rtw89/sar.c      | 369 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/sar.h      |   5 +-
 15 files changed, 377 insertions(+), 91 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index be6d73273910..f60e93870b09 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -8,6 +8,7 @@
 #include "fw.h"
 #include "mac.h"
 #include "ps.h"
+#include "sar.h"
 #include "util.h"
 
 static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
@@ -2673,6 +2674,7 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	struct rtw89_entity_weight w = {};
+	int ret;
 
 	rtwvif_link->chanctx_idx = cfg->idx;
 	rtwvif_link->chanctx_assigned = true;
@@ -2692,7 +2694,13 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 	rtw89_swap_chanctx(rtwdev, cfg->idx, RTW89_CHANCTX_0);
 
 out:
-	return rtw89_set_channel(rtwdev);
+	ret = rtw89_set_channel(rtwdev);
+	if (ret)
+		return ret;
+
+	rtw89_tas_reset(rtwdev, true);
+
+	return 0;
 }
 
 void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4d286182e21d..cc9b014457ac 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4601,8 +4601,6 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	rtw89_mac_cfg_phy_rpt_bands(rtwdev, true);
 	rtw89_mac_update_rts_threshold(rtwdev);
 
-	rtw89_tas_reset(rtwdev);
-
 	ret = rtw89_hci_start(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to start hci\n");
@@ -4956,6 +4954,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
 	rtw89_phy_config_edcca(rtwdev, bb, true);
+	rtw89_tas_scan(rtwdev, true);
 
 	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, mac_addr);
 }
@@ -4982,6 +4981,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 	rtw89_btc_ntfy_scan_finish(rtwdev, rtwvif_link->phy_idx);
 	bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
 	rtw89_phy_config_edcca(rtwdev, bb, false);
+	rtw89_tas_scan(rtwdev, false);
 
 	rtwdev->scanning = false;
 	rtw89_for_each_active_bb(rtwdev, bb)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3f62df657e1f..074c865e6d03 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4240,6 +4240,7 @@ enum rtw89_chanctx_state {
 enum rtw89_chanctx_callbacks {
 	RTW89_CHANCTX_CALLBACK_PLACEHOLDER,
 	RTW89_CHANCTX_CALLBACK_RFK,
+	RTW89_CHANCTX_CALLBACK_TAS,
 
 	NUM_OF_RTW89_CHANCTX_CALLBACKS,
 };
@@ -4281,6 +4282,7 @@ struct rtw89_chip_info {
 	bool support_unii4;
 	bool support_rnr;
 	bool support_ant_gain;
+	bool support_tas;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
 	bool rx_freq_frome_ie;
@@ -4679,18 +4681,29 @@ struct rtw89_6ghz_span {
 enum rtw89_tas_state {
 	RTW89_TAS_STATE_DPR_OFF,
 	RTW89_TAS_STATE_DPR_ON,
-	RTW89_TAS_STATE_DPR_FORBID,
+	RTW89_TAS_STATE_STATIC_SAR,
 };
 
-#define RTW89_TAS_MAX_WINDOW 50
+#define RTW89_TAS_TX_RATIO_WINDOW 6
+#define RTW89_TAS_TXPWR_WINDOW 180
 struct rtw89_tas_info {
-	s16 txpwr_history[RTW89_TAS_MAX_WINDOW];
-	s32 total_txpwr;
-	u8 cur_idx;
-	s8 dpr_gap;
-	s8 delta;
+	u16 tx_ratio_history[RTW89_TAS_TX_RATIO_WINDOW];
+	u64 txpwr_history[RTW89_TAS_TXPWR_WINDOW];
+	u8 txpwr_head_idx;
+	u8 txpwr_tail_idx;
+	u8 tx_ratio_idx;
+	u16 total_tx_ratio;
+	u64 total_txpwr;
+	u64 instant_txpwr;
+	u32 window_size;
+	s8 dpr_on_threshold;
+	s8 dpr_off_threshold;
+	enum rtw89_tas_state backup_state;
 	enum rtw89_tas_state state;
+	bool keep_history;
+	bool block_regd;
 	bool enable;
+	bool pause;
 };
 
 struct rtw89_chanctx_cfg {
@@ -4748,6 +4761,7 @@ struct rtw89_edcca_bak {
 enum rtw89_dm_type {
 	RTW89_DM_DYNAMIC_EDCCA,
 	RTW89_DM_THERMAL_PROTECT,
+	RTW89_DM_TAS,
 };
 
 #define RTW89_THERMAL_PROT_LV_MAX 5
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 885a5ebeb6cd..f2c5753fd386 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -4154,6 +4154,7 @@ static const struct rtw89_disabled_dm_info {
 } rtw89_disabled_dm_infos[] = {
 	DM_INFO(DYNAMIC_EDCCA),
 	DM_INFO(THERMAL_PROTECT),
+	DM_INFO(TAS),
 };
 
 static ssize_t
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index e0faed076150..55255b48bdb7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4543,6 +4543,12 @@ struct rtw89_c2h_rfk_report {
 	u8 version;
 } __packed;
 
+struct rtw89_c2h_rf_tas_info {
+	struct rtw89_c2h_hdr hdr;
+	__le32 cur_idx;
+	__le16 txpwr_history[20];
+} __packed;
+
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
 #define RTW89_FW_BACKTRACE_INFO_SIZE 8
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e4b690a5febc..abc2a7e989eb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3459,6 +3459,30 @@ rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u3
 static void
 rtw89_phy_c2h_rfk_log_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
+	const struct rtw89_c2h_rf_tas_info *rf_tas =
+		(const struct rtw89_c2h_rf_tas_info *)c2h->data;
+	const enum rtw89_sar_sources src = rtwdev->sar.src;
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	u64 linear = 0;
+	u32 i, cur_idx;
+	s16 txpwr;
+
+	if (!tas->enable || src == RTW89_SAR_SOURCE_NONE)
+		return;
+
+	cur_idx = le32_to_cpu(rf_tas->cur_idx);
+	for (i = 0; i < cur_idx; i++) {
+		txpwr = (s16)le16_to_cpu(rf_tas->txpwr_history[i]);
+		linear += rtw89_db_quarter_to_linear(txpwr);
+
+		rtw89_debug(rtwdev, RTW89_DBG_SAR,
+			    "tas: index: %u, txpwr: %d\n", i, txpwr);
+	}
+
+	if (cur_idx == 0)
+		tas->instant_txpwr = rtw89_db_to_linear(0);
+	else
+		tas->instant_txpwr = DIV_ROUND_DOWN_ULL(linear, cur_idx);
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 0e67d0f128dd..d31403f9009e 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -721,6 +721,18 @@ static void rtw89_regd_apply_policy_6ghz(struct rtw89_dev *rtwdev,
 		sband->channels[i].flags |= IEEE80211_CHAN_DISABLED;
 }
 
+static void rtw89_regd_apply_policy_tas(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd *regd = regulatory->regd;
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+
+	if (!tas->enable)
+		return;
+
+	tas->block_regd = !test_bit(RTW89_REGD_FUNC_TAS, regd->func_bitmap);
+}
+
 static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 				      struct wiphy *wiphy,
 				      struct regulatory_request *request)
@@ -738,6 +750,7 @@ static void rtw89_regd_notifier_apply(struct rtw89_dev *rtwdev,
 
 	rtw89_regd_apply_policy_unii4(rtwdev, wiphy);
 	rtw89_regd_apply_policy_6ghz(rtwdev, wiphy);
+	rtw89_regd_apply_policy_tas(rtwdev);
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index b709dd71b06a..0d482cd57f6e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2498,6 +2498,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
 	.support_ant_gain	= false,
+	.support_tas		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 638236bffebb..286334e26c84 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2216,6 +2216,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= false,
 	.support_ant_gain	= false,
+	.support_tas		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 8bec74716f84..eceb4fb9880d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -852,6 +852,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
 	.support_ant_gain	= true,
+	.support_tas		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index e62810660005..bbf37442c492 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -785,6 +785,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_80),
 	.support_unii4		= true,
 	.support_ant_gain	= true,
+	.support_tas		= false,
 	.ul_tb_waveform_ctrl	= true,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 5d3e105dc87f..08bcdf246382 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -12,6 +12,7 @@
 #include "rtw8852c.h"
 #include "rtw8852c_rfk.h"
 #include "rtw8852c_table.h"
+#include "sar.h"
 #include "util.h"
 
 #define RTW8852C_FW_FORMAT_MAX 1
@@ -2880,6 +2881,7 @@ static int rtw8852c_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 
 static const struct rtw89_chanctx_listener rtw8852c_chanctx_listener = {
 	.callbacks[RTW89_CHANCTX_CALLBACK_RFK] = rtw8852c_rfk_chanctx_cb,
+	.callbacks[RTW89_CHANCTX_CALLBACK_TAS] = rtw89_tas_chanctx_cb,
 };
 
 #ifdef CONFIG_PM
@@ -3011,6 +3013,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
 	.support_ant_gain	= true,
+	.support_tas		= true,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= true,
 	.rx_freq_frome_ie	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 210fa818ffe8..d90af2daebcf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2770,6 +2770,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
 	.support_ant_gain	= false,
+	.support_tas		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
 	.rx_freq_frome_ie	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 24a32dc4e67d..0b5af9528702 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -7,10 +7,16 @@
 #include "phy.h"
 #include "reg.h"
 #include "sar.h"
+#include "util.h"
 
 #define RTW89_TAS_FACTOR 2 /* unit: 0.25 dBm */
+#define RTW89_TAS_SAR_GAP (1 << RTW89_TAS_FACTOR)
 #define RTW89_TAS_DPR_GAP (1 << RTW89_TAS_FACTOR)
 #define RTW89_TAS_DELTA (2 << RTW89_TAS_FACTOR)
+#define RTW89_TAS_TX_RATIO_THRESHOLD 70
+#define RTW89_TAS_DFLT_TX_RATIO 80
+#define RTW89_TAS_DPR_ON_OFFSET (RTW89_TAS_DELTA + RTW89_TAS_SAR_GAP)
+#define RTW89_TAS_DPR_OFF_OFFSET (4 << RTW89_TAS_FACTOR)
 
 static enum rtw89_sar_subband rtw89_sar_get_subband(struct rtw89_dev *rtwdev,
 						    u32 center_freq)
@@ -117,8 +123,8 @@ static s8 rtw89_txpwr_sar_to_mac(struct rtw89_dev *rtwdev, u8 fct, s32 cfg)
 			   RTW89_SAR_TXPWR_MAC_MAX);
 }
 
-static s8 rtw89_txpwr_tas_to_sar(const struct rtw89_sar_handler *sar_hdl,
-				 s8 cfg)
+static s32 rtw89_txpwr_tas_to_sar(const struct rtw89_sar_handler *sar_hdl,
+				  s32 cfg)
 {
 	const u8 fct = sar_hdl->txpwr_factor_sar;
 
@@ -128,8 +134,8 @@ static s8 rtw89_txpwr_tas_to_sar(const struct rtw89_sar_handler *sar_hdl,
 		return cfg >> (RTW89_TAS_FACTOR - fct);
 }
 
-static s8 rtw89_txpwr_sar_to_tas(const struct rtw89_sar_handler *sar_hdl,
-				 s8 cfg)
+static s32 rtw89_txpwr_sar_to_tas(const struct rtw89_sar_handler *sar_hdl,
+				  s32 cfg)
 {
 	const u8 fct = sar_hdl->txpwr_factor_sar;
 
@@ -139,13 +145,43 @@ static s8 rtw89_txpwr_sar_to_tas(const struct rtw89_sar_handler *sar_hdl,
 		return cfg << (RTW89_TAS_FACTOR - fct);
 }
 
+static bool rtw89_tas_is_active(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	struct rtw89_vif *rtwvif;
+
+	if (!tas->enable)
+		return false;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		if (ieee80211_vif_is_mld(rtwvif_to_vif(rtwvif)))
+			return false;
+	}
+
+	return true;
+}
+
+static const char *rtw89_tas_state_str(enum rtw89_tas_state state)
+{
+	switch (state) {
+	case RTW89_TAS_STATE_DPR_OFF:
+		return "DPR OFF";
+	case RTW89_TAS_STATE_DPR_ON:
+		return "DPR ON";
+	case RTW89_TAS_STATE_STATIC_SAR:
+		return "STATIC SAR";
+	default:
+		return NULL;
+	}
+}
+
 s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
 	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
 	struct rtw89_tas_info *tas = &rtwdev->tas;
-	s8 delta;
+	s32 offset;
 	int ret;
 	s32 cfg;
 	u8 fct;
@@ -159,15 +195,17 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
 	if (ret)
 		return RTW89_SAR_TXPWR_MAC_MAX;
 
-	if (tas->enable) {
+	if (rtw89_tas_is_active(rtwdev)) {
 		switch (tas->state) {
 		case RTW89_TAS_STATE_DPR_OFF:
-			return RTW89_SAR_TXPWR_MAC_MAX;
+			offset = rtw89_txpwr_tas_to_sar(sar_hdl, RTW89_TAS_DPR_OFF_OFFSET);
+			cfg += offset;
+			break;
 		case RTW89_TAS_STATE_DPR_ON:
-			delta = rtw89_txpwr_tas_to_sar(sar_hdl, tas->delta);
-			cfg -= delta;
+			offset = rtw89_txpwr_tas_to_sar(sar_hdl, RTW89_TAS_DPR_ON_OFFSET);
+			cfg -= offset;
 			break;
-		case RTW89_TAS_STATE_DPR_FORBID:
+		case RTW89_TAS_STATE_STATIC_SAR:
 		default:
 			break;
 		}
@@ -223,13 +261,23 @@ int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_tas_info *tas = &rtwdev->tas;
 	char *p = buf, *end = buf + bufsz;
 
-	if (!tas->enable) {
+	if (!rtw89_tas_is_active(rtwdev)) {
 		p += scnprintf(p, end - p, "no TAS is applied\n");
 		goto out;
 	}
 
-	p += scnprintf(p, end - p, "DPR gap: %d\n", tas->dpr_gap);
-	p += scnprintf(p, end - p, "TAS delta: %d\n", tas->delta);
+	p += scnprintf(p, end - p, "State: %s\n",
+		       rtw89_tas_state_str(tas->state));
+	p += scnprintf(p, end - p, "Average time: %d\n",
+		       tas->window_size * 2);
+	p += scnprintf(p, end - p, "SAR gap: %d dBm\n",
+		       RTW89_TAS_SAR_GAP >> RTW89_TAS_FACTOR);
+	p += scnprintf(p, end - p, "DPR gap: %d dBm\n",
+		       RTW89_TAS_DPR_GAP >> RTW89_TAS_FACTOR);
+	p += scnprintf(p, end - p, "DPR ON offset: %d dBm\n",
+		       RTW89_TAS_DPR_ON_OFFSET >> RTW89_TAS_FACTOR);
+	p += scnprintf(p, end - p, "DPR OFF offset: %d dBm\n",
+		       RTW89_TAS_DPR_OFF_OFFSET >> RTW89_TAS_FACTOR);
 
 out:
 	return p - buf;
@@ -250,6 +298,7 @@ static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 
 	rtw89_sar_set_src(rtwdev, RTW89_SAR_SOURCE_COMMON, cfg_common, sar);
 	rtw89_core_set_chip_txpwr(rtwdev);
+	rtw89_tas_reset(rtwdev, false);
 
 	return 0;
 }
@@ -314,65 +363,174 @@ int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 	return rtw89_apply_sar_common(rtwdev, &sar_common);
 }
 
-static void rtw89_tas_state_update(struct rtw89_dev *rtwdev)
+static bool rtw89_tas_query_sar_config(struct rtw89_dev *rtwdev, s32 *cfg)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
 	const struct rtw89_sar_handler *sar_hdl = &rtw89_sar_handlers[src];
-	struct rtw89_tas_info *tas = &rtwdev->tas;
-	s32 txpwr_avg = tas->total_txpwr / RTW89_TAS_MAX_WINDOW / PERCENT;
-	s32 dpr_on_threshold, dpr_off_threshold, cfg;
-	enum rtw89_tas_state state = tas->state;
-	const struct rtw89_chan *chan;
 	int ret;
 
-	lockdep_assert_wiphy(rtwdev->hw->wiphy);
-
 	if (src == RTW89_SAR_SOURCE_NONE)
-		return;
+		return false;
 
-	chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
-	ret = sar_hdl->query_sar_config(rtwdev, chan->freq, &cfg);
+	ret = sar_hdl->query_sar_config(rtwdev, chan->freq, cfg);
 	if (ret)
+		return false;
+
+	*cfg = rtw89_txpwr_sar_to_tas(sar_hdl, *cfg);
+
+	return true;
+}
+
+static void rtw89_tas_state_update(struct rtw89_dev *rtwdev,
+				   enum rtw89_tas_state state)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+
+	if (tas->state == state)
 		return;
 
-	cfg = rtw89_txpwr_sar_to_tas(sar_hdl, cfg);
+	rtw89_debug(rtwdev, RTW89_DBG_SAR, "tas: switch state: %s -> %s\n",
+		    rtw89_tas_state_str(tas->state), rtw89_tas_state_str(state));
+
+	tas->state = state;
+	rtw89_core_set_chip_txpwr(rtwdev);
+}
 
-	if (tas->delta >= cfg) {
+static u32 rtw89_tas_get_window_size(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	u8 band = chan->band_type;
+	u8 regd = rtw89_regd_get(rtwdev, band);
+
+	switch (regd) {
+	default:
 		rtw89_debug(rtwdev, RTW89_DBG_SAR,
-			    "TAS delta exceed SAR limit\n");
-		state = RTW89_TAS_STATE_DPR_FORBID;
-		goto out;
+			    "tas: regd: %u is unhandled\n", regd);
+		fallthrough;
+	case RTW89_IC:
+	case RTW89_KCC:
+		return 180;
+	case RTW89_FCC:
+		switch (band) {
+		case RTW89_BAND_2G:
+			return 50;
+		case RTW89_BAND_5G:
+			return 30;
+		case RTW89_BAND_6G:
+		default:
+			return 15;
+		}
+		break;
 	}
+}
+
+static void rtw89_tas_window_update(struct rtw89_dev *rtwdev)
+{
+	u32 window_size = rtw89_tas_get_window_size(rtwdev);
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	u64 total_txpwr = 0;
+	u8 head_idx;
+	u32 i, j;
+
+	WARN_ON_ONCE(tas->window_size > RTW89_TAS_TXPWR_WINDOW);
+
+	if (tas->window_size == window_size)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_SAR, "tas: window update: %u -> %u\n",
+		    tas->window_size, window_size);
+
+	head_idx = (tas->txpwr_tail_idx - window_size + 1 + RTW89_TAS_TXPWR_WINDOW) %
+		   RTW89_TAS_TXPWR_WINDOW;
+	for (i = 0; i < window_size; i++) {
+		j = (head_idx + i) % RTW89_TAS_TXPWR_WINDOW;
+		total_txpwr += tas->txpwr_history[j];
+	}
+
+	tas->window_size = window_size;
+	tas->total_txpwr = total_txpwr;
+	tas->txpwr_head_idx = head_idx;
+}
+
+static void rtw89_tas_history_update(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, RTW89_PHY_0);
+	struct rtw89_env_monitor_info *env = &bb->env_monitor;
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	u8 tx_ratio = env->ifs_clm_tx_ratio;
+	u64 instant_txpwr, txpwr;
+
+	/* txpwr in unit of linear(mW) multiply by percentage */
+	if (tx_ratio == 0) {
+		/* special case: idle tx power
+		 * use -40 dBm * 100 tx ratio
+		 */
+		instant_txpwr = rtw89_db_to_linear(-40);
+		txpwr = instant_txpwr * 100;
+	} else {
+		instant_txpwr = tas->instant_txpwr;
+		txpwr = instant_txpwr * tx_ratio;
+	}
+
+	tas->total_txpwr += txpwr - tas->txpwr_history[tas->txpwr_head_idx];
+	tas->total_tx_ratio += tx_ratio - tas->tx_ratio_history[tas->tx_ratio_idx];
+	tas->tx_ratio_history[tas->tx_ratio_idx] = tx_ratio;
+
+	tas->txpwr_head_idx = (tas->txpwr_head_idx + 1) % RTW89_TAS_TXPWR_WINDOW;
+	tas->txpwr_tail_idx = (tas->txpwr_tail_idx + 1) % RTW89_TAS_TXPWR_WINDOW;
+	tas->tx_ratio_idx = (tas->tx_ratio_idx + 1) % RTW89_TAS_TX_RATIO_WINDOW;
+	tas->txpwr_history[tas->txpwr_tail_idx] = txpwr;
 
-	dpr_on_threshold = cfg;
-	dpr_off_threshold = cfg - tas->dpr_gap;
 	rtw89_debug(rtwdev, RTW89_DBG_SAR,
-		    "DPR_ON thold: %d, DPR_OFF thold: %d, txpwr_avg: %d\n",
-		    dpr_on_threshold, dpr_off_threshold, txpwr_avg);
+		    "tas: instant_txpwr: %d, tx_ratio: %u, txpwr: %d\n",
+		    rtw89_linear_to_db_quarter(instant_txpwr), tx_ratio,
+		    rtw89_linear_to_db_quarter(div_u64(txpwr, PERCENT)));
+}
 
-	if (txpwr_avg >= dpr_on_threshold)
+static void rtw89_tas_rolling_average(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	s32 dpr_on_threshold, dpr_off_threshold;
+	enum rtw89_tas_state state;
+	u16 tx_ratio_avg;
+	s32 txpwr_avg;
+	u64 linear;
+
+	linear = DIV_ROUND_DOWN_ULL(tas->total_txpwr, tas->window_size * PERCENT);
+	txpwr_avg = rtw89_linear_to_db_quarter(linear);
+	tx_ratio_avg = tas->total_tx_ratio / RTW89_TAS_TX_RATIO_WINDOW;
+	dpr_on_threshold = tas->dpr_on_threshold;
+	dpr_off_threshold = tas->dpr_off_threshold;
+
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "tas: DPR_ON: %d, DPR_OFF: %d, txpwr_avg: %d, tx_ratio_avg: %u\n",
+		    dpr_on_threshold, dpr_off_threshold, txpwr_avg, tx_ratio_avg);
+
+	if (tx_ratio_avg >= RTW89_TAS_TX_RATIO_THRESHOLD)
+		state = RTW89_TAS_STATE_STATIC_SAR;
+	else if (txpwr_avg >= dpr_on_threshold)
 		state = RTW89_TAS_STATE_DPR_ON;
 	else if (txpwr_avg < dpr_off_threshold)
 		state = RTW89_TAS_STATE_DPR_OFF;
-
-out:
-	if (tas->state == state)
+	else
 		return;
 
-	rtw89_debug(rtwdev, RTW89_DBG_SAR,
-		    "TAS old state: %d, new state: %d\n", tas->state, state);
-	tas->state = state;
-	rtw89_core_set_chip_txpwr(rtwdev);
+	rtw89_tas_state_update(rtwdev, state);
 }
 
 void rtw89_tas_init(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_tas_info *tas = &rtwdev->tas;
 	struct rtw89_acpi_dsm_result res = {};
 	int ret;
 	u8 val;
 
+	if (!chip->support_tas)
+		return;
+
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_TAS_EN, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_SAR,
@@ -396,65 +554,116 @@ void rtw89_tas_init(struct rtw89_dev *rtwdev)
 		rtw89_debug(rtwdev, RTW89_DBG_SAR, "TAS not enable\n");
 		return;
 	}
-
-	tas->dpr_gap = RTW89_TAS_DPR_GAP;
-	tas->delta = RTW89_TAS_DELTA;
 }
 
-void rtw89_tas_reset(struct rtw89_dev *rtwdev)
+void rtw89_tas_reset(struct rtw89_dev *rtwdev, bool force)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_tas_info *tas = &rtwdev->tas;
+	u64 linear;
+	s32 cfg;
+	int i;
 
-	if (!tas->enable)
+	if (!rtw89_tas_is_active(rtwdev))
+		return;
+
+	if (!rtw89_tas_query_sar_config(rtwdev, &cfg))
+		return;
+
+	tas->dpr_on_threshold = cfg - RTW89_TAS_SAR_GAP;
+	tas->dpr_off_threshold = cfg - RTW89_TAS_SAR_GAP - RTW89_TAS_DPR_GAP;
+
+	/* avoid history reset after new SAR apply */
+	if (!force && tas->keep_history)
 		return;
 
-	memset(&tas->txpwr_history, 0, sizeof(tas->txpwr_history));
-	tas->total_txpwr = 0;
-	tas->cur_idx = 0;
+	linear = rtw89_db_quarter_to_linear(cfg) * RTW89_TAS_DFLT_TX_RATIO;
+	for (i = 0; i < RTW89_TAS_TXPWR_WINDOW; i++)
+		tas->txpwr_history[i] = linear;
+
+	for (i = 0; i < RTW89_TAS_TX_RATIO_WINDOW; i++)
+		tas->tx_ratio_history[i] = RTW89_TAS_DFLT_TX_RATIO;
+
+	tas->total_tx_ratio = RTW89_TAS_DFLT_TX_RATIO * RTW89_TAS_TX_RATIO_WINDOW;
+	tas->total_txpwr = linear * RTW89_TAS_TXPWR_WINDOW;
+	tas->window_size = RTW89_TAS_TXPWR_WINDOW;
+	tas->txpwr_head_idx = 0;
+	tas->txpwr_tail_idx = RTW89_TAS_TXPWR_WINDOW - 1;
+	tas->tx_ratio_idx = 0;
 	tas->state = RTW89_TAS_STATE_DPR_OFF;
-}
+	tas->backup_state = RTW89_TAS_STATE_DPR_OFF;
+	tas->keep_history = true;
 
-static const struct rtw89_reg_def txpwr_regs[] = {
-	{R_PATH0_TXPWR, B_PATH0_TXPWR},
-	{R_PATH1_TXPWR, B_PATH1_TXPWR},
-};
+	rtw89_debug(rtwdev, RTW89_DBG_SAR,
+		    "tas: band: %u, freq: %u\n", chan->band_type, chan->freq);
+}
 
 void rtw89_tas_track(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, RTW89_PHY_0);
-	struct rtw89_env_monitor_info *env = &bb->env_monitor;
-	const enum rtw89_sar_sources src = rtwdev->sar.src;
-	u8 max_nss_num = rtwdev->chip->rf_path_num;
 	struct rtw89_tas_info *tas = &rtwdev->tas;
-	s16 tmp, txpwr, instant_txpwr = 0;
-	u32 val;
-	int i;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	s32 cfg;
 
-	if (!tas->enable || src == RTW89_SAR_SOURCE_NONE)
+	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_TAS))
 		return;
 
-	if (env->ccx_watchdog_result != RTW89_PHY_ENV_MON_IFS_CLM)
+	if (!rtw89_tas_is_active(rtwdev))
 		return;
 
-	for (i = 0; i < max_nss_num; i++) {
-		val = rtw89_phy_read32_mask(rtwdev, txpwr_regs[i].addr,
-					    txpwr_regs[i].mask);
-		tmp = sign_extend32(val, 8);
-		if (tmp <= 0)
-			return;
-		instant_txpwr += tmp;
+	if (!rtw89_tas_query_sar_config(rtwdev, &cfg) || tas->block_regd) {
+		rtw89_tas_state_update(rtwdev, RTW89_TAS_STATE_STATIC_SAR);
+		return;
 	}
 
-	instant_txpwr /= max_nss_num;
-	/* in unit of 0.25 dBm multiply by percentage */
-	txpwr = instant_txpwr * env->ifs_clm_tx_ratio;
-	tas->total_txpwr += txpwr - tas->txpwr_history[tas->cur_idx];
-	tas->txpwr_history[tas->cur_idx] = txpwr;
-	rtw89_debug(rtwdev, RTW89_DBG_SAR,
-		    "instant_txpwr: %d, tx_ratio: %d, txpwr: %d\n",
-		    instant_txpwr, env->ifs_clm_tx_ratio, txpwr);
+	if (tas->pause)
+		return;
+
+	rtw89_tas_window_update(rtwdev);
+	rtw89_tas_history_update(rtwdev);
+	rtw89_tas_rolling_average(rtwdev);
+}
+
+void rtw89_tas_scan(struct rtw89_dev *rtwdev, bool start)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	s32 cfg;
+
+	if (!rtw89_tas_is_active(rtwdev))
+		return;
 
-	tas->cur_idx = (tas->cur_idx + 1) % RTW89_TAS_MAX_WINDOW;
+	if (!rtw89_tas_query_sar_config(rtwdev, &cfg))
+		return;
 
-	rtw89_tas_state_update(rtwdev);
+	if (start) {
+		tas->backup_state = tas->state;
+		rtw89_tas_state_update(rtwdev, RTW89_TAS_STATE_STATIC_SAR);
+	} else {
+		rtw89_tas_state_update(rtwdev, tas->backup_state);
+	}
+}
+
+void rtw89_tas_chanctx_cb(struct rtw89_dev *rtwdev,
+			  enum rtw89_chanctx_state state)
+{
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	s32 cfg;
+
+	if (!rtw89_tas_is_active(rtwdev))
+		return;
+
+	if (!rtw89_tas_query_sar_config(rtwdev, &cfg))
+		return;
+
+	switch (state) {
+	case RTW89_CHANCTX_STATE_MCC_START:
+		tas->pause = true;
+		rtw89_tas_state_update(rtwdev, RTW89_TAS_STATE_STATIC_SAR);
+		break;
+	case RTW89_CHANCTX_STATE_MCC_STOP:
+		tas->pause = false;
+		break;
+	default:
+		break;
+	}
 }
+EXPORT_SYMBOL(rtw89_tas_chanctx_cb);
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 095277df5a71..0df1661db9a8 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -25,7 +25,10 @@ int rtw89_print_tas(struct rtw89_dev *rtwdev, char *buf, size_t bufsz);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 			    const struct cfg80211_sar_specs *sar);
 void rtw89_tas_init(struct rtw89_dev *rtwdev);
-void rtw89_tas_reset(struct rtw89_dev *rtwdev);
+void rtw89_tas_reset(struct rtw89_dev *rtwdev, bool force);
 void rtw89_tas_track(struct rtw89_dev *rtwdev);
+void rtw89_tas_scan(struct rtw89_dev *rtwdev, bool start);
+void rtw89_tas_chanctx_cb(struct rtw89_dev *rtwdev,
+			  enum rtw89_chanctx_state state);
 
 #endif
-- 
2.25.1


