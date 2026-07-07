Return-Path: <linux-wireless+bounces-38742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDQ9O3zGTGpDpgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:27:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A80719C09
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:27:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="rYj5/dwq";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38742-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38742-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F543151337
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33FE32E12E;
	Tue,  7 Jul 2026 09:13:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516423911CD
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:13:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415590; cv=none; b=CM+OOQ5Ax5vhfDR1P6bcXMAY4TF0H+IMkvg3tXk47cI/8/b1mkKGOYcWKsnE4EumTXOQY+SoNNca5WjsiuSalXlCLZjtc2hzga5z6YBY5D9OgKuYtaykmfVndCDu+M6/xqtH3HhbZjxQzoNwot1nHYQj1j4L+SDbNltBn/F1+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415590; c=relaxed/simple;
	bh=6XppuIh0r9VvCHOwUGm+r+hynawSlA4JESMh5+ygRFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tysCR+sxH6N7HfQ3THlXIK40jezA6dKCt26OIX8TSnDGJAsQeXqgWFVEPGYkqArRZDeD6oXYy5oWujvaqXH14cXB2dlbD0AVphz9PZUfinl4bjRyVCQ5jISRPweHm3RlS5DK1gLCCm2jwf33mtUKQyZDbNavDpFc6jUECS2vxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rYj5/dwq; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679D6zY41359717, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415586; bh=pC1nMNjaYL8L7kR0DfHEAdFQuIWE8nCOzEwz88Spw/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rYj5/dwq+KHAyc19LbcWDo8//xPHD+pb4Xi3zvGVLgdEV8K3cAKdLkbzh3aV55Kjr
	 3bK1oaSUnUGuLehARWdQk5u8+NKtzbDVdkcHn8+gCr4rFgmvQVekVr8WhAgrk0cUDu
	 U1V9omAbdS67qgAi1yrt4la7sfqkX4KxUEwMrdMtDbfJVEv1n3EOsLIxxD5wXHMo7H
	 ZkLBWVPeuDujdJZYk5TFI8Rk4siMsN7R8Wi7DOpCf8UQG3PGgqFimn4reQPygfFK86
	 VIds/TDwIqGSDJTxUs6BhDJL3241KR5XIyo66B3f9A3ynPxJVYxQI4bjf5d9f03UM3
	 M1AuBxjhbvJYA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679D6zY41359717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:13:06 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:13:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:13:06 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:13:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 14/15] wifi: rtw89: unify access struct of TX power track tables
Date: Tue, 7 Jul 2026 17:10:55 +0800
Message-ID: <20260707091056.42771-15-pkshih@realtek.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38742-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70A80719C09

There are two struct to access TX power track tables. One is to access
driver built-in tables, and the other one is to access the tables in fw
element. As we are going to remove the built-in tables from driver, unify
to use the struct as fw element style.

The precedence is to use tables in fw element if present, and then
built-in tables.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.h      |  19 ----
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c |  20 ++--
 .../wireless/realtek/rtw89/rtw8851b_table.c   |  15 +--
 .../wireless/realtek/rtw89/rtw8851b_table.h   |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  36 ++++---
 .../wireless/realtek/rtw89/rtw8852a_table.c   |  27 ++---
 .../wireless/realtek/rtw89/rtw8852a_table.h   |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  36 ++++---
 .../wireless/realtek/rtw89/rtw8852b_table.c   |  27 ++---
 .../wireless/realtek/rtw89/rtw8852b_table.h   |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 101 +++++++-----------
 .../wireless/realtek/rtw89/rtw8852c_table.c   |  35 +++---
 .../wireless/realtek/rtw89/rtw8852c_table.h   |   2 +-
 13 files changed, 146 insertions(+), 178 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index e31034377b54..b0c82bac72f0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -353,25 +353,6 @@ struct rtw89_txpwr_byrate_cfg {
 	u32 data;
 };
 
-struct rtw89_txpwr_track_cfg {
-	const s8 (*delta_swingidx_6gb_n)[DELTA_SWINGIDX_SIZE];
-	const s8 (*delta_swingidx_6gb_p)[DELTA_SWINGIDX_SIZE];
-	const s8 (*delta_swingidx_6ga_n)[DELTA_SWINGIDX_SIZE];
-	const s8 (*delta_swingidx_6ga_p)[DELTA_SWINGIDX_SIZE];
-	const s8 (*delta_swingidx_5gb_n)[DELTA_SWINGIDX_SIZE];
-	const s8 (*delta_swingidx_5gb_p)[DELTA_SWINGIDX_SIZE];
-	const s8 (*delta_swingidx_5ga_n)[DELTA_SWINGIDX_SIZE];
-	const s8 (*delta_swingidx_5ga_p)[DELTA_SWINGIDX_SIZE];
-	const s8 *delta_swingidx_2gb_n;
-	const s8 *delta_swingidx_2gb_p;
-	const s8 *delta_swingidx_2ga_n;
-	const s8 *delta_swingidx_2ga_p;
-	const s8 *delta_swingidx_2g_cck_b_n;
-	const s8 *delta_swingidx_2g_cck_b_p;
-	const s8 *delta_swingidx_2g_cck_a_n;
-	const s8 *delta_swingidx_2g_cck_a_p;
-};
-
 struct rtw89_phy_dig_gain_cfg {
 	const struct rtw89_reg_def *table;
 	u8 size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index a6c7f59223ef..c63f0e6364da 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -2823,6 +2823,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	}						\
 	__val;						\
 })
+	const struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
@@ -2833,23 +2834,26 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	u32 tmp = 0;
 	u8 i, j;
 
+	if (!trk)
+		trk = &rtw89_8851b_trk_cfg;
+
 	switch (subband) {
 	default:
 	case RTW89_CH_2G:
-		thm_up_a = rtw89_8851b_trk_cfg.delta_swingidx_2ga_p;
-		thm_down_a = rtw89_8851b_trk_cfg.delta_swingidx_2ga_n;
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0];
 		break;
 	case RTW89_CH_5G_BAND_1:
-		thm_up_a = rtw89_8851b_trk_cfg.delta_swingidx_5ga_p[0];
-		thm_down_a = rtw89_8851b_trk_cfg.delta_swingidx_5ga_n[0];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0];
 		break;
 	case RTW89_CH_5G_BAND_3:
-		thm_up_a = rtw89_8851b_trk_cfg.delta_swingidx_5ga_p[1];
-		thm_down_a = rtw89_8851b_trk_cfg.delta_swingidx_5ga_n[1];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1];
 		break;
 	case RTW89_CH_5G_BAND_4:
-		thm_up_a = rtw89_8851b_trk_cfg.delta_swingidx_5ga_p[2];
-		thm_down_a = rtw89_8851b_trk_cfg.delta_swingidx_5ga_n[2];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2];
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
index a9c309c245c3..b8105f6e94f1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2022-2023  Realtek Corporation
  */
 
+#include "fw.h"
 #include "phy.h"
 #include "reg.h"
 #include "rtw8851b_table.h"
@@ -14866,13 +14867,13 @@ const struct rtw89_txpwr_table rtw89_8851b_byr_table_type2 = {
 	.load = rtw89_phy_load_txpwr_byrate,
 };
 
-const struct rtw89_txpwr_track_cfg rtw89_8851b_trk_cfg = {
-	.delta_swingidx_5ga_n = _txpwr_track_delta_swingidx_5ga_n,
-	.delta_swingidx_5ga_p = _txpwr_track_delta_swingidx_5ga_p,
-	.delta_swingidx_2ga_n = _txpwr_track_delta_swingidx_2ga_n,
-	.delta_swingidx_2ga_p = _txpwr_track_delta_swingidx_2ga_p,
-	.delta_swingidx_2g_cck_a_n = _txpwr_track_delta_swingidx_2g_cck_a_n,
-	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
+const struct rtw89_fw_txpwr_track_cfg rtw89_8851b_trk_cfg = {
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N] = _txpwr_track_delta_swingidx_5ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P] = _txpwr_track_delta_swingidx_5ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N] = &_txpwr_track_delta_swingidx_2ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P] = &_txpwr_track_delta_swingidx_2ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_N] = &_txpwr_track_delta_swingidx_2g_cck_a_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_P] = &_txpwr_track_delta_swingidx_2g_cck_a_p,
 };
 
 const struct rtw89_rfe_parms rtw89_8851b_dflt_parms = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
index d8cf545d40a0..a73c0a6f03df 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_table.h
@@ -11,7 +11,7 @@ extern const struct rtw89_phy_table rtw89_8851b_phy_bb_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_bb_gain_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8851b_phy_nctl_table;
-extern const struct rtw89_txpwr_track_cfg rtw89_8851b_trk_cfg;
+extern const struct rtw89_fw_txpwr_track_cfg rtw89_8851b_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8851b_dflt_parms;
 extern const struct rtw89_rfe_parms_conf rtw89_8851b_rfe_parms_conf[];
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index 8679b21fd3fd..609cc300f24e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -2910,6 +2910,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	}						\
 	__val;						\
 })
+	const struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
@@ -2922,31 +2923,34 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	u32 tmp = 0;
 	u8 i, j;
 
+	if (!trk)
+		trk = &rtw89_8852a_trk_cfg;
+
 	switch (subband) {
 	default:
 	case RTW89_CH_2G:
-		thm_up_a = rtw89_8852a_trk_cfg.delta_swingidx_2ga_p;
-		thm_down_a = rtw89_8852a_trk_cfg.delta_swingidx_2ga_n;
-		thm_up_b = rtw89_8852a_trk_cfg.delta_swingidx_2gb_p;
-		thm_down_b = rtw89_8852a_trk_cfg.delta_swingidx_2gb_n;
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N][0];
 		break;
 	case RTW89_CH_5G_BAND_1:
-		thm_up_a = rtw89_8852a_trk_cfg.delta_swingidx_5ga_p[0];
-		thm_down_a = rtw89_8852a_trk_cfg.delta_swingidx_5ga_n[0];
-		thm_up_b = rtw89_8852a_trk_cfg.delta_swingidx_5gb_p[0];
-		thm_down_b = rtw89_8852a_trk_cfg.delta_swingidx_5gb_n[0];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][0];
 		break;
 	case RTW89_CH_5G_BAND_3:
-		thm_up_a = rtw89_8852a_trk_cfg.delta_swingidx_5ga_p[1];
-		thm_down_a = rtw89_8852a_trk_cfg.delta_swingidx_5ga_n[1];
-		thm_up_b = rtw89_8852a_trk_cfg.delta_swingidx_5gb_p[1];
-		thm_down_b = rtw89_8852a_trk_cfg.delta_swingidx_5gb_n[1];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][1];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][1];
 		break;
 	case RTW89_CH_5G_BAND_4:
-		thm_up_a = rtw89_8852a_trk_cfg.delta_swingidx_5ga_p[2];
-		thm_down_a = rtw89_8852a_trk_cfg.delta_swingidx_5ga_n[2];
-		thm_up_b = rtw89_8852a_trk_cfg.delta_swingidx_5gb_p[2];
-		thm_down_b = rtw89_8852a_trk_cfg.delta_swingidx_5gb_n[2];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][2];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][2];
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
index ffdeb3801991..f1bcef64a91f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "fw.h"
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852a_table.h"
@@ -50983,19 +50984,19 @@ const struct rtw89_txpwr_table rtw89_8852a_byr_table = {
 	.load = rtw89_phy_load_txpwr_byrate,
 };
 
-const struct rtw89_txpwr_track_cfg rtw89_8852a_trk_cfg = {
-	.delta_swingidx_5gb_n = _txpwr_track_delta_swingidx_5gb_n,
-	.delta_swingidx_5gb_p = _txpwr_track_delta_swingidx_5gb_p,
-	.delta_swingidx_5ga_n = _txpwr_track_delta_swingidx_5ga_n,
-	.delta_swingidx_5ga_p = _txpwr_track_delta_swingidx_5ga_p,
-	.delta_swingidx_2gb_n = _txpwr_track_delta_swingidx_2gb_n,
-	.delta_swingidx_2gb_p = _txpwr_track_delta_swingidx_2gb_p,
-	.delta_swingidx_2ga_n = _txpwr_track_delta_swingidx_2ga_n,
-	.delta_swingidx_2ga_p = _txpwr_track_delta_swingidx_2ga_p,
-	.delta_swingidx_2g_cck_b_n = _txpwr_track_delta_swingidx_2g_cck_b_n,
-	.delta_swingidx_2g_cck_b_p = _txpwr_track_delta_swingidx_2g_cck_b_p,
-	.delta_swingidx_2g_cck_a_n = _txpwr_track_delta_swingidx_2g_cck_a_n,
-	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
+const struct rtw89_fw_txpwr_track_cfg rtw89_8852a_trk_cfg = {
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N] = _txpwr_track_delta_swingidx_5gb_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P] = _txpwr_track_delta_swingidx_5gb_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N] = _txpwr_track_delta_swingidx_5ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P] = _txpwr_track_delta_swingidx_5ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N] = &_txpwr_track_delta_swingidx_2gb_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P] = &_txpwr_track_delta_swingidx_2gb_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N] = &_txpwr_track_delta_swingidx_2ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P] = &_txpwr_track_delta_swingidx_2ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_N] = &_txpwr_track_delta_swingidx_2g_cck_b_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_P] = &_txpwr_track_delta_swingidx_2g_cck_b_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_N] = &_txpwr_track_delta_swingidx_2g_cck_a_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_P] = &_txpwr_track_delta_swingidx_2g_cck_a_p,
 };
 
 const struct rtw89_rfe_parms rtw89_8852a_dflt_parms = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
index 58fe8575c1c9..501a8248d1ce 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
@@ -11,7 +11,7 @@ extern const struct rtw89_phy_table rtw89_8852a_phy_bb_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_nctl_table;
-extern const struct rtw89_txpwr_track_cfg rtw89_8852a_trk_cfg;
+extern const struct rtw89_fw_txpwr_track_cfg rtw89_8852a_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8852a_dflt_parms;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 5cfacc10e7c8..29a82b1c4457 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -2784,6 +2784,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	}						\
 	__val;						\
 })
+	const struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
@@ -2796,31 +2797,34 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	u32 tmp = 0;
 	u8 i, j;
 
+	if (!trk)
+		trk = &rtw89_8852b_trk_cfg;
+
 	switch (subband) {
 	default:
 	case RTW89_CH_2G:
-		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_2ga_p;
-		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_2ga_n;
-		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_2gb_p;
-		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_2gb_n;
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N][0];
 		break;
 	case RTW89_CH_5G_BAND_1:
-		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_p[0];
-		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_n[0];
-		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_p[0];
-		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_n[0];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][0];
 		break;
 	case RTW89_CH_5G_BAND_3:
-		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_p[1];
-		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_n[1];
-		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_p[1];
-		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_n[1];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][1];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][1];
 		break;
 	case RTW89_CH_5G_BAND_4:
-		thm_up_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_p[2];
-		thm_down_a = rtw89_8852b_trk_cfg.delta_swingidx_5ga_n[2];
-		thm_up_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_p[2];
-		thm_down_b = rtw89_8852b_trk_cfg.delta_swingidx_5gb_n[2];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][2];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][2];
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
index 07945d06dc59..96b18e9095b3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "fw.h"
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852b_table.h"
@@ -22895,19 +22896,19 @@ const struct rtw89_txpwr_table rtw89_8852b_byr_table = {
 	.load = rtw89_phy_load_txpwr_byrate,
 };
 
-const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg = {
-	.delta_swingidx_5gb_n = _txpwr_track_delta_swingidx_5gb_n,
-	.delta_swingidx_5gb_p = _txpwr_track_delta_swingidx_5gb_p,
-	.delta_swingidx_5ga_n = _txpwr_track_delta_swingidx_5ga_n,
-	.delta_swingidx_5ga_p = _txpwr_track_delta_swingidx_5ga_p,
-	.delta_swingidx_2gb_n = _txpwr_track_delta_swingidx_2gb_n,
-	.delta_swingidx_2gb_p = _txpwr_track_delta_swingidx_2gb_p,
-	.delta_swingidx_2ga_n = _txpwr_track_delta_swingidx_2ga_n,
-	.delta_swingidx_2ga_p = _txpwr_track_delta_swingidx_2ga_p,
-	.delta_swingidx_2g_cck_b_n = _txpwr_track_delta_swingidx_2g_cck_b_n,
-	.delta_swingidx_2g_cck_b_p = _txpwr_track_delta_swingidx_2g_cck_b_p,
-	.delta_swingidx_2g_cck_a_n = _txpwr_track_delta_swingidx_2g_cck_a_n,
-	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
+const struct rtw89_fw_txpwr_track_cfg rtw89_8852b_trk_cfg = {
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N] = _txpwr_track_delta_swingidx_5gb_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P] = _txpwr_track_delta_swingidx_5gb_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N] = _txpwr_track_delta_swingidx_5ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P] = _txpwr_track_delta_swingidx_5ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N] = &_txpwr_track_delta_swingidx_2gb_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P] = &_txpwr_track_delta_swingidx_2gb_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N] = &_txpwr_track_delta_swingidx_2ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P] = &_txpwr_track_delta_swingidx_2ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_N] = &_txpwr_track_delta_swingidx_2g_cck_b_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_P] = &_txpwr_track_delta_swingidx_2g_cck_b_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_N] = &_txpwr_track_delta_swingidx_2g_cck_a_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_P] = &_txpwr_track_delta_swingidx_2g_cck_a_p,
 };
 
 const struct rtw89_rfe_parms rtw89_8852b_dflt_parms = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
index da6c90e2ba93..d30a1fb43e96 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_table.h
@@ -12,7 +12,7 @@ extern const struct rtw89_phy_table rtw89_8852b_phy_bb_gain_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852b_phy_nctl_table;
-extern const struct rtw89_txpwr_track_cfg rtw89_8852b_trk_cfg;
+extern const struct rtw89_fw_txpwr_track_cfg rtw89_8852b_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8852b_dflt_parms;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index cbee484dee30..8d03a4645947 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -2992,7 +2992,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	}						\
 	__val;						\
 })
-	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
+	const struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
@@ -3005,91 +3005,62 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	u32 tmp = 0;
 	u8 i, j;
 
+	if (!trk)
+		trk = &rtw89_8852c_trk_cfg;
+
 	switch (subband) {
 	default:
 	case RTW89_CH_2G:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_2ga_p;
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_2ga_n;
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P][0] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_2gb_p;
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N][0] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_2gb_n;
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N][0];
 		break;
 	case RTW89_CH_5G_BAND_1:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[0];
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[0];
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][0] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[0];
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][0] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[0];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][0];
 		break;
 	case RTW89_CH_5G_BAND_3:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[1];
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[1];
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][1] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[1];
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][1] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[1];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][1];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][1];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][1];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][1];
 		break;
 	case RTW89_CH_5G_BAND_4:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_5ga_p[2];
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_5ga_n[2];
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][2] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_5gb_p[2];
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][2] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_5gb_n[2];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P][2];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N][2];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P][2];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N][2];
 		break;
 	case RTW89_CH_6G_BAND_IDX0:
 	case RTW89_CH_6G_BAND_IDX1:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][0] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[0];
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][0] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[0];
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][0] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[0];
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][0] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[0];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][0];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][0];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][0];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][0];
 		break;
 	case RTW89_CH_6G_BAND_IDX2:
 	case RTW89_CH_6G_BAND_IDX3:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][1] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[1];
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][1] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[1];
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][1] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[1];
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][1] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[1];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][1];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][1];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][1];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][1];
 		break;
 	case RTW89_CH_6G_BAND_IDX4:
 	case RTW89_CH_6G_BAND_IDX5:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][2] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[2];
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][2] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[2];
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][2] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[2];
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][2] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[2];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][2];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][2];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][2];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][2];
 		break;
 	case RTW89_CH_6G_BAND_IDX6:
 	case RTW89_CH_6G_BAND_IDX7:
-		thm_up_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][3] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6ga_p[3];
-		thm_down_a = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][3] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6ga_n[3];
-		thm_up_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][3] :
-				 rtw89_8852c_trk_cfg.delta_swingidx_6gb_p[3];
-		thm_down_b = trk ? trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][3] :
-				   rtw89_8852c_trk_cfg.delta_swingidx_6gb_n[3];
+		thm_up_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P][3];
+		thm_down_a = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N][3];
+		thm_up_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P][3];
+		thm_down_b = trk->delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N][3];
 		break;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index 24c390b6f3d3..b4cf497e8524 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "fw.h"
 #include "phy.h"
 #include "reg.h"
 #include "rtw8852c_table.h"
@@ -57109,23 +57110,23 @@ const struct rtw89_txpwr_table rtw89_8852c_byr_table = {
 	.load = rtw89_phy_load_txpwr_byrate,
 };
 
-const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg = {
-	.delta_swingidx_6gb_n = _txpwr_track_delta_swingidx_6gb_n,
-	.delta_swingidx_6gb_p = _txpwr_track_delta_swingidx_6gb_p,
-	.delta_swingidx_6ga_n = _txpwr_track_delta_swingidx_6ga_n,
-	.delta_swingidx_6ga_p = _txpwr_track_delta_swingidx_6ga_p,
-	.delta_swingidx_5gb_n = _txpwr_track_delta_swingidx_5gb_n,
-	.delta_swingidx_5gb_p = _txpwr_track_delta_swingidx_5gb_p,
-	.delta_swingidx_5ga_n = _txpwr_track_delta_swingidx_5ga_n,
-	.delta_swingidx_5ga_p = _txpwr_track_delta_swingidx_5ga_p,
-	.delta_swingidx_2gb_n = _txpwr_track_delta_swingidx_2gb_n,
-	.delta_swingidx_2gb_p = _txpwr_track_delta_swingidx_2gb_p,
-	.delta_swingidx_2ga_n = _txpwr_track_delta_swingidx_2ga_n,
-	.delta_swingidx_2ga_p = _txpwr_track_delta_swingidx_2ga_p,
-	.delta_swingidx_2g_cck_b_n = _txpwr_track_delta_swingidx_2g_cck_b_n,
-	.delta_swingidx_2g_cck_b_p = _txpwr_track_delta_swingidx_2g_cck_b_p,
-	.delta_swingidx_2g_cck_a_n = _txpwr_track_delta_swingidx_2g_cck_a_n,
-	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
+const struct rtw89_fw_txpwr_track_cfg rtw89_8852c_trk_cfg = {
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_N] = _txpwr_track_delta_swingidx_6gb_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_6GB_P] = _txpwr_track_delta_swingidx_6gb_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_N] = _txpwr_track_delta_swingidx_6ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_6GA_P] = _txpwr_track_delta_swingidx_6ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_N] = _txpwr_track_delta_swingidx_5gb_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GB_P] = _txpwr_track_delta_swingidx_5gb_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_N] = _txpwr_track_delta_swingidx_5ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_5GA_P] = _txpwr_track_delta_swingidx_5ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_N] = &_txpwr_track_delta_swingidx_2gb_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GB_P] = &_txpwr_track_delta_swingidx_2gb_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_N] = &_txpwr_track_delta_swingidx_2ga_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2GA_P] = &_txpwr_track_delta_swingidx_2ga_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_N] = &_txpwr_track_delta_swingidx_2g_cck_b_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_B_P] = &_txpwr_track_delta_swingidx_2g_cck_b_p,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_N] = &_txpwr_track_delta_swingidx_2g_cck_a_n,
+	.delta[RTW89_FW_TXPWR_TRK_TYPE_2G_CCK_A_P] = &_txpwr_track_delta_swingidx_2g_cck_a_p,
 };
 
 const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
index 7c9f3ecdc4e7..69c95f35b535 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
@@ -13,7 +13,7 @@ extern const struct rtw89_phy_table rtw89_8852c_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_nctl_table;
 extern const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table;
-extern const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg;
+extern const struct rtw89_fw_txpwr_track_cfg rtw89_8852c_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8852c_dflt_parms;
 
 #endif
-- 
2.25.1


