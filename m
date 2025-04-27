Return-Path: <linux-wireless+bounces-22104-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E8DA9DE03
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 02:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDF01A8130B
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Apr 2025 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3635B227BB5;
	Sun, 27 Apr 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="hQCD2OPJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442E3D69;
	Sun, 27 Apr 2025 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745713485; cv=none; b=qOuqcacJHyKqGR+AoO5PWgyS55FTnd8Ma2eGVgvUfitrz0q8yx+qjVFSg3H3miIwoAhgCbBKEpsrs7rKOvxJgi1p2dBK36QKvW++3vVQgOeFXA9lT+g1Mg6h6vCZ0gt/+Nn9AVCeXZ0CNsGZWMlo43lPR6IDaV+uUFhKsVGHOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745713485; c=relaxed/simple;
	bh=W4wKcQFKyzXroOCC+5XaPsI4KmtRd208o3Omp+mBfRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipPILM6KnIOlzos3Zgg6tIzMlIwEm3U8OkMHKoopv210MCT08aSt3B95ujf6BZPOf7mzChY36llA+IC6tubY/bFbs5qOkO38Mw4rwVZeMkjJtZuH5Hpx7f0/DioAOqj6XPqCvtgFo3ukD3AHypovGNJG0HzjMcDSac+pU/i6BUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=hQCD2OPJ; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745713478; bh=W4wKcQFKyzXroOCC+5XaPsI4KmtRd208o3Omp+mBfRI=;
	h=From:To:Cc:Subject:Date:From;
	b=hQCD2OPJBcZGf01aDAam6BWtGtUz+BixMmwbH7byuWDgPhJoEHcoOv+f3fHJK2CaQ
	 epWZBS2+qPY/fPGYS0GlH9QQd+1XaWpidBbNJfPi7r3YTi8p3Tqs8U1lJ+or0mPHcP
	 pW2zvBLrSnyA/vBdDgpIYVl8fklEekGDzk0/Ms5o=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw89))
Subject: [PATCH] wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data
Date: Sun, 27 Apr 2025 02:24:12 +0200
Message-ID: <20250427002414.410791-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

Internally wiphy writes to individual channels in this structure,
so we must not share one static definition of channel list between
multiple device instances, because that causes hard to debug
breakage.

For example, with two rtw89 driven devices in the system, channel
information may get incoherent, preventing channel use.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---

This patch relates to this report of mine:

  https://lore.kernel.org/linux-wireless/2goskmst4na36v42p2bs47uernp6kh3gzpadhr3u3r2yvyoxlg@bfprgq2qae7p/T/#u

 drivers/net/wireless/realtek/rtw89/core.c | 48 ++++++++++++++++++-----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index cc9b014457ac..ae22954f5f5c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4398,16 +4398,44 @@ static void rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
 	_ieee80211_set_sband_iftype_data(sband, iftype_data, idx);
 }
 
+static struct ieee80211_supported_band *rtw89_copy_sband(const struct ieee80211_supported_band *sband)
+{
+	struct ieee80211_supported_band *copy = kmemdup(sband, sizeof(*sband), GFP_KERNEL);
+
+	copy->channels = kmemdup(sband->channels, sizeof(struct ieee80211_channel) * sband->n_channels, GFP_KERNEL);
+	if (!copy->channels) {
+		kfree(copy);
+		return NULL;
+	}
+
+	copy->bitrates = kmemdup(sband->bitrates, sizeof(struct ieee80211_rate) * sband->n_bitrates, GFP_KERNEL);
+	if (!copy->bitrates) {
+		kfree(copy->channels);
+		kfree(copy);
+		return NULL;
+	}
+
+	return copy;
+}
+
+static void rtw89_free_sband(const struct ieee80211_supported_band *sband)
+{
+	if (sband) {
+		kfree(sband->bitrates);
+		kfree(sband->channels);
+		kfree(sband);
+	}
+}
+
 static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_supported_band *sband_2ghz = NULL, *sband_5ghz = NULL;
 	struct ieee80211_supported_band *sband_6ghz = NULL;
-	u32 size = sizeof(struct ieee80211_supported_band);
 	u8 support_bands = rtwdev->chip->support_bands;
 
 	if (support_bands & BIT(NL80211_BAND_2GHZ)) {
-		sband_2ghz = kmemdup(&rtw89_sband_2ghz, size, GFP_KERNEL);
+		sband_2ghz = rtw89_copy_sband(&rtw89_sband_2ghz);
 		if (!sband_2ghz)
 			goto err;
 		rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
@@ -4416,7 +4444,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 	}
 
 	if (support_bands & BIT(NL80211_BAND_5GHZ)) {
-		sband_5ghz = kmemdup(&rtw89_sband_5ghz, size, GFP_KERNEL);
+		sband_5ghz = rtw89_copy_sband(&rtw89_sband_5ghz);
 		if (!sband_5ghz)
 			goto err;
 		rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
@@ -4426,7 +4454,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 	}
 
 	if (support_bands & BIT(NL80211_BAND_6GHZ)) {
-		sband_6ghz = kmemdup(&rtw89_sband_6ghz, size, GFP_KERNEL);
+		sband_6ghz = rtw89_copy_sband(&rtw89_sband_6ghz);
 		if (!sband_6ghz)
 			goto err;
 		rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_6GHZ, sband_6ghz);
@@ -4445,9 +4473,9 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 		kfree((__force void *)sband_5ghz->iftype_data);
 	if (sband_6ghz)
 		kfree((__force void *)sband_6ghz->iftype_data);
-	kfree(sband_2ghz);
-	kfree(sband_5ghz);
-	kfree(sband_6ghz);
+	rtw89_free_sband(sband_2ghz);
+	rtw89_free_sband(sband_5ghz);
+	rtw89_free_sband(sband_6ghz);
 	return -ENOMEM;
 }
 
@@ -4461,9 +4489,9 @@ static void rtw89_core_clr_supported_band(struct rtw89_dev *rtwdev)
 		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_5GHZ]->iftype_data);
 	if (hw->wiphy->bands[NL80211_BAND_6GHZ])
 		kfree((__force void *)hw->wiphy->bands[NL80211_BAND_6GHZ]->iftype_data);
-	kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
-	kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
-	kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]);
+	rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_2GHZ]);
+	rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_5GHZ]);
+	rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_6GHZ]);
 	hw->wiphy->bands[NL80211_BAND_2GHZ] = NULL;
 	hw->wiphy->bands[NL80211_BAND_5GHZ] = NULL;
 	hw->wiphy->bands[NL80211_BAND_6GHZ] = NULL;
-- 
2.49.0


