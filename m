Return-Path: <linux-wireless+bounces-25075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DBAFE088
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6013A8984
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5309A270EA5;
	Wed,  9 Jul 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="d45AEV7L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D38270574
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043844; cv=none; b=hbnFyABERkY9Dj2mvm+Ga7oW3NgyzEvR88x0E7zT127HBt3yl42aYzdmTEzBQOajpm0/NoxS7/CWMGJ1IFux50dHQXhws7JVlDGpDXBZfLHcEVvJIAJjHu4Z5m70cE3rXNFiu1bY8pB/vFXAUKE3a+I1uNZ2lwhxHvxALirYngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043844; c=relaxed/simple;
	bh=U++/INvAYQB91aZeS/QEt2bgUAeqyuorLkOgmmNUObI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3Wl1ge2RRTiUgoGZw7xFOMuJxrCpaGW7jZx4Jl94JSXfeeOA+Uum/pCGaZ4MDs4lWpva7kQqqp245/MohWVcINL4/p6ReHEPOZR/PBl44iB0j7xmcrHJ9441Ovb9N7oApmBUDXV4xn8IE0wmmQwhhGOHrL7V+sAuetO1l0L7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=d45AEV7L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5696od5nB863805, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752043839; bh=amyKrWlmH7rFYpN5RgF9dz2I8QOFXkKn2hXhZPhwnJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=d45AEV7L4KjL5uxavALXfSyTn3aMJt/Nh7MzSz4jlnA0t9eJWx9nf5oVPUtxYkdIi
	 uf0PTD45zBIc9UWKG1TlXvtIRaGjW0McszvPbaueqW/ehGLzBmqnHLItyOCMj4Uyne
	 YSaBqb2poIH6pSYVT4Zth2hoRj23hNkWpxb/NBmgHrmdN2//6lGlDMS/ALpz8qEXln
	 g0ADr77QspsktFr97Q/j9CZKrGQ1xAEd75NWPPF6wsKzXTGZOo5is4JFMNdA+tIBme
	 4ig6tHWJe5BIwx+lgrfXPF5PP854bkg5FJw0EVIv3EA0bWEIzk7SsKBM78qd72CRli
	 nRAeW5nxaL2vA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5696od5nB863805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 14:50:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 14:51:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Jul
 2025 14:51:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/4] wifi: rtw89: regd/acpi: update field definition to specific country in UNII-4 conf
Date: Wed, 9 Jul 2025 14:50:04 +0800
Message-ID: <20250709065006.32028-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709065006.32028-1-pkshih@realtek.com>
References: <20250709065006.32028-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, fields of ACPI DSM function 6 were handled for countries
following specific regulatory.
	BIT(0) for countries following FCC regulatory
	BIT(1) for countries following IC regulatory

Now, update to the following (one field for one specific country).
	BIT(0) for country US
	BIT(1) for country CA

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.h |  4 +--
 drivers/net/wireless/realtek/rtw89/regd.c | 34 ++++++++---------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 8217cdfbbc49..8cf261505539 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -22,8 +22,8 @@ enum rtw89_acpi_dsm_func {
 };
 
 enum rtw89_acpi_conf_unii4 {
-	RTW89_ACPI_CONF_UNII4_FCC = BIT(0),
-	RTW89_ACPI_CONF_UNII4_IC = BIT(1),
+	RTW89_ACPI_CONF_UNII4_US = BIT(0),
+	RTW89_ACPI_CONF_UNII4_CA = BIT(1),
 };
 
 enum rtw89_acpi_policy_mode {
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index c91a86332b17..ea44b8311cb2 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -360,15 +360,13 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 				   struct wiphy *wiphy)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
-	const struct rtw89_regd_ctrl *regd_ctrl = &regulatory->ctrl;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_supported_band *sband;
 	struct rtw89_acpi_dsm_result res = {};
-	bool enable_by_fcc;
-	bool enable_by_ic;
+	bool enable;
+	u8 index;
 	int ret;
 	u8 val;
-	int i;
 
 	sband = wiphy->bands[NL80211_BAND_5GHZ];
 	if (!sband)
@@ -385,35 +383,25 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD,
 			    "acpi: cannot eval unii 4: %d\n", ret);
-		enable_by_fcc = true;
-		enable_by_ic = false;
+		val = u8_encode_bits(1, RTW89_ACPI_CONF_UNII4_US);
 		goto bottom;
 	}
 
 	val = res.u.value;
-	enable_by_fcc = u8_get_bits(val, RTW89_ACPI_CONF_UNII4_FCC);
-	enable_by_ic = u8_get_bits(val, RTW89_ACPI_CONF_UNII4_IC);
 
 	rtw89_debug(rtwdev, RTW89_DBG_REGD,
 		    "acpi: eval if allow unii-4: 0x%x\n", val);
 
 bottom:
-	for (i = 0; i < regd_ctrl->nr; i++) {
-		const struct rtw89_regd *regd = &regd_ctrl->map[i];
+	index = rtw89_regd_get_index_by_name(rtwdev, "US");
+	enable = u8_get_bits(val, RTW89_ACPI_CONF_UNII4_US);
+	if (enable && index != RTW89_REGD_MAX_COUNTRY_NUM)
+		clear_bit(index, regulatory->block_unii4);
 
-		switch (regd->txpwr_regd[RTW89_BAND_5G]) {
-		case RTW89_FCC:
-			if (enable_by_fcc)
-				clear_bit(i, regulatory->block_unii4);
-			break;
-		case RTW89_IC:
-			if (enable_by_ic)
-				clear_bit(i, regulatory->block_unii4);
-			break;
-		default:
-			break;
-		}
-	}
+	index = rtw89_regd_get_index_by_name(rtwdev, "CA");
+	enable = u8_get_bits(val, RTW89_ACPI_CONF_UNII4_CA);
+	if (enable && index != RTW89_REGD_MAX_COUNTRY_NUM)
+		clear_bit(index, regulatory->block_unii4);
 }
 
 static void __rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev, bool block,
-- 
2.25.1


