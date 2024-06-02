Return-Path: <linux-wireless+bounces-8380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506888D7417
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764361C20A16
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53242EBE;
	Sun,  2 Jun 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETXHYSHr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0940639
	for <linux-wireless@vger.kernel.org>; Sun,  2 Jun 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312930; cv=none; b=cn/AazWl2Ioc2ohLH6eMNx9zOYQYJiwgxv72T8BEKoG8de/DE6z3n+VK+mtpbMOYbOmfAMZ7ODNRlQ1vT8Jgbh1nIu2Fcm+15tLEOazQ97p8UjXIgTA9Ew9Ceifz7otp/ZEKvSMe+tQJudgmZ7QpoCcL9O+HbIbgvzTyG+wAK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312930; c=relaxed/simple;
	bh=6YpH9KxWZ9kiGJ6U8ypbNpE2l0oX5e7slMdJjoySuME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RBCzsNiioNwxbmZxxuT1utKi/8sRmR/sTKsu2J2cskkE7v0QcT2e7mF7BctZZqXG9ttqeVJXpnnburUCHxsa+BGGQgKanLCqs739AHfr6jkQRBpPUzUDq7wBxFSjHuGNrcyMnF7RUp+Ra+ODHDvmGBqrGLjboZoCIhoTI30QtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETXHYSHr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717312928; x=1748848928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6YpH9KxWZ9kiGJ6U8ypbNpE2l0oX5e7slMdJjoySuME=;
  b=ETXHYSHr0G7oyi68rv3J/rXTfvpb4dAeFpf6ykEvC5lM9+ERwH0Ztbi+
   v90rusLsyAiCHScmmwHFWclURXmuzKTYGBk/ql7+f+lu8oUKUIGTZjnmP
   VvbqTLy/nP8A7gp4RFdTwBr9iW6+MB+L9DJAMpkid7BY+LtZ2+Q80eDRB
   ygIFAslBfspW8taSuxBObD1mSGjxLKGOFmwNUzclzWHHWMimk50LdjyBB
   BfuoTDhhlmKzol0R4ZZCIOPNYIj1thDlKW/kEPaFF/BCWpcOVvnxfXGYc
   S4aYrUxtK0jihXs3bNUGcDaTlOSj1nJSOw8BbjfFX/zS17TP9/paYHcDD
   A==;
X-CSE-ConnectionGUID: 980bY0ZgSH632F5ej1gXjQ==
X-CSE-MsgGUID: 14VmoYglRQ+7hTFNZuePIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="39224360"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="39224360"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 00:22:07 -0700
X-CSE-ConnectionGUID: S5IPm2YbT86O4Tbwrbi29Q==
X-CSE-MsgGUID: l9JJOPvhR4OOzJ4WLoRXPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="36677147"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 00:22:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] wifi: cfg80211: reject non-conformant 6 GHz center frequencies
Date: Sun,  2 Jun 2024 10:22:00 +0300
Message-Id: <20240602102200.876b10a2beda.I0d3d0daea4014e99654437ff6691378dbe452652@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

On 6 GHz (and also 5 GHz to some degree), only a specific set of center
frequencies should be used depending on the channel bandwidth. Verify
this is the case on 6 GHz. For 5 GHz, we are more accepting as there are
APs that got it wrong historically.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/chan.c       | 38 ++++++++++++++++++++++++++++++++++++++
 net/wireless/tests/chan.c | 22 +++++++++++-----------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 3414b2c3abcc..bc98573f36be 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -263,6 +263,37 @@ static int cfg80211_chandef_get_width(const struct cfg80211_chan_def *c)
 	return nl80211_chan_width_to_mhz(c->width);
 }
 
+static bool cfg80211_valid_center_freq(u32 center,
+				       enum nl80211_chan_width width)
+{
+	int bw;
+	int step;
+
+	/* We only do strict verification on 6 GHz */
+	if (center < 5955 || center > 7115)
+		return true;
+
+	bw = nl80211_chan_width_to_mhz(width);
+	if (bw < 0)
+		return false;
+
+	/* Validate that the channels bw is entirely within the 6 GHz band */
+	if (center - bw / 2 < 5945 || center + bw / 2 > 7125)
+		return false;
+
+	/* With 320 MHz the permitted channels overlap */
+	if (bw == 320)
+		step = 160;
+	else
+		step = bw;
+
+	/*
+	 * Valid channels are packed from lowest frequency towards higher ones.
+	 * So test that the lower frequency alignes with one of these steps.
+	 */
+	return (center - bw / 2 - 5945) % step == 0;
+}
+
 bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 {
 	u32 control_freq, oper_freq;
@@ -374,6 +405,13 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 		return false;
 	}
 
+	if (!cfg80211_valid_center_freq(chandef->center_freq1, chandef->width))
+		return false;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_80P80 &&
+	    !cfg80211_valid_center_freq(chandef->center_freq2, chandef->width))
+		return false;
+
 	/* channel 14 is only for IEEE 802.11b */
 	if (chandef->center_freq1 == 2484 &&
 	    chandef->width != NL80211_CHAN_WIDTH_20_NOHT)
diff --git a/net/wireless/tests/chan.c b/net/wireless/tests/chan.c
index d02258ac2dab..74bbee25085f 100644
--- a/net/wireless/tests/chan.c
+++ b/net/wireless/tests/chan.c
@@ -113,16 +113,16 @@ static const struct chandef_compat_case {
 		},
 	},
 	{
-		.desc = "different primary 160 MHz",
+		.desc = "different primary 320 MHz",
 		.c1 = {
 			.width = NL80211_CHAN_WIDTH_320,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 + 150,
+			.center_freq1 = 6475 + 110,
 		},
 		.c2 = {
 			.width = NL80211_CHAN_WIDTH_320,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 - 10,
+			.center_freq1 = 6475 - 50,
 		},
 	},
 	{
@@ -131,12 +131,12 @@ static const struct chandef_compat_case {
 		.c1 = {
 			.width = NL80211_CHAN_WIDTH_160,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 + 70,
+			.center_freq1 = 6475 + 30,
 		},
 		.c2 = {
 			.width = NL80211_CHAN_WIDTH_320,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 - 10,
+			.center_freq1 = 6475 - 50,
 		},
 		.compat = true,
 	},
@@ -145,12 +145,12 @@ static const struct chandef_compat_case {
 		.c1 = {
 			.width = NL80211_CHAN_WIDTH_160,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 + 70,
+			.center_freq1 = 6475 + 30,
 		},
 		.c2 = {
 			.width = NL80211_CHAN_WIDTH_320,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 - 10,
+			.center_freq1 = 6475 - 50,
 			.punctured = 0xf,
 		},
 		.compat = true,
@@ -160,13 +160,13 @@ static const struct chandef_compat_case {
 		.c1 = {
 			.width = NL80211_CHAN_WIDTH_160,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 + 70,
+			.center_freq1 = 6475 + 30,
 			.punctured = 0xc0,
 		},
 		.c2 = {
 			.width = NL80211_CHAN_WIDTH_320,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 - 10,
+			.center_freq1 = 6475 - 50,
 			.punctured = 0xc000,
 		},
 		.compat = true,
@@ -176,13 +176,13 @@ static const struct chandef_compat_case {
 		.c1 = {
 			.width = NL80211_CHAN_WIDTH_160,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 + 70,
+			.center_freq1 = 6475 + 30,
 			.punctured = 0x80,
 		},
 		.c2 = {
 			.width = NL80211_CHAN_WIDTH_320,
 			.chan = &chan_6ghz_105,
-			.center_freq1 = 6475 - 10,
+			.center_freq1 = 6475 - 50,
 			.punctured = 0xc000,
 		},
 	},
-- 
2.34.1


