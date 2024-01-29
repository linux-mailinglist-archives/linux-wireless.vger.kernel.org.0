Return-Path: <linux-wireless+bounces-2688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EE58412A7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3984284648
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A515A489;
	Mon, 29 Jan 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="v3quiYhO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AEA159574
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553685; cv=none; b=Y3608PPO6Or96g36UAVBh6N5ef9LIcTpQcz75ktKJ1Imr/FSG8rHNDzQtGD4/433qULXcAbr+Ja5vvNCLfmqWGX/K75IVtEB2HP6G9mo67PjDqN1yQR+n+/9lrohmgtT2/SVpYGALxJHPsGHwCtOuQ0yBWmzjRzs73B0GTktG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553685; c=relaxed/simple;
	bh=EKSdNwt19CKH3tIOcT2/1wLoTBi9/zjzWkdRvGk/gHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMZrt8LAb0QcyVvgcdeKoBIyVxlGs+O97dE5HZa3hYqqROVP4SL+3g/CIAezCSFaqaV7Mx9miwtjbfAqmMV0iNXsGnAWbx7+ehCj6uexczfmThLDRL1jU0yafl3eRVkc7bxcQL/VnDOiW7ZNWIesgwWQFya7tb03ux7sc9Q52Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=v3quiYhO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QPretpK49GERcMqUt9zwN7Ok4/lvUI5cZMiChIAtXvo=;
	t=1706553682; x=1707763282; b=v3quiYhOW+qDAp5tVAexKEDPoaLpuIBkaZrrkG0dU5Sd/F6
	eewxoy5fFKMoyxskwQK24bUXuNFo0K9v4qiMm6qzTzwgh4XQU1kcffXvDz84oX6hqTr/c8fO0LaCT
	RRtLKhepf8d7rOsJ4v9LSOtDf3Y8oSlFxsk6WFW37+JtWEPcns3ULOMkwiPf21p+tOFF6B92FaACR
	a5RaZloWoDDFxMHoAnlkZV4KLAqNnKCxZpGtCIDJSKu2HWIzJFCZm/c92eegH/jlGQgcHPFNm5LC7
	GrMlYd0nuZIxRP+qH7bJqXJlAbWYlXJq/0YJRSLZOrWrByfdAxgIewACnj8GT02w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZL-00000004z9N-24QR;
	Mon, 29 Jan 2024 19:41:19 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: cfg80211: move puncturing validation code
Date: Mon, 29 Jan 2024 19:34:44 +0100
Message-ID: <20240129194108.1ca184427c76.I077deb8d52c4648eac145b63f88b6c5a3b920ddc@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Upcoming patches will move the puncturing bitmap into the
chandef, so chandef validation will need to check for correct
puncturing. Purely move the code first so later changes are
easier to review.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/chan.c | 138 ++++++++++++++++++++++----------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index ceb9174c5c3d..71f1bd456d88 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -56,6 +56,75 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 }
 EXPORT_SYMBOL(cfg80211_chandef_create);
 
+struct cfg80211_per_bw_puncturing_values {
+	u8 len;
+	const u16 *valid_values;
+};
+
+static const u16 puncturing_values_80mhz[] = {
+	0x8, 0x4, 0x2, 0x1
+};
+
+static const u16 puncturing_values_160mhz[] = {
+	 0x80, 0x40, 0x20, 0x10, 0x8, 0x4, 0x2, 0x1, 0xc0, 0x30, 0xc, 0x3
+};
+
+static const u16 puncturing_values_320mhz[] = {
+	0xc000, 0x3000, 0xc00, 0x300, 0xc0, 0x30, 0xc, 0x3, 0xf000, 0xf00,
+	0xf0, 0xf, 0xfc00, 0xf300, 0xf0c0, 0xf030, 0xf00c, 0xf003, 0xc00f,
+	0x300f, 0xc0f, 0x30f, 0xcf, 0x3f
+};
+
+#define CFG80211_PER_BW_VALID_PUNCTURING_VALUES(_bw) \
+	{ \
+		.len = ARRAY_SIZE(puncturing_values_ ## _bw ## mhz), \
+		.valid_values = puncturing_values_ ## _bw ## mhz \
+	}
+
+static const struct cfg80211_per_bw_puncturing_values per_bw_puncturing[] = {
+	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(80),
+	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(160),
+	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(320)
+};
+
+bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
+					      const struct cfg80211_chan_def *chandef)
+{
+	u32 idx, i, start_freq;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_80:
+		idx = 0;
+		start_freq = chandef->center_freq1 - 40;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		idx = 1;
+		start_freq = chandef->center_freq1 - 80;
+		break;
+	case NL80211_CHAN_WIDTH_320:
+		idx = 2;
+		start_freq = chandef->center_freq1 - 160;
+		break;
+	default:
+		*bitmap = 0;
+		break;
+	}
+
+	if (!*bitmap)
+		return true;
+
+	/* check if primary channel is punctured */
+	if (*bitmap & (u16)BIT((chandef->chan->center_freq - start_freq) / 20))
+		return false;
+
+	for (i = 0; i < per_bw_puncturing[idx].len; i++)
+		if (per_bw_puncturing[idx].valid_values[i] == *bitmap)
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL(cfg80211_valid_disable_subchannel_bitmap);
+
 static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
 	int max_contiguous = 0;
@@ -1532,72 +1601,3 @@ struct cfg80211_chan_def *wdev_chandef(struct wireless_dev *wdev,
 	}
 }
 EXPORT_SYMBOL(wdev_chandef);
-
-struct cfg80211_per_bw_puncturing_values {
-	u8 len;
-	const u16 *valid_values;
-};
-
-static const u16 puncturing_values_80mhz[] = {
-	0x8, 0x4, 0x2, 0x1
-};
-
-static const u16 puncturing_values_160mhz[] = {
-	 0x80, 0x40, 0x20, 0x10, 0x8, 0x4, 0x2, 0x1, 0xc0, 0x30, 0xc, 0x3
-};
-
-static const u16 puncturing_values_320mhz[] = {
-	0xc000, 0x3000, 0xc00, 0x300, 0xc0, 0x30, 0xc, 0x3, 0xf000, 0xf00,
-	0xf0, 0xf, 0xfc00, 0xf300, 0xf0c0, 0xf030, 0xf00c, 0xf003, 0xc00f,
-	0x300f, 0xc0f, 0x30f, 0xcf, 0x3f
-};
-
-#define CFG80211_PER_BW_VALID_PUNCTURING_VALUES(_bw) \
-	{ \
-		.len = ARRAY_SIZE(puncturing_values_ ## _bw ## mhz), \
-		.valid_values = puncturing_values_ ## _bw ## mhz \
-	}
-
-static const struct cfg80211_per_bw_puncturing_values per_bw_puncturing[] = {
-	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(80),
-	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(160),
-	CFG80211_PER_BW_VALID_PUNCTURING_VALUES(320)
-};
-
-bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
-					      const struct cfg80211_chan_def *chandef)
-{
-	u32 idx, i, start_freq;
-
-	switch (chandef->width) {
-	case NL80211_CHAN_WIDTH_80:
-		idx = 0;
-		start_freq = chandef->center_freq1 - 40;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		idx = 1;
-		start_freq = chandef->center_freq1 - 80;
-		break;
-	case NL80211_CHAN_WIDTH_320:
-		idx = 2;
-		start_freq = chandef->center_freq1 - 160;
-		break;
-	default:
-		*bitmap = 0;
-		break;
-	}
-
-	if (!*bitmap)
-		return true;
-
-	/* check if primary channel is punctured */
-	if (*bitmap & (u16)BIT((chandef->chan->center_freq - start_freq) / 20))
-		return false;
-
-	for (i = 0; i < per_bw_puncturing[idx].len; i++)
-		if (per_bw_puncturing[idx].valid_values[i] == *bitmap)
-			return true;
-
-	return false;
-}
-EXPORT_SYMBOL(cfg80211_valid_disable_subchannel_bitmap);
-- 
2.43.0


