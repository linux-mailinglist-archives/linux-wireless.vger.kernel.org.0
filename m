Return-Path: <linux-wireless+bounces-2691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E698412A9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 998441F21857
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB1159594;
	Mon, 29 Jan 2024 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BjSF3hNn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DD159592
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553687; cv=none; b=Yuk26bpCyuZ3YttAswZhYdrJxxej9b2OVGcI7tJXjhKPLDD+FQCNFu+bFxoObuu3uGcMCbXJPwJMGvqv9U2XQxA+tv4zVr3UzdhP+tgSZAGnxxim6caB9rB0nx79ZJb+KZ0hK7ef2pNwVUprz+6/KsZc7Aqs0UiPvjLLnWV+Guw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553687; c=relaxed/simple;
	bh=OoF3tNFfV4RnLHykSFf4+uHzmfSZSp9idU3yks5lofI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8Z1M9zmkWfbEiN4b80SZBglURNc6nlKV8XfOg0T301JglwE56lbGggAhLbM8GgpbJSdRDqQVC319kFL0+0lThKjwvkdVY/oU/JQFjmvTMCAYj7OfrOOy2zrrITIzNRXkOvVO6szBLaJEubacNVJwd3p8SgULQSvA3Xf9xVRdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BjSF3hNn; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PZNnSa2OjJKWubsdAUcCLfTNtDfMLJiAJRqodR6D2nk=;
	t=1706553684; x=1707763284; b=BjSF3hNn0N17JH+9sOcbA5WSPCNMzEZXFEwKPsaS9waJvUt
	0AjExkMFoKx/42n7UZzqw9lZtX+vrnh9YPhRrt60veRNxan8VXmwtoY/G7lvySf9koRLhD/5xs0D3
	IegCs3j4/jCDhlLrnUv9ZEitSz6q6qDYb/KO3kSTDpgrxOFAEUqq65F9k4kvUCVpbsl5oJZ+RUJKA
	iAMbq0+y5gVYyxLaWPBz16SePFckEYHaAh5YRnzU5ajy9+883Ta6q/Mn5XWYY8oRAnOg07fPYakRS
	f8c98f98YBBTeTwxFBSJoceH8eAykkQ/3/ykX7ap6VRUTmuEeCRBBaGZ856MkGEg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZN-00000004z9N-25m4;
	Mon, 29 Jan 2024 19:41:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/15] wifi: cfg80211: simplify cfg80211_chandef_compatible()
Date: Mon, 29 Jan 2024 19:34:47 +0100
Message-ID: <20240129194108.be3e6eccaba3.I8399c2ff1435d7378e5837794cb5aa6dd2ee1416@changeid>
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

Simplify cfg80211_chandef_compatible() a bit by switching
c1 and c2 around so that c1 is always the narrower one
(once they're not identical or narrow/S1G). Then we can
just check the various primary channels and exit with the
wider one (c2), or NULL.

Also refactor the primary 40/80/160 function to not have
all the calculations hard-coded, and use a wrapper around
it to check primary 40/80/160 compatibility.

While at it, add some kunit tests for this functionality.

Also expose the new cfg80211_chandef_primary_freq() to
drivers, mac80211 will use it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h      |  11 +++
 net/wireless/chan.c         | 190 +++++++++++++++++++-----------------
 net/wireless/tests/Makefile |   2 +-
 net/wireless/tests/chan.c   | 182 ++++++++++++++++++++++++++++++++++
 4 files changed, 294 insertions(+), 91 deletions(-)
 create mode 100644 net/wireless/tests/chan.c

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 51b9e6fa12f8..9d7333064866 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1047,6 +1047,17 @@ unsigned int
 cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
 			      const struct cfg80211_chan_def *chandef);
 
+/**
+ * cfg80211_chandef_primary_freq - calculate primary 40/80/160 MHz freq
+ * @chandef: chandef to calculate for
+ * @primary_chan_width: primary channel width to calculate center for
+ *
+ * Returns: the primary 40/80/160 MHz channel center frequency, or -1
+ *	for errors
+ */
+int cfg80211_chandef_primary_freq(const struct cfg80211_chan_def *chandef,
+				  enum nl80211_chan_width primary_chan_width);
+
 /**
  * nl80211_send_chandef - sends the channel definition.
  * @msg: the msg to send channel definition
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 159b8aac451e..bfa2ea935fc2 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -390,68 +390,60 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 }
 EXPORT_SYMBOL(cfg80211_chandef_valid);
 
-static void chandef_primary_freqs(const struct cfg80211_chan_def *c,
-				  u32 *pri40, u32 *pri80, u32 *pri160)
+int cfg80211_chandef_primary_freq(const struct cfg80211_chan_def *c,
+				  enum nl80211_chan_width primary_chan_width)
 {
-	int tmp;
+	int pri_width = nl80211_chan_width_to_mhz(primary_chan_width);
+	int width = cfg80211_chandef_get_width(c);
+	u32 control = c->chan->center_freq;
+	u32 center = c->center_freq1;
 
-	switch (c->width) {
-	case NL80211_CHAN_WIDTH_40:
-		*pri40 = c->center_freq1;
-		*pri80 = 0;
-		*pri160 = 0;
-		break;
-	case NL80211_CHAN_WIDTH_80:
-	case NL80211_CHAN_WIDTH_80P80:
-		*pri160 = 0;
-		*pri80 = c->center_freq1;
-		/* n_P20 */
-		tmp = (30 + c->chan->center_freq - c->center_freq1)/20;
-		/* n_P40 */
-		tmp /= 2;
-		/* freq_P40 */
-		*pri40 = c->center_freq1 - 20 + 40 * tmp;
-		break;
-	case NL80211_CHAN_WIDTH_160:
-		*pri160 = c->center_freq1;
-		/* n_P20 */
-		tmp = (70 + c->chan->center_freq - c->center_freq1)/20;
-		/* n_P40 */
-		tmp /= 2;
-		/* freq_P40 */
-		*pri40 = c->center_freq1 - 60 + 40 * tmp;
-		/* n_P80 */
-		tmp /= 2;
-		*pri80 = c->center_freq1 - 40 + 80 * tmp;
-		break;
-	case NL80211_CHAN_WIDTH_320:
-		/* n_P20 */
-		tmp = (150 + c->chan->center_freq - c->center_freq1) / 20;
-		/* n_P40 */
-		tmp /= 2;
-		/* freq_P40 */
-		*pri40 = c->center_freq1 - 140 + 40 * tmp;
-		/* n_P80 */
-		tmp /= 2;
-		*pri80 = c->center_freq1 - 120 + 80 * tmp;
-		/* n_P160 */
-		tmp /= 2;
-		*pri160 = c->center_freq1 - 80 + 160 * tmp;
-		break;
-	default:
-		WARN_ON_ONCE(1);
+	if (WARN_ON_ONCE(pri_width < 0 || width < 0))
+		return -1;
+
+	/* not intended to be called this way, can't determine */
+	if (WARN_ON_ONCE(pri_width > width))
+		return -1;
+
+	while (width > pri_width) {
+		if (control > center)
+			center += width / 4;
+		else
+			center -= width / 4;
+		width /= 2;
 	}
+
+	return center;
+}
+EXPORT_SYMBOL(cfg80211_chandef_primary_freq);
+
+static const struct cfg80211_chan_def *
+check_chandef_primary_compat(const struct cfg80211_chan_def *c1,
+			     const struct cfg80211_chan_def *c2,
+			     enum nl80211_chan_width primary_chan_width)
+{
+	/* check primary is compatible -> error if not */
+	if (cfg80211_chandef_primary_freq(c1, primary_chan_width) !=
+	    cfg80211_chandef_primary_freq(c2, primary_chan_width))
+		return ERR_PTR(-EINVAL);
+
+	/* assumes c1 is smaller width, if that was just checked -> done */
+	if (c1->width == primary_chan_width)
+		return c2;
+
+	/* otherwise continue checking the next width */
+	return NULL;
 }
 
-const struct cfg80211_chan_def *
-cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
-			    const struct cfg80211_chan_def *c2)
+static const struct cfg80211_chan_def *
+_cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
+			     const struct cfg80211_chan_def *c2)
 {
-	u32 c1_pri40, c1_pri80, c2_pri40, c2_pri80, c1_pri160, c2_pri160;
+	const struct cfg80211_chan_def *ret;
 
 	/* If they are identical, return */
 	if (cfg80211_chandef_identical(c1, c2))
-		return c1;
+		return c2;
 
 	/* otherwise, must have same control channel */
 	if (c1->chan != c2->chan)
@@ -479,44 +471,62 @@ cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
 	if (NARROW_OR_S1G(c1->width) || NARROW_OR_S1G(c2->width))
 		return NULL;
 
-	if (c1->width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    c1->width == NL80211_CHAN_WIDTH_20)
-		return c2;
-
-	if (c2->width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    c2->width == NL80211_CHAN_WIDTH_20)
-		return c1;
-
-	chandef_primary_freqs(c1, &c1_pri40, &c1_pri80, &c1_pri160);
-	chandef_primary_freqs(c2, &c2_pri40, &c2_pri80, &c2_pri160);
-
-	if (c1_pri40 != c2_pri40)
-		return NULL;
-
-	if (c1->width == NL80211_CHAN_WIDTH_40)
-		return c2;
-
-	if (c2->width == NL80211_CHAN_WIDTH_40)
-		return c1;
-
-	if (c1_pri80 != c2_pri80)
-		return NULL;
-
-	if (c1->width == NL80211_CHAN_WIDTH_80 &&
-	    c2->width > NL80211_CHAN_WIDTH_80)
-		return c2;
-
-	if (c2->width == NL80211_CHAN_WIDTH_80 &&
-	    c1->width > NL80211_CHAN_WIDTH_80)
-		return c1;
-
-	WARN_ON(!c1_pri160 && !c2_pri160);
-	if (c1_pri160 && c2_pri160 && c1_pri160 != c2_pri160)
-		return NULL;
-
+	/*
+	 * Make sure that c1 is always the narrower one, so that later
+	 * we either return NULL or c2 and don't have to check both
+	 * directions.
+	 */
 	if (c1->width > c2->width)
-		return c1;
-	return c2;
+		swap(c1, c2);
+
+	/*
+	 * No further checks needed if the "narrower" one is only 20 MHz.
+	 * Here "narrower" includes being a 20 MHz non-HT channel vs. a
+	 * 20 MHz HT (or later) one.
+	 */
+	if (c1->width <= NL80211_CHAN_WIDTH_20)
+		return c2;
+
+	ret = check_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_40);
+	if (ret)
+		return ret;
+
+	ret = check_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_80);
+	if (ret)
+		return ret;
+
+	/*
+	 * If c1 is 80+80, then c2 is 160 or higher, but that cannot
+	 * match. If c2 was also 80+80 it was already either accepted
+	 * or rejected above (identical or not, respectively.)
+	 */
+	if (c1->width == NL80211_CHAN_WIDTH_80P80)
+		return NULL;
+
+	ret = check_chandef_primary_compat(c1, c2, NL80211_CHAN_WIDTH_160);
+	if (ret)
+		return ret;
+
+	/*
+	 * Getting here would mean they're both wider than 160, have the
+	 * same primary 160, but are not identical - this cannot happen
+	 * since they must be 320 (no wider chandefs exist, at least yet.)
+	 */
+	WARN_ON_ONCE(1);
+
+	return NULL;
+}
+
+const struct cfg80211_chan_def *
+cfg80211_chandef_compatible(const struct cfg80211_chan_def *c1,
+			    const struct cfg80211_chan_def *c2)
+{
+	const struct cfg80211_chan_def *ret;
+
+	ret = _cfg80211_chandef_compatible(c1, c2);
+	if (IS_ERR(ret))
+		return NULL;
+	return ret;
 }
 EXPORT_SYMBOL(cfg80211_chandef_compatible);
 
diff --git a/net/wireless/tests/Makefile b/net/wireless/tests/Makefile
index 1f6622fcb758..c364e63b508e 100644
--- a/net/wireless/tests/Makefile
+++ b/net/wireless/tests/Makefile
@@ -1,3 +1,3 @@
-cfg80211-tests-y += module.o fragmentation.o scan.o util.o
+cfg80211-tests-y += module.o fragmentation.o scan.o util.o chan.o
 
 obj-$(CONFIG_CFG80211_KUNIT_TEST) += cfg80211-tests.o
diff --git a/net/wireless/tests/chan.c b/net/wireless/tests/chan.c
new file mode 100644
index 000000000000..b9e7a27e43cb
--- /dev/null
+++ b/net/wireless/tests/chan.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+#include <net/cfg80211.h>
+#include <kunit/test.h>
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+static struct ieee80211_channel chan_6ghz_1 = {
+	.band = NL80211_BAND_6GHZ,
+	.center_freq = 5955,
+};
+
+static struct ieee80211_channel chan_6ghz_5 = {
+	.band = NL80211_BAND_6GHZ,
+	.center_freq = 5975,
+};
+
+static struct ieee80211_channel chan_6ghz_105 = {
+	.band = NL80211_BAND_6GHZ,
+	.center_freq = 6475,
+};
+
+static const struct chandef_compat_case {
+	const char *desc;
+	/* leave c1 empty for tests for identical */
+	struct cfg80211_chan_def c1, c2;
+	/* we test both ways around, so c2 should always be the compat one */
+	bool compat;
+} chandef_compat_cases[] = {
+	{
+		.desc = "identical non-HT",
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_20_NOHT,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "identical 20 MHz",
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_20,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "identical 40 MHz",
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_40,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955 + 10,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "identical 80 MHz",
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_80,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955 + 10 + 20,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "identical 160 MHz",
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955 + 10 + 20 + 40,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "identical 320 MHz",
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955 + 10 + 20 + 40 + 80,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "20 MHz in 320 MHz\n",
+		.c1 = {
+			.width = NL80211_CHAN_WIDTH_20,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955,
+		},
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955 + 10 + 20 + 40 + 80,
+		},
+		.compat = true,
+	},
+	{
+		.desc = "different 20 MHz",
+		.c1 = {
+			.width = NL80211_CHAN_WIDTH_20,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955,
+		},
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_20,
+			.chan = &chan_6ghz_5,
+			.center_freq1 = 5975,
+		},
+	},
+	{
+		.desc = "different primary 160 MHz",
+		.c1 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 150,
+		},
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 - 10,
+		},
+	},
+	{
+		/* similar to previous test but one has lower BW */
+		.desc = "matching primary 160 MHz",
+		.c1 = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 70,
+		},
+		.c2 = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 - 10,
+		},
+		.compat = true,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(chandef_compat, chandef_compat_cases, desc)
+
+static void test_chandef_compat(struct kunit *test)
+{
+	const struct chandef_compat_case *params = test->param_value;
+	const struct cfg80211_chan_def *ret, *expect;
+	struct cfg80211_chan_def c1 = params->c1;
+
+	/* tests with identical ones */
+	if (!params->c1.chan)
+		c1 = params->c2;
+
+	KUNIT_EXPECT_EQ(test, cfg80211_chandef_valid(&c1), true);
+	KUNIT_EXPECT_EQ(test, cfg80211_chandef_valid(&params->c2), true);
+
+	expect = params->compat ? &params->c2 : NULL;
+
+	ret = cfg80211_chandef_compatible(&c1, &params->c2);
+	KUNIT_EXPECT_PTR_EQ(test, ret, expect);
+
+	if (!params->c1.chan)
+		expect = &c1;
+
+	ret = cfg80211_chandef_compatible(&params->c2, &c1);
+	KUNIT_EXPECT_PTR_EQ(test, ret, expect);
+}
+
+static struct kunit_case chandef_compat_test_cases[] = {
+	KUNIT_CASE_PARAM(test_chandef_compat, chandef_compat_gen_params),
+	{}
+};
+
+static struct kunit_suite chandef_compat = {
+	.name = "cfg80211-chandef-compat",
+	.test_cases = chandef_compat_test_cases,
+};
+
+kunit_test_suite(chandef_compat);
-- 
2.43.0


