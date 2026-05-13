Return-Path: <linux-wireless+bounces-36366-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLe3LhcQBGouDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36366-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1DB52DB37
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25D330B66FF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709063A6EF4;
	Wed, 13 May 2026 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jU2byE81"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344F3A4F46
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651071; cv=none; b=MW5hoW6RplH0Jco5IP19EobVB58e+6/q/1m6PIHHIN8T7If1wAOhPn6dI+rcQOSxrUR+/VZPK5e+FsxThOtzyjXoWgvlz52umxqmvNNM/1PbeKQjIa4pFGxvspRH0WAhcxloz8DSWP4EiMfhNtvfb++MF5D8DbuazBN2NaM7r6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651071; c=relaxed/simple;
	bh=0mQ0DTEIYxib9BKSkOGsOhImtew7OvBA0Rgqh1iv794=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgpRKe1fhnXUaq3Ovoh2x40Nd+eidep825ftlOQgcSZ+EJ0xz172Y4CZzpThqneRohqPuBJnfPgOBxPzBMW1OlHhkEtF+z4y52oz8UqocLN0cwiHNaSndxHOjWA8SYaevf5ZRS997YXF6ihMQvQV3cLppxnVamh1JBa2Zw9J7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jU2byE81; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651070; x=1810187070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0mQ0DTEIYxib9BKSkOGsOhImtew7OvBA0Rgqh1iv794=;
  b=jU2byE81az4S16z9TpH3yIKlL5W3gOUWN1OxqVnOeAOV47o0IGQyCjVJ
   PxAxQMQqTY5XjrbdXly5spOz53N18tR2jnImJlbjOZH0XHdPkvdk7ISFH
   1ZKReYOa9ZgXtFVA0sA7ya51blopsphuNzV67vcZ4ryyDloKo0GcQZ/GQ
   mSKqj/4qtCiwHV6j+j4fI8wUzzqAl5y94GpoAjguEr0ia5sVJ6aFB4onc
   mNa0f3PpkWjzXimZWd/uA2kqPu9xlVUE00fXkV5ciYaW6ZvSEyAx49z2W
   pllmwNkINKTxGWKfRJ2fdSNQZfZ9w8MJh9TTPbIa87I1HZ/r+3OxGGjnP
   A==;
X-CSE-ConnectionGUID: B6NplQSjR16QtPPhr+A1Vw==
X-CSE-MsgGUID: fbPzyncIQ+yiADI4M4GnnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552840"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552840"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:30 -0700
X-CSE-ConnectionGUID: pMO1TKDCR6uVi8jLneSg7w==
X-CSE-MsgGUID: 9xrWvCKQQR2YcZdpZSYwxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077940"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:27 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: update link grading tables per bandwidth
Date: Wed, 13 May 2026 08:43:57 +0300
Message-Id: <20260513084215.9f848b0da851.Id239216fda62e25d343495696cc60742e57d56ea@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A1DB52DB37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36366-lists,linux-wireless=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,intel.com:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

Replace single RSSI-to-grade table with separate tables for each
operational bandwidth. Grade selection now depends on both RSSI and
the link's operational bandwidth.

Improve puncturing penalty calculation to apply proportional reduction
based on unusable spectrum percentage rather than absolute channel count.

Update existing KUnit tests with RSSI values for new grading tables.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 228 ++++++++++++++----
 .../intel/iwlwifi/mld/tests/link-selection.c  |   6 +-
 2 files changed, 183 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 70965627e2dd..3c1825ba2b86 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -696,35 +696,131 @@ struct iwl_mld_rssi_to_grade {
 	u16 grade;
 };
 
-#define RSSI_TO_GRADE_LINE(_lb, _hb_uhb, _grade) \
+#define RSSI_TO_GRADE_LINE_WITH_LB(_lb, _hb_uhb, _grade) \
 	{ \
 		.rssi = {_lb, _hb_uhb}, \
 		.grade = _grade \
 	}
 
-/*
- * This array must be sorted by increasing RSSI for proper functionality.
- * The grades are actually estimated throughput, represented as fixed-point
- * with a scale factor of 1/10.
- */
-static const struct iwl_mld_rssi_to_grade rssi_to_grade_map[] = {
-	RSSI_TO_GRADE_LINE(-85, -89, 172),
-	RSSI_TO_GRADE_LINE(-83, -86, 344),
-	RSSI_TO_GRADE_LINE(-82, -85, 516),
-	RSSI_TO_GRADE_LINE(-80, -83, 688),
-	RSSI_TO_GRADE_LINE(-77, -79, 1032),
-	RSSI_TO_GRADE_LINE(-73, -76, 1376),
-	RSSI_TO_GRADE_LINE(-70, -74, 1548),
-	RSSI_TO_GRADE_LINE(-69, -72, 1720),
-	RSSI_TO_GRADE_LINE(-65, -68, 2064),
-	RSSI_TO_GRADE_LINE(-61, -66, 2294),
-	RSSI_TO_GRADE_LINE(-58, -61, 2580),
-	RSSI_TO_GRADE_LINE(-55, -58, 2868),
-	RSSI_TO_GRADE_LINE(-46, -55, 3098),
-	RSSI_TO_GRADE_LINE(-43, -54, 3442)
+#define RSSI_TO_GRADE_LINE(_rssi, _grade) \
+	RSSI_TO_GRADE_LINE_WITH_LB(_rssi, _rssi, _grade)
+
+/* Tables must be sorted by increasing RSSI */
+
+/* 20 MHz Operational BW Grading Table */
+static const struct iwl_mld_rssi_to_grade rssi_to_grade_20mhz[] = {
+	RSSI_TO_GRADE_LINE_WITH_LB(-94, -95, 9),
+	RSSI_TO_GRADE_LINE_WITH_LB(-92, -93, 17),
+	RSSI_TO_GRADE_LINE_WITH_LB(-90, -90, 34),
+	RSSI_TO_GRADE_LINE_WITH_LB(-87, -87, 52),
+	RSSI_TO_GRADE_LINE_WITH_LB(-83, -84, 69),
+	RSSI_TO_GRADE_LINE_WITH_LB(-79, -80, 103),
+	RSSI_TO_GRADE_LINE_WITH_LB(-75, -75, 137),
+	RSSI_TO_GRADE_LINE_WITH_LB(-72, -73, 155),
+	RSSI_TO_GRADE_LINE_WITH_LB(-70, -71, 172),
+	RSSI_TO_GRADE_LINE_WITH_LB(-67, -68, 206),
+	RSSI_TO_GRADE_LINE_WITH_LB(-64, -65, 230),
+	RSSI_TO_GRADE_LINE_WITH_LB(-59, -60, 258),
+	RSSI_TO_GRADE_LINE_WITH_LB(-57, -58, 287),
+	RSSI_TO_GRADE_LINE_WITH_LB(-52, -53, 310),
+	RSSI_TO_GRADE_LINE_WITH_LB(-50, -50, 345),
 };
 
-#define MAX_GRADE (rssi_to_grade_map[ARRAY_SIZE(rssi_to_grade_map) - 1].grade)
+/* 40 MHz Operational BW Grading Table */
+static const struct iwl_mld_rssi_to_grade rssi_to_grade_40mhz[] = {
+	RSSI_TO_GRADE_LINE_WITH_LB(-95, -95, 9),
+	RSSI_TO_GRADE_LINE_WITH_LB(-93, -93, 17),
+	RSSI_TO_GRADE_LINE_WITH_LB(-91, -92, 18),
+	RSSI_TO_GRADE_LINE_WITH_LB(-89, -90, 34),
+	RSSI_TO_GRADE_LINE_WITH_LB(-87, -87, 68),
+	RSSI_TO_GRADE_LINE_WITH_LB(-84, -84, 104),
+	RSSI_TO_GRADE_LINE_WITH_LB(-80, -81, 138),
+	RSSI_TO_GRADE_LINE_WITH_LB(-77, -77, 206),
+	RSSI_TO_GRADE_LINE_WITH_LB(-72, -72, 274),
+	RSSI_TO_GRADE_LINE_WITH_LB(-69, -70, 310),
+	RSSI_TO_GRADE_LINE_WITH_LB(-67, -68, 344),
+	RSSI_TO_GRADE_LINE_WITH_LB(-64, -65, 412),
+	RSSI_TO_GRADE_LINE_WITH_LB(-61, -62, 460),
+	RSSI_TO_GRADE_LINE_WITH_LB(-56, -57, 516),
+	RSSI_TO_GRADE_LINE_WITH_LB(-54, -55, 574),
+	RSSI_TO_GRADE_LINE_WITH_LB(-49, -50, 620),
+	RSSI_TO_GRADE_LINE_WITH_LB(-46, -47, 690),
+};
+
+/* 80 MHz Operational BW Grading Table */
+static const struct iwl_mld_rssi_to_grade rssi_to_grade_80mhz[] = {
+	RSSI_TO_GRADE_LINE(-95, 9),
+	RSSI_TO_GRADE_LINE(-93, 17),
+	RSSI_TO_GRADE_LINE(-92, 18),
+	RSSI_TO_GRADE_LINE(-90, 34),
+	RSSI_TO_GRADE_LINE(-89, 36),
+	RSSI_TO_GRADE_LINE(-87, 68),
+	RSSI_TO_GRADE_LINE(-83, 136),
+	RSSI_TO_GRADE_LINE(-80, 208),
+	RSSI_TO_GRADE_LINE(-77, 276),
+	RSSI_TO_GRADE_LINE(-74, 412),
+	RSSI_TO_GRADE_LINE(-69, 548),
+	RSSI_TO_GRADE_LINE(-67, 620),
+	RSSI_TO_GRADE_LINE(-66, 688),
+	RSSI_TO_GRADE_LINE(-61, 824),
+	RSSI_TO_GRADE_LINE(-59, 920),
+	RSSI_TO_GRADE_LINE(-54, 1032),
+	RSSI_TO_GRADE_LINE(-52, 1148),
+	RSSI_TO_GRADE_LINE(-47, 1240),
+	RSSI_TO_GRADE_LINE(-44, 1380),
+};
+
+/* 160 MHz Operational BW Grading Table */
+static const struct iwl_mld_rssi_to_grade rssi_to_grade_160mhz[] = {
+	RSSI_TO_GRADE_LINE(-95, 9),
+	RSSI_TO_GRADE_LINE(-93, 17),
+	RSSI_TO_GRADE_LINE(-92, 18),
+	RSSI_TO_GRADE_LINE(-90, 34),
+	RSSI_TO_GRADE_LINE(-89, 36),
+	RSSI_TO_GRADE_LINE(-87, 68),
+	RSSI_TO_GRADE_LINE(-86, 72),
+	RSSI_TO_GRADE_LINE(-84, 136),
+	RSSI_TO_GRADE_LINE(-81, 272),
+	RSSI_TO_GRADE_LINE(-78, 416),
+	RSSI_TO_GRADE_LINE(-75, 552),
+	RSSI_TO_GRADE_LINE(-71, 824),
+	RSSI_TO_GRADE_LINE(-67, 1096),
+	RSSI_TO_GRADE_LINE(-65, 1240),
+	RSSI_TO_GRADE_LINE(-63, 1376),
+	RSSI_TO_GRADE_LINE(-59, 1648),
+	RSSI_TO_GRADE_LINE(-57, 1840),
+	RSSI_TO_GRADE_LINE(-52, 2064),
+	RSSI_TO_GRADE_LINE(-50, 2296),
+	RSSI_TO_GRADE_LINE(-46, 2480),
+	RSSI_TO_GRADE_LINE(-42, 2760),
+};
+
+/* 320 MHz Operational BW Grading Table */
+static const struct iwl_mld_rssi_to_grade rssi_to_grade_320mhz[] = {
+	RSSI_TO_GRADE_LINE(-95, 9),
+	RSSI_TO_GRADE_LINE(-93, 17),
+	RSSI_TO_GRADE_LINE(-92, 18),
+	RSSI_TO_GRADE_LINE(-90, 34),
+	RSSI_TO_GRADE_LINE(-89, 36),
+	RSSI_TO_GRADE_LINE(-87, 68),
+	RSSI_TO_GRADE_LINE(-86, 72),
+	RSSI_TO_GRADE_LINE(-84, 136),
+	RSSI_TO_GRADE_LINE(-83, 144),
+	RSSI_TO_GRADE_LINE(-81, 272),
+	RSSI_TO_GRADE_LINE(-78, 544),
+	RSSI_TO_GRADE_LINE(-75, 832),
+	RSSI_TO_GRADE_LINE(-72, 1104),
+	RSSI_TO_GRADE_LINE(-69, 1648),
+	RSSI_TO_GRADE_LINE(-64, 2192),
+	RSSI_TO_GRADE_LINE(-62, 2480),
+	RSSI_TO_GRADE_LINE(-61, 2752),
+	RSSI_TO_GRADE_LINE(-57, 3296),
+	RSSI_TO_GRADE_LINE(-55, 3680),
+	RSSI_TO_GRADE_LINE(-50, 4128),
+	RSSI_TO_GRADE_LINE(-47, 4592),
+	RSSI_TO_GRADE_LINE(-43, 4960),
+	RSSI_TO_GRADE_LINE(-40, 5520),
+};
 
 #define DEFAULT_CHAN_LOAD_2GHZ	30
 #define DEFAULT_CHAN_LOAD_5GHZ	15
@@ -734,26 +830,23 @@ static const struct iwl_mld_rssi_to_grade rssi_to_grade_map[] = {
 #define SCALE_FACTOR 256
 #define MAX_CHAN_LOAD 256
 
-static unsigned int
-iwl_mld_get_n_subchannels(const struct ieee80211_bss_conf *link_conf)
+static void
+iwl_mld_apply_puncturing_penalty(const struct ieee80211_bss_conf *link_conf,
+				 unsigned int *grade, int bw_mhz)
 {
-	enum nl80211_chan_width chan_width =
-		link_conf->chanreq.oper.width;
-	int mhz = nl80211_chan_width_to_mhz(chan_width);
-	unsigned int n_subchannels;
+	unsigned int n_punctured, n_subchannels;
 
-	if (WARN_ONCE(mhz < 20 || mhz > 320,
-		      "Invalid channel width : (%d)\n", mhz))
-		return 1;
+	/* Puncturing only applicable for BW >= 80 MHz */
+	if (bw_mhz < 80)
+		return;
 
-	/* total number of subchannels */
-	n_subchannels = mhz / 20;
+	n_punctured = hweight16(link_conf->chanreq.oper.punctured);
+	if (n_punctured == 0)
+		return;
 
-	/* No puncturing if less than 80 MHz */
-	if (mhz >= 80)
-		n_subchannels -= hweight16(link_conf->chanreq.oper.punctured);
+	n_subchannels = bw_mhz / 20;
 
-	return n_subchannels;
+	*grade = *grade * (n_subchannels - n_punctured) / n_subchannels;
 }
 
 static int
@@ -1115,14 +1208,19 @@ static s8 iwl_mld_get_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf)
 unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 				    struct ieee80211_bss_conf *link_conf)
 {
+	const struct iwl_mld_rssi_to_grade *grade_table;
 	enum nl80211_band band;
-	int rssi_idx;
+	int rssi_idx, table_size, bw_mhz;
 	s32 link_rssi;
-	unsigned int grade = MAX_GRADE;
+	unsigned int grade;
 
 	if (WARN_ON_ONCE(!link_conf || !link_conf->bss))
 		return 0;
 
+	bw_mhz = nl80211_chan_width_to_mhz(link_conf->chanreq.oper.width);
+	if (bw_mhz < 0)
+		return 0;
+
 	band = link_conf->chanreq.oper.chan->band;
 	if (WARN_ONCE(band != NL80211_BAND_2GHZ &&
 		      band != NL80211_BAND_5GHZ &&
@@ -1149,22 +1247,50 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 		link_rssi += rssi_adj_6g;
 	}
 
+	/* Select grading table based on operational bandwidth */
+	switch (bw_mhz) {
+	case 20:
+		grade_table = rssi_to_grade_20mhz;
+		table_size = ARRAY_SIZE(rssi_to_grade_20mhz);
+		break;
+	case 40:
+		grade_table = rssi_to_grade_40mhz;
+		table_size = ARRAY_SIZE(rssi_to_grade_40mhz);
+		break;
+	case 80:
+		grade_table = rssi_to_grade_80mhz;
+		table_size = ARRAY_SIZE(rssi_to_grade_80mhz);
+		break;
+	case 160:
+		grade_table = rssi_to_grade_160mhz;
+		table_size = ARRAY_SIZE(rssi_to_grade_160mhz);
+		break;
+	case 320:
+		grade_table = rssi_to_grade_320mhz;
+		table_size = ARRAY_SIZE(rssi_to_grade_320mhz);
+		break;
+	default:
+		WARN_ONCE(1, "Invalid bandwidth: %d MHz\n", bw_mhz);
+		return 0;
+	}
+
+	/* Initialize grade to maximum value from selected table */
+	grade = grade_table[table_size - 1].grade;
+
 	rssi_idx = band == NL80211_BAND_2GHZ ? 0 : 1;
 
-	/* No valid RSSI - take the lowest grade */
+	/* No valid RSSI - take the lowest grade from selected table */
 	if (!link_rssi)
-		link_rssi = rssi_to_grade_map[0].rssi[rssi_idx];
+		link_rssi = grade_table[0].rssi[rssi_idx];
 
 	IWL_DEBUG_EHT(mld,
-		      "Calculating grade of link %d: band = %d, bandwidth = %d, punctured subchannels =0x%x RSSI = %d\n",
-		      link_conf->link_id, band,
-		      link_conf->chanreq.oper.width,
+		      "Calculating grade of link %d: band = %d, BW = %d, punct subchannels = 0x%x RSSI = %d\n",
+		      link_conf->link_id, band, bw_mhz,
 		      link_conf->chanreq.oper.punctured, link_rssi);
 
-	/* Get grade based on RSSI */
-	for (int i = 0; i < ARRAY_SIZE(rssi_to_grade_map); i++) {
-		const struct iwl_mld_rssi_to_grade *line =
-			&rssi_to_grade_map[i];
+	/* Get grade based on RSSI from the bandwidth-specific table */
+	for (int i = 0; i < table_size; i++) {
+		const struct iwl_mld_rssi_to_grade *line = &grade_table[i];
 
 		if (link_rssi > line->rssi[rssi_idx])
 			continue;
@@ -1173,8 +1299,10 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 	}
 
 	/* Apply the channel load and puncturing factors */
-	grade = grade * iwl_mld_get_avail_chan_load(mld, link_conf) / SCALE_FACTOR;
-	grade = grade * iwl_mld_get_n_subchannels(link_conf);
+	grade = grade * iwl_mld_get_avail_chan_load(mld, link_conf) /
+		SCALE_FACTOR;
+
+	iwl_mld_apply_puncturing_penalty(link_conf, &grade, bw_mhz);
 
 	IWL_DEBUG_EHT(mld, "Link %d's grade: %d\n", link_conf->link_id, grade);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index 766c24db3613..69d222a8194c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for link selection functions
  *
- * Copyright (C) 2025 Intel Corporation
+ * Copyright (C) 2025-2026 Intel Corporation
  */
 #include <kunit/static_stub.h>
 
@@ -34,6 +34,7 @@ static const struct link_grading_test_case {
 			.link_id = 0,
 			.chandef = &chandef_2ghz_20mhz,
 			.active = false,
+			.signal = -70,
 			.has_chan_util_elem = true,
 			.chan_util = 128,
 		},
@@ -45,6 +46,7 @@ static const struct link_grading_test_case {
 			.link_id = 0,
 			.chandef = &chandef_2ghz_20mhz,
 			.active = false,
+			.signal = -70,
 			.has_chan_util_elem = true,
 			.chan_util = 180,
 		},
@@ -55,6 +57,7 @@ static const struct link_grading_test_case {
 		.input.link = {
 			.link_id = 0,
 			.chandef = &chandef_2ghz_20mhz,
+			.signal = -70,
 			.has_chan_util_elem = true,
 			.chan_util = 180,
 			.active = true,
@@ -67,6 +70,7 @@ static const struct link_grading_test_case {
 		.input.link = {
 			.link_id = 0,
 			.chandef = &chandef_2ghz_20mhz,
+			.signal = -70,
 			.active = true,
 		},
 		.expected_grade = 120,
-- 
2.34.1


