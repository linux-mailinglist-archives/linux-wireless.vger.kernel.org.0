Return-Path: <linux-wireless+bounces-6252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373248A2DE6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E667428350C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 12:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706655783;
	Fri, 12 Apr 2024 11:59:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AF54BEA
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923193; cv=none; b=JazVrmcS6+WVfIm8uY+5r6ocwFFanMjwUR+fzDLNk7glZp3kz2VtX7euAHcRFySV8Ie2fcZauwvJfcvHybyxAn921jWnTJUeV72DwD3r1GIlWM6+XfxiiQBAiVOXK9Qc1VYQ/veUwhEA8l3KJakI1V/RAYaoNU4YzQprGCkU2dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923193; c=relaxed/simple;
	bh=e/0oW4GAwWNRWd9lVsjLhuG86gb/CUm8qZ8LIhgFNdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XlnPbpc+HE9F1auPcP15j6ayqhrc9/mVUsttHUTXPJzINWbLRJas1j5SprPZGMdA3vRj7y0si2CZi+beyA+MXVPU03Yh5u1o7wt+fB5qpahQTQ/fNNRJjCu7NDcuo7GR3931l6U/9uAf4K19/7dLGaUjOHH3TszGmRfwqJ1JLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43CBxnwtF2094321, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43CBxnwtF2094321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 19:59:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 19:59:50 +0800
Received: from [127.0.1.1] (172.16.17.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 19:59:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 8/8] wifi: rtw89: regd: handle policy of 6 GHz SP according to BIOS
Date: Fri, 12 Apr 2024 19:57:29 +0800
Message-ID: <20240412115729.8316-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412115729.8316-1-pkshih@realtek.com>
References: <20240412115729.8316-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

According to BIOS configuration of Realtek ACPI DSM function 7,
RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP, we handle the regd policy of 6 GHz SP.

If BIOS indicates to override driver settings, we only allow the countries,
which are enabled by BIOS, to use 6 GHz SP power. Other countries will be
applied to select default power when recalculating 6 GHz regulatory power
selection.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/regd.c | 59 +++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7cd6b3179713..1fb960af0a85 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4760,6 +4760,7 @@ struct rtw89_regulatory_info {
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
 	DECLARE_BITMAP(block_unii4, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz, RTW89_REGD_MAX_COUNTRY_NUM);
+	DECLARE_BITMAP(block_6ghz_sp, RTW89_REGD_MAX_COUNTRY_NUM);
 };
 
 enum rtw89_ifs_clm_application {
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 47384615e18c..1a133914f673 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -468,6 +468,51 @@ static void rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev)
 	kfree(ptr);
 }
 
+static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_acpi_policy_6ghz_sp *ptr;
+	struct rtw89_acpi_dsm_result res = {};
+	bool enable_by_us;
+	int ret;
+	int i;
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP, &res);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "acpi: cannot eval policy 6ghz-sp: %d\n", ret);
+		return;
+	}
+
+	ptr = res.u.policy_6ghz_sp;
+
+	switch (ptr->override) {
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "%s: unknown override case: %d\n", __func__,
+			    ptr->override);
+		fallthrough;
+	case 0:
+		goto out;
+	case 1:
+		break;
+	}
+
+	bitmap_fill(regulatory->block_6ghz_sp, RTW89_REGD_MAX_COUNTRY_NUM);
+
+	enable_by_us = u8_get_bits(ptr->conf, RTW89_ACPI_CONF_6GHZ_SP_US);
+
+	for (i = 0; i < ARRAY_SIZE(rtw89_regd_map); i++) {
+		const struct rtw89_regd *tmp = &rtw89_regd_map[i];
+
+		if (enable_by_us && memcmp(tmp->alpha2, "US", 2) == 0)
+			clear_bit(i, regulatory->block_6ghz_sp);
+	}
+
+out:
+	kfree(ptr);
+}
+
 static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -510,6 +555,7 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 
 	if (regd_allow_6ghz) {
 		rtw89_regd_setup_policy_6ghz(rtwdev);
+		rtw89_regd_setup_policy_6ghz_sp(rtwdev);
 		return;
 	}
 
@@ -671,10 +717,12 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 static void __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd *regd = regulatory->regd;
 	enum rtw89_reg_6ghz_power sel;
 	const struct rtw89_chan *chan;
 	struct rtw89_vif *rtwvif;
 	int count = 0;
+	u8 index;
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
@@ -691,6 +739,17 @@ static void __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 	if (count != 1)
 		sel = RTW89_REG_6GHZ_POWER_DFLT;
 
+	if (sel == RTW89_REG_6GHZ_POWER_STD) {
+		index = rtw89_regd_get_index(regd);
+		if (index == RTW89_REGD_MAX_COUNTRY_NUM ||
+		    test_bit(index, regulatory->block_6ghz_sp)) {
+			rtw89_debug(rtwdev, RTW89_DBG_REGD,
+				    "%c%c 6 GHz SP is blocked by policy\n",
+				    regd->alpha2[0], regd->alpha2[1]);
+			sel = RTW89_REG_6GHZ_POWER_DFLT;
+		}
+	}
+
 	if (regulatory->reg_6ghz_power == sel)
 		return;
 
-- 
2.25.1


