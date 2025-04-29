Return-Path: <linux-wireless+bounces-22197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FFCAA0BAC
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 14:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B78E3A5E37
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 12:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CB2C3749;
	Tue, 29 Apr 2025 12:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="LDGT+Bjv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6712BEC35;
	Tue, 29 Apr 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929771; cv=none; b=tGzbsGwy/7ht2fR46udSanG4k3Jzt3GxfJS6P9xSzgeOuHpEUtVF6+d1gzQypCLJ8fQk7mMZx8Qn3sxtau0gdk7+5daANCff1576iolECRPAVs8QOlC462qlWFMJvXDG24l4tDmAbOwkcO5R64Ko5jW8Z7MDYUMcxE49lBZODkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929771; c=relaxed/simple;
	bh=FbzQ5xgMLQCmABRpj7905rWZk9UuHcSN1po5XTM5cog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/Zk+UqZnHFgAVzxa/Nr6sASLJjCEwa7RLZLjlM8cu051xUwi6tocFz0DhsjpKKyLage1YOmY7x9t8fl4VxDW1zI+FnlhQ3aSEytuaasochIgrlEaag+sNFYuZ02x4kwZz/3SJnch/wbAZVM1odHr7TIdeojFACvSArfrw9Ik6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=LDGT+Bjv; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1745929765; bh=FbzQ5xgMLQCmABRpj7905rWZk9UuHcSN1po5XTM5cog=;
	h=From:To:Cc:Subject:Date:References:From;
	b=LDGT+BjvnoBzvkcQR3mok7nNt0/Coy26foIRZLH9JB7a0buy41Y7pWwbMX8LzRi0f
	 5grLeqzy2NIbAPEH/tdYGQAyDbOjm9u0UQ+mdJBAA95OXtNbMhNf6idWQb4xbJLn4z
	 qNXDEovmq3yD2urOf5OJaBkcBz2gkKZw37lKCapg=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Ondrej Jirman <megi@xff.cz>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rtw-next v3 2/2] wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data
Date: Tue, 29 Apr 2025 14:29:11 +0200
Message-ID: <20250429122916.1734879-3-megi@xff.cz>
In-Reply-To: <20250429122916.1734879-1-megi@xff.cz>
References: <20250429122916.1734879-1-megi@xff.cz>
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
index b164bc767e82..bc26790ed313 100644
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
+				     sizeof(*sband->channels) * sband->n_channels,
+				     GFP_KERNEL);
+	if (!dup->channels)
+		return NULL;
+
+	dup->bitrates = devm_kmemdup(rtwdev->dev, sband->bitrates,
+				     sizeof(*sband->bitrates) * sband->n_bitrates,
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


