Return-Path: <linux-wireless+bounces-37205-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOjeEG0THGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37205-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CE615AC1
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 587C33051A87
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5525376A02;
	Sun, 31 May 2026 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEROhK/d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4D376A06
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224816; cv=none; b=jZ8+TTKJREs+hI3ASiyh+XEahBQw8zl6CWEinxfyuMw88TQhz7F2eACcXwkPoAqKQ3JNB4c+nfjYbLPQdocdjWjc/mcC0jSlw5gEy+K5nEdNNMDSZgoGwekfHoqSdmsJDW0xjheoLMgMvEL0RDT7btpvL9adf7UEcXdPSNxx3nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224816; c=relaxed/simple;
	bh=V0ZyuQa2QosS5aonQJYiO8EO3n4nOelaA4h3qSPRXYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VtrYa6me8QwdobfSGU7Tc6Y2p7gkEoUbaruwCmt+JhfhInI0dEQ20USslpgX0rssxwp3mZnPm/lQwERduBJ0XmethCW1lDZ4No11eGd0iXqa7rPH2tlZOJmBYse4lD3xynN6k5aQlvIdUMNi74EnCzwVIo8cBSd7hw5CZWEk+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEROhK/d; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224814; x=1811760814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0ZyuQa2QosS5aonQJYiO8EO3n4nOelaA4h3qSPRXYY=;
  b=BEROhK/drumVPZmmiIS2/h8Xue6WARtP8/6Y+ffbLJTPvbEVxqH3xkVJ
   4H9HKEQFOIhpyxKtNS6AmGeJNQrXgvQz3BtvbTci9hm7DG2/dYRwcsFAJ
   myPuPUSIU83HW7k3OYVIIMxHeCKXMJ4JxulSRS8u1FWwF01WvLS9mgD5e
   jb5Xlw2to4C8qr4kCGhKrJZ+uG2ockhAO88BemHu/729HJ14Jb3TQ8ie+
   CSXbW/Rdhb3M3mO/xMMrKsbdUaXF0fJ9Jouv/DR8Fn5W/JPjqY7y2jiWD
   1RL/rE9s3Azq7/V08BVp6BGnxEZuJE5UZHNwFTys74tJpt2MZwwEo1cS5
   g==;
X-CSE-ConnectionGUID: NBmSX7cGRNeFxjknStdtDQ==
X-CSE-MsgGUID: nB6lmxLNQuecTRbYPpMTAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039670"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039670"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:34 -0700
X-CSE-ConnectionGUID: EnlfAANUQfGEymf3+rnIcA==
X-CSE-MsgGUID: 4E6Z6b2PQ9+1OzN4XZm+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240296017"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH wireless-next 09/10] wifi: iwlwifi: mld: add KUnit tests for link grading
Date: Sun, 31 May 2026 13:53:08 +0300
Message-Id: <20260531135036.a4251e5665a0.I811b35680115e7de0ffd75b6b7a1c91ad361c97c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
References: <20260531105309.125363-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37205-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD0CE615AC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Bhatt <avinash.bhatt@intel.com>

Add tests for the link grading algorithm covering per-bandwidth
grading tables, channel load calculation, 6 GHz RSSI adjustments
including duplicated beacon and PSD/EIRP compensation, and
puncturing penalty.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   8 +
 .../intel/iwlwifi/mld/tests/link-selection.c  | 280 +++++++++++++++---
 2 files changed, 254 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 2b8b0196692e..96e06940b34c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2024-2026 Intel Corporation
  */
 
+#include <kunit/static_stub.h>
+
 #include "constants.h"
 #include "link.h"
 #include "iface.h"
@@ -1032,6 +1034,9 @@ iwl_mld_get_dup_beacon_rssi_adjust(struct iwl_mld *mld,
 	const struct cfg80211_bss_ies *beacon_ies;
 	const struct element *elem;
 
+	KUNIT_STATIC_STUB_REDIRECT(iwl_mld_get_dup_beacon_rssi_adjust,
+				   mld, link_conf);
+
 	/* Duplicated beacon feature is only specific to 6 GHz */
 	if (WARN_ONCE(link_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ,
 		      "Unexpected band %d\n",
@@ -1109,6 +1114,9 @@ iwl_mld_get_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf)
 	int bw_mhz, num_subchans;
 	u8 bw_index;
 
+	KUNIT_STATIC_STUB_REDIRECT(iwl_mld_get_psd_eirp_rssi_adjust,
+				   link_conf);
+
 	/* PSD/EIRP adjustment is only specific to 6 GHz */
 	if (WARN_ONCE(link_conf->chanreq.oper.chan->band != NL80211_BAND_6GHZ,
 		      "PSD/EIRP adjustment called for non-6 GHz band %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
index 69d222a8194c..73c2b7b3c9de 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link-selection.c
@@ -13,24 +13,39 @@
 #include "phy.h"
 #include "mlo.h"
 
+struct link_grading_input {
+	u8 link_id;
+	const struct cfg80211_chan_def *chandef;
+	bool active;
+	s32 signal;
+	bool has_chan_util_elem;
+	u8 chan_util;
+	u8 chan_load_by_us;
+	s8 dup_beacon_adj;
+	s8 psd_eirp_adj;
+	u16 punctured;
+};
+
 static const struct link_grading_test_case {
 	const char *desc;
-	struct {
-		struct {
-			u8 link_id;
-			const struct cfg80211_chan_def *chandef;
-			bool active;
-			s32 signal;
-			bool has_chan_util_elem;
-			u8 chan_util; /* 0-255 , used only if has_chan_util_elem is true */
-			u8 chan_load_by_us; /* 0-100, used only if active is true */;
-		} link;
-	} input;
+	struct link_grading_input link;
 	unsigned int expected_grade;
 } link_grading_cases[] = {
+	/* Per-bandwidth grading table tests */
 	{
-		.desc = "channel util of 128 (50%)",
-		.input.link = {
+		.desc = "20 MHz grading table: -75 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_2ghz_20mhz,
+			.active = false,
+			.signal = -75,
+		},
+		/* 137 * 0.7 (default 2.4GHz channel load 30%) */
+		.expected_grade = 96,
+	},
+	{
+		.desc = "20 MHz with channel util 128 (50%): -70 dBm",
+		.link = {
 			.link_id = 0,
 			.chandef = &chandef_2ghz_20mhz,
 			.active = false,
@@ -41,8 +56,8 @@ static const struct link_grading_test_case {
 		.expected_grade = 86,
 	},
 	{
-		.desc = "channel util of 180 (70%)",
-		.input.link = {
+		.desc = "20 MHz with channel util 180 (70%): -70 dBm",
+		.link = {
 			.link_id = 0,
 			.chandef = &chandef_2ghz_20mhz,
 			.active = false,
@@ -53,32 +68,222 @@ static const struct link_grading_test_case {
 		.expected_grade = 51,
 	},
 	{
-		.desc = "channel util of 180 (70%), channel load by us of 10%",
-		.input.link = {
+		.desc = "20 MHz active link with chan load by us 10%: -70 dBm",
+		.link = {
 			.link_id = 0,
 			.chandef = &chandef_2ghz_20mhz,
+			.active = true,
 			.signal = -70,
 			.has_chan_util_elem = true,
 			.chan_util = 180,
-			.active = true,
 			.chan_load_by_us = 10,
 		},
 		.expected_grade = 67,
 	},
-		{
-		.desc = "no channel util element",
-		.input.link = {
+	{
+		.desc = "40 MHz grading table: -80 dBm",
+		.link = {
 			.link_id = 0,
-			.chandef = &chandef_2ghz_20mhz,
+			.chandef = &chandef_5ghz_40mhz,
+			.active = false,
+			.signal = -80,
+		},
+		/* 206 * 0.85 (default 5GHz channel load 15%) */
+		.expected_grade = 175,
+	},
+	{
+		.desc = "80 MHz grading table: -70 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_5ghz_80mhz,
+			.active = false,
 			.signal = -70,
-			.active = true,
 		},
-		.expected_grade = 120,
+		/* 548 * 0.85 (default 5GHz channel load 15%) */
+		.expected_grade = 466,
+	},
+	{
+		.desc = "160 MHz grading table: -65 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_5ghz_160mhz,
+			.active = false,
+			.signal = -65,
+		},
+		/* 1240 * 0.85 (default 5GHz channel load 15%) */
+		.expected_grade = 1055,
+	},
+	{
+		.desc = "320 MHz grading table: -60 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_320mhz,
+			.active = false,
+			.signal = -60,
+		},
+		/* 3680 at -56 dBm (-60 + 4 dBm 6 GHz) */
+		.expected_grade = 3680,
+	},
+	/* 6 GHz RSSI adjustment integration tests */
+	{
+		.desc = "6 GHz 160 MHz with fixed +4 dBm adjustment",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_160mhz,
+			.active = false,
+			.signal = -69,
+		},
+		/* -69 + 4 dBm = -65, grade 1240 */
+		.expected_grade = 1240,
+	},
+	{
+		.desc = "6 GHz 80 MHz with fixed +4 dBm adjustment",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_80mhz,
+			.active = false,
+			.signal = -74,
+		},
+		/* -74 + 4 dBm = -70, grade 548 */
+		.expected_grade = 548,
+	},
+	{
+		.desc = "6 GHz 40 MHz with fixed +4 dBm adjustment",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_40mhz,
+			.active = false,
+			.signal = -84,
+		},
+		/* -84 + 4 dBm = -80, grade 206 */
+		.expected_grade = 206,
+	},
+	{
+		.desc = "6 GHz 20 MHz with fixed +4 dBm adjustment",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_20mhz,
+			.active = false,
+			.signal = -79,
+		},
+		.expected_grade = 137,
+	},
+	/* Duplicated beacon RSSI adjustment tests */
+	{
+		.desc = "6 GHz 40 MHz dup beacon: -81 dBm + 3 dBm = -78 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_40mhz,
+			.active = false,
+			.signal = -81,
+			.dup_beacon_adj = 3,
+		},
+		.expected_grade = 206,
+	},
+	{
+		.desc = "6 GHz 80 MHz dup beacon: -73 dBm + 6 dBm = -67 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_80mhz,
+			.active = false,
+			.signal = -73,
+			.dup_beacon_adj = 6,
+		},
+		.expected_grade = 620,
+	},
+	{
+		.desc = "6 GHz 160 MHz dup beacon: -74 dBm + 9 dBm = -65 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_160mhz,
+			.active = false,
+			.signal = -74,
+			.dup_beacon_adj = 9,
+		},
+		.expected_grade = 1240,
+	},
+	{
+		.desc = "6 GHz 320 MHz dup beacon: -72 dBm + 12 dBm = -60 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_320mhz,
+			.active = false,
+			.signal = -72,
+			.dup_beacon_adj = 12,
+		},
+		.expected_grade = 3296,
+	},
+	/* PSD/EIRP RSSI adjustment tests */
+	{
+		.desc = "6 GHz 80 MHz PSD/EIRP: -77 dBm + 3 dBm = -74 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_80mhz,
+			.active = false,
+			.signal = -77,
+			.psd_eirp_adj = 3,
+		},
+		/* -77 + 3 dBm = -74, grade 412; fallback +4: -73 -> 548 */
+		.expected_grade = 412,
+	},
+	{
+		.desc = "6 GHz 160 MHz PSD/EIRP: -70 dBm + 3 dBm = -67 dBm",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_6ghz_160mhz,
+			.active = false,
+			.signal = -70,
+			.psd_eirp_adj = 3,
+		},
+		/* -70 + 3 dBm = -67, grade 1096; fallback +4: -66 -> 1240 */
+		.expected_grade = 1096,
+	},
+	/* Puncturing penalty tests */
+	{
+		.desc = "80 MHz with 20 MHz punctured: 3 active subchannels",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_5ghz_80mhz,
+			.active = false,
+			.signal = -70,
+			.punctured = 0x2,
+		},
+		/* 548 * 0.85 (5GHz load) * 3/4 (puncturing) */
+		.expected_grade = 349,
+	},
+	{
+		.desc = "160 MHz with 40 MHz punctured: 6 active subchannels",
+		.link = {
+			.link_id = 0,
+			.chandef = &chandef_5ghz_160mhz,
+			.active = false,
+			.signal = -65,
+			.punctured = 0xC,
+		},
+		/* 1240 * 0.85 (5GHz load) * 6/8 (puncturing) */
+		.expected_grade = 791,
 	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(link_grading, link_grading_cases, desc);
 
+static s8 fake_dup_beacon_rssi_adjust(struct iwl_mld *mld,
+				      struct ieee80211_bss_conf *link_conf)
+{
+	const struct link_grading_test_case *params =
+		kunit_get_current_test()->param_value;
+
+	return params->link.dup_beacon_adj;
+}
+
+static s8 fake_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf)
+{
+	const struct link_grading_test_case *params =
+		kunit_get_current_test()->param_value;
+
+	return params->link.psd_eirp_adj;
+}
+
 static void setup_link(struct ieee80211_bss_conf *link)
 {
 	struct kunit *test = kunit_get_current_test();
@@ -88,14 +293,14 @@ static void setup_link(struct ieee80211_bss_conf *link)
 
 	KUNIT_ALLOC_AND_ASSERT(test, link->bss);
 
-	link->bss->signal = DBM_TO_MBM(test_param->input.link.signal);
+	link->bss->signal = DBM_TO_MBM(test_param->link.signal);
 
-	link->chanreq.oper = *test_param->input.link.chandef;
+	link->chanreq.oper = *test_param->link.chandef;
 
-	if (test_param->input.link.has_chan_util_elem) {
+	if (test_param->link.has_chan_util_elem) {
 		struct cfg80211_bss_ies *ies;
 		struct ieee80211_bss_load_elem bss_load = {
-			.channel_util = test_param->input.link.chan_util,
+			.channel_util = test_param->link.chan_util,
 		};
 		struct element *elem =
 			iwlmld_kunit_gen_element(WLAN_EID_QBSS_LOAD,
@@ -110,7 +315,10 @@ static void setup_link(struct ieee80211_bss_conf *link)
 		rcu_assign_pointer(link->bss->ies, ies);
 	}
 
-	if (test_param->input.link.active) {
+	if (test_param->link.punctured)
+		link->chanreq.oper.punctured = test_param->link.punctured;
+
+	if (test_param->link.active) {
 		struct ieee80211_chanctx_conf *chan_ctx =
 			wiphy_dereference(mld->wiphy, link->chanctx_conf);
 		struct iwl_mld_phy *phy;
@@ -119,7 +327,7 @@ static void setup_link(struct ieee80211_bss_conf *link)
 
 		phy = iwl_mld_phy_from_mac80211(chan_ctx);
 
-		phy->channel_load_by_us = test_param->input.link.chan_load_by_us;
+		phy->channel_load_by_us = test_param->link.chan_load_by_us;
 	}
 }
 
@@ -131,12 +339,11 @@ static void test_link_grading(struct kunit *test)
 	struct ieee80211_vif *vif;
 	struct ieee80211_bss_conf *link;
 	unsigned int actual_grade;
-	/* Extract test case parameters */
-	u8 link_id = test_param->input.link.link_id;
-	bool active = test_param->input.link.active;
+	u8 link_id = test_param->link.link_id;
+	bool active = test_param->link.active;
 	u16 valid_links;
 	struct iwl_mld_kunit_link assoc_link = {
-		.chandef = test_param->input.link.chandef,
+		.chandef = test_param->link.chandef,
 	};
 
 	/* If the link is not active, use a different link as the assoc link */
@@ -150,6 +357,11 @@ static void test_link_grading(struct kunit *test)
 
 	vif = iwlmld_kunit_setup_mlo_assoc(valid_links, &assoc_link);
 
+	kunit_activate_static_stub(test, iwl_mld_get_dup_beacon_rssi_adjust,
+				   fake_dup_beacon_rssi_adjust);
+	kunit_activate_static_stub(test, iwl_mld_get_psd_eirp_rssi_adjust,
+				   fake_psd_eirp_rssi_adjust);
+
 	wiphy_lock(mld->wiphy);
 	link = wiphy_dereference(mld->wiphy, vif->link_conf[link_id]);
 	KUNIT_ASSERT_NOT_NULL(test, link);
-- 
2.34.1


