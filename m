Return-Path: <linux-wireless+bounces-18503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4F5A286CE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80C5188A205
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FD22A808;
	Wed,  5 Feb 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daG/PXhz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2444122A80A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748402; cv=none; b=T4efbXwn2OxONuJrd79BMIBq/KTjHMPYP9SW802PFpR0M6RiqRf5X7a9riX5btP2KoZezBDXLJD/NDKVB8KzRbsYEC+xBjXeGlQ/jzwRoL//8Jiu/hJ10IzoZJAmExf4HTLhsLCRTg7OKdQ4Vmh93s/ca7NfMcJbn+TOkHkNkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748402; c=relaxed/simple;
	bh=aLL3dFCO7644BqthUzjKfLCYBRMZR8Z018vlITELisM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bgf61S24xEmrrePDv4wZlAdAFo6FSOEnH98/ju6T/i5YrRPZ4l5m0GwEWP6zit7F9ecNM44BeOidecYtLe9Y3ihPKGGMnswGZiG11A6Ld31LE//pvJ1SNL+pFmrY8tT1U2HMEwan9M3g8sS5axWyxfj+SQnFTa6GzGVgymasSdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daG/PXhz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748400; x=1770284400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aLL3dFCO7644BqthUzjKfLCYBRMZR8Z018vlITELisM=;
  b=daG/PXhzKzndBTnaoybaWLni5bZzJz+soVQ06Xa9ArLwe1K6+E06a9LX
   mVlYrIL48TM19qj8169UXWuFaffYxJSKG0frSFD8KySHwxjCqD7IA3fnz
   AXsAnL2gkMyrADHG2LeqtciSmeDT/5aylffNiy4v7zlfvRmcZD/w+2PII
   By6qANkrxghuMl9j0/U/iGtYCLnfw7y9tiAgaAXz1SxNp2fzhEEtG9wQ9
   SWnx0aeR0EnczaItw8ZGOZC4hBg8B9vsgMkHq2w0r45zu5zGAmj+xW3ut
   PHqY1zPhEbpRg0NfipMWVofXEqXAIVHiTjnGX+oO3AmD/IbmfqB2Ewt4E
   A==;
X-CSE-ConnectionGUID: 0rozzMT8SWuPvCdeJPuJ2g==
X-CSE-MsgGUID: KTaKdXcfRD6ygsW4ehAhrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225234"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:00 -0800
X-CSE-ConnectionGUID: X82/XdpDTL2NYynS6eTheA==
X-CSE-MsgGUID: Mz2/YmqWTB2mbjCmO/QUCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845300"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:39:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/17] wifi: mac80211: tests: add tests for ieee80211_determine_chan_mode
Date: Wed,  5 Feb 2025 11:39:19 +0200
Message-Id: <20250205110958.530c81eb7fdc.Ia77f5efdf9efb70d2766a3d6bf425553bcb308e8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Add a few tests for ieee80211_determine_chan_mode that check that
mac80211 will not try to connect to an AP if an advertised basic rate is
not supported.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h     |   7 +
 net/mac80211/mlme.c            |   3 +-
 net/mac80211/tests/Makefile    |   2 +-
 net/mac80211/tests/chan-mode.c | 254 +++++++++++++++++++++++++++++++++
 net/mac80211/tests/util.c      |   6 +-
 5 files changed, 265 insertions(+), 7 deletions(-)
 create mode 100644 net/mac80211/tests/chan-mode.c

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cee534aac668..9552dbf0e2c3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2807,6 +2807,13 @@ int ieee80211_calc_chandef_subchan_offset(const struct cfg80211_chan_def *ap,
 void ieee80211_rearrange_tpe_psd(struct ieee80211_parsed_tpe_psd *psd,
 				 const struct cfg80211_chan_def *ap,
 				 const struct cfg80211_chan_def *used);
+struct ieee802_11_elems *
+ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
+			      struct ieee80211_conn_settings *conn,
+			      struct cfg80211_bss *cbss, int link_id,
+			      struct ieee80211_chan_req *chanreq,
+			      struct cfg80211_chan_def *ap_chandef,
+			      unsigned long *userspace_selectors);
 #else
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym)
 #define VISIBLE_IF_MAC80211_KUNIT static
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3749b3e23bb7..686b33654b52 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -989,7 +989,7 @@ static void ieee80211_set_chanreq_ap(struct ieee80211_sub_if_data *sdata,
 	chanreq->ap = *ap_chandef;
 }
 
-static struct ieee802_11_elems *
+VISIBLE_IF_MAC80211_KUNIT struct ieee802_11_elems *
 ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_conn_settings *conn,
 			      struct cfg80211_bss *cbss, int link_id,
@@ -1214,6 +1214,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	kfree(elems);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_determine_chan_mode);
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
diff --git a/net/mac80211/tests/Makefile b/net/mac80211/tests/Makefile
index 0f5336bc7314..3b0c08356fc5 100644
--- a/net/mac80211/tests/Makefile
+++ b/net/mac80211/tests/Makefile
@@ -1,3 +1,3 @@
-mac80211-tests-y += module.o util.o elems.o mfp.o tpe.o
+mac80211-tests-y += module.o util.o elems.o mfp.o tpe.o chan-mode.o
 
 obj-$(CONFIG_MAC80211_KUNIT_TEST) += mac80211-tests.o
diff --git a/net/mac80211/tests/chan-mode.c b/net/mac80211/tests/chan-mode.c
new file mode 100644
index 000000000000..96c7b3ab2744
--- /dev/null
+++ b/net/mac80211/tests/chan-mode.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for channel mode functions
+ *
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include <net/cfg80211.h>
+#include <kunit/test.h>
+
+#include "util.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static const struct determine_chan_mode_case {
+	const char *desc;
+	u8 extra_supp_rate;
+	enum ieee80211_conn_mode conn_mode;
+	enum ieee80211_conn_mode expected_mode;
+	bool strict;
+	u8 userspace_selector;
+	struct ieee80211_ht_cap ht_capa_mask;
+	struct ieee80211_vht_cap vht_capa;
+	struct ieee80211_vht_cap vht_capa_mask;
+	u8 vht_basic_mcs_1_4_set:1,
+	   vht_basic_mcs_5_8_set:1,
+	   he_basic_mcs_1_4_set:1,
+	   he_basic_mcs_5_8_set:1;
+	u8 vht_basic_mcs_1_4, vht_basic_mcs_5_8;
+	u8 he_basic_mcs_1_4, he_basic_mcs_5_8;
+	u8 eht_mcs7_min_nss;
+	int error;
+} determine_chan_mode_cases[] = {
+	{
+		.desc = "Normal case, EHT is working",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_EHT,
+	}, {
+		.desc = "Requiring EHT support is fine",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_EHT,
+		.extra_supp_rate = 0x80 | BSS_MEMBERSHIP_SELECTOR_EHT_PHY,
+	}, {
+		.desc = "Lowering the mode limits us",
+		.conn_mode = IEEE80211_CONN_MODE_VHT,
+		.expected_mode = IEEE80211_CONN_MODE_VHT,
+	}, {
+		.desc = "Requesting a basic rate/selector that we do not support",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.extra_supp_rate = 0x80 | (BSS_MEMBERSHIP_SELECTOR_MIN - 1),
+		.error = EINVAL,
+	}, {
+		.desc = "As before, but userspace says it is taking care of it",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.userspace_selector = BSS_MEMBERSHIP_SELECTOR_MIN - 1,
+		.extra_supp_rate = 0x80 | (BSS_MEMBERSHIP_SELECTOR_MIN - 1),
+		.expected_mode = IEEE80211_CONN_MODE_EHT,
+	}, {
+		.desc = "Masking out a supported rate in HT capabilities",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_LEGACY,
+		.ht_capa_mask = {
+			.mcs.rx_mask[0] = 0xf7,
+		},
+	}, {
+		.desc = "Masking out a RX rate in VHT capabilities",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_HT,
+		/* Only one RX stream at MCS 0-7 */
+		.vht_capa = {
+			.supp_mcs.rx_mcs_map =
+				cpu_to_le16(IEEE80211_VHT_MCS_SUPPORT_0_7),
+		},
+		.vht_capa_mask = {
+			.supp_mcs.rx_mcs_map = cpu_to_le16(0xffff),
+		},
+		.strict = true,
+	}, {
+		.desc = "Masking out a TX rate in VHT capabilities",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_HT,
+		/* Only one TX stream at MCS 0-7 */
+		.vht_capa = {
+			.supp_mcs.tx_mcs_map =
+				cpu_to_le16(IEEE80211_VHT_MCS_SUPPORT_0_7),
+		},
+		.vht_capa_mask = {
+			.supp_mcs.tx_mcs_map = cpu_to_le16(0xffff),
+		},
+		.strict = true,
+	}, {
+		.desc = "AP has higher VHT requirement than client",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_HT,
+		.vht_basic_mcs_5_8_set = 1,
+		.vht_basic_mcs_5_8 = 0xFE, /* require 5th stream */
+		.strict = true,
+	}, {
+		.desc = "all zero VHT basic rates are ignored (many APs broken)",
+		.conn_mode = IEEE80211_CONN_MODE_VHT,
+		.expected_mode = IEEE80211_CONN_MODE_VHT,
+		.vht_basic_mcs_1_4_set = 1,
+		.vht_basic_mcs_5_8_set = 1,
+	}, {
+		.desc = "AP requires 3 HE streams but client only has two",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_VHT,
+		.he_basic_mcs_1_4 = 0b11001010,
+		.he_basic_mcs_1_4_set = 1,
+	}, {
+		.desc = "all zero HE basic rates are ignored (iPhone workaround)",
+		.conn_mode = IEEE80211_CONN_MODE_HE,
+		.expected_mode = IEEE80211_CONN_MODE_HE,
+		.he_basic_mcs_1_4_set = 1,
+		.he_basic_mcs_5_8_set = 1,
+	}, {
+		.desc = "AP requires too many RX streams with EHT MCS 7",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_HE,
+		.eht_mcs7_min_nss = 0x15,
+	}, {
+		.desc = "AP requires too many TX streams with EHT MCS 7",
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.expected_mode = IEEE80211_CONN_MODE_HE,
+		.eht_mcs7_min_nss = 0x51,
+	}, {
+		.desc = "AP requires too many RX streams with EHT MCS 7 and EHT is required",
+		.extra_supp_rate = 0x80 | BSS_MEMBERSHIP_SELECTOR_EHT_PHY,
+		.conn_mode = IEEE80211_CONN_MODE_EHT,
+		.eht_mcs7_min_nss = 0x15,
+		.error = EINVAL,
+	}
+};
+KUNIT_ARRAY_PARAM_DESC(determine_chan_mode, determine_chan_mode_cases, desc)
+
+static void test_determine_chan_mode(struct kunit *test)
+{
+	const struct determine_chan_mode_case *params = test->param_value;
+	struct t_sdata *t_sdata = T_SDATA(test);
+	struct ieee80211_conn_settings conn = {
+		.mode = params->conn_mode,
+		.bw_limit = IEEE80211_CONN_BW_LIMIT_20,
+	};
+	struct cfg80211_bss cbss = {
+		.channel = &t_sdata->band_5ghz.channels[0],
+	};
+	unsigned long userspace_selectors[BITS_TO_LONGS(128)] = {};
+	u8 bss_ies[] = {
+		/* Supported Rates */
+		WLAN_EID_SUPP_RATES, 0x08,
+		0x82, 0x84, 0x8b, 0x96, 0xc, 0x12, 0x18, 0x24,
+		/* Extended Supported Rates */
+		WLAN_EID_EXT_SUPP_RATES, 0x05,
+		0x30, 0x48, 0x60, 0x6c, params->extra_supp_rate,
+		/* HT Capabilities */
+		WLAN_EID_HT_CAPABILITY, 0x1a,
+		0x0c, 0x00, 0x1b, 0xff, 0xff, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00,
+		/* HT Information (0xff for 1 stream) */
+		WLAN_EID_HT_OPERATION, 0x16,
+		0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		/* VHT Capabilities */
+		WLAN_EID_VHT_CAPABILITY, 0xc,
+		0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
+		0xff, 0xff, 0x00, 0x00,
+		/* VHT Operation */
+		WLAN_EID_VHT_OPERATION, 0x05,
+		0x00, 0x00, 0x00,
+		params->vht_basic_mcs_1_4_set ?
+			params->vht_basic_mcs_1_4 :
+			le16_get_bits(t_sdata->band_5ghz.vht_cap.vht_mcs.rx_mcs_map, 0xff),
+		params->vht_basic_mcs_5_8_set ?
+			params->vht_basic_mcs_5_8 :
+			le16_get_bits(t_sdata->band_5ghz.vht_cap.vht_mcs.rx_mcs_map, 0xff00),
+		/* HE Capabilities */
+		WLAN_EID_EXTENSION, 0x16, WLAN_EID_EXT_HE_CAPABILITY,
+		0x01, 0x78, 0xc8, 0x1a, 0x40, 0x00, 0x00, 0xbf,
+		0xce, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0xfa, 0xff, 0xfa, 0xff,
+		/* HE Operation (permit overriding values) */
+		WLAN_EID_EXTENSION, 0x07, WLAN_EID_EXT_HE_OPERATION,
+		0xf0, 0x3f, 0x00, 0xb0,
+		params->he_basic_mcs_1_4_set ? params->he_basic_mcs_1_4 : 0xfc,
+		params->he_basic_mcs_5_8_set ? params->he_basic_mcs_5_8 : 0xff,
+		/* EHT Capabilities */
+		WLAN_EID_EXTENSION, 0x12, WLAN_EID_EXT_EHT_CAPABILITY,
+		0x07, 0x00, 0x1c, 0x00, 0x00, 0xfe, 0xff, 0xff,
+		0x7f, 0x01, 0x00, 0x88, 0x88, 0x88, 0x00, 0x00,
+		0x00,
+		/* EHT Operation */
+		WLAN_EID_EXTENSION, 0x09, WLAN_EID_EXT_EHT_OPERATION,
+		0x01, params->eht_mcs7_min_nss ? params->eht_mcs7_min_nss : 0x11,
+		0x00, 0x00, 0x00, 0x00, 0x24, 0x00,
+	};
+	struct ieee80211_chan_req chanreq = {};
+	struct cfg80211_chan_def ap_chandef = {};
+	struct ieee802_11_elems *elems;
+
+	if (params->strict)
+		set_bit(IEEE80211_HW_STRICT, t_sdata->local.hw.flags);
+	else
+		clear_bit(IEEE80211_HW_STRICT, t_sdata->local.hw.flags);
+
+	t_sdata->sdata->u.mgd.ht_capa_mask = params->ht_capa_mask;
+	t_sdata->sdata->u.mgd.vht_capa = params->vht_capa;
+	t_sdata->sdata->u.mgd.vht_capa_mask = params->vht_capa_mask;
+
+	if (params->userspace_selector)
+		set_bit(params->userspace_selector, userspace_selectors);
+
+	rcu_assign_pointer(cbss.ies,
+			   kunit_kzalloc(test,
+					 sizeof(cbss) + sizeof(bss_ies),
+					 GFP_KERNEL));
+	KUNIT_ASSERT_NOT_NULL(test, rcu_access_pointer(cbss.ies));
+	((struct cfg80211_bss_ies *)rcu_access_pointer(cbss.ies))->len = sizeof(bss_ies);
+
+	memcpy((void *)rcu_access_pointer(cbss.ies)->data, bss_ies,
+	       sizeof(bss_ies));
+
+	rcu_read_lock();
+	elems = ieee80211_determine_chan_mode(t_sdata->sdata, &conn, &cbss,
+					      0, &chanreq, &ap_chandef,
+					      userspace_selectors);
+	rcu_read_unlock();
+
+	/* We do not need elems, free them if they are valid. */
+	if (!IS_ERR_OR_NULL(elems))
+		kfree(elems);
+
+	if (params->error) {
+		KUNIT_ASSERT_TRUE(test, IS_ERR(elems));
+		KUNIT_ASSERT_EQ(test, PTR_ERR(elems), -params->error);
+	} else {
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elems);
+		KUNIT_ASSERT_EQ(test, conn.mode, params->expected_mode);
+	}
+}
+
+static struct kunit_case chan_mode_cases[] = {
+	KUNIT_CASE_PARAM(test_determine_chan_mode,
+			 determine_chan_mode_gen_params),
+	{}
+};
+
+static struct kunit_suite chan_mode = {
+	.name = "mac80211-mlme-chan-mode",
+	.test_cases = chan_mode_cases,
+};
+
+kunit_test_suite(chan_mode);
diff --git a/net/mac80211/tests/util.c b/net/mac80211/tests/util.c
index 0936a73e3617..9c2d63a5cd2b 100644
--- a/net/mac80211/tests/util.c
+++ b/net/mac80211/tests/util.c
@@ -266,11 +266,7 @@ int t_sdata_init(struct kunit_resource *resource, void *ctx)
 				cpu_to_le16(IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
 					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 2 |
 					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 4 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 6 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 8 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 10 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 12 |
-					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 14);
+					    IEEE80211_VHT_MCS_SUPPORT_0_9 << 6);
 			sband->vht_cap.vht_mcs.tx_mcs_map =
 				sband->vht_cap.vht_mcs.rx_mcs_map;
 			break;
-- 
2.34.1


