Return-Path: <linux-wireless+bounces-36964-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKo4OXhnFmqLmAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36964-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 05:39:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 871405DEFB7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 05:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FDAA30071C7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110352E975E;
	Wed, 27 May 2026 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="kygvgzJO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050337C90E
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853129; cv=none; b=d4Dzpw0wsc0wvkY8Sx1cU7Xx6mG/VEJLK7szY3vspoOPQUMlhfPADsp44ArZf2CiCqmIE36EqpUChfIDYDuEGi+xZiMW5R93M16YBs5e+U8IqncGr2fQg99gTw5xY9+KoXHfiFx2e9c3AtOw4i2tbwJrIq1BBKWysKVKrAsHZJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853129; c=relaxed/simple;
	bh=9dIQ83CCvMUuUiiNU4eGIguAOXznpGfBY+1aEv0FXvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhnDmi2ZweL/wLLSz+/KJtH69zDl+95AfcWfaeknkw89FPvWpnnA0Sj8VbckkPk87IXxKO5D5/7KY4cqJ5RtmnlQuZY2LEDqBRCrgoyS922w8Dx+tFADCZBYISwPPuGSRxaiVojq+cg722Ay/sOhtLsRwFBVRuOzfCf33zzR8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=kygvgzJO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so117488305ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1779853127; x=1780457927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHm9eNjcFZOgjQMBcctBZFzs47STpkDa9lbmcKEPvlc=;
        b=kygvgzJOmnYcoK8bg+O2KdVBThDYtOu0gqqCzqbC9bYY2DmaKJPOq5nEt6STfbxr/U
         pVWFgDsqA3yrzjnvldUeYwMquOJOy3a7Lj6mmtkpeo0h6vo9cU46PeCT2NrMdk1B5leB
         LjTxM5VZidzZqCXBDsQuj+K4Zk2wolRGndjVuYug1pL6QR8nAyLChusMc5FWu1zWwRiL
         rG7K4CDpXdDsnbina5KHUI3yxNQMU/WhtBYJm1D76/sWRUDgUKFYELto+aJV3ByLxQni
         5qThqsoNiXmSlY0JzTp608F4jGqljtrNG8vtLH80xvgp/XyPMo0ZpnQJVuyjTdCGh4Jt
         bchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779853127; x=1780457927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dHm9eNjcFZOgjQMBcctBZFzs47STpkDa9lbmcKEPvlc=;
        b=CPw6bLBgXqIYvVIruw9q5SCyzyOsY9B7wB1OfVe3ta4L+vWYLDv2Ch6OmcPB3yaF6q
         mPq7WbO6ZnkX8iaut85Bffl7HjxiP5wL0e8aMB1fpKmaZFv566a1Xecvrdp+kNbKa1qH
         UIB6D/mYX2tPVkZjtD2RLa/oqva2Qz/+kumMT055mvxbdbmmlhWnoQSEOKMBaf2wA1wY
         Ufp8E8WInwgfBN5m5LTpJ3I/GJUUpVUCppq19duccz4RClcOl9XWh0srqqVsszouRAcQ
         cH0QF3BnNAiSJBbFl8dn5x1m4nBEk5sqy6QrvRsITg2Q2WDIlPYP12lnSDQri8r258Bp
         oInQ==
X-Gm-Message-State: AOJu0Yxy28/pQY/Oc5X0ThUu6w0y4jNL/bIpDotEIEqP1dhU23xpU1ch
	oz3ItZoRk0v8Zfq6gS0JJAb8M7iZ6TNR1BYNKzqkg2S4JdkxFLBe02xNjphNS1moe8E=
X-Gm-Gg: Acq92OHt1MxE3SNdYbdt+y5TGhNJ17z2V3SbwVrcwDoP/g3NoGOwT+rkIsDYNxQI3DK
	pQJLeH8kvSimhdSRqNG0KOsCnBS7tLO2qtyT2keicnf9m+zx9t8KMK7rYBRMBdWOmFFZsV2Ag6Y
	Yjv0PknpRvWKuoK3x+0Uj4qP+9iKc/XXnhhPgCPYayC2Fzx+8UyEpcEiX+Q3BnG3rhiLmB0zi6P
	D6RjDnhgPYoIHfg5cM+8npkcM4VXUrCCoytvdP33mWsZPLcLkyDzN/aFuFv/wOcGbf8wYqg4UI6
	dtxZGp3bM7MOrYTRJpS1pkogDnqYXHRlFjqg3lN1j/0/tiul1EGCtGN8ZsxRp2EBx9YC+8QvdKg
	nVXBgZHH7tVDYoy6BsdDlVqVwzEcTXufB47qQ9FqtRXHch8RCEA6eFMQA6jAQ+ZZCv0OrSSUxNN
	BTHFIarJ0Xy09NrC7yqiwIZhTsx824j8IF5V2QMLzXB7Y/odWX7qHtHg0U3ioxRUA7cSZSNZ1s7
	MUBtdjegLlQUEnfxj+5LCBR5AC6Jto=
X-Received: by 2002:a17:902:cccf:b0:2ba:fed:7891 with SMTP id d9443c01a7336-2beb0626253mr257284685ad.30.1779853126901;
        Tue, 26 May 2026 20:38:46 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5924211sm127970475ad.84.2026.05.26.20.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:38:46 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211_hwsim: modernise S1G channel list
Date: Wed, 27 May 2026 13:38:28 +1000
Message-ID: <20260527033828.183821-3-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527033828.183821-1-lachlan.hodges@morsemicro.com>
References: <20260527033828.183821-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36964-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,morsemicro.com:mid,morsemicro.com:email]
X-Rspamd-Queue-Id: 871405DEFB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current S1G channel list in mac80211_hwsim does not represent
what S1G drivers would advertise that being 1MHz primaries. Also,
include the NO_PRIMARY flag on the edgeband 1MHz primaries to emulate
US operation such that it can also be tested.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../wireless/virtual/mac80211_hwsim_main.c    | 56 +++++++++++++------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0241b38beddc..1512e160e41a 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -356,6 +356,14 @@ static struct net_device *hwsim_mon; /* global monitor netdev */
 	.hw_value = (_freq), \
 }
 
+#define CHANS1G(_freq, _offset, _flags) { \
+	.band = NL80211_BAND_S1GHZ, \
+	.center_freq = (_freq), \
+	.freq_offset = (_offset), \
+	.hw_value = (_freq), \
+	.flags = (_flags), \
+}
+
 static const struct ieee80211_channel hwsim_channels_2ghz[] = {
 	CHAN2G(2412), /* Channel 1 */
 	CHAN2G(2417), /* Channel 2 */
@@ -490,7 +498,38 @@ static const struct ieee80211_channel hwsim_channels_6ghz[] = {
 static_assert(HWSIM_NUM_CHANNELS_6GHZ == ARRAY_SIZE(hwsim_channels_6ghz),
 	      "Inconsistent 6 GHz channel count");
 
-static struct ieee80211_channel hwsim_channels_s1g[HWSIM_NUM_S1G_CHANNELS_US];
+/*
+ * US 2024 channels (op class 1). Additionally to emulate real world
+ * US operation, the edgeband 1MHz channels (1, 51) are marked as NO_PRIMARY.
+ */
+static const struct ieee80211_channel hwsim_channels_s1g[] = {
+	CHANS1G(902, 500, IEEE80211_CHAN_S1G_NO_PRIMARY), /* Channel 1 */
+	CHANS1G(903, 500, 0), /* Channel 3 */
+	CHANS1G(904, 500, 0), /* Channel 5 */
+	CHANS1G(905, 500, 0), /* Channel 7 */
+	CHANS1G(906, 500, 0), /* Channel 9 */
+	CHANS1G(907, 500, 0), /* Channel 11 */
+	CHANS1G(908, 500, 0), /* Channel 13 */
+	CHANS1G(909, 500, 0), /* Channel 15 */
+	CHANS1G(910, 500, 0), /* Channel 17 */
+	CHANS1G(911, 500, 0), /* Channel 19 */
+	CHANS1G(912, 500, 0), /* Channel 21 */
+	CHANS1G(913, 500, 0), /* Channel 23 */
+	CHANS1G(914, 500, 0), /* Channel 25 */
+	CHANS1G(915, 500, 0), /* Channel 27 */
+	CHANS1G(916, 500, 0), /* Channel 29 */
+	CHANS1G(917, 500, 0), /* Channel 31 */
+	CHANS1G(918, 500, 0), /* Channel 33 */
+	CHANS1G(919, 500, 0), /* Channel 35 */
+	CHANS1G(920, 500, 0), /* Channel 37 */
+	CHANS1G(921, 500, 0), /* Channel 39 */
+	CHANS1G(922, 500, 0), /* Channel 41 */
+	CHANS1G(923, 500, 0), /* Channel 43 */
+	CHANS1G(924, 500, 0), /* Channel 45 */
+	CHANS1G(925, 500, 0), /* Channel 47 */
+	CHANS1G(926, 500, 0), /* Channel 49 */
+	CHANS1G(927, 500, IEEE80211_CHAN_S1G_NO_PRIMARY), /* Channel 51 */
+};
 
 static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
 	.s1g = true,
@@ -519,19 +558,6 @@ static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
 		     0 },
 };
 
-static void hwsim_init_s1g_channels(struct ieee80211_channel *chans)
-{
-	int ch, freq;
-
-	for (ch = 0; ch < ARRAY_SIZE(hwsim_channels_s1g); ch++) {
-		freq = 902000 + (ch + 1) * 500;
-		chans[ch].band = NL80211_BAND_S1GHZ;
-		chans[ch].center_freq = KHZ_TO_MHZ(freq);
-		chans[ch].freq_offset = freq % 1000;
-		chans[ch].hw_value = ch + 1;
-	}
-}
-
 static const struct ieee80211_rate hwsim_rates[] = {
 	{ .bitrate = 10 },
 	{ .bitrate = 20, .flags = IEEE80211_RATE_SHORT_PREAMBLE },
@@ -7443,8 +7469,6 @@ static int __init init_mac80211_hwsim(void)
 	if (err)
 		goto out_exit_virtio;
 
-	hwsim_init_s1g_channels(hwsim_channels_s1g);
-
 	for (i = 0; i < radios; i++) {
 		struct hwsim_new_radio_params param = { 0 };
 
-- 
2.43.0


