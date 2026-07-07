Return-Path: <linux-wireless+bounces-38741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qSvlAHvGTGpBpgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:27:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E9A719C03
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:27:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=sKwMQz1q;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38741-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38741-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0DE631B36B1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E103E2580F3;
	Tue,  7 Jul 2026 09:13:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD193909B5
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:13:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415584; cv=none; b=UWyq3GhWF7s+zDTo4Lx/axa6l3Wi+PcMdvAQBXjLcndCTYH0jaKZLCdGWMP459iHeFUQSW1V5xrOqfGMsdSO12mOSvao6N9Bdvd7xjw4eIAIKq725Q4sgtufCvfvp628YMhxRAWp1Kmtpdq6sgL0PQptAnun7m9WqY+HobxBjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415584; c=relaxed/simple;
	bh=94lviQjUzoZn6Tsz7tRxAcaNO40np9t1NCEPmNNNaPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKoijiOHjcqho38XsBF1/ZmgL/ZmGsYfqLwtE2zV9foNIlhb4WeiQWW3roic7w0qYCNcHHBL6h4oTPZ7yZxwOH6pZq0SS0/sZBBFqlecAnUK/PXYNztmChg27/Ul5O5U2ARCqiTwq0tX7HytfYEkm65FeRlkWGHtJIRsqXdXgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sKwMQz1q; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679D1w641359693, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415581; bh=hSq+53k2S5L3bTP1+/U4r3fmNONVkRg9D+PDCLI3xZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sKwMQz1qkIivkIuc3iXfnZ8Okn3ibIcQ+5g5QH+RAFzx5FDZsaqDLPgg0TmquyzVD
	 11N/lNZOMLTHa2nCx/oqI059b7LrI+9y+jEgnht/awNmCN9uxFIjvUavuYm7pVkEv5
	 zrLu5fYHMlk5vsGkC1TZ6tA83sxPYubXwY46mgEK8ZqlWEyUzXZdXBRbVM0yvrjaKY
	 kdlf/btK8jm/5icSluWJ2ijiYqM9QlJ30aFYGhIkwgwdq5WjY3Quf6Q4QIZ70K1oq5
	 5S4L4sXV2+HCHcQdrS+AaeyO0e6OxmzvXh5xU3gmhyrZcCTLl/wNUQBhcy+wE5NftC
	 5thYd8BjuMxtA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679D1w641359693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:13:01 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:13:01 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:13:01 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:13:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 13/15] wifi: rtw89: phy: add NCTL check for WiFi 7 chips
Date: Tue, 7 Jul 2026 17:10:54 +0800
Message-ID: <20260707091056.42771-14-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38741-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 51E9A719C03

Initialize NCTL hardware and check the state before downloading NCTL.
Otherwise, the following RF calibrations relying on NCTL may fail.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    |  1 +
 drivers/net/wireless/realtek/rtw89/phy.h    |  6 +++
 drivers/net/wireless/realtek/rtw89/phy_be.c | 41 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  6 +++
 4 files changed, 54 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index dcd54be58a33..30d5741da87e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -9010,6 +9010,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.physts = &rtw89_physts_regs_ax,
 	.cfo = &rtw89_cfo_regs_ax,
 	.bb_wrap = NULL,
+	.nctl = NULL,
 	.phy0_phy1_offset = rtw89_phy0_phy1_offset_ax,
 	.config_bb_gain = rtw89_phy_config_bb_gain_ax,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 532232892831..e31034377b54 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -502,6 +502,11 @@ struct rtw89_bb_wrap_regs {
 	u32 pwr_macid_path;
 };
 
+struct rtw89_nctl_regs {
+	u32 cfg;
+	u32 rw;
+};
+
 enum rtw89_bandwidth_section_num_ax {
 	RTW89_BW20_SEC_NUM_AX = 8,
 	RTW89_BW40_SEC_NUM_AX = 4,
@@ -679,6 +684,7 @@ struct rtw89_phy_gen_def {
 	const struct rtw89_physts_regs *physts;
 	const struct rtw89_cfo_regs *cfo;
 	const struct rtw89_bb_wrap_regs *bb_wrap;
+	const struct rtw89_nctl_regs *nctl;
 	u32 (*phy0_phy1_offset)(struct rtw89_dev *rtwdev, u32 addr);
 	void (*config_bb_gain)(struct rtw89_dev *rtwdev,
 			       const struct rtw89_reg2_def *reg,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index ac4ce30445b3..2187b448fe75 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -225,6 +225,16 @@ static const struct rtw89_bb_wrap_regs rtw89_bb_wrap_regs_be_v1 = {
 	.pwr_macid_path = R_BE_PWR_MACID_PATH_BASE_V1,
 };
 
+static const struct rtw89_nctl_regs rtw89_nctl_regs_be = {
+	.cfg = R_NCTL_CFG,
+	.rw = R_NCTL_RW,
+};
+
+static const struct rtw89_nctl_regs rtw89_nctl_regs_be_v1 = {
+	.cfg = R_NCTL_CFG_BE4,
+	.rw = R_NCTL_RW_BE4,
+};
+
 static u32 rtw89_phy0_phy1_offset_be(struct rtw89_dev *rtwdev, u32 addr)
 {
 	u32 phy_page = addr >> 8;
@@ -440,6 +450,28 @@ static void rtw89_phy_config_bb_gain_be(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_phy_preinit_rf_nctl_check_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+	const struct rtw89_nctl_regs *nctl = phy->nctl;
+	int poll;
+	u32 val;
+
+	rtw89_phy_write32(rtwdev, nctl->cfg, B_NCTL_CHK_EN);
+
+	for (poll = 0; poll < 10000; poll++) {
+		rtw89_phy_write32(rtwdev, nctl->rw, B_NCTL_CHECK);
+
+		fsleep(10);
+
+		val = rtw89_phy_read32(rtwdev, nctl->rw);
+		if (val == B_NCTL_CHECK)
+			return;
+	}
+
+	rtw89_warn(rtwdev, "NCTL INIT check 0x%x[2]TIMEOUT!\n", nctl->rw);
+}
+
 static void rtw89_phy_preinit_rf_nctl_be(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_write32_mask(rtwdev, R_GOTX_IQKDPK_C0, B_GOTX_IQKDPK, 0x3);
@@ -456,6 +488,11 @@ static void rtw89_phy_preinit_rf_nctl_be(struct rtw89_dev *rtwdev)
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_RST_C1, B_IQK_DPK_RST, 0x1);
 		rtw89_phy_write32_mask(rtwdev, R_TXRFC_C1, B_TXRFC_RST, 0x1);
 	}
+
+	rtw89_phy_write32_mask(rtwdev, R_TX_COLLISION_T2R_ST, B_RX_CFIR_PATH_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_TX_COLLISION_T2R_ST, B_RX_CFIR_PATH, 0x3);
+
+	rtw89_phy_preinit_rf_nctl_check_be(rtwdev);
 }
 
 static void rtw89_phy_preinit_rf_nctl_be_v1(struct rtw89_dev *rtwdev)
@@ -466,6 +503,8 @@ static void rtw89_phy_preinit_rf_nctl_be_v1(struct rtw89_dev *rtwdev)
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_RST_BE4, B_IQK_DPK_RST, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_PRST_BE4, B_IQK_DPK_PRST, 0x1);
 	rtw89_phy_write32_mask(rtwdev, R_IQK_DPK_PRST_C1_BE4, B_IQK_DPK_PRST, 0x1);
+
+	rtw89_phy_preinit_rf_nctl_check_be(rtwdev);
 }
 
 static u32 rtw89_phy_bb_wrap_flush_addr(struct rtw89_dev *rtwdev, u32 addr)
@@ -1905,6 +1944,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.physts = &rtw89_physts_regs_be,
 	.cfo = &rtw89_cfo_regs_be,
 	.bb_wrap = &rtw89_bb_wrap_regs_be,
+	.nctl = &rtw89_nctl_regs_be,
 	.phy0_phy1_offset = rtw89_phy0_phy1_offset_be,
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be,
@@ -1930,6 +1970,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be_v1 = {
 	.physts = &rtw89_physts_regs_be_v1,
 	.cfo = &rtw89_cfo_regs_be_v1,
 	.bb_wrap = &rtw89_bb_wrap_regs_be_v1,
+	.nctl = &rtw89_nctl_regs_be_v1,
 	.phy0_phy1_offset = rtw89_phy0_phy1_offset_be_v1,
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2caefb929199..4d2117de798b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9022,6 +9022,8 @@
 #define B_IQK_DPK_RST BIT(0)
 #define R_TX_COLLISION_T2R_ST 0x0C70
 #define B_TX_COLLISION_T2R_ST_M GENMASK(25, 20)
+#define B_RX_CFIR_PATH_EN BIT(9)
+#define B_RX_CFIR_PATH GENMASK(6, 5)
 #define B_TXRX_FORCE_VAL GENMASK(9, 0)
 #define R_TXGATING 0x0C74
 #define B_TXGATING_EN BIT(4)
@@ -10115,6 +10117,8 @@
 #define R_S1_DACKQ8 0x7E98
 #define B_S1_DACKQ8_K GENMASK(15, 8)
 #define R_NCTL_CFG 0x8000
+#define R_NCTL_CFG_BE4 0x38000
+#define B_NCTL_CHK_EN BIT(3)
 #define B_NCTL_CFG_SPAGE GENMASK(2, 1)
 #define R_NCTL_RPT 0x8008
 #define B_NCTL_RPT_FLG BIT(26)
@@ -10148,6 +10152,8 @@
 #define R_KIP_MOD 0x8078
 #define B_KIP_MOD GENMASK(19, 0)
 #define R_NCTL_RW 0x8080
+#define R_NCTL_RW_BE4 0x38080
+#define B_NCTL_CHECK BIT(2)
 #define R_KIP_SYSCFG 0x8088
 #define R_KIP_CLK 0x808C
 #define R_DPK_IDL 0x809C
-- 
2.25.1


