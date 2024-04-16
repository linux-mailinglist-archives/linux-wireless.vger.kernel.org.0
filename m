Return-Path: <linux-wireless+bounces-6380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595F8A6921
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2828C1C20FAC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1A128385;
	Tue, 16 Apr 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMt2v6aE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CB129A6D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264869; cv=none; b=QeDD+OTHK3pyTZtbJC137IJP4PMXrcgWdl89I39MfEbp8rw4Bkgf+sWk24YcRTbOhyqZW6WhEowd/VIw76qFW6cijYSalPgvsXzwlYs9gWxpW01uDwuyJFBMDZwkUwpAbERfk7sKaq8us1sUD5xHY/rW7Jw9ovuZHC6CNzGaqCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264869; c=relaxed/simple;
	bh=MyGIpD/CzQJj1R4ty+g7GATZj7CyR8myCtL6awq57vI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R49WZ5DT2iF9NIi84PXAZLIvDuMyWChwg7CexpG5RThe/RNRlT5toHOCaoZIJWZeyAK/rp4dyhfSHw0BeY6qvI2YiszQC7Reb/iIRY3n6tJE5jWjPgYs+9Sxr2hclhCnJMHOCCc7n6Zvp8mCAGv4sgDmLhGJn9OPkxPmqcynM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMt2v6aE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264868; x=1744800868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MyGIpD/CzQJj1R4ty+g7GATZj7CyR8myCtL6awq57vI=;
  b=YMt2v6aEAwZ+Fpzpixz4wiptMopAyuyl2MCC9WKIIYeqMmEiAodGKJbr
   utilfc789HBXpz5lPR3fHkk0C0VZGu2pEVggxgKBDtOtoQP+HJHE0cVwy
   DFDeH5yUqG1hIoAiGMDHfDvVr8s8NXs7Z3VlPW2wsk5kGVdBX5ZXEe7sW
   x9UFoSUFy8UxRaxJ5/Y4dMceDaUXhIsndjm22/2Fpzfy/nKWdXL2mByar
   MzzF8pGBYc4n2uz38uQjihqRI6kH+sJGj/bAfa9JLtxvoJOSmyKVtWTDF
   +mqcJ9PBD73pfBBqDfFMnLWhHCkqMqUzA1TkVFDantDRXwDI5cS0qK9WP
   A==;
X-CSE-ConnectionGUID: UziHJ48iT9eYF7cwL8W51w==
X-CSE-MsgGUID: SrQioKp1RS68ORg2YT1xiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556035"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556035"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:27 -0700
X-CSE-ConnectionGUID: 7zWx16MqQXqAVQ+ttxl5Fw==
X-CSE-MsgGUID: dP4v31wPSsqZOwFiBa18aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872444"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/16] wifi: iwlwifi: mvm: implement link grading
Date: Tue, 16 Apr 2024 13:53:58 +0300
Message-Id: <20240416134215.a6799dbd5643.If137ca6dc443606c7d8c99ec1fc38b325003a7c1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

For selecting what link(s) out of the usable ones
to activate, calculate a grade for a given link.

Calculation of a link grade is done as follows:
1. get the estimated throughput according to the RSSI of the link, this
   will be the base grade
2. get the channel load from the BSS Load Element, subtracting the load
   caused by us. Apply the factor on the grade.
3. puncturing factor: calculate the percentage of the punctured
   subchannels (out of the total subchannels). Apply this on the grade.

The link grading will be used by the link selection mechanism in a later
patch.

Also add KUnit tests for it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 172 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 +
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   3 +
 .../wireless/intel/iwlwifi/mvm/tests/links.c  | 210 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mvm/tests/module.c |  10 +
 include/linux/ieee80211.h                     |  18 ++
 7 files changed, 416 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/module.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 593fe28d89cf..5c754b87ea20 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IWLMVM)   += iwlmvm.o
+obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += tests/
 iwlmvm-y += fw.o mac80211.o nvm.o ops.o phy-ctxt.o mac-ctxt.o
 iwlmvm-y += utils.o rx.o rxmq.o tx.o binding.o quota.o sta.o sf.o
 iwlmvm-y += scan.o time-event.o rs.o rs-fw.o
@@ -15,4 +16,4 @@ iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
 iwlmvm-$(CONFIG_IWLMEI) += vendor-cmd.o
 
-ccflags-y += -I $(srctree)/$(src)/../
+subdir-ccflags-y += -I $(srctree)/$(src)/../
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 9f69e04594e4..23660238348b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -329,3 +329,175 @@ int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	return ret;
 }
+
+struct iwl_mvm_rssi_to_grade {
+	s8 rssi[2];
+	u16 grade;
+};
+
+#define RSSI_TO_GRADE_LINE(_lb, _hb_uhb, _grade) \
+	{ \
+		.rssi = {_lb, _hb_uhb}, \
+		.grade = _grade \
+	}
+
+/*
+ * This array must be sorted by increasing RSSI for proper functionality.
+ * The grades are actually estimated throughput, represented as fixed-point
+ * with a scale factor of 1/10.
+ */
+static const struct iwl_mvm_rssi_to_grade rssi_to_grade_map[] = {
+	RSSI_TO_GRADE_LINE(-85, -89, 177),
+	RSSI_TO_GRADE_LINE(-83, -86, 344),
+	RSSI_TO_GRADE_LINE(-82, -85, 516),
+	RSSI_TO_GRADE_LINE(-80, -83, 688),
+	RSSI_TO_GRADE_LINE(-77, -79, 1032),
+	RSSI_TO_GRADE_LINE(-73, -76, 1376),
+	RSSI_TO_GRADE_LINE(-70, -74, 1548),
+	RSSI_TO_GRADE_LINE(-69, -72, 1750),
+	RSSI_TO_GRADE_LINE(-65, -68, 2064),
+	RSSI_TO_GRADE_LINE(-61, -66, 2294),
+	RSSI_TO_GRADE_LINE(-58, -61, 2580),
+	RSSI_TO_GRADE_LINE(-55, -58, 2868),
+	RSSI_TO_GRADE_LINE(-46, -55, 3098),
+	RSSI_TO_GRADE_LINE(-43, -54, 3442)
+};
+
+#define MAX_GRADE (rssi_to_grade_map[ARRAY_SIZE(rssi_to_grade_map) - 1].grade)
+
+#define DEFAULT_CHAN_LOAD_LB	30
+#define DEFAULT_CHAN_LOAD_HB	15
+#define DEFAULT_CHAN_LOAD_UHB	0
+
+/* Factors calculation is done with fixed-point with a scaling factor of 1/256 */
+#define SCALE_FACTOR 256
+
+/* Convert a percentage from [0,100] to [0,255] */
+#define NORMALIZE_PERCENT_TO_255(percentage) ((percentage) * SCALE_FACTOR / 100)
+
+static unsigned int
+iwl_mvm_get_puncturing_factor(const struct ieee80211_bss_conf *link_conf)
+{
+	enum nl80211_chan_width chan_width =
+		link_conf->chanreq.oper.width;
+	int mhz = nl80211_chan_width_to_mhz(chan_width);
+	unsigned int n_subchannels, n_punctured, puncturing_penalty;
+
+	if (WARN_ONCE(mhz < 20 || mhz > 320,
+		      "Invalid channel width : (%d)\n", mhz))
+		return SCALE_FACTOR;
+
+	/* No puncturing, no penalty */
+	if (mhz < 80)
+		return SCALE_FACTOR;
+
+	/* total number of subchannels */
+	n_subchannels = mhz / 20;
+	/* how many of these are punctured */
+	n_punctured = hweight16(link_conf->chanreq.oper.punctured);
+
+	puncturing_penalty = n_punctured * SCALE_FACTOR / n_subchannels;
+	return SCALE_FACTOR - puncturing_penalty;
+}
+
+static unsigned int
+iwl_mvm_get_chan_load_factor(struct ieee80211_bss_conf *link_conf)
+{
+	struct iwl_mvm_vif_link_info *mvm_link =
+		iwl_mvm_vif_from_mac80211(link_conf->vif)->link[link_conf->link_id];
+	const struct element *bss_load_elem =
+		ieee80211_bss_get_elem(link_conf->bss, WLAN_EID_QBSS_LOAD);
+	const struct ieee80211_bss_load_elem *bss_load;
+	enum nl80211_band band = link_conf->chanreq.oper.chan->band;
+	unsigned int chan_load;
+	u32 chan_load_by_us;
+
+	/* If there isn't BSS Load element, take the defaults */
+	if (!bss_load_elem ||
+	    bss_load_elem->datalen != sizeof(*bss_load)) {
+		switch (band) {
+		case NL80211_BAND_2GHZ:
+			chan_load = DEFAULT_CHAN_LOAD_LB;
+			break;
+		case NL80211_BAND_5GHZ:
+			chan_load = DEFAULT_CHAN_LOAD_HB;
+			break;
+		case NL80211_BAND_6GHZ:
+			chan_load = DEFAULT_CHAN_LOAD_UHB;
+			break;
+		default:
+			chan_load = 0;
+			break;
+		}
+		/* The defaults are given in percentage */
+		return SCALE_FACTOR - NORMALIZE_PERCENT_TO_255(chan_load);
+	}
+
+	bss_load = (const void *)bss_load_elem->data;
+	/* Channel util is in range 0-255 */
+	chan_load = bss_load->channel_util;
+
+	if (!mvm_link || !mvm_link->active)
+		goto done;
+
+	if (WARN_ONCE(!mvm_link->phy_ctxt,
+		      "Active link (%u) without phy ctxt assigned!\n",
+		      link_conf->link_id))
+		goto done;
+
+	/* channel load by us is given in percentage */
+	chan_load_by_us =
+		NORMALIZE_PERCENT_TO_255(mvm_link->phy_ctxt->channel_load_by_us);
+
+	/* Use only values that firmware sends that can possibly be valid */
+	if (chan_load_by_us <= chan_load)
+		chan_load -= chan_load_by_us;
+done:
+	return  SCALE_FACTOR - chan_load;
+}
+
+/* This function calculates the grade of a link. Returns 0 in error case */
+unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf)
+{
+	enum nl80211_band band;
+	int i, rssi_idx;
+	s32 link_rssi;
+	unsigned int grade = MAX_GRADE;
+
+	if (WARN_ON_ONCE(!link_conf))
+		return 0;
+
+	band = link_conf->chanreq.oper.chan->band;
+	if (WARN_ONCE(band != NL80211_BAND_2GHZ &&
+		      band != NL80211_BAND_5GHZ &&
+		      band != NL80211_BAND_6GHZ,
+		      "Invalid band (%u)\n", band))
+		return 0;
+
+	link_rssi = MBM_TO_DBM(link_conf->bss->signal);
+	/*
+	 * For 6 GHz the RSSI of the beacons is lower than
+	 * the RSSI of the data.
+	 */
+	if (band == NL80211_BAND_6GHZ)
+		link_rssi += 4;
+
+	rssi_idx = band == NL80211_BAND_2GHZ ? 0 : 1;
+
+	/* Get grade based on RSSI */
+	for (i = 0; i < ARRAY_SIZE(rssi_to_grade_map); i++) {
+		const struct iwl_mvm_rssi_to_grade *line =
+			&rssi_to_grade_map[i];
+
+		if (link_rssi > line->rssi[rssi_idx])
+			continue;
+		grade = line->grade;
+		break;
+	}
+
+	/* apply the channel load and puncturing factors */
+	grade = grade * iwl_mvm_get_chan_load_factor(link_conf) / SCALE_FACTOR;
+	grade = grade * iwl_mvm_get_puncturing_factor(link_conf) / SCALE_FACTOR;
+	return grade;
+}
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_get_link_grade);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0dd83e0171ba..c477978d8fa3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2449,6 +2449,7 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 			  struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta,
 			  struct ieee80211_key_conf *keyconf);
+unsigned int iwl_mvm_get_link_grade(struct ieee80211_bss_conf *link_conf);
 
 bool iwl_rfi_supported(struct iwl_mvm *mvm);
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
new file mode 100644
index 000000000000..b13aebbf7d5e
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
@@ -0,0 +1,3 @@
+iwlmvm-tests-y += module.o links.o
+
+obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmvm-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
new file mode 100644
index 000000000000..321d18de1ca3
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <net/mac80211.h>
+#include "../mvm.h"
+#include <kunit/test.h>
+
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+
+static struct ieee80211_channel chan_5ghz = {
+	.band = NL80211_BAND_5GHZ,
+};
+
+static struct ieee80211_channel chan_6ghz = {
+	.band = NL80211_BAND_6GHZ,
+};
+
+static struct ieee80211_channel chan_2ghz = {
+	.band = NL80211_BAND_2GHZ,
+};
+
+static struct iwl_mvm_phy_ctxt ctx = {};
+
+static struct iwl_mvm_vif_link_info mvm_link = {
+	.phy_ctxt = &ctx,
+	.active = true
+};
+
+static struct cfg80211_bss bss = {};
+
+static struct ieee80211_bss_conf link_conf = {.bss = &bss};
+
+static const struct link_grading_case {
+	const char *desc;
+	const struct cfg80211_chan_def chandef;
+	s32 signal;
+	s16 channel_util;
+	int chan_load_by_us;
+	unsigned int grade;
+} link_grading_cases[] = {
+	{
+		.desc = "UHB, RSSI below range, no factors",
+		.chandef = {
+			.chan = &chan_6ghz,
+			.width = NL80211_CHAN_WIDTH_20,
+		},
+		.signal = -100,
+		.grade = 177,
+	},
+	{
+		.desc = "LB, RSSI in range, no factors",
+		.chandef = {
+			.chan = &chan_2ghz,
+			.width = NL80211_CHAN_WIDTH_20,
+		},
+		.signal = -84,
+		.grade = 344,
+	},
+	{
+		.desc = "HB, RSSI above range, no factors",
+		.chandef = {
+			.chan = &chan_5ghz,
+			.width = NL80211_CHAN_WIDTH_20,
+		},
+		.signal = -50,
+		.grade = 3442,
+	},
+	{
+		.desc = "HB, BSS Load IE (20 percent), inactive link, no puncturing factor",
+		.chandef = {
+			.chan = &chan_5ghz,
+			.width = NL80211_CHAN_WIDTH_20,
+		},
+		.signal = -66,
+		.channel_util = 51,
+		.grade = 1836,
+	},
+	{
+		.desc = "LB, BSS Load IE (20 percent), active link, chan_load_by_us=10 percent. No puncturing factor",
+		.chandef = {
+			.chan = &chan_2ghz,
+			.width = NL80211_CHAN_WIDTH_20,
+		},
+		.signal = -61,
+		.channel_util = 51,
+		.chan_load_by_us = 10,
+		.grade = 2061,
+	},
+	{
+		.desc = "UHB, BSS Load IE (40 percent), active link, chan_load_by_us=50 (invalid) percent. No puncturing factor",
+		.chandef = {
+			.chan = &chan_6ghz,
+			.width = NL80211_CHAN_WIDTH_20,
+		},
+		.signal = -66,
+		.channel_util = 102,
+		.chan_load_by_us = 50,
+		.grade = 1552,
+	},
+	{	.desc = "HB, 80 MHz, no channel load factor, punctured percentage 0",
+		.chandef = {
+			.chan = &chan_5ghz,
+			.width = NL80211_CHAN_WIDTH_80,
+			.punctured = 0x0000
+		},
+		.signal = -72,
+		.grade = 1750,
+	},
+	{	.desc = "HB, 160 MHz, no channel load factor, punctured percentage 25",
+		.chandef = {
+			.chan = &chan_5ghz,
+			.width = NL80211_CHAN_WIDTH_160,
+			.punctured = 0x3
+		},
+		.signal = -72,
+		.grade = 1312,
+	},
+	{	.desc = "UHB, 320 MHz, no channel load factor, punctured percentage 12.5 (2/16)",
+		.chandef = {
+			.chan = &chan_6ghz,
+			.width = NL80211_CHAN_WIDTH_320,
+			.punctured = 0x3
+		},
+		.signal = -72,
+		.grade = 1806,
+	},
+	{	.desc = "HB, 160 MHz, channel load 20, channel load by us 10, punctured percentage 25",
+		.chandef = {
+			.chan = &chan_5ghz,
+			.width = NL80211_CHAN_WIDTH_160,
+			.punctured = 0x3
+		},
+		.channel_util = 51,
+		.chan_load_by_us = 10,
+		.signal = -72,
+		.grade = 1179,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(link_grading, link_grading_cases, desc)
+
+static void setup_link_conf(struct kunit *test)
+{
+	const struct link_grading_case *params = test->param_value;
+	size_t vif_size = sizeof(struct ieee80211_vif) +
+		sizeof(struct iwl_mvm_vif);
+	struct ieee80211_vif *vif = kunit_kzalloc(test, vif_size, GFP_KERNEL);
+	struct ieee80211_bss_load_elem *bss_load;
+	struct element *element;
+	size_t ies_size = sizeof(struct cfg80211_bss_ies) + sizeof(*bss_load) + sizeof(element);
+	struct cfg80211_bss_ies *ies;
+	struct iwl_mvm_vif *mvmvif;
+
+	KUNIT_ASSERT_NOT_NULL(test, vif);
+
+	mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	if (params->chan_load_by_us > 0) {
+		ctx.channel_load_by_us = params->chan_load_by_us;
+		mvmvif->link[0] = &mvm_link;
+	}
+
+	link_conf.vif = vif;
+	link_conf.chanreq.oper = params->chandef;
+	bss.signal = DBM_TO_MBM(params->signal);
+
+	ies = kunit_kzalloc(test, ies_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ies);
+	ies->len = sizeof(*bss_load) + sizeof(struct element);
+
+	element = (void *)ies->data;
+	element->datalen = sizeof(*bss_load);
+	element->id = 11;
+
+	bss_load = (void *)element->data;
+	bss_load->channel_util = params->channel_util;
+
+	rcu_assign_pointer(bss.ies, ies);
+}
+
+static void test_link_grading(struct kunit *test)
+{
+	const struct link_grading_case *params = test->param_value;
+	unsigned int ret;
+
+	setup_link_conf(test);
+
+	rcu_read_lock();
+	ret = iwl_mvm_get_link_grade(&link_conf);
+	rcu_read_unlock();
+
+	KUNIT_EXPECT_EQ(test, ret, params->grade);
+
+	kunit_kfree(test, link_conf.vif);
+	RCU_INIT_POINTER(bss.ies, NULL);
+}
+
+static struct kunit_case link_grading_test_cases[] = {
+	KUNIT_CASE_PARAM(test_link_grading, link_grading_gen_params),
+	{}
+};
+
+static struct kunit_suite link_grading = {
+	.name = "iwlmvm-link-grading",
+	.test_cases = link_grading_test_cases,
+};
+
+kunit_test_suite(link_grading);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/module.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/module.c
new file mode 100644
index 000000000000..f556acbac77f
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/module.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This is just module boilerplate for the iwlmvm kunit module.
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <linux/module.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("kunit tests for iwlmvm");
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 7f9b829dcb1e..de2dce743ee2 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1287,6 +1287,24 @@ struct ieee80211_ttlm_elem {
 	u8 optional[];
 } __packed;
 
+/**
+ * struct ieee80211_bss_load_elem - BSS Load elemen
+ *
+ * Defined in section 9.4.2.26 in IEEE 802.11-REVme D4.1
+ *
+ * @sta_count: total number of STAs currently associated with the AP.
+ * @channel_util: Percentage of time that the access point sensed the channel
+ *	was busy. This value is in range [0, 255], the highest value means
+ *	100% busy.
+ * @avail_admission_capa: remaining amount of medium time used for admission
+ *	control.
+ */
+struct ieee80211_bss_load_elem {
+	__le16 sta_count;
+	u8 channel_util;
+	__le16 avail_admission_capa;
+} __packed;
+
 struct ieee80211_mgmt {
 	__le16 frame_control;
 	__le16 duration;
-- 
2.34.1


