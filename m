Return-Path: <linux-wireless+bounces-27867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4979BC31DB
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 03:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91DF54E127A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 01:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064DD28D84F;
	Wed,  8 Oct 2025 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Lv/mGzES"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC9286413
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759887564; cv=none; b=DMo/IHp7ifBbcF8uNHX4yD7lEmbQFugGfa7xGPtDE7yB73205lXk0P3l6sJtEFkdNIqQi9xJHL3hv3hcsiiP1AiwkcffbIK1XeH/trOOX5qg001E7SylLOAMcJzddWlVzOaDSz6qB3H5ewkYqL+6q1torRvG6csWjL1HpfZNahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759887564; c=relaxed/simple;
	bh=Wkylx4y1AotVjQSGb1TEHvwMfFPZrR5CTFgRe9OM7a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ty+8/cWejZQh0FFgYuvsnZ6VSJmWjubOZSx5TTFXEADqqlQKWFOfA0FdqIzRW4d1CbzqeFgSr0KpN7cCvtH+3n+ekJeef/ehggMH+IOXCzNTr+wFzmHP5Tgj2lLbyVWxiEiwFmLX3Cl8Xx+ScdC4xI9nwTDCETEPv1dKFC+ObVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Lv/mGzES; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-782bfd0a977so6011953b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 18:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1759887562; x=1760492362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOegZgCGfsuY2ZSO7hoPKDK2DkDCi6DOqQot2mu+73A=;
        b=Lv/mGzESUZSGbTP4ob1PKWWCTAjqR/T6KfbU9dEoNbigOBv95MrOJ9u8C/fgf+qYRq
         Vb5mpYzxVQMDbStKemw8LNh9VnNqrRcAFrzYjT7n87jojZ6wwYvwmjMwFHI4pw3lKrLE
         3E3Xv3lf6/Du8lq/x/vCpik4OdLQGTnDtd75kHjmauvdNLIA+STWU2mzXgNYcwIvvJlg
         Q/FicjWaJ65h1GUuiNRmHK8i8PjXJWI1azhakcM0N/Y7BXeE8Vz9twIEbNDBf80hHcfe
         Vghbi2KIoByUIYTMgkZnglsgd0T/DewgXnTlnLKI17TndWwCOaxIinfEqT9/GLofiEX+
         V+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759887562; x=1760492362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOegZgCGfsuY2ZSO7hoPKDK2DkDCi6DOqQot2mu+73A=;
        b=m0TH9eIhubPi+x9o/Ho1qQoAYhqaIJ9V9LVjLH3U40OPNLKR0tPYDupjFi/PBpYvBc
         UFxlMakMEm8Wa6B6FHBDq36//Dd8QXzAeTJTPMXNtImgthsg4TSDOAG90B7JXVB7BBxF
         pvBm3C/s1qFXic5Wmq0ZybPyfeoN3rlUfvQvDidIXaYXYQBI4QxlDbsFVuh0TEmlC2Pj
         rhAohkJs/A5S8eQVBUwvOM+izDbujHJPp0Q/j3SYwF+gwlDDE+oG0LjwRSoSecwKrXwF
         aMDNSENRwpM/Rw57yW37o7eDzZvM/qpiecv8a5pyKlJaNDN1Brq2N8sSecvAY5H+x2Zn
         Wv1w==
X-Gm-Message-State: AOJu0YwlmD+gNZcvDG59VXWq9WpQfF+t8QqV2nzJfh4MrmmeaOtsw6t0
	+sZFyDveFXBjTSDYk/bD9I84JyplgUGnD8ImN1QXSuzC8x6OBEGMYPYJ+U7kJOGYvBg=
X-Gm-Gg: ASbGncvtyqtX5KaunVd/IrjyCbxQmHQ3cBxIs6Hn0Halyo3jWWccvVLn+vNv3Twov/R
	ThIE9Tacfe/TwJ0OuTuafuefn9t8PewRB3jCvrJiDitdHudHFXveru1p9w3y5cFrzzao2XgL9kT
	331mMWGF3ym1OOSJRIcsWm1DAEsejxAc58fGju+xm48TC7kuv/lRTzIHfAwr0PduQ48B/cRlR/i
	gzskdCY2y/dMIfuKzoS8RO46Vf/qNA1DPwG4eYrzEPJbdzZ8hedwmzVnt9Roo8FzksmekKNj2B0
	/BZL6+94FwoJ4ALI/KeAn99nC3aI/EXgrJJhz3K26wtTXnFL0y/FCmHwEbg1+0dvILWuit5r6b/
	4nhgReiNtphbXjQAIGiqxJ1n05sZ+kWNbO8Caes4pq/BE30Kb9m+nRyMMG0iKldEpNTr4wH4Ulm
	WtNtFApE0T6Kazi3f/CBk=
X-Google-Smtp-Source: AGHT+IHvr4QSLNCbuayBM6KO/U2fd3/+0epVPwRTdaDJWWXgWhUZqdD3K3gsgZKAQDLSo9AEuikLKQ==
X-Received: by 2002:a05:6a00:886:b0:77f:449f:66b0 with SMTP id d2e1a72fcca58-793883dad54mr1960205b3a.32.1759887562220;
        Tue, 07 Oct 2025 18:39:22 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a364sm16978696b3a.6.2025.10.07.18.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 18:39:21 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	arien.judge@morsemicro.com,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: update S1G channel list
Date: Wed,  8 Oct 2025 12:39:03 +1100
Message-ID: <20251008013903.219169-1-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the mac80211_hwsim channel list to represent what cfg80211
expects drivers to advertise, that being 1MHz primary channels.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 53 +++++++++++++------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9f856042a67a..dde6a622ff72 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -359,6 +359,13 @@ static struct net_device *hwsim_mon; /* global monitor netdev */
 	.hw_value = (_freq), \
 }
 
+#define CHANS1G(_freq, _offset) { \
+	.band = NL80211_BAND_S1GHZ, \
+	.center_freq = (_freq), \
+	.freq_offset = (_offset), \
+	.hw_value = (_freq), \
+}
+
 static const struct ieee80211_channel hwsim_channels_2ghz[] = {
 	CHAN2G(2412), /* Channel 1 */
 	CHAN2G(2417), /* Channel 2 */
@@ -487,8 +494,35 @@ static const struct ieee80211_channel hwsim_channels_6ghz[] = {
 	CHAN6G(7115), /* Channel 233 */
 };
 
-#define NUM_S1G_CHANS_US 51
-static struct ieee80211_channel hwsim_channels_s1g[NUM_S1G_CHANS_US];
+/* US S1G channels only */
+static const struct ieee80211_channel hwsim_channels_s1g[] = {
+	CHANS1G(902, 500), /* Channel 1 */
+	CHANS1G(903, 500), /* Channel 3 */
+	CHANS1G(904, 500), /* Channel 5 */
+	CHANS1G(905, 500), /* Channel 7 */
+	CHANS1G(906, 500), /* Channel 9 */
+	CHANS1G(907, 500), /* Channel 11 */
+	CHANS1G(908, 500), /* Channel 13 */
+	CHANS1G(909, 500), /* Channel 15 */
+	CHANS1G(910, 500), /* Channel 17 */
+	CHANS1G(911, 500), /* Channel 19 */
+	CHANS1G(912, 500), /* Channel 21 */
+	CHANS1G(913, 500), /* Channel 23 */
+	CHANS1G(914, 500), /* Channel 25 */
+	CHANS1G(915, 500), /* Channel 27 */
+	CHANS1G(916, 500), /* Channel 29 */
+	CHANS1G(917, 500), /* Channel 31 */
+	CHANS1G(918, 500), /* Channel 33 */
+	CHANS1G(919, 500), /* Channel 35 */
+	CHANS1G(920, 500), /* Channel 37 */
+	CHANS1G(921, 500), /* Channel 39 */
+	CHANS1G(922, 500), /* Channel 41 */
+	CHANS1G(923, 500), /* Channel 43 */
+	CHANS1G(924, 500), /* Channel 45 */
+	CHANS1G(925, 500), /* Channel 47 */
+	CHANS1G(926, 500), /* Channel 49 */
+	CHANS1G(927, 500), /* Channel 51 */
+};
 
 static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
 	.s1g = true,
@@ -517,19 +551,6 @@ static const struct ieee80211_sta_s1g_cap hwsim_s1g_cap = {
 		     0 },
 };
 
-static void hwsim_init_s1g_channels(struct ieee80211_channel *chans)
-{
-	int ch, freq;
-
-	for (ch = 0; ch < NUM_S1G_CHANS_US; ch++) {
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
@@ -7081,8 +7102,6 @@ static int __init init_mac80211_hwsim(void)
 		goto out_exit_virtio;
 	}
 
-	hwsim_init_s1g_channels(hwsim_channels_s1g);
-
 	for (i = 0; i < radios; i++) {
 		struct hwsim_new_radio_params param = { 0 };
 
-- 
2.43.0


