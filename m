Return-Path: <linux-wireless+bounces-36014-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM+4Jmk++2nTYQMAu9opvQ
	(envelope-from <linux-wireless+bounces-36014-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:13:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD674DACBB
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48B88305020A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498045BD57;
	Wed,  6 May 2026 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HLPFaIxY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBEB46AEC5
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073028; cv=none; b=dUOh2yXJ5e5JpAy5Y+kgvFvT+Kv9iTy1kPQ320sscdJZ1PthYgLlIXW2BSQRDbby7dIPiq/7aqI1OZqj/UgfXsyeFTJqLERhoQ8c9fxCPZvI1bXiLqaWXX/Q9QKAbw+E7Al8Vb03qNSD7+1mDKYDA9JcqhZutq5t8myIQo0HFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073028; c=relaxed/simple;
	bh=Cc+GOOaZ++oMFeLoQskrjFFXJrV5/Cibz+/MX3ZX9+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lK9ZvoQ1h5v+7HwdZFGPErptkXjuwLEUO4sYxJ6Ym/eBKbePzinWftdJsYsUOywXTsOMW77IAbxKGHaoHaHsGMZ5+7vnRBMp3gKKU6nuqE/aQppjNIha3Nq6gWWxNR1AKBMwr2CvKRRrP9/opzEOB67HDJwuvM4XqRpHeX4tul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HLPFaIxY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 646DAMMu81986856, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778073022; bh=Er1NyWZ9/K/kjgMrM/44ANly3+IluDZM2igraxz7hwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HLPFaIxYLJPcISg/yuAuv1cWu9uwdrRUrN9FnZfm9drTPFNmKeJbsvpAz+1nQHJJk
	 5dTtPyxUJI9xzGseMP5XqaURpfPVnUQgaGeStt0+dQzLKvd7IJ3ZJ7LpwsISXJbDVc
	 9Fv+LKW5UyskdbAaRv9ok90CmHz+bXPuDKkbGdBam0o1qCTzaJcM0Y1Q30aR95w38T
	 2YHHBxUU58c0SNNOLeK7hLR8najJ/g1PhKlLH8EdVLZzCTuSSLRHLiDEOsZes5gIV0
	 Mm4F7MUvHhz9l97u4dhEtJdNCwzzuNSFxBLf7HqoywnYPzFnczMcVkpdmey7btNGWv
	 BYeCLVEQnqhig==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 646DAMMu81986856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 21:10:22 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 21:10:21 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 6 May 2026 21:10:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 04/14] wifi: rtw89: phy: define PHY status IE length for generations
Date: Wed, 6 May 2026 21:09:50 +0800
Message-ID: <20260506131000.1706298-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260506131000.1706298-1-pkshih@realtek.com>
References: <20260506131000.1706298-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 1BD674DACBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36014-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:email,realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Both RTL8922A and RTL8922D are WiFi 7 chips, but their IE length of PHY
status are different. Define them accordingly.

Generation 0: WiFi 6 chips
Generation 1: WiFi 7 RTL8922A
Generation 2: WiFi 7 RTL8922D

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c   | 19 ++-----------------
 drivers/net/wireless/realtek/rtw89/phy.c    |  4 ++++
 drivers/net/wireless/realtek/rtw89/phy.h    |  5 +++++
 drivers/net/wireless/realtek/rtw89/phy_be.c |  8 ++++++++
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d6bf1d57e8e1..caedb2bd21d5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2040,29 +2040,14 @@ static void rtw89_core_rx_process_phy_ppdu_iter(void *data,
 	}
 }
 
-#define VAR_LEN 0xff
-#define VAR_LEN_UNIT 8
 static u16 rtw89_core_get_phy_status_ie_len(struct rtw89_dev *rtwdev,
 					    const struct rtw89_phy_sts_iehdr *iehdr)
 {
-	static const u8 physts_ie_len_tabs[RTW89_CHIP_GEN_NUM][32] = {
-		[RTW89_CHIP_AX] = {
-			16, 32, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
-			VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 16, 24, VAR_LEN,
-			VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32
-		},
-		[RTW89_CHIP_BE] = {
-			32, 40, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
-			VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 88, 56, VAR_LEN,
-			VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32
-		},
-	};
-	const u8 *physts_ie_len_tab;
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const u8 *physts_ie_len_tab = phy->physt_ie_len;
 	u16 ie_len;
 	u8 ie;
 
-	physts_ie_len_tab = physts_ie_len_tabs[rtwdev->chip->chip_gen];
-
 	ie = le32_get_bits(iehdr->w0, RTW89_PHY_STS_IEHDR_TYPE);
 	if (physts_ie_len_tab[ie] != VAR_LEN)
 		ie_len = physts_ie_len_tab[ie];
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index f98a77f9fc1a..4f82b1a9fa4c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -8948,6 +8948,10 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.cr_base = 0x10000,
 	.physt_bmp_start = R_PHY_STS_BITMAP_ADDR_START,
 	.physt_bmp_eht = 0xfc,
+	.physt_ie_len = {16, 32, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
+			 VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 16, 24, VAR_LEN,
+			 VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32},
+	.physt_gen = 0,
 	.ccx = &rtw89_ccx_regs_ax,
 	.physts = &rtw89_physts_regs_ax,
 	.cfo = &rtw89_cfo_regs_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index a6e685654037..d8038ae5ca86 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -154,6 +154,9 @@
 #define EDCCA_UNIT_CONVER 128
 #define EDCCA_PWROFST_DEFAULT 18
 
+#define VAR_LEN 0xff
+#define VAR_LEN_UNIT 8
+
 enum rtw89_phy_c2h_ra_func {
 	RTW89_PHY_C2H_FUNC_STS_RPT,
 	RTW89_PHY_C2H_FUNC_MU_GPTBL_RPT,
@@ -573,6 +576,8 @@ struct rtw89_phy_gen_def {
 	u32 cr_base;
 	u32 physt_bmp_start;
 	u32 physt_bmp_eht;
+	u8 physt_ie_len[32];
+	u8 physt_gen;
 	const struct rtw89_ccx_regs *ccx;
 	const struct rtw89_physts_regs *physts;
 	const struct rtw89_cfo_regs *cfo;
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 5cd298a2c91b..23137f2dbd4b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -1561,6 +1561,10 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cr_base = 0x20000,
 	.physt_bmp_start = R_PHY_STS_BITMAP_ADDR_START,
 	.physt_bmp_eht = R_PHY_STS_BITMAP_EHT,
+	.physt_ie_len = {32, 40, 24, 24, 8, 8, 8, 8, VAR_LEN, 8, VAR_LEN, 176, VAR_LEN,
+			 VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 88, 56, VAR_LEN,
+			 VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32},
+	.physt_gen = 1,
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
 	.cfo = &rtw89_cfo_regs_be,
@@ -1582,6 +1586,10 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be_v1 = {
 	.cr_base = 0x0,
 	.physt_bmp_start = R_PHY_STS_BITMAP_ADDR_START_BE4,
 	.physt_bmp_eht = R_PHY_STS_BITMAP_EHT_BE4,
+	.physt_ie_len = {32, 40, 24, 24, 16, 16, 16, 16, VAR_LEN, VAR_LEN, VAR_LEN, 168,
+			 VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, VAR_LEN, 32, 56,
+			 96, VAR_LEN, VAR_LEN, 0, 24, 24, 24, 24, 32, 32, 32, 32},
+	.physt_gen = 2,
 	.ccx = &rtw89_ccx_regs_be_v1,
 	.physts = &rtw89_physts_regs_be_v1,
 	.cfo = &rtw89_cfo_regs_be_v1,
-- 
2.25.1


