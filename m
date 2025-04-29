Return-Path: <linux-wireless+bounces-22164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8447DA9FFBA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478A63B34C6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86529C336;
	Tue, 29 Apr 2025 02:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="iOEES0j4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BD29C327;
	Tue, 29 Apr 2025 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893273; cv=none; b=EYfw3fb6ve3ccQUWzQsmLLtL3V2TIqG16xo6vwxLGKVc6HTqEdrpLqPSerwmeIEumYqFnDS41XiowdkLsMzyAz9l0oAaVg2Q/7+q8CDtRTRAEnBoKj11odqqj5fedqsplxynro92y7fj931xnGmsaE3dlQMjZf0rpPgAjXeLrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893273; c=relaxed/simple;
	bh=qKgN89vLfEMIK4xuMj7s0TAnx8FLxgnwgji9G/4c0+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxs4btJt8GhoAFNapNOyXWGIUK6fENBWyl8MhLWYDB0I+frgCsVSxl4rMgQiVU4Uguu7BYdxDGVly92B6MxHF4eaZxhVMajC3y1he2MeC4mqdmi0uHkZkDzfT0hzmxHJ1SJAmpDEVH5sfFRQ5sPF5ScSTVh+Fq/qqCKbRrzqkp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=iOEES0j4; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745893266; bh=qKgN89vLfEMIK4xuMj7s0TAnx8FLxgnwgji9G/4c0+E=;
	h=From:To:Cc:Subject:Date:References:From;
	b=iOEES0j4q622GuNEzs/hMz5ANDw4QyCVQJ05nujM8QzvtNEcIqZZiM6Koap91Xhd2
	 iGB/1HoW511f5T9IfRd5S6SLnoCJncljaZi20JpmiltcdSjcZXWdR6E0QkIsbHuYiG
	 9llyah2F8+NmLqlqQgmww8KbeBtc5khi3gWl68K0=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
Date: Tue, 29 Apr 2025 04:20:32 +0200
Message-ID: <20250429022046.1656056-2-megi@xff.cz>
In-Reply-To: <20250429022046.1656056-1-megi@xff.cz>
References: <20250429022046.1656056-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

The code can be simplified by using device managed memory
allocations. Simplify it.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/net/wireless/realtek/rtw89/core.c | 99 +++++++++--------------
 1 file changed, 36 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index cc9b014457ac..b164bc767e82 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4361,17 +4361,18 @@ static void rtw89_init_eht_cap(struct rtw89_dev *rtwdev,
 
 #define RTW89_SBAND_IFTYPES_NR 2
 
-static void rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
-				  enum nl80211_band band,
-				  struct ieee80211_supported_band *sband)
+static int rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
+				 enum nl80211_band band,
+				 struct ieee80211_supported_band *sband)
 {
 	struct ieee80211_sband_iftype_data *iftype_data;
 	enum nl80211_iftype iftype;
 	int idx = 0;
 
-	iftype_data = kcalloc(RTW89_SBAND_IFTYPES_NR, sizeof(*iftype_data), GFP_KERNEL);
+	iftype_data = devm_kcalloc(rtwdev->dev, RTW89_SBAND_IFTYPES_NR,
+				   sizeof(*iftype_data), GFP_KERNEL);
 	if (!iftype_data)
-		return;
+		return -ENOMEM;
 
 	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
 		switch (iftype) {
@@ -4396,77 +4397,52 @@ static void rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
 	}
 
 	_ieee80211_set_sband_iftype_data(sband, iftype_data, idx);
+	return 0;
 }
 
 static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
-	struct ieee80211_supported_band *sband_2ghz = NULL, *sband_5ghz = NULL;
-	struct ieee80211_supported_band *sband_6ghz = NULL;
+	struct ieee80211_supported_band *sband;
 	u32 size = sizeof(struct ieee80211_supported_band);
 	u8 support_bands = rtwdev->chip->support_bands;
+	struct device *dev = rtwdev->dev;
+	int ret;
 
 	if (support_bands & BIT(NL80211_BAND_2GHZ)) {
-		sband_2ghz = kmemdup(&rtw89_sband_2ghz, size, GFP_KERNEL);
-		if (!sband_2ghz)
-			goto err;
-		rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
-		rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_2GHZ, sband_2ghz);
-		hw->wiphy->bands[NL80211_BAND_2GHZ] = sband_2ghz;
+		sband = devm_kmemdup(dev, &rtw89_sband_2ghz, size, GFP_KERNEL);
+		if (!sband)
+			return -ENOMEM;
+		rtw89_init_ht_cap(rtwdev, &sband->ht_cap);
+		ret = rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_2GHZ, sband);
+		if (ret)
+			return ret;
+		hw->wiphy->bands[NL80211_BAND_2GHZ] = sband;
 	}
 
 	if (support_bands & BIT(NL80211_BAND_5GHZ)) {
-		sband_5ghz = kmemdup(&rtw89_sband_5ghz, size, GFP_KERNEL);
-		if (!sband_5ghz)
-			goto err;
-		rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
-		rtw89_init_vht_cap(rtwdev, &sband_5ghz->vht_cap);
-		rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_5GHZ, sband_5ghz);
-		hw->wiphy->bands[NL80211_BAND_5GHZ] = sband_5ghz;
+		sband = devm_kmemdup(dev, &rtw89_sband_5ghz, size, GFP_KERNEL);
+		if (!sband)
+			return -ENOMEM;
+		rtw89_init_ht_cap(rtwdev, &sband->ht_cap);
+		rtw89_init_vht_cap(rtwdev, &sband->vht_cap);
+		ret = rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_5GHZ, sband);
+		if (ret)
+			return ret;
+		hw->wiphy->bands[NL80211_BAND_5GHZ] = sband;
 	}
 
 	if (support_bands & BIT(NL80211_BAND_6GHZ)) {
-		sband_6ghz = kmemdup(&rtw89_sband_6ghz, size, GFP_KERNEL);
-		if (!sband_6ghz)
-			goto err;
-		rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_6GHZ, sband_6ghz);
-		hw->wiphy->bands[NL80211_BAND_6GHZ] = sband_6ghz;
+		sband = devm_kmemdup(dev, &rtw89_sband_6ghz, size, GFP_KERNEL);
+		if (!sband)
+			return -ENOMEM;
+		ret = rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_6GHZ, sband);
+		if (ret)
+			return ret;
+		hw->wiphy->bands[NL80211_BAND_6GHZ] = sband;
 	}
 
 	return 0;
-
-err:
-	hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
-	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
-	hw->wiphy->bands[NL80211_BAND_6GHZ] = NULL;
-	if (sband_2ghz)
-		kfree((__force void *)sband_2ghz->iftype_data);
-	if (sband_5ghz)
-		kfree((__force void *)sband_5ghz->iftype_data);
-	if (sband_6ghz)
-		kfree((__force void *)sband_6ghz->iftype_data);
-	kfree(sband_2ghz);
-	kfree(sband_5ghz);
-	kfree(sband_6ghz);
-	return -ENOMEM;
-}
-
-static void rtw89_core_clr_supported_band(struct rtw89_dev *rtwdev)
-{
-	struct ieee80211_hw *hw = rtwdev->hw;
-
-	if (hw->wiphy->bands[NL80211_BAND_2GHZ])
-		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_2GHZ]->iftype_data);
-	if (hw->wiphy->bands[NL80211_BAND_5GHZ])
-		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_5GHZ]->iftype_data);
-	if (hw->wiphy->bands[NL80211_BAND_6GHZ])
-		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_6GHZ]->iftype_data);
-	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
-	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
-	kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]);
-	hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
-	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
-	hw->wiphy->bands[NL80211_BAND_6GHZ] = NULL;
 }
 
 static void rtw89_core_ppdu_sts_init(struct rtw89_dev *rtwdev)
@@ -5337,7 +5313,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ret = rtw89_regd_setup(rtwdev);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to set up regd\n");
-		goto err_free_supported_band;
+		return ret;
 	}
 
 	hw->wiphy->sar_capa = &rtw89_sar_capa;
@@ -5345,7 +5321,7 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 	ret = ieee80211_register_hw(hw);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to register hw\n");
-		goto err_free_supported_band;
+		return ret;
 	}
 
 	ret = rtw89_regd_init_hint(rtwdev);
@@ -5360,8 +5336,6 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 err_unregister_hw:
 	ieee80211_unregister_hw(hw);
-err_free_supported_band:
-	rtw89_core_clr_supported_band(rtwdev);
 
 	return ret;
 }
@@ -5372,7 +5346,6 @@ static void rtw89_core_unregister_hw(struct rtw89_dev *rtwdev)
 
 	rtw89_rfkill_polling_deinit(rtwdev);
 	ieee80211_unregister_hw(hw);
-	rtw89_core_clr_supported_band(rtwdev);
 }
 
 int rtw89_core_register(struct rtw89_dev *rtwdev)
-- 
2.49.0


