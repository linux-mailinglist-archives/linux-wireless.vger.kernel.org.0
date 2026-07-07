Return-Path: <linux-wireless+bounces-38731-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D5ssGVzFTGrfpQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38731-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786F719AFB
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:22:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b="Ma/tOXs+";
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38731-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38731-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BD6E3143D9B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64FE3914E9;
	Tue,  7 Jul 2026 09:12:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196F63905EC
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:12:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415531; cv=none; b=XFd6v87AQ58nQ6Jzzn9ajcx9P7iGeoKNUx1OZgJBGmBM2AkVSwtvh3WlTULAvRqnG5gEbKGMTnCSW7Al40y9s1jkbwIVyjMrRux5V8Al6o/yl/LkEEUyZT1f3Mfl3CDuyOxO2fLxMpzxxI9CJtGSsQj/fYr8Ga3XE1DijgCB7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415531; c=relaxed/simple;
	bh=xKvwC7Mat03U6x+d2gIS71FGMdvn65vjFAGySmdU9/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GAJxN2nPcFbMREXy4F7lyMK0wUiHmgBRbre6PEu0GAAUkgOtZaZc61pNngJ7oQkgh7Ya69oEXpfxJ2cS8ZFBTt3f2KOlZp9sizWaXiftz6Gi/qvGDptCBx0txjtvu0D0V/wk+Zw0bresFTWovmdQYvdLKBstWNXi3OP991rpJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ma/tOXs+; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679C7eM41359481, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415527; bh=tHT+2VhK8RlwOx6DVx5zoOuYHIR5ex/fYRIrHkm6AcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ma/tOXs+kKZxOR3hHdd0JNFZe3XoyXT5FiF9UhvZApKu8uvRNygznMYtI9S6WgRPd
	 htn0XCYOcU9wn2hAjRNUPpXu414AXTqqIMMKd8WchO1kleM2ryiLr+NysJhaTBt99P
	 UJq9JLXXCk7/bE9v/57+fdJG+Hqntgy7dzpz4W+vneCr33en1hvgo0HJ4m7PLIeY/u
	 NtTgy2dH362WVFaUUKyhHdCv3yJYQ61T2WCuX3B0MUSwaZT774RF1xQdPNm1wDTljj
	 1tyuhRa7UQ2Aq/c5GPGRKyE1EZITe5kxoHSyUQv38+vPY3IqozMn2nRmnHezm02rLd
	 kDRNiV6ccliVQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679C7eM41359481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:12:07 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:12:08 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:12:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 03/15] wifi: rtw89: 8922d: fix EMLSR BB switch sequence for MLO mode transition
Date: Tue, 7 Jul 2026 17:10:44 +0800
Message-ID: <20260707091056.42771-4-pkshih@realtek.com>
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
	TAGGED_FROM(0.00)[bounces-38731-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 0786F719AFB

From: Eric Huang <echuang@realtek.com>

Assert BB reset in the intermediate "switch to 1+1" step of the EMLSR
switch sequence for all three MLO mode transitions by updating the
B_EMLSR_SWITCH_BE4 intermediate value from 0xAFFF to 0x3BAB.

Without the BB reset in this step, the baseband can be left in an
inconsistent state before settling into the final MLO configuration.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 45 ++++++++-----------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 1ff788c24eec..3908f9729736 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -10782,6 +10782,7 @@
 #define B_SYS_DBCC_24G_BAND_SEL_BE4 BIT(1)
 #define R_EMLSR_SWITCH_BE4 0x20044
 #define B_EMLSR_SWITCH_BE4 GENMASK(27, 12)
+#define B_EMLSR_CLR_FORCE_BE4 GENMASK(20, 19)
 #define B_EMLSR_BB_CLK_BE4 GENMASK(31, 30)
 #define R_CHINFO_SEG_BE4 0x200B4
 #define B_CHINFO_SEG_LEN_BE4 GENMASK(12, 10)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index 805dd96e61e6..212917db7154 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -2309,17 +2309,16 @@ static void rtw8922d_digital_pwr_comp(struct rtw89_dev *rtwdev,
 	}
 }
 
-static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode,
-			     bool pwr_comp)
+static void rtw8922d_ctrl_mlo_mode_core(struct rtw89_dev *rtwdev,
+					enum rtw89_mlo_dbcc_mode mode)
 {
-	u32 reg0, reg1;
-	u8 cck_phy_idx;
+	rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_CLR_FORCE_BE4, 0x3);
 
 	if (mode == MLO_2_PLUS_0_1RF) {
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
 		udelay(1);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x3BAB);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEBAD);
 		udelay(1);
 
@@ -2329,7 +2328,7 @@ static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
 		udelay(1);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x3BAB);
 		udelay(1);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEFFF);
 
@@ -2339,7 +2338,7 @@ static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
 		udelay(1);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
+		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x3BAB);
 		udelay(1);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x3AAB);
@@ -2351,6 +2350,15 @@ static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0x0);
 	}
+}
+
+static int rtw8922d_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode,
+			     bool pwr_comp)
+{
+	u32 reg0, reg1;
+	u8 cck_phy_idx;
+
+	rtw8922d_ctrl_mlo_mode_core(rtwdev, mode);
 
 	if (pwr_comp)
 		rtw8922d_digital_pwr_comp(rtwdev, RTW89_PHY_0);
@@ -2474,25 +2482,10 @@ static void rtw8922d_pre_set_channel_bb(struct rtw89_dev *rtwdev,
 
 	rtw89_phy_write32_mask(rtwdev, R_SYS_DBCC_BE4, B_SYS_DBCC_BE4, 0x0);
 
-	if (phy_idx == RTW89_PHY_0) {
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
-		fsleep(1);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEBAD);
-		fsleep(1);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEAAD);
-	} else {
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xBBBB);
-		fsleep(1);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x3);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xAFFF);
-		fsleep(1);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEFFF);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_BB_CLK_BE4, 0x0);
-		rtw89_phy_write32_mask(rtwdev, R_EMLSR_SWITCH_BE4, B_EMLSR_SWITCH_BE4, 0xEEFF);
-	}
+	if (phy_idx == RTW89_PHY_0)
+		rtw8922d_ctrl_mlo_mode_core(rtwdev, MLO_2_PLUS_0_1RF);
+	else
+		rtw8922d_ctrl_mlo_mode_core(rtwdev, MLO_0_PLUS_2_1RF);
 
 	fsleep(1);
 }
-- 
2.25.1


