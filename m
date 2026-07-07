Return-Path: <linux-wireless+bounces-38730-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fg4pJ1vFTGrepQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38730-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E35B719AF6
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=L7TW3Lca;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38730-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38730-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289B731A6D2B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF1392C39;
	Tue,  7 Jul 2026 09:12:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D52390C84
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:12:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415527; cv=none; b=b8G6lJkLrTw9mwSmci4nMIF8OBDexzjzrGEW3qxQ2ogzdB2sId6y9AUjt7ytekC3BXdFPzYhldk0gRf6K0rbdzHjuodwuqt+qeT/dLabYXQ8osdBhUlftMSmtkHBYa10C3587Y5nRMrIqU+FYuTj5vAuwCmuQn62qMOcFEUCKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415527; c=relaxed/simple;
	bh=WkRCUx1sZwJL6aX6nZ64hmBoJr1lrKxyqVe2gqP5Jao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9m5P+wQVpS6QL06Vxrg+1QiofqS50HCTtMp5kllmuG8de+TbtskH78SFvAUkYbmnQir8MkhsRvKEU2FmcMD1axSJpvM5Mk2kcjfuAHcAqNkCs7oRM9I1ynTthvNhae8EEUvraAn7jyzYB5RzFDjqQ2SvZ7dy6oxBUeKBfAubJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=L7TW3Lca; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679C22801359446, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415522; bh=hE8q/bYG/6gzVPI49QgceeNfr3YRBX1eY23NbftnY+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=L7TW3LcaalrKsIMJDgw+YKX2SStqSNMKdhuMK6UVjGR4OE+aEB2SRf4A6vIJioxv9
	 k2arD2IfXtiSj8jtDGOX1D1huIrSX59Ac9gnw3HfO33RR+vZ73RR6g2UU8nPoWc7PY
	 cAFmZfj5NjFcI4qvBnB/B3yZAzilvSvOJi6c3llalyt/Oh09HmDK8CYMEJsWm+6+9x
	 ZcMxxweJWuBs9Wxxg+KWc+nur9sA5MEywL5tU0zrsK3p1KZGJOMYq95uhigCU3AiUW
	 ya+6ECvEKK3eqknYl3mSFqYc1GfINkIbHWNoJM+jFT6H6W/0kC3Uc65BUoD47FezLL
	 GD6/MiXBBMOOw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679C22801359446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:12:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:12:02 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:12:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 02/15] wifi: rtw89: 8922d: dynamic adjust channel smoothing
Date: Tue, 7 Jul 2026 17:10:43 +0800
Message-ID: <20260707091056.42771-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707091056.42771-1-pkshih@realtek.com>
References: <20260707091056.42771-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-38730-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:echuang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E35B719AF6

From: Eric Huang <echuang@realtek.com>

Add support for path difference based channel smoothing for RTL8922D chip.
This feature measures the ratio of NDP frames and uses a moving average
filter to decide whether to enable beamforming channel smoothing. Tone
index selection is dynamically adjusted based on bandwidth and link mode
(HE/EHT vs VHT). The feature is only enabled for RTL8922D_CID7090 variant.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  8 +++
 drivers/net/wireless/realtek/rtw89/core.h     | 21 ++++++
 drivers/net/wireless/realtek/rtw89/phy.c      |  5 ++
 drivers/net/wireless/realtek/rtw89/reg.h      | 24 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 68 +++++++++++++++++++
 11 files changed, 132 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 26b744dfbcf8..9dbf01e82383 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5806,6 +5806,7 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 									 rtwsta_link);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
 	struct ieee80211_link_sta *link_sta;
 	int ret;
 
@@ -5858,6 +5859,7 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		struct ieee80211_bss_conf *bss_conf;
+		u8 link_mode = 0;
 
 		rcu_read_lock();
 
@@ -5865,6 +5867,12 @@ int rtw89_core_sta_link_assoc(struct rtw89_dev *rtwdev,
 		link_sta = rtw89_sta_rcu_dereference_link(rtwsta_link, true);
 		rtwsta_link->er_cap = rtw89_sta_link_can_er(rtwdev, bss_conf, link_sta);
 
+		if (link_sta->he_cap.has_he || link_sta->eht_cap.has_eht)
+			link_mode = 2;
+		else if (link_sta->vht_cap.vht_supported)
+			link_mode = 1;
+		bb->path_diff.link_mode = link_mode;
+
 		rcu_read_unlock();
 
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, rtwsta_link,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 5dde620b1e5e..9a4d42b60bbb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -14,6 +14,7 @@
 #include <net/mac80211.h>
 
 struct rtw89_dev;
+struct rtw89_bb_ctx;
 struct rtw89_pci_info;
 struct rtw89_usb_info;
 struct rtw89_mac_gen_def;
@@ -3948,6 +3949,8 @@ struct rtw89_chip_ops {
 				    enum rtw89_rf_path path,
 				    enum rtw89_phy_idx phy_idx,
 				    struct rtw89_phy_calc_efuse_gain *calc);
+	void (*path_diff_update)(struct rtw89_dev *rtwdev,
+				 struct rtw89_bb_ctx *bb);
 	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
 	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
 	void (*query_rxdesc)(struct rtw89_dev *rtwdev,
@@ -5504,6 +5507,14 @@ struct rtw89_beacon_stat {
 };
 
 DECLARE_EWMA(thermal, 4, 4);
+DECLARE_EWMA(path_diff, 4, 2);
+
+struct rtw89_phy_path_diff {
+	struct ewma_path_diff avg;
+	u8 raw;
+	bool bf_smo_en;
+	u8 link_mode;
+};
 
 #define RTW89_TX_RATE_NR 40
 struct rtw89_phy_stat {
@@ -6562,6 +6573,7 @@ struct rtw89_dev {
 		struct rtw89_pmac_stat_info pmac_stat;
 		struct rtw89_tx_stat_info tx_stat;
 		struct rtw89_diag_bb diag;
+		struct rtw89_phy_path_diff path_diff;
 	} bbs[RTW89_PHY_NUM];
 
 	struct wiphy_delayed_work track_work;
@@ -7673,6 +7685,15 @@ static inline void rtw89_chip_power_trim(struct rtw89_dev *rtwdev)
 		chip->ops->power_trim(rtwdev);
 }
 
+static inline void rtw89_chip_path_diff_update(struct rtw89_dev *rtwdev,
+					       struct rtw89_bb_ctx *bb)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->path_diff_update)
+		chip->ops->path_diff_update(rtwdev, bb);
+}
+
 static inline void __rtw89_chip_init_txpwr_unit(struct rtw89_dev *rtwdev,
 						enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 759be4dab42b..981c7f02271a 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -5842,6 +5842,9 @@ static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 		memset(&bb->last_pkt_stat, 0, sizeof(bb->last_pkt_stat));
 
 		ewma_rssi_init(&bb->bcn_rssi);
+		bb->path_diff.raw = 0;
+		ewma_path_diff_init(&bb->path_diff.avg);
+		bb->path_diff.bf_smo_en = false;
 	}
 
 	rtwdev->hal.thermal_prot_lv = 0;
@@ -6190,6 +6193,8 @@ void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
 	rtw89_for_each_active_bb(rtwdev, bb) {
 		bb->last_pkt_stat = bb->cur_pkt_stat;
 		memset(&bb->cur_pkt_stat, 0, sizeof(bb->cur_pkt_stat));
+
+		rtw89_chip_path_diff_update(rtwdev, bb);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bf1c6cb0ae9c..1ff788c24eec 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10822,6 +10822,13 @@
 #define B_TXINFO_PATH_MB_BE4 BIT(19)
 #define R_SHAPER_COEFF_BE4 0x20CBC
 #define B_SHAPER_COEFF_BE4 BIT(19)
+
+#define R_CL_MODE_CNT_BE4 0x20DE0
+#define B_CL_MODE_NDP_CNT_PHY0_BE4 GENMASK(31, 24)
+#define B_CL_MODE_NDP_CNT_PHY1_BE4 GENMASK(15, 8)
+#define B_CL_MODE_CL_CNT_PHY0_BE4 GENMASK(23, 16)
+#define B_CL_MODE_CL_CNT_PHY1_BE4 GENMASK(7, 0)
+
 #define R_IFS_T1_AVG_BE4 0x20EDC
 #define B_IFS_T1_AVG_BE4 GENMASK(15, 0)
 #define B_IFS_T2_AVG_BE4 GENMASK(31, 16)
@@ -10940,6 +10947,14 @@
 #define R_GAIN_BIAS_BE4 0x260A0
 #define B_GAIN_BIAS_BW20_BE4 GENMASK(11, 6)
 #define B_GAIN_BIAS_BW40_BE4 GENMASK(17, 12)
+
+#define R_BF_SMO_PDP_LMT_EHT_BE4 0x26568
+#define B_BF_SMO_PDP_LMT_EHT_BE4 BIT(30)
+#define R_BF_SMO_PDP_LMT_HE_BE4 0x26568
+#define B_BF_SMO_PDP_LMT_HE_BE4 BIT(31)
+#define R_BF_SMO_PDP_LMT_VHT_BE4 0x2656C
+#define B_BF_SMO_PDP_LMT_VHT_BE4 BIT(31)
+
 #define R_AWGN_DET_BE4 0x2668C
 #define B_AWGN_DET_BE4 GENMASK(17, 9)
 #define R_CSI_WGT_BE4 0x26770
@@ -10981,6 +10996,15 @@
 #define R_BSS_CLR_VLD_BE4 0x26920
 #define B_BSS_CLR_VLD_BE4 BIT(2)
 
+#define R_CL_MODE_TRIG_BE4 0x26F44
+#define B_CL_MODE_TRIG_BE4 BIT(31)
+#define R_SELECTED_TONE_IDX_BE4 0x26F4C
+#define B_SELECTED_TONE_IDX_BE4 GENMASK(11, 0)
+#define R_OS_TRIG_BY_SW_BE4 0x26F50
+#define B_OS_TRIG_BY_SW_BE4 BIT(30)
+#define R_OS_TRIG_SOURCE_BE4 0x26F6C
+#define B_OS_TRIG_SOURCE_BE4 BIT(0)
+
 #define R_SW_SI_DATA_BE4 0x2CF4C
 #define B_SW_SI_READ_DATA_BE4 GENMASK(19, 0)
 #define B_SW_SI_W_BUSY_BE4 BIT(24)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 4caf231c6287..d0c262c3dffe 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2580,6 +2580,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
 	.calc_rx_gain_normal	= NULL,
+	.path_diff_update	= NULL,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
 	.pwr_off_func		= rtw8851b_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 78addc0aef69..a5a06ae5c446 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2326,6 +2326,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
 	.calc_rx_gain_normal	= NULL,
+	.path_diff_update	= NULL,
 	.pwr_on_func		= NULL,
 	.pwr_off_func		= NULL,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index debcdb2eacd6..a8638024b54a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -907,6 +907,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
 	.calc_rx_gain_normal	= NULL,
+	.path_diff_update	= NULL,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index fc8a17fb95f4..e68f73827fa5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -753,6 +753,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
 	.calc_rx_gain_normal	= NULL,
+	.path_diff_update	= NULL,
 	.pwr_on_func		= rtw8852bt_pwr_on_func,
 	.pwr_off_func		= rtw8852bt_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 29a3c90021f3..52986b982ecd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3125,6 +3125,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.digital_pwr_comp	= NULL,
 	.calc_rx_gain_normal	= NULL,
+	.path_diff_update	= NULL,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 6d4301661b04..5389c8cd07f4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3110,6 +3110,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.set_txpwr_ul_tb_offset	= NULL,
 	.digital_pwr_comp	= rtw8922a_digital_pwr_comp,
 	.calc_rx_gain_normal	= NULL,
+	.path_diff_update	= NULL,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 625f8d675f08..805dd96e61e6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -1716,6 +1716,73 @@ static void rtw8922d_calc_rx_gain_normal(struct rtw89_dev *rtwdev,
 	rtw8922d_calc_rx_gain_normal_cck(rtwdev, chan, path, phy_idx, calc);
 }
 
+static void rtw8922d_path_diff_update(struct rtw89_dev *rtwdev,
+				      struct rtw89_bb_ctx *bb)
+{
+#define BF_SMOOTH_TH 80
+	static const u32 path_diff_cnt_mask[] = {0xff0000, 0xff};
+	static const u32 ndp_cnt_mask[] = {0xff000000, 0xff00};
+	static const u16 he_eht_sel_tone[4] = {27, 54, 56, 56};
+	static const u16 vht_sel_tone[4] = {11, 25, 25, 25};
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_entity_conf conf;
+	const struct rtw89_chan *chan;
+	u8 phy_idx = bb->phy_idx;
+	u32 path_diff_cnt;
+	u16 sel_tone = 0;
+	bool bf_smo_lmt;
+	u32 ndp_cnt;
+
+	if (hal->cid != RTL8922D_CID7090)
+		return;
+
+	ndp_cnt = rtw89_phy_read32_mask(rtwdev, R_CL_MODE_CNT_BE4, ndp_cnt_mask[phy_idx]);
+	path_diff_cnt = rtw89_phy_read32_mask(rtwdev, R_CL_MODE_CNT_BE4,
+					      path_diff_cnt_mask[phy_idx]);
+
+	bb->path_diff.raw = clamp(phy_div(path_diff_cnt * 100, ndp_cnt), 0, 255);
+
+	if (ndp_cnt == 0)
+		ewma_path_diff_init(&bb->path_diff.avg);
+	else
+		ewma_path_diff_add(&bb->path_diff.avg, bb->path_diff.raw);
+
+	rtw89_phy_write32_mask(rtwdev, R_CL_MODE_TRIG_BE4, B_CL_MODE_TRIG_BE4, 1);
+	rtw89_phy_write32_mask(rtwdev, R_CL_MODE_TRIG_BE4, B_CL_MODE_TRIG_BE4, 0);
+
+	bf_smo_lmt = ewma_path_diff_read(&bb->path_diff.avg) < BF_SMOOTH_TH;
+	bb->path_diff.bf_smo_en = !bf_smo_lmt;
+
+	rtw89_phy_write32_mask(rtwdev, R_BF_SMO_PDP_LMT_EHT_BE4,
+			       B_BF_SMO_PDP_LMT_EHT_BE4, bf_smo_lmt);
+	rtw89_phy_write32_mask(rtwdev, R_BF_SMO_PDP_LMT_HE_BE4,
+			       B_BF_SMO_PDP_LMT_HE_BE4, bf_smo_lmt);
+	rtw89_phy_write32_mask(rtwdev, R_BF_SMO_PDP_LMT_VHT_BE4,
+			       B_BF_SMO_PDP_LMT_VHT_BE4, bf_smo_lmt);
+
+	rtw89_phy_write32_mask(rtwdev, R_OS_TRIG_BY_SW_BE4,
+			       B_OS_TRIG_BY_SW_BE4, !bf_smo_lmt);
+	rtw89_phy_write32_mask(rtwdev, R_OS_TRIG_SOURCE_BE4,
+			       B_OS_TRIG_SOURCE_BE4, !bf_smo_lmt);
+
+	rtw89_entity_get_conf(rtwdev, &conf);
+	chan = conf.chans[phy_idx];
+	if (chan->band_width <= RTW89_CHANNEL_WIDTH_160) {
+		if (bb->path_diff.link_mode >= 2)
+			sel_tone = he_eht_sel_tone[chan->band_width];
+		else if (bb->path_diff.link_mode == 1)
+			sel_tone = vht_sel_tone[chan->band_width];
+		rtw89_phy_write32_mask(rtwdev, R_SELECTED_TONE_IDX_BE4,
+				       B_SELECTED_TONE_IDX_BE4, sel_tone);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_PHY_TRACK,
+		    "[PATH_DIFF] raw=%d%%, ma=%ld%%, bf_smo_en=%d, tone=%d\n",
+		    bb->path_diff.raw,
+		    ewma_path_diff_read(&bb->path_diff.avg),
+		    bb->path_diff.bf_smo_en, sel_tone);
+}
+
 static void rtw8922d_set_cck_parameters(struct rtw89_dev *rtwdev,
 					const struct rtw89_chan *chan,
 					enum rtw89_phy_idx phy_idx)
@@ -3288,6 +3355,7 @@ static const struct rtw89_chip_ops rtw8922d_chip_ops = {
 	.set_txpwr_ul_tb_offset	= NULL,
 	.digital_pwr_comp	= rtw8922d_digital_pwr_comp,
 	.calc_rx_gain_normal	= rtw8922d_calc_rx_gain_normal,
+	.path_diff_update	= rtw8922d_path_diff_update,
 	.pwr_on_func		= rtw8922d_pwr_on_func,
 	.pwr_off_func		= rtw8922d_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc_v3,
-- 
2.25.1


