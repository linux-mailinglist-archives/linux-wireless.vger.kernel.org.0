Return-Path: <linux-wireless+bounces-35009-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KFCGLOg5WlMmQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35009-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12100426988
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 05:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 049A6300253B
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 03:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9222BDC0F;
	Mon, 20 Apr 2026 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HATaazKb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436942FD1B1
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776656557; cv=none; b=f820ZxKcfrovKxNZV4esRbh5DGMnL/pCHcEfFN21vinwyAU4nVgatwuBCUphvNXppGPtYeaxgsROzZzvyTYdzY8WtZaLJtk7jEgdRgZGYsyy+qMJ6Jb1XG4PKnB+kfnsvcsd1Ra4BXWRzPr2WzVBhLV4BBaGoC7Xe4yMkrkwUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776656557; c=relaxed/simple;
	bh=Irf+G33khxRgDdbNnOqgyCTDhUSNttCJb6oBOWOe/GM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEDGq6NfZwHEutfhd02XpBCM3dvqKUzHpe6tEx9CJV5o8Agq0dG68EL2u49lfaiXHfQWxPPE9nyoPhLBdoEoJCwGzIsfBPEkvZ85q57UURrPLGoiFFQvzEMl/Ls7zATX3RskRg7eU2I/qmMCd7tl2dff2S9TjgbXjJCqjcHm9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HATaazKb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K3gXVk9429275, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1776656553; bh=jzp7DPPTySl/PhwaElI0XhNahIuke0apkSzs+gt5MQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HATaazKbDwc1e5Mo9mxuijN/Dbc2CtVuuiCHEXsohUFcAzIOpn9ArXvfchWAIuCMH
	 zU1cCBXwtOiZFZUEHedvGD5dmgKnKqRGWO+22f2xmQh2RLwbYz4CGdwNz6LWFxxPQm
	 +AxQgYd7Mv6w/TmwEbQ/4wWlwmixzoS3BMV1eDshhQJP9OXCnkLRcnzt8L0tChHHo2
	 zyZN8l1HntSAlIwUeCs0j1uItzBOdEgIdq3hQlPU3od2v9nRxHHoCJL602UHOR+J4J
	 ZGCLh0YQ5hDvNU4ENNX9j6/IBl6ktt+KEVJRg7pzGubACqH1HGDNVOfVCDghb1ix8b
	 1mZGOBK29vptw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K3gXVk9429275
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 11:42:33 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 20 Apr 2026 11:42:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 11:42:34 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 20 Apr 2026 11:42:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>, <gary.chang@realtek.com>, <echuang@realtek.com>,
        <wenjie.tsai@realtek.com>, <phhuang@realtek.com>, <isaiah@realtek.com>,
        <kevin_yang@realtek.com>, <mh_chen@realtek.com>
Subject: [PATCH rtw-next 16/16] wifi: rtw89: 8922d: update RF calibration flow for MLD
Date: Mon, 20 Apr 2026 11:40:51 +0800
Message-ID: <20260420034051.17666-17-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260420034051.17666-1-pkshih@realtek.com>
References: <20260420034051.17666-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35009-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 12100426988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zong-Zhe Yang <kevin_yang@realtek.com>

RF calibration (RFK) will record the results in HW RFK tables. SW can
select and configure the target HW RFK table to reuse the RFK result
on the target channel. Though the above can work as before, when MLD
runs eMLSR mode, a faster switching between links than SW is needed.

So, introduce a new working flow for MLD. With the new settings, HW
can easily switch RFK results between links during eMLSR mode.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c |  7 ++
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.c | 70 +++++++++++++++----
 .../net/wireless/realtek/rtw89/rtw8922d_rfk.h |  1 +
 4 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 42ffe83931a3..b8b2aabedc8f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8462,6 +8462,8 @@
 #define RR_MODOPT_V1 0x10001
 #define RR_SW_SEL BIT(19)
 #define RR_TXG_SEL GENMASK(19, 17)
+#define RR_TBL_SEL_IDX1 GENMASK(9, 8)
+#define RR_TBL_SEL_IDX0 GENMASK(7, 6)
 #define RR_MODOPT_M_TXPWR GENMASK(5, 0)
 #define RR_WLSEL 0x02
 #define RR_WLSEL_AG GENMASK(18, 16)
@@ -10687,6 +10689,8 @@
 #define R_KTBL0B_BE4 0x38204
 #define B_KTBL0_IDX0 GENMASK(1, 0)
 #define B_KTBL0_IDX1 GENMASK(9, 8)
+#define B_KTBL0_MLD_IDX0 GENMASK(25, 24)
+#define B_KTBL0_MLD_IDX1 GENMASK(27, 26)
 #define B_KTBL0_RST BIT(31)
 #define R_KTBL1A_BE4 0x38154
 #define R_KTBL1B_BE4 0x38254
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index f0c9d8661e57..47e0e360ed6e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2332,12 +2332,16 @@ static void rtw8922d_rfk_tssi(struct rtw89_dev *rtwdev,
 static void rtw8922d_rfk_channel(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link)
 {
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link->rtwvif);
 	enum rtw89_chanctx_idx chanctx_idx = rtwvif_link->chanctx_idx;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 	u32 tx_en;
 
+	if (ieee80211_vif_is_mld(vif))
+		rtw8922d_chlk_ktbl_ctl_mld(rtwdev, phy_idx, true);
+
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
 	_wait_rx_mode(rtwdev, RF_AB);
@@ -2353,6 +2357,9 @@ static void rtw8922d_rfk_channel(struct rtw89_dev *rtwdev,
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_STOP);
+
+	if (ieee80211_vif_is_mld(vif))
+		rtw8922d_chlk_ktbl_ctl_mld(rtwdev, phy_idx, false);
 }
 
 static void rtw8922d_rfk_band_changed(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
index 7957f7b2d8e5..a465e6631a22 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c
@@ -105,26 +105,60 @@ static void rtw8922d_set_syn01(struct rtw89_dev *rtwdev, enum _rf_syn_pow syn)
 	}
 }
 
-static void rtw8922d_chlk_ktbl_sel(struct rtw89_dev *rtwdev, u8 kpath, u8 idx)
+void rtw8922d_chlk_ktbl_ctl_mld(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool manual)
 {
-	bool mlo_linking = false;
+	if (manual) {
+		struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+		u8 path = phy_idx; /* numerical equal for target */
+		u8 idx = rfk_mcc[path].table_idx;
 
-	if (idx > 2) {
-		rtw89_warn(rtwdev, "[DBCC][ERROR]indx is out of limit!! index(%d)", idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_RST, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_RST, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_IDX0, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_IDX1, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_IDX0, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_IDX1, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1A_BE4, B_KTBL1_TBL0, idx & BIT(0));
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1A_BE4, B_KTBL1_TBL1, (idx & BIT(1)) >> 1);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1B_BE4, B_KTBL1_TBL0, idx & BIT(0));
+		rtw89_phy_write32_mask(rtwdev, R_KTBL1B_BE4, B_KTBL1_TBL1, (idx & BIT(1)) >> 1);
 		return;
 	}
 
-	if (mlo_linking) {
-		if (kpath & RF_A) {
-			rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RR_SW_SEL, 0x0);
-			rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT_V1, RR_SW_SEL, 0x0);
-		}
+	rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_RST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_RST, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RR_SW_SEL, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT_V1, RR_SW_SEL, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RR_SW_SEL, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT_V1, RR_SW_SEL, 0x0);
+}
 
-		if (kpath & RF_B) {
-			rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RR_SW_SEL, 0x0);
-			rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT_V1, RR_SW_SEL, 0x0);
-		}
+static void rtw8922d_chlk_ktbl_sel_mld(struct rtw89_dev *rtwdev,
+				       enum rtw89_phy_idx phy_idx, u8 idx)
+{
+	if (phy_idx == RTW89_PHY_0) {
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_MLD_IDX0, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_MLD_IDX0, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RR_TBL_SEL_IDX0, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT_V1, RR_TBL_SEL_IDX0, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RR_TBL_SEL_IDX0, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT_V1, RR_TBL_SEL_IDX0, idx);
+	} else if (phy_idx == RTW89_PHY_1) {
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0A_BE4, B_KTBL0_MLD_IDX1, idx);
+		rtw89_phy_write32_mask(rtwdev, R_KTBL0B_BE4, B_KTBL0_MLD_IDX1, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RR_TBL_SEL_IDX1, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT_V1, RR_TBL_SEL_IDX1, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RR_TBL_SEL_IDX1, idx);
+		rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT_V1, RR_TBL_SEL_IDX1, idx);
+	}
+
+	rtw8922d_chlk_ktbl_ctl_mld(rtwdev, phy_idx, false);
+}
 
+static void rtw8922d_chlk_ktbl_sel(struct rtw89_dev *rtwdev, u8 kpath, u8 idx)
+{
+	if (idx > 2) {
+		rtw89_warn(rtwdev, "[DBCC][ERROR]indx is out of limit!! index(%d)", idx);
 		return;
 	}
 
@@ -195,8 +229,18 @@ static void rtw8922d_chlk_reload(struct rtw89_dev *rtwdev)
 	s0_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, conf.chans[0], 0);
 	s1_tbl = rtw8922d_chlk_reload_sel_tbl(rtwdev, conf.chans[1], 1);
 
+	if (conf.is_mld)
+		goto mld;
+
 	rtw8922d_chlk_ktbl_sel(rtwdev, RF_A, s0_tbl);
 	rtw8922d_chlk_ktbl_sel(rtwdev, RF_B, s1_tbl);
+	return;
+
+mld:
+	if (test_bit(RTW89_PHY_0, conf.hw_bitmap))
+		rtw8922d_chlk_ktbl_sel_mld(rtwdev, RTW89_PHY_0, s0_tbl);
+	if (test_bit(RTW89_PHY_1, conf.hw_bitmap))
+		rtw8922d_chlk_ktbl_sel_mld(rtwdev, RTW89_PHY_1, s1_tbl);
 }
 
 static enum _rf_syn_pow rtw8922d_get_syn_pow(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
index c5bbe0eb972a..11742b4a8f59 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h
@@ -18,5 +18,6 @@ void rtw8922d_rfk_mlo_ctrl(struct rtw89_dev *rtwdev);
 void rtw8922d_pre_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8922d_post_set_channel_rf(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8922d_lck_track(struct rtw89_dev *rtwdev);
+void rtw8922d_chlk_ktbl_ctl_mld(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool manual);
 
 #endif
-- 
2.25.1


