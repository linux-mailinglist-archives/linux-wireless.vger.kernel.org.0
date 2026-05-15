Return-Path: <linux-wireless+bounces-36461-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MItIJI8HB2qcqwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36461-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:46:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 959E454EB65
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 13:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81F833022BA5
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ECC3CE4BA;
	Fri, 15 May 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3c+Us5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5EE4779B3
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843548; cv=none; b=cUxPBfse0nSF8NhzsCNSVv664g+N1sAUSnaAkBKNcQX7iWYWXJX5vLiFaQVPnfliXCy2hUfwhv76ylR0B7vF6lfLFped4ekDAvWbN6fri5jAFWYF7AtZAlX0CIZEvY67GzbUorzZ/D4yTxABYdI1PmZlfP2iVeQMrCQG/yf8Tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843548; c=relaxed/simple;
	bh=oTa1MU05OLlfwZHp5MaVD9izIWlbShThvuFl4Gm3NaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AK1bUTlnvPBGS5yYcgK0XHC3p3n2B6Mx7ObsGfVHkHhgUGCF+RvqYlzjmEhWDDQaimaBfcqRr/AleY4+CIQfKkvHeG6Y/7NTW94P6mEyZFmWFZ9/070SSoUCKPbqc4Pvl2cLKqVw/7te7r+kIzLdHIZw6dFQ5aBIwSCH3v2j/hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3c+Us5Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778843547; x=1810379547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oTa1MU05OLlfwZHp5MaVD9izIWlbShThvuFl4Gm3NaQ=;
  b=h3c+Us5ZPTpytgb5IORLpzLAUXK7QuP7SQiN2qkTXtj3axFxMbP/ATHm
   blyGccRmXEw15f2viiZ6mF49lrkyDnXGvlDcSw3FvnuInvpowO2i2eLUy
   3oLFCx8jg3Fx+hsQiILses2VwUtO63G/QV5qAXmjs1V2z/Hjjti4ITRB5
   nqKsIZ6ic0HTHimO2DYV+VUgkiaouUPe+XHiqSw/0yTilSLkjafXog/7u
   sbZ5Pq8ISf9yvm5RRx8Pz37hmbed8XaGvGnY6bxwRcZX7YpqboStPf7rm
   PgjnKbVkxspv3DxGkZGMdhPwzfijzl49JGzxuW/YMrvqZqn+h/2y3IO/y
   Q==;
X-CSE-ConnectionGUID: bGgZkmksRM+XffrJ+D8qNA==
X-CSE-MsgGUID: 0kKKKkFEQFq1uBlkGz1FJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="97226575"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="97226575"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:12:26 -0700
X-CSE-ConnectionGUID: OGD1H8fkQPKPphOxUShgrw==
X-CSE-MsgGUID: vuVLAIbxS/SNIul6FWSv5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="269016777"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 04:12:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: add a function to parse UHR DBE
Date: Fri, 15 May 2026 14:12:12 +0300
Message-Id: <20260515141209.4eb1490f5cc6.I3ca9421f1fe4c31073846b1b62017f12c75889de@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 959E454EB65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36461-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Add a function that takes the DBE information and parses it
into an existing chandef that should hold the BSS channel.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h    |  10 ++
 net/wireless/chan.c       | 130 ++++++++++++++++++++++++++
 net/wireless/tests/chan.c | 192 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 326 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ddcf559430dd..69dc9a978861 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1190,6 +1190,16 @@ int cfg80211_chandef_add_npca(struct wiphy *wiphy,
 			      struct cfg80211_chan_def *chandef,
 			      const struct ieee80211_uhr_npca_info *npca);
 
+/**
+ * cfg80211_chandef_add_dbe - parse and add DBE information to chandef
+ * @chandef: the chandef to expand
+ * @dbe: the DBE information, must be size-checked if not %NULL
+ *
+ * Returns: 0 for success, a negative error code otherwise
+ */
+int cfg80211_chandef_add_dbe(struct cfg80211_chan_def *chandef,
+			     const struct ieee80211_uhr_dbe_info *dbe);
+
 /**
  * nl80211_send_chandef - sends the channel definition.
  * @msg: the msg to send channel definition
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index ed35b55b1b67..f0811efb5d0f 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -619,6 +619,136 @@ int cfg80211_chandef_add_npca(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_chandef_add_npca);
 
+int cfg80211_chandef_add_dbe(struct cfg80211_chan_def *chandef,
+			     const struct ieee80211_uhr_dbe_info *dbe)
+{
+	struct cfg80211_chan_def new_chandef = *chandef;
+	u16 starting_freq, bw_mhz, start_old, start_new;
+	u8 bw, punct_shift;
+	int offset, index;
+
+	if (!dbe)
+		return 0;
+
+	if (!cfg80211_chandef_valid(chandef))
+		return -EINVAL;
+
+	if (chandef->width == NL80211_CHAN_WIDTH_20_NOHT)
+		return -EINVAL;
+
+	bw = u8_get_bits(dbe->params, IEEE80211_UHR_DBE_OPER_BANDWIDTH);
+
+	switch (chandef->chan->band) {
+	case NL80211_BAND_5GHZ:
+		if (bw > IEEE80211_UHR_DBE_OPER_BW_160)
+			return -EINVAL;
+		if (chandef->chan->center_freq < 5745)
+			starting_freq = 5180; /* channel 36 */
+		else
+			starting_freq = 5745; /* channel 149 */
+		break;
+	case NL80211_BAND_6GHZ:
+		starting_freq = 5955; /* channel 1 center */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (bw) {
+	case IEEE80211_UHR_DBE_OPER_BW_320_2:
+	case IEEE80211_UHR_DBE_OPER_BW_320_1:
+		if (chandef->width == NL80211_CHAN_WIDTH_160)
+			break;
+		fallthrough;
+	case IEEE80211_UHR_DBE_OPER_BW_160:
+		if (chandef->width == NL80211_CHAN_WIDTH_80)
+			break;
+		fallthrough;
+	case IEEE80211_UHR_DBE_OPER_BW_80:
+		if (chandef->width == NL80211_CHAN_WIDTH_40)
+			break;
+		fallthrough;
+	case IEEE80211_UHR_DBE_OPER_BW_40:
+		if (chandef->width == NL80211_CHAN_WIDTH_20)
+			break;
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	switch (bw) {
+	case IEEE80211_UHR_DBE_OPER_BW_320_2:
+		/* 320-2 starts shifted by 160 */
+		starting_freq += 160;
+		fallthrough;
+	case IEEE80211_UHR_DBE_OPER_BW_320_1:
+		new_chandef.width = NL80211_CHAN_WIDTH_320;
+		bw_mhz = 320;
+		break;
+	case IEEE80211_UHR_DBE_OPER_BW_160:
+		new_chandef.width = NL80211_CHAN_WIDTH_160;
+		bw_mhz = 160;
+		break;
+	case IEEE80211_UHR_DBE_OPER_BW_80:
+		new_chandef.width = NL80211_CHAN_WIDTH_80;
+		bw_mhz = 80;
+		break;
+	case IEEE80211_UHR_DBE_OPER_BW_40:
+		new_chandef.width = NL80211_CHAN_WIDTH_40;
+		bw_mhz = 40;
+		break;
+	}
+
+	/* this should only happen for 320-2 and misconfigured AP */
+	if (chandef->chan->center_freq < starting_freq)
+		return -EINVAL;
+
+	offset = chandef->chan->center_freq - starting_freq;
+	index = offset / bw_mhz;
+	start_new = starting_freq - 10 + index * bw_mhz;
+	new_chandef.center_freq1 = start_new + bw_mhz / 2;
+
+	start_old = chandef->center_freq1 -
+		    cfg80211_chandef_get_width(chandef) / 2;
+
+	/*
+	 * If the DBE channel extends downward below the lower
+	 * edge of the BSS channel, we need to shift puncturing
+	 * bitmaps up to adjust for that.
+	 */
+	if (start_new < start_old)
+		punct_shift = (start_old - start_new) / 20;
+	else
+		punct_shift = 0;
+
+	new_chandef.punctured <<= punct_shift;
+	new_chandef.npca_punctured <<= punct_shift;
+
+	if (dbe->params & IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES) {
+		u16 punct_mask = ((1 << (bw_mhz / 40)) - 1) << punct_shift;
+		u16 punctured = le16_to_cpu(dbe->dis_subch_bmap[0]);
+
+		if ((punctured & punct_mask) != (new_chandef.punctured & punct_mask))
+			return -EINVAL;
+
+		new_chandef.punctured = punctured;
+	}
+
+	if (!cfg80211_chandef_valid(&new_chandef))
+		return -EINVAL;
+
+	/*
+	 * If e.g. a 40 MHz BSS channel (erroneously) occupies the center of the
+	 * DBE 80 MHz channel, they would be incompatible; check and reject.
+	 */
+	if (!cfg80211_chandef_compatible(&new_chandef, chandef))
+		return -EINVAL;
+
+	*chandef = new_chandef;
+	return 0;
+}
+EXPORT_SYMBOL(cfg80211_chandef_add_dbe);
+
 static const struct cfg80211_chan_def *
 check_chandef_primary_compat(const struct cfg80211_chan_def *c1,
 			     const struct cfg80211_chan_def *c2,
diff --git a/net/wireless/tests/chan.c b/net/wireless/tests/chan.c
index 7b97b731993c..65eb18c498de 100644
--- a/net/wireless/tests/chan.c
+++ b/net/wireless/tests/chan.c
@@ -2,13 +2,18 @@
 /*
  * KUnit tests for channel helper functions
  *
- * Copyright (C) 2023-2024 Intel Corporation
+ * Copyright (C) 2023-2024, 2026 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <kunit/test.h>
 
 MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
 
+static struct ieee80211_channel chan_2ghz_1 = {
+	.band = NL80211_BAND_2GHZ,
+	.center_freq = 2412,
+};
+
 static struct ieee80211_channel chan_6ghz_1 = {
 	.band = NL80211_BAND_6GHZ,
 	.center_freq = 5955,
@@ -215,14 +220,189 @@ static void test_chandef_compat(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, ret, expect);
 }
 
-static struct kunit_case chandef_compat_test_cases[] = {
+static const struct chandef_dbe_case {
+	const char *desc;
+	struct cfg80211_chan_def c;
+	u8 dbe[3];
+	bool fails;
+	u16 cf1;
+} chandef_dbe_cases[] = {
+	{
+		.desc = "non-HT failure",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_20_NOHT,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_40,
+		.fails = true,
+	},
+	{
+		.desc = "2.4 GHz fails",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_20,
+			.chan = &chan_2ghz_1,
+			.center_freq1 = 2412,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_40,
+		.fails = true,
+	},
+	{
+		.desc = "DBE narrower",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_320,
+			.chan = &chan_6ghz_1,
+			.center_freq1 = 5955 + 10 + 20 + 40 + 80,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_160,
+		.fails = true,
+	},
+	{
+		.desc = "DBE to 320-1",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_1,
+		.cf1 = 6425,
+	},
+	{
+		.desc = "DBE to 320-2",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_2,
+		.cf1 = 6585,
+	},
+	{
+		.desc = "bad disabled subchannel bitmap - not enough in BSS (1)",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+			.punctured = 0x0001,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_1 |
+			  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES,
+		/* DBE disabled subchannel bitmap == 0 */
+		.fails = true,
+	},
+	{
+		.desc = "bad disabled subchannel bitmap - too much in BSS (1)",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+			.punctured = 0x0001,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_1 |
+			  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES,
+		/* DBE disabled subchannel bitmap == 0x0300 */
+		.dbe[2] = 0x03,
+		.fails = true,
+	},
+	{
+		.desc = "bad disabled subchannel bitmap - not enough in BSS (2)",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+			.punctured = 0x0001,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_2 |
+			  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES,
+		/* DBE disabled subchannel bitmap == 0 */
+		.fails = true,
+	},
+	{
+		.desc = "bad disabled subchannel bitmap - too much in BSS (2)",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+			.punctured = 0x0001,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_2 |
+			  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES,
+		/* DBE disabled subchannel bitmap == 0x03 */
+		.dbe[1] = 0x03,
+		.fails = true,
+	},
+	{
+		.desc = "bad disabled subchannel bitmap - bad bitmap",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+			.punctured = 0x0001,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_1 |
+			  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES,
+		/* DBE disabled subchannel bitmap == 0x1100 */
+		.dbe[2] = 0x11,
+		.fails = true,
+	},
+	{
+		.desc = "good disabled subchannel bitmap (1)",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+			.punctured = 0x0003,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_1 |
+			  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES,
+		/* DBE disabled subchannel bitmap == 0x0300 */
+		.dbe[2] = 0x03,
+		.cf1 = 6425,
+	},
+	{
+		.desc = "good disabled subchannel bitmap (2)",
+		.c = {
+			.width = NL80211_CHAN_WIDTH_160,
+			.chan = &chan_6ghz_105,
+			.center_freq1 = 6475 + 30,
+			.punctured = 0x0003,
+		},
+		.dbe[0] = IEEE80211_UHR_DBE_OPER_BW_320_2 |
+			  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES,
+		/* DBE disabled subchannel bitmap == 0x0003 */
+		.dbe[1] = 0x03,
+		.cf1 = 6585,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(chandef_dbe, chandef_dbe_cases, desc)
+
+static void test_chandef_dbe(struct kunit *test)
+{
+	const struct chandef_dbe_case *params = test->param_value;
+	struct cfg80211_chan_def c = params->c;
+	int ret;
+
+	KUNIT_EXPECT_EQ(test, cfg80211_chandef_valid(&params->c), true);
+
+	ret = cfg80211_chandef_add_dbe(&c, (void *)params->dbe);
+	KUNIT_EXPECT_EQ(test, ret != 0, params->fails);
+
+	if (params->fails)
+		return;
+
+	KUNIT_EXPECT_EQ(test, c.center_freq1, params->cf1);
+}
+
+static struct kunit_case chandef_test_cases[] = {
 	KUNIT_CASE_PARAM(test_chandef_compat, chandef_compat_gen_params),
+	KUNIT_CASE_PARAM(test_chandef_dbe, chandef_dbe_gen_params),
 	{}
 };
 
-static struct kunit_suite chandef_compat = {
-	.name = "cfg80211-chandef-compat",
-	.test_cases = chandef_compat_test_cases,
+static struct kunit_suite chandef = {
+	.name = "cfg80211-chandef",
+	.test_cases = chandef_test_cases,
 };
 
-kunit_test_suite(chandef_compat);
+kunit_test_suite(chandef);
-- 
2.34.1


