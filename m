Return-Path: <linux-wireless+bounces-31799-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOeBNvDBjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31799-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F231133373
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98C67302F7E9
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6282288E3;
	Fri, 13 Feb 2026 06:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hxYFTkB4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4C1DA62E
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963437; cv=none; b=uKVw1Q199WBkVnZMXlas1O0mFeomQ0FusqIeS7dqD7BhxQ31CCuejybMDaU52gGE3oQ+FD0Dl/cUPseAX81ALCC44S7tqRkNRcVXo3fwo1ipRY19TxJDrqVaExyLlGBRcuSAazBRZ2lpHu2dFu8Dz+PYWfYR1EWWNXJyc7PVuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963437; c=relaxed/simple;
	bh=/pTrLPPSRB2sM23yK/14jQq/1AZfskBsI2tTdrlYfWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKsFp/vqoX2J8mOMIcIiJd6LxfoKb9HrPV7eGlkH7KUKHyhXUf8bzslicU4FxTjdCFAQzzIeZVYGpEhodSYCMCc0sdZW7H2F8h+0nT08/SkMKk3mL2stv6fVA67LrXcmQInGHGSjXntDZMxwQ7bCv10jqBiY7ZMOmxU1kKRXzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hxYFTkB4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6HDRS01419626, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963433; bh=kRIq7xFl18qdjICUZ3sZEmzifGKnuAaUe0BQt+vGI6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hxYFTkB4BJxJhqQIPpU95TwpRl6+k2YHY76mVjdw19GwaFoo/oT74rTiB30uZjsEx
	 DbxvYy6Rn4BwMePoYPBLo4WaBz0OYXy1KGtDfO9csbBvlVQfOQGYdUewmxfENnk9Uj
	 Ntn5DeRPu1DsY2x8FnYTm+eY854Y4Xq70hWgVoCyYKeWBkCxHr7P1gMGoa8Ul8KJDx
	 zZ9CrpQWxmSk48uFGp+ynVvKFfJoy8aSNR7TbzJgUkpa9ikTemHPcWsx2Hl8byRflo
	 tJrXxn9Q7ex1W0/fr8nkuHz+sEwpJOTd1IQ6/cvkf+SXnsu66eBkm2PUlDo3YG1qwx
	 MYBOweVfI0ABg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6HDRS01419626
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:13 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/12] wifi: rtw89: 8852a: move DIG tables to rtw8852a.c
Date: Fri, 13 Feb 2026 14:15:45 +0800
Message-ID: <20260213061552.29997-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_FROM(0.00)[bounces-31799-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email]
X-Rspamd-Queue-Id: 9F231133373
X-Rspamd-Action: no action

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Now, most of PHY parameter tables in driver can be loaded via FW elements.
Plan to generate the corresponding FW elements for 8852A PHY tables. Then,
after FW elements work for a enough time, rtw8852a_table.c can be cleaned
up. However, DIG (dynamic initial gain) tables are legacy for 8852A only,
so FW element doesn't support. Their sizes are not very big, so move them
to rtw8852a.c and keep rtw8852a_table.c for PHY tables which are supported
by FW elements.

No logic is changed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 51 +++++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852a_table.c   | 51 -------------------
 .../wireless/realtek/rtw89/rtw8852a_table.h   |  1 -
 3 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0d5ec9755783..6089cf9e1d54 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2179,6 +2179,57 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 		rtw8852a_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
 }
 
+#define DECLARE_DIG_TABLE(name) \
+static const struct rtw89_phy_dig_gain_cfg name##_table = { \
+	.table = name, \
+	.size = ARRAY_SIZE(name) \
+}
+
+static const struct rtw89_reg_def rtw89_8852a_lna_gain_g[] = {
+	{R_PATH0_LNA_ERR1, B_PATH0_LNA_ERR_G0_G_MSK},
+	{R_PATH0_LNA_ERR2, B_PATH0_LNA_ERR_G1_G_MSK},
+	{R_PATH0_LNA_ERR2, B_PATH0_LNA_ERR_G2_G_MSK},
+	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G3_G_MSK},
+	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G4_G_MSK},
+	{R_PATH0_LNA_ERR4, B_PATH0_LNA_ERR_G5_G_MSK},
+	{R_PATH0_LNA_ERR5, B_PATH0_LNA_ERR_G6_G_MSK},
+};
+
+DECLARE_DIG_TABLE(rtw89_8852a_lna_gain_g);
+
+static const struct rtw89_reg_def rtw89_8852a_tia_gain_g[] = {
+	{R_PATH0_TIA_ERR_G0, B_PATH0_TIA_ERR_G0_G_MSK},
+	{R_PATH0_TIA_ERR_G1, B_PATH0_TIA_ERR_G1_G_MSK},
+};
+
+DECLARE_DIG_TABLE(rtw89_8852a_tia_gain_g);
+
+static const struct rtw89_reg_def rtw89_8852a_lna_gain_a[] = {
+	{R_PATH0_LNA_ERR1, B_PATH0_LNA_ERR_G0_A_MSK},
+	{R_PATH0_LNA_ERR1, B_PATH0_LNA_ERR_G1_A_MSK},
+	{R_PATH0_LNA_ERR2, B_PATH0_LNA_ERR_G2_A_MSK},
+	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G3_A_MSK},
+	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G4_A_MSK},
+	{R_PATH0_LNA_ERR4, B_PATH0_LNA_ERR_G5_A_MSK},
+	{R_PATH0_LNA_ERR4, B_PATH0_LNA_ERR_G6_A_MSK},
+};
+
+DECLARE_DIG_TABLE(rtw89_8852a_lna_gain_a);
+
+static const struct rtw89_reg_def rtw89_8852a_tia_gain_a[] = {
+	{R_PATH0_TIA_ERR_G0, B_PATH0_TIA_ERR_G0_A_MSK},
+	{R_PATH0_TIA_ERR_G1, B_PATH0_TIA_ERR_G1_A_MSK},
+};
+
+DECLARE_DIG_TABLE(rtw89_8852a_tia_gain_a);
+
+static const struct rtw89_phy_dig_gain_table rtw89_8852a_phy_dig_table = {
+	.cfg_lna_g = &rtw89_8852a_lna_gain_g_table,
+	.cfg_tia_g = &rtw89_8852a_tia_gain_g_table,
+	.cfg_lna_a = &rtw89_8852a_lna_gain_a_table,
+	.cfg_tia_a = &rtw89_8852a_tia_gain_a_table
+};
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8852a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
index 495890c180ef..ffdeb3801991 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
@@ -50952,50 +50952,6 @@ const s8 rtw89_8852a_txpwr_lmt_ru_5g[RTW89_RU_NUM][RTW89_NTX_NUM]
 	[2][1][RTW89_UK][46] = 32,
 };
 
-#define DECLARE_DIG_TABLE(name) \
-static const struct rtw89_phy_dig_gain_cfg name##_table = { \
-	.table = name, \
-	.size = ARRAY_SIZE(name) \
-}
-
-static const struct rtw89_reg_def rtw89_8852a_lna_gain_g[] = {
-	{R_PATH0_LNA_ERR1, B_PATH0_LNA_ERR_G0_G_MSK},
-	{R_PATH0_LNA_ERR2, B_PATH0_LNA_ERR_G1_G_MSK},
-	{R_PATH0_LNA_ERR2, B_PATH0_LNA_ERR_G2_G_MSK},
-	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G3_G_MSK},
-	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G4_G_MSK},
-	{R_PATH0_LNA_ERR4, B_PATH0_LNA_ERR_G5_G_MSK},
-	{R_PATH0_LNA_ERR5, B_PATH0_LNA_ERR_G6_G_MSK},
-};
-
-DECLARE_DIG_TABLE(rtw89_8852a_lna_gain_g);
-
-static const struct rtw89_reg_def rtw89_8852a_tia_gain_g[] = {
-	{R_PATH0_TIA_ERR_G0, B_PATH0_TIA_ERR_G0_G_MSK},
-	{R_PATH0_TIA_ERR_G1, B_PATH0_TIA_ERR_G1_G_MSK},
-};
-
-DECLARE_DIG_TABLE(rtw89_8852a_tia_gain_g);
-
-static const struct rtw89_reg_def rtw89_8852a_lna_gain_a[] = {
-	{R_PATH0_LNA_ERR1, B_PATH0_LNA_ERR_G0_A_MSK},
-	{R_PATH0_LNA_ERR1, B_PATH0_LNA_ERR_G1_A_MSK},
-	{R_PATH0_LNA_ERR2, B_PATH0_LNA_ERR_G2_A_MSK},
-	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G3_A_MSK},
-	{R_PATH0_LNA_ERR3, B_PATH0_LNA_ERR_G4_A_MSK},
-	{R_PATH0_LNA_ERR4, B_PATH0_LNA_ERR_G5_A_MSK},
-	{R_PATH0_LNA_ERR4, B_PATH0_LNA_ERR_G6_A_MSK},
-};
-
-DECLARE_DIG_TABLE(rtw89_8852a_lna_gain_a);
-
-static const struct rtw89_reg_def rtw89_8852a_tia_gain_a[] = {
-	{R_PATH0_TIA_ERR_G0, B_PATH0_TIA_ERR_G0_A_MSK},
-	{R_PATH0_TIA_ERR_G1, B_PATH0_TIA_ERR_G1_A_MSK},
-};
-
-DECLARE_DIG_TABLE(rtw89_8852a_tia_gain_a);
-
 const struct rtw89_phy_table rtw89_8852a_phy_bb_table = {
 	.regs		= rtw89_8852a_phy_bb_regs,
 	.n_regs		= ARRAY_SIZE(rtw89_8852a_phy_bb_regs),
@@ -51042,13 +50998,6 @@ const struct rtw89_txpwr_track_cfg rtw89_8852a_trk_cfg = {
 	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
 };
 
-const struct rtw89_phy_dig_gain_table rtw89_8852a_phy_dig_table = {
-	.cfg_lna_g = &rtw89_8852a_lna_gain_g_table,
-	.cfg_tia_g = &rtw89_8852a_tia_gain_g_table,
-	.cfg_lna_a = &rtw89_8852a_lna_gain_a_table,
-	.cfg_tia_a = &rtw89_8852a_tia_gain_a_table
-};
-
 const struct rtw89_rfe_parms rtw89_8852a_dflt_parms = {
 	.byr_tbl = &rtw89_8852a_byr_table,
 	.rule_2ghz = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
index 7463ae6ee3f9..58fe8575c1c9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
@@ -11,7 +11,6 @@ extern const struct rtw89_phy_table rtw89_8852a_phy_bb_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852a_phy_nctl_table;
-extern const struct rtw89_phy_dig_gain_table rtw89_8852a_phy_dig_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852a_trk_cfg;
 extern const struct rtw89_rfe_parms rtw89_8852a_dflt_parms;
 
-- 
2.25.1


