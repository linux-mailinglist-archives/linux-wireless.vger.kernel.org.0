Return-Path: <linux-wireless+bounces-22163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8E3A9FFB6
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51901B62181
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521F29C34E;
	Tue, 29 Apr 2025 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="whDQ127t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A329B769;
	Tue, 29 Apr 2025 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745893272; cv=none; b=uutOZF0hlGvx2DNepFTM/fBfgcPyIsdDzDIiOL65Krdz0bqjTp/VwVHQmfaqA+VfQ55g/2r3lbvD+6O4QZ+3l5NPsPAGcD89z326MgY6Op1ag2JuVt/P5zFqRN7OdkHtPJeIxzYuUl91PuUhhzMHENCGJf0pwhTFvX8RSXXPqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745893272; c=relaxed/simple;
	bh=RlLhbmyYW3wOJhwOrOik8uhu4LVMLGqZOdQlzpsoPQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHj3LtphCMoOamntbMGVYnF3q+jV2CxVcAVW0X6DwZpgzI82JgpVIgIvoEWEftArLkOa7WMkEryiQRKMvlZ7fzxD5RQoX3b/p6gtqrm9jsN6zd7RidtDYCJOJtRfO5GSm42HaoPk1SzRfNTl+80z/bnrh20vnvRT1qFfvhmS5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=whDQ127t; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745893266; bh=RlLhbmyYW3wOJhwOrOik8uhu4LVMLGqZOdQlzpsoPQY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=whDQ127t8Mbn7eywG4c/UreL7hqj70pEfffNMEKYox3bD2Cro6NIPOhy7nPM+5EIJ
	 GSZNTUs5bkhUaC4iTw9vvMer9NA7YGFItiRcSSdIxhqU7pWM3LCC/0sUKs2vl6NAtz
	 O7xPT4WmWQlWX9ZbdjzsQmohjEVkwFRreoFuEhG0=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data
Date: Tue, 29 Apr 2025 04:20:33 +0200
Message-ID: <20250429022046.1656056-3-megi@xff.cz>
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

Internally wiphy writes to individual channels in this structure,
so we must not share one static definition of channel list between
multiple device instances, because that causes hard to debug
breakage.

For example, with two rtw89 driven devices in the system, channel
information may get incoherent, preventing channel use.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/net/wireless/realtek/rtw89/core.c | 33 +++++++++++++++++++----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b164bc767e82..48e21a3549ff 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4400,17 +4400,40 @@ static int rtw89_init_he_eht_cap(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static struct ieee80211_supported_band *
+rtw89_core_sband_dup(struct rtw89_dev *rtwdev,
+		     const struct ieee80211_supported_band *sband)
+{
+	struct ieee80211_supported_band *dup;
+
+	dup = devm_kmemdup(rtwdev->dev, sband, sizeof(*sband), GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	dup->channels = devm_kmemdup(rtwdev->dev, sband->channels,
+				     sizeof(struct ieee80211_channel) * sband->n_channels,
+				     GFP_KERNEL);
+	if (!dup->channels)
+		return NULL;
+
+	dup->bitrates = devm_kmemdup(rtwdev->dev, sband->bitrates,
+				     sizeof(struct ieee80211_rate) * sband->n_bitrates,
+				     GFP_KERNEL);
+	if (!dup->bitrates)
+		return NULL;
+
+	return dup;
+}
+
 static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_supported_band *sband;
-	u32 size = sizeof(struct ieee80211_supported_band);
 	u8 support_bands = rtwdev->chip->support_bands;
-	struct device *dev = rtwdev->dev;
 	int ret;
 
 	if (support_bands & BIT(NL80211_BAND_2GHZ)) {
-		sband = devm_kmemdup(dev, &rtw89_sband_2ghz, size, GFP_KERNEL);
+		sband = rtw89_core_sband_dup(rtwdev, &rtw89_sband_2ghz);
 		if (!sband)
 			return -ENOMEM;
 		rtw89_init_ht_cap(rtwdev, &sband->ht_cap);
@@ -4421,7 +4444,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 	}
 
 	if (support_bands & BIT(NL80211_BAND_5GHZ)) {
-		sband = devm_kmemdup(dev, &rtw89_sband_5ghz, size, GFP_KERNEL);
+		sband = rtw89_core_sband_dup(rtwdev, &rtw89_sband_5ghz);
 		if (!sband)
 			return -ENOMEM;
 		rtw89_init_ht_cap(rtwdev, &sband->ht_cap);
@@ -4433,7 +4456,7 @@ static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
 	}
 
 	if (support_bands & BIT(NL80211_BAND_6GHZ)) {
-		sband = devm_kmemdup(dev, &rtw89_sband_6ghz, size, GFP_KERNEL);
+		sband = rtw89_core_sband_dup(rtwdev, &rtw89_sband_6ghz);
 		if (!sband)
 			return -ENOMEM;
 		ret = rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_6GHZ, sband);
-- 
2.49.0


