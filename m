Return-Path: <linux-wireless+bounces-30125-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED7CDE5FF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF9F730012CA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2225C838;
	Fri, 26 Dec 2025 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NvKsD60g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E750135A53
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729746; cv=none; b=HfsktP1ASaTGpKr04EQTsMqaqApOCP0xUpbJJBZaLnREVLC2avtKh5x9EBvQfuX7/HT5Kijnm564UcLfleUHHVQenLtE9xuL9GGHU2calT/EVbla6l9T6mW47tnqzdnjDnTEoAXgevD1C5x4iLWaQzJj563MrCLv7kgxfa2mFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729746; c=relaxed/simple;
	bh=yOEa6drOqReuNBHZD/FW0P/b/GqDw5J8uPaQ5o0ZCHk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=siTJk1dDsyaFAzolZ7ZLbQvmie6pa34N7noM8xyNEiDKk7qZfpZFegz3fs5q1rX/SWFSRbWpJRvleSwmHshqNvCP8B3YkIHVvguJRymdtOwSMTVX2M1SlQQmSNMhAdxSj1GJ6K8WOJI9aTBym2CgMSVTYQZdJYGWpNHCSuHwI8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NvKsD60g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6Fgn063113624, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729742; bh=DftrTr3R1v+srgVCHMzKFeIFiLhOY5jHCaV/6D/aIWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=NvKsD60giC4C96Jd096RPWkCfd/zDnlpmbLjudsG48WjbsOqYKRgwWs4ALsA+68N0
	 XmDsfeXXugXAYj9z4r+M/iA61G/tFz2YoSa3oS0C/gaEqQhR3kW+cXMietiN21GQC4
	 vz3PqMvHN0lijjU78tiK5XxPDfjI6DGKV8PnxspwuLP/NyshV0bOMl7+VGfanhmH50
	 IMKXENrEC7/D2HRSWCdA0OU4EXT0htwjAjQ96HpGpHhiFpJq3B0ZwuSpMttNfluGVS
	 UGGrmPjYBKvCLrGz7twfgkv5jhyeCJEjhTnD5/MwZjcUGZVaFmwvgoe5H2NrTXkIUJ
	 gTMy3g//rqyZQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6Fgn063113624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:42 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:43 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:42 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/12] wifi: rtw89: add default quirks as features to chip_info
Date: Fri, 26 Dec 2025 14:14:42 +0800
Message-ID: <20251226061446.63514-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251226061446.63514-1-pkshih@realtek.com>
References: <20251226061446.63514-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The coming chip will support thermal protection by default, so add default
quirks to chip_info.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c      | 3 +++
 drivers/net/wireless/realtek/rtw89/core.h      | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  | 1 +
 8 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 78cbfd6677e1..e713422ebd7c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5924,6 +5924,9 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	struct rtw89_btc *btc = &rtwdev->btc;
 	u8 band;
 
+	bitmap_or(rtwdev->quirks, rtwdev->quirks, &rtwdev->chip->default_quirks,
+		  NUM_OF_RTW89_QUIRKS);
+
 	INIT_LIST_HEAD(&rtwdev->ba_list);
 	INIT_LIST_HEAD(&rtwdev->forbid_ba_list);
 	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 70bb044a9d35..bd7aa5d0ea8a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4559,6 +4559,7 @@ struct rtw89_chip_info {
 	const struct rtw89_edcca_regs *edcca_regs;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const struct rtw89_xtal_info *xtal_info;
+	unsigned long default_quirks; /* bitmap of rtw89_quirks */
 };
 
 struct rtw89_chip_variant {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e3933946d1ca..e06e70751735 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2715,6 +2715,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8851b,
 #endif
 	.xtal_info		= &rtw8851b_xtal_info,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8851b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 46f5e9c50222..bb12982afef7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2400,6 +2400,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852a,
 #endif
 	.xtal_info		= &rtw8852a_xtal_info,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f813ec9242eb..0f18555e619b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1029,6 +1029,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852b,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852b_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 534ac137b43f..7b637483e9b4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -886,6 +886,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852bt,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852bt_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c20c732d2f6a..a82bbe3ec901 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3245,6 +3245,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8852c,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 795c00d65d5e..041ffec9a327 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3011,6 +3011,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.wowlan_stub		= &rtw_wowlan_stub_8922a,
 #endif
 	.xtal_info		= NULL,
+	.default_quirks		= 0,
 };
 EXPORT_SYMBOL(rtw8922a_chip_info);
 
-- 
2.25.1


