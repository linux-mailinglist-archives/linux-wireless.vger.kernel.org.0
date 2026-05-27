Return-Path: <linux-wireless+bounces-37038-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB/rIOBOF2qaAggAu9opvQ
	(envelope-from <linux-wireless+bounces-37038-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C45E9E9A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34A533084B99
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D576E3B6BFD;
	Wed, 27 May 2026 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WX8ZCu6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975A3B27C4
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912346; cv=none; b=noJ8Br/Ddh3lVM9FfLwpZDh2u5eDo5XM68lx/fvNxoFnempjfAfruM7Hv1qkvczJ0E/GN0YRFlZQnQehZFi1vsXC9NrfTOTXgfOC8304LAecoZg99jYkre8oH3uuJannvBlzJEVa9ndxHyTtnSl454JL7iSwJa10bwH2qcVz1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912346; c=relaxed/simple;
	bh=aDZlPUkblch/Awm58vko9J+FWwWTyHgw9JunVP+COSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXQpCKeeoLihWtjOWZeQF6KWKwlN3KhtS9ihgqUuenafHD8VAUaqRhSjhSE61FUa/JfjE9YKyHUfL/T8Qy3DUSqq+7mZv4BrXhKmvHammfSmlvyOvYnSw49GCCPRqWb/MqMuzJ8D3k7q+Nk8P36NXVwwwM97uDCYdQ2CUZgrgFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WX8ZCu6L; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912346; x=1811448346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDZlPUkblch/Awm58vko9J+FWwWTyHgw9JunVP+COSQ=;
  b=WX8ZCu6LdGhM3MN3TerzjYksC6d2E+lUbkK8hywXFEpY8gSABQGlxQqK
   K+ipaeHfEPRWihnvFWsRJegYKOMppqpU9DBJAWjt1cPqHMIr3fLTwvINX
   IWI9xc+5NWgcT6YNw52VQkPjAtsu90lG5q6H4jUfLDv60R6xrCdlVEgIB
   0015RiVomrT3KVRUrPNIr7E+UQGTwy2TAJPjh3i3Mppv2m7bx+jvPHhEO
   wh498J35meJ8WJE99ZGyYe7Np1lLyhCp3L8vqD9FM4MuCHEwHKmd1x2X2
   fSbZfkAD/c2EEEYMoedHF2gnq0NZPnQGpe5dpAGPbFQZ4wz5W3+WAsSu0
   g==;
X-CSE-ConnectionGUID: IPUkq54DQOmfjQQl6sXbvA==
X-CSE-MsgGUID: AV6W0LoFRaCRFhMuTwYLsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940879"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940879"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:45 -0700
X-CSE-ConnectionGUID: fW+YHaVVTtiirYosEsLFAg==
X-CSE-MsgGUID: 9JXVdAYQQCGugT/w0FQtLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286986"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: add KUnit tests for duplicated beacon RSSI adjustment
Date: Wed, 27 May 2026 23:05:10 +0300
Message-Id: <20260527230313.a3500c44f5e8.Icba6ee1158e9f563a91b482b8cdd3f51ddace468@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
References: <20260527200512.506707-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37038-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1D9C45E9E9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Bhatt <avinash.bhatt@intel.com>

Add KUnit tests to verify RSSI adjustment for 6 GHz duplicated
beacons across different operational bandwidths and validate
detection of the duplicated beacon bit.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   5 +
 .../wireless/intel/iwlwifi/mld/tests/link.c   | 102 +++++++++++++++++-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  60 +++++++++++
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |   7 +-
 5 files changed, 173 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 234821f6a441..98b9c4eef583 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -1024,7 +1024,7 @@ iwl_mld_get_avail_chan_load(struct iwl_mld *mld,
 	return MAX_CHAN_LOAD - iwl_mld_get_chan_load(mld, link_conf);
 }
 
-static s8
+VISIBLE_IF_IWLWIFI_KUNIT s8
 iwl_mld_get_dup_beacon_rssi_adjust(struct iwl_mld *mld,
 				   struct ieee80211_bss_conf *link_conf)
 {
@@ -1077,6 +1077,7 @@ iwl_mld_get_dup_beacon_rssi_adjust(struct iwl_mld *mld,
 		return 0;
 	}
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_get_dup_beacon_rssi_adjust);
 
 static s8 iwl_mld_get_primary_psd(const struct ieee80211_parsed_tpe_psd *psd,
 				  const struct cfg80211_chan_def *chandef,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index f1997e280058..d0aa577de81d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -142,6 +142,11 @@ int iwl_mld_link_set_associated(struct iwl_mld *mld, struct ieee80211_vif *vif,
 unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 				    struct ieee80211_bss_conf *link_conf);
 
+#if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
+s8 iwl_mld_get_dup_beacon_rssi_adjust(struct iwl_mld *mld,
+				      struct ieee80211_bss_conf *link_conf);
+#endif
+
 unsigned int iwl_mld_get_chan_load(struct iwl_mld *mld,
 				   struct ieee80211_bss_conf *link_conf);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
index 69a0d67858bf..21bcc341cd7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * KUnit tests for channel helper functions
+ * KUnit tests for link helper functions
  *
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <kunit/static_stub.h>
 
@@ -96,8 +96,106 @@ static void test_missed_beacon(struct kunit *test)
 	/* TODO: add test cases for esr and check */
 }
 
+struct dup_beacon_test_case {
+	const char *desc;
+	enum nl80211_chan_width bandwidth;
+	bool has_he_oper;
+	bool dup_beacon_bit;
+	s8 expected_adj;
+};
+
+static const struct dup_beacon_test_case dup_beacon_cases[] = {
+	{
+		.desc = "20 MHz - no duplication",
+		.bandwidth = NL80211_CHAN_WIDTH_20,
+		.has_he_oper = true,
+		.dup_beacon_bit = true,
+		.expected_adj = 0,
+	},
+	{
+		.desc = "40 MHz with duplication - 3 dB",
+		.bandwidth = NL80211_CHAN_WIDTH_40,
+		.has_he_oper = true,
+		.dup_beacon_bit = true,
+		.expected_adj = 3,
+	},
+	{
+		.desc = "80 MHz with duplication - 6 dB",
+		.bandwidth = NL80211_CHAN_WIDTH_80,
+		.has_he_oper = true,
+		.dup_beacon_bit = true,
+		.expected_adj = 6,
+	},
+	{
+		.desc = "160 MHz with duplication - 9 dB",
+		.bandwidth = NL80211_CHAN_WIDTH_160,
+		.has_he_oper = true,
+		.dup_beacon_bit = true,
+		.expected_adj = 9,
+	},
+	{
+		.desc = "320 MHz with duplication - 12 dB",
+		.bandwidth = NL80211_CHAN_WIDTH_320,
+		.has_he_oper = true,
+		.dup_beacon_bit = true,
+		.expected_adj = 12,
+	},
+	{
+		.desc = "80 MHz without dup bit - no adjustment",
+		.bandwidth = NL80211_CHAN_WIDTH_80,
+		.has_he_oper = true,
+		.dup_beacon_bit = false,
+		.expected_adj = 0,
+	},
+	{
+		.desc = "80 MHz without HE oper - no adjustment",
+		.bandwidth = NL80211_CHAN_WIDTH_80,
+		.has_he_oper = false,
+		.dup_beacon_bit = true,
+		.expected_adj = 0,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(test_dup_beacon_rssi_adjust, dup_beacon_cases, desc);
+
+static void test_dup_beacon_rssi_adjust(struct kunit *test)
+{
+	const struct dup_beacon_test_case *params = test->param_value;
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_bss *bss;
+	struct element *he_elem = NULL;
+	s8 result;
+
+	KUNIT_ALLOC_AND_ASSERT(test, link_conf);
+	KUNIT_ALLOC_AND_ASSERT(test, bss);
+	link_conf->bss = bss;
+
+	link_conf->chanreq.oper.chan = &chan_6ghz;
+	link_conf->chanreq.oper.width = params->bandwidth;
+
+	if (params->has_he_oper) {
+		struct ieee80211_he_6ghz_oper he_6ghz = {};
+
+		if (params->dup_beacon_bit)
+			he_6ghz.control =
+				IEEE80211_HE_6GHZ_OPER_CTRL_DUP_BEACON;
+		he_elem = iwlmld_kunit_create_he_6ghz_oper(he_6ghz);
+	}
+
+	rcu_assign_pointer(bss->beacon_ies,
+			   iwlmld_kunit_create_bss_ies(he_elem));
+
+	guard(wiphy)(mld->wiphy);
+	result = iwl_mld_get_dup_beacon_rssi_adjust(mld, link_conf);
+
+	KUNIT_EXPECT_EQ(test, result, params->expected_adj);
+}
+
 static struct kunit_case link_cases[] = {
 	KUNIT_CASE_PARAM(test_missed_beacon, test_missed_beacon_gen_params),
+	KUNIT_CASE_PARAM(test_dup_beacon_rssi_adjust,
+			 test_dup_beacon_rssi_adjust_gen_params),
 	{},
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index cb1968b07452..fdeab7082e78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -439,6 +439,66 @@ struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(struct iwl_mld_kunit_link *link1,
 	return vif;
 }
 
+struct element *
+iwlmld_kunit_create_he_6ghz_oper(struct ieee80211_he_6ghz_oper he_6ghz)
+{
+	struct kunit *test = kunit_get_current_test();
+	u8 *data;
+	size_t data_len;
+	size_t offset = 0;
+	__le32 he_oper_params;
+	__le16 he_mcs_nss_set = 0;
+
+	/* Build HE Operation IE with 6 GHz info using raw buffer.
+	 * Cannot use struct embedding because ieee80211_he_operation
+	 * has a flexible array member (optional[]).
+	 *
+	 * Layout:
+	 *   1 byte:         ext_id (WLAN_EID_EXT_HE_OPERATION)
+	 *   he_oper_params: he_oper_params (from ieee80211_he_operation)
+	 *   he_mcs_nss_set: he_mcs_nss_set (from ieee80211_he_operation)
+	 *   he_6ghz:        ieee80211_he_6ghz_oper (goes into optional[])
+	 */
+	data_len = 1 + sizeof(he_oper_params) + sizeof(he_mcs_nss_set) +
+		   sizeof(struct ieee80211_he_6ghz_oper);
+
+	data = kunit_kzalloc(test, data_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, data);
+
+	data[offset++] = WLAN_EID_EXT_HE_OPERATION;
+
+	he_oper_params = cpu_to_le32(IEEE80211_HE_OPERATION_6GHZ_OP_INFO);
+	memcpy(&data[offset], &he_oper_params, sizeof(he_oper_params));
+	offset += sizeof(he_oper_params);
+
+	memcpy(&data[offset], &he_mcs_nss_set, sizeof(he_mcs_nss_set));
+	offset += sizeof(he_mcs_nss_set);
+
+	memcpy(&data[offset], &he_6ghz, sizeof(he_6ghz));
+
+	return iwlmld_kunit_gen_element(WLAN_EID_EXTENSION, data, data_len);
+}
+
+struct cfg80211_bss_ies *iwlmld_kunit_create_bss_ies(struct element *elem)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct cfg80211_bss_ies *ies;
+	size_t ies_len = 0;
+
+	if (elem)
+		ies_len = sizeof(*elem) + elem->datalen;
+
+	ies = kunit_kzalloc(test, sizeof(*ies) + ies_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ies);
+
+	ies->len = ies_len;
+
+	if (elem)
+		memcpy(ies->data, elem, ies_len);
+
+	return ies;
+}
+
 struct element *iwlmld_kunit_gen_element(u8 id, const void *data, size_t len)
 {
 	struct kunit *test = kunit_get_current_test();
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
index edf8eef4e81a..cfed5acaac3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #ifndef __iwl_mld_kunit_utils_h__
@@ -121,6 +121,11 @@ iwlmld_kunit_assoc_emlsr(struct iwl_mld_kunit_link *link1,
 
 struct element *iwlmld_kunit_gen_element(u8 id, const void *data, size_t len);
 
+struct element *
+iwlmld_kunit_create_he_6ghz_oper(struct ieee80211_he_6ghz_oper he_6ghz);
+
+struct cfg80211_bss_ies *iwlmld_kunit_create_bss_ies(struct element *elem);
+
 /**
  * iwlmld_kunit_get_phy_of_link - Get the phy of a link
  *
-- 
2.34.1


