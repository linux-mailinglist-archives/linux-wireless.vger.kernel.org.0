Return-Path: <linux-wireless+bounces-37204-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBs9HTsTHGraJQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37204-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E7615A9D
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 12:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D31E93004628
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2026 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FBF376A08;
	Sun, 31 May 2026 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBIVsBdp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65834376A02
	for <linux-wireless@vger.kernel.org>; Sun, 31 May 2026 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224815; cv=none; b=cM3UrqMouLwEzEjvj18ApVnw2C4gBh2kR5JcclQ+1eWUiAgw/1jJSJuorJiuGfWYjKdYDKuHWLskUc7ZV/RBwW4bYgEypnowtqZU1EPE4QXI8Wdaf1UK9aycRt4a7AldfJjZ6aiMfV9wJ9KgqFhzfEyjtm/c3kuc6z9MjQ7aUKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224815; c=relaxed/simple;
	bh=L4Pn/NonnhF9EB5FvUKucEG9Sx3xUjjjPQwthuaR5Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHO/FxJUDJt0E5O9V7n0hzNgp5VfP9CxVHgCIbG+j7Nnv3nyI51ZW+Oy+8s9qScIFCGXLvBDwmyM/ynNkYzttcqXMXK+5DrYAfVPpu5oZHdZ4amBmfarLdLmZh/wP0nZZfLAonEQOpSmmZuT+gl8DXAJjttsMaC6VGgTxuqfMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBIVsBdp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780224813; x=1811760813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L4Pn/NonnhF9EB5FvUKucEG9Sx3xUjjjPQwthuaR5Ak=;
  b=nBIVsBdpfGOap1iq+E8KHv3Qwj3Ip9RNDRLCCZ+QkTDO5iHxALXW2WSX
   PJ+Z5JlGBLpMES6vCEidk6y4hO6klkqNreINLSfSjizM5Oc8ZSubgzXsr
   J5EP6X5EoeI7EIxmV0OJhsSH69twJWlZnnVXkmzf6Ys9UWBBKhGcaod+V
   VJf5l6E3mPBaaehw+IzOjjJsMDxKeGXJE8ZtL21iqh3jsjbTSab6q8wbS
   j43FwEgMt+NcDQB8QZDk6zcnwomVbwhTFNIN2Mt6fqKpGQasHsMgcflum
   dr2e2p9j4TBa4M3EKXT9wokHk0yttamrR8BCEJVytt9rI/bJSYMnx4S5F
   A==;
X-CSE-ConnectionGUID: mNm8zEPeTtSXJprLkH7v1Q==
X-CSE-MsgGUID: RQOrC7UFR/qlWJjzw7b6sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80039669"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80039669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:33 -0700
X-CSE-ConnectionGUID: Tj9wBpI5SOisiYZnZh5iQA==
X-CSE-MsgGUID: lLV3ZY2lQvODeMLZTxYoXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="240296013"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 03:53:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH wireless-next 08/10] wifi: iwlwifi: mld: add KUnit tests for PSD/EIRP RSSI adjustment
Date: Sun, 31 May 2026 13:53:07 +0300
Message-Id: <20260531135036.a18b8d0acd62.I68dfcc17359ab8a5abdc84e1e21db4ad1671af41@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37204-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7D8E7615A9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avinash Bhatt <avinash.bhatt@intel.com>

Add tests for PSD/EIRP RSSI adjustment which compensates measurements
when APs use PSD-based power scaling with bandwidth.

Tests cover all power types, bandwidths, and limiting scenarios.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   1 +
 .../wireless/intel/iwlwifi/mld/tests/link.c   | 372 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |   2 +
 4 files changed, 378 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 98b9c4eef583..2b8b0196692e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -1098,7 +1098,8 @@ static s8 iwl_mld_get_primary_psd(const struct ieee80211_parsed_tpe_psd *psd,
 	return psd->power[primary_idx] / 2;
 }
 
-static s8 iwl_mld_get_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf)
+VISIBLE_IF_IWLWIFI_KUNIT s8
+iwl_mld_get_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf)
 {
 	const struct ieee80211_parsed_tpe *tpe = &link_conf->tpe;
 	s8 psd_20mhz, psd_oper, psd_local, psd_reg, psd_boost;
@@ -1217,6 +1218,7 @@ static s8 iwl_mld_get_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf)
 
 	return adjustment;
 }
+EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_get_psd_eirp_rssi_adjust);
 
 /* This function calculates the grade of a link. Returns 0 in error case */
 unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index d0aa577de81d..7b56819d45fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -145,6 +145,7 @@ unsigned int iwl_mld_get_link_grade(struct iwl_mld *mld,
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
 s8 iwl_mld_get_dup_beacon_rssi_adjust(struct iwl_mld *mld,
 				      struct ieee80211_bss_conf *link_conf);
+s8 iwl_mld_get_psd_eirp_rssi_adjust(struct ieee80211_bss_conf *link_conf);
 #endif
 
 unsigned int iwl_mld_get_chan_load(struct iwl_mld *mld,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
index 21bcc341cd7d..a4e5f2be499f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/link.c
@@ -158,6 +158,354 @@ static const struct dup_beacon_test_case dup_beacon_cases[] = {
 
 KUNIT_ARRAY_PARAM_DESC(test_dup_beacon_rssi_adjust, dup_beacon_cases, desc);
 
+struct psd_eirp_test_case {
+	const char *desc;
+	const struct cfg80211_chan_def *chandef;
+	enum ieee80211_ap_reg_power power_type;
+	struct {
+		s8 psd_20;
+		s8 psd_oper;
+		s8 eirp_20;
+		s8 eirp_oper;
+	} local, reg;
+	s8 expected_adj;
+	struct {
+		bool no_psd_data;
+		bool no_eirp_data;
+		bool no_reg_psd_data;
+		bool has_partial_psd;
+		u8 psd_partial_count;
+		bool non_uniform_psd;
+		bool has_unusable_channels;
+	} flags;
+};
+
+static const struct psd_eirp_test_case psd_eirp_cases[] = {
+	{
+		.desc = "20 MHz VLP baseline - no boost expected",
+		.chandef = &chandef_6ghz_20mhz,
+		.power_type = IEEE80211_REG_VLP_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 40,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 40,
+		},
+		.expected_adj = 0,
+	},
+	{
+		.desc = "40 MHz VLP - power limit prevents boost",
+		.chandef = &chandef_6ghz_40mhz,
+		.power_type = IEEE80211_REG_VLP_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 46,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 46,
+		},
+		.expected_adj = 0,
+	},
+	{
+		.desc = "80 MHz LPI - power limit caps the boost",
+		.chandef = &chandef_6ghz_80mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.expected_adj = 3,
+	},
+	{
+		.desc = "160 MHz LPI - power limit caps the boost",
+		.chandef = &chandef_6ghz_160mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 58,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 58,
+		},
+		.expected_adj = 3,
+	},
+	{
+		.desc = "320 MHz SP - power limit caps the boost",
+		.chandef = &chandef_6ghz_320mhz_pri0,
+		.power_type = IEEE80211_REG_SP_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 63,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 63,
+		},
+		.expected_adj = 3,
+	},
+	{
+		.desc = "80 MHz - EIRP prevents boost",
+		.chandef = &chandef_6ghz_80mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 20,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 20,
+		},
+		.expected_adj = 0,
+	},
+	{
+		.desc = "40 MHz - regulatory TPE sets lower limits",
+		.chandef = &chandef_6ghz_40mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 30, .psd_oper = 30,
+			.eirp_20 = 50, .eirp_oper = 56,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 46,
+		},
+		.expected_adj = 3,
+	},
+	{
+		.desc = "80 MHz - PSD missing, use EIRP only",
+		.chandef = &chandef_6ghz_80mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = S8_MAX, .psd_oper = S8_MAX,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.reg = {
+			.psd_20 = S8_MAX, .psd_oper = S8_MAX,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.expected_adj = 0,
+		.flags.no_psd_data = true,
+	},
+	{
+		.desc = "80 MHz - single PSD source available",
+		.chandef = &chandef_6ghz_80mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.expected_adj = 3,
+		.flags.no_reg_psd_data = true,
+	},
+	{
+		.desc = "80 MHz - partial PSD data present",
+		.chandef = &chandef_6ghz_80mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 24, .psd_oper = 24,
+			.eirp_20 = 40, .eirp_oper = 56,
+		},
+		.reg = {
+			.psd_20 = 24, .psd_oper = 24,
+			.eirp_20 = 40, .eirp_oper = 56,
+		},
+		.expected_adj = 0,
+		.flags.has_partial_psd = true,
+		.flags.psd_partial_count = 2,
+	},
+	{
+		.desc = "160 MHz - different PSD per sub-channel",
+		.chandef = &chandef_6ghz_160mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 8, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 58,
+		},
+		.reg = {
+			.psd_20 = 8, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 58,
+		},
+		.expected_adj = 11,
+		.flags.non_uniform_psd = true,
+	},
+	{
+		.desc = "80 MHz - EIRP missing, use PSD only",
+		.chandef = &chandef_6ghz_80mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = S8_MAX, .eirp_oper = S8_MAX,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = S8_MAX, .eirp_oper = S8_MAX,
+		},
+		.expected_adj = 3,
+		.flags.no_eirp_data = true,
+	},
+	{
+		.desc = "80 MHz - skip unusable channels in average",
+		.chandef = &chandef_6ghz_80mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 52,
+		},
+		.expected_adj = 3,
+		.flags.has_unusable_channels = true,
+	},
+	{
+		.desc = "40 MHz - no negative adjustment",
+		.chandef = &chandef_6ghz_40mhz,
+		.power_type = IEEE80211_REG_LPI_AP,
+		.local = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 18,
+		},
+		.reg = {
+			.psd_20 = 20, .psd_oper = 20,
+			.eirp_20 = 40, .eirp_oper = 18,
+		},
+		.expected_adj = 0,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(test_psd_eirp_rssi_adjust, psd_eirp_cases, desc);
+
+static void setup_psd(struct ieee80211_bss_conf *link_conf,
+		      const struct psd_eirp_test_case *params,
+		      int num_subchannels)
+{
+	int i;
+
+	if (params->flags.no_psd_data) {
+		link_conf->tpe.psd_local[0].valid = false;
+		link_conf->tpe.psd_reg_client[0].valid = false;
+		link_conf->tpe.psd_local[0].count = 0;
+		link_conf->tpe.psd_reg_client[0].count = 0;
+	} else if (params->flags.no_reg_psd_data) {
+		link_conf->tpe.psd_local[0].valid = true;
+		link_conf->tpe.psd_local[0].count = num_subchannels;
+		link_conf->tpe.psd_reg_client[0].valid = false;
+		link_conf->tpe.psd_reg_client[0].count = 0;
+	} else if (params->flags.has_partial_psd) {
+		link_conf->tpe.psd_local[0].valid = true;
+		link_conf->tpe.psd_local[0].count =
+			params->flags.psd_partial_count;
+		link_conf->tpe.psd_reg_client[0].valid = true;
+		link_conf->tpe.psd_reg_client[0].count =
+			params->flags.psd_partial_count;
+	} else {
+		link_conf->tpe.psd_local[0].valid = true;
+		link_conf->tpe.psd_local[0].count = num_subchannels;
+		link_conf->tpe.psd_reg_client[0].valid = true;
+		link_conf->tpe.psd_reg_client[0].count = num_subchannels;
+	}
+
+	/* TPE element stores PSD limit as value * 2 */
+	if (params->flags.non_uniform_psd) {
+		/* PSD varies per sub-channel: 10/12/10/8 dBm pattern */
+		static const s8 psd_values[] = {20, 24, 20, 16, 20, 24, 20, 16,
+						20, 24, 20, 16, 20, 24, 20};
+		/* Set primary channel (index 0) explicitly */
+		link_conf->tpe.psd_local[0].power[0] =
+			params->local.psd_20 * 2;
+		link_conf->tpe.psd_reg_client[0].power[0] =
+			params->reg.psd_20 * 2;
+		/* Set remaining subchannels with pattern */
+		for (i = 1; i < num_subchannels; i++) {
+			link_conf->tpe.psd_local[0].power[i] =
+				psd_values[i - 1];
+			link_conf->tpe.psd_reg_client[0].power[i] =
+				psd_values[i - 1];
+		}
+	} else if (params->flags.no_psd_data) {
+		for (i = 0; i < num_subchannels; i++) {
+			link_conf->tpe.psd_local[0].power[i] = S8_MAX;
+			link_conf->tpe.psd_reg_client[0].power[i] = S8_MAX;
+		}
+	} else if (params->flags.has_unusable_channels) {
+		/* Alternate usable/unusable channels for S8_MIN test */
+		/* Set primary channel (index 0) explicitly */
+		link_conf->tpe.psd_local[0].power[0] =
+			params->local.psd_20 * 2;
+		link_conf->tpe.psd_reg_client[0].power[0] =
+			params->reg.psd_20 * 2;
+		/* Alternate usable/unusable for remaining subchannels */
+		for (i = 1; i < num_subchannels; i++) {
+			if (i % 2 == 0) {
+				link_conf->tpe.psd_local[0].power[i] =
+					params->local.psd_oper * 2;
+				link_conf->tpe.psd_reg_client[0].power[i] =
+					params->reg.psd_oper * 2;
+			} else {
+				link_conf->tpe.psd_local[0].power[i] = S8_MIN;
+				link_conf->tpe.psd_reg_client[0].power[i] =
+					S8_MIN;
+			}
+		}
+	} else {
+		/* Set primary channel (index 0) separately */
+		link_conf->tpe.psd_local[0].power[0] =
+			params->local.psd_20 * 2;
+		link_conf->tpe.psd_reg_client[0].power[0] =
+			params->reg.psd_20 * 2;
+		/* Set remaining subchannels */
+		for (i = 1; i < num_subchannels; i++) {
+			link_conf->tpe.psd_local[0].power[i] =
+				params->local.psd_oper * 2;
+			link_conf->tpe.psd_reg_client[0].power[i] =
+				params->reg.psd_oper * 2;
+		}
+	}
+}
+
+static void setup_eirp(struct ieee80211_bss_conf *link_conf,
+		       const struct psd_eirp_test_case *params,
+		       int num_subchannels)
+{
+	int i;
+	int count = ilog2(num_subchannels) + 1;
+
+	link_conf->tpe.max_local[0].valid = !params->flags.no_eirp_data;
+	link_conf->tpe.max_reg_client[0].valid = !params->flags.no_eirp_data;
+
+	if (params->flags.no_eirp_data) {
+		link_conf->tpe.max_local[0].count = 0;
+		link_conf->tpe.max_reg_client[0].count = 0;
+		return;
+	}
+
+	link_conf->tpe.max_local[0].count = count;
+	link_conf->tpe.max_reg_client[0].count = count;
+
+	/* TPE element stores EIRP limit as value * 2 */
+	link_conf->tpe.max_local[0].power[0] = params->local.eirp_20 * 2;
+	link_conf->tpe.max_reg_client[0].power[0] = params->reg.eirp_20 * 2;
+	for (i = 1; i < count; i++) {
+		link_conf->tpe.max_local[0].power[i] =
+			params->local.eirp_oper * 2;
+		link_conf->tpe.max_reg_client[0].power[i] =
+			params->reg.eirp_oper * 2;
+	}
+}
+
 static void test_dup_beacon_rssi_adjust(struct kunit *test)
 {
 	const struct dup_beacon_test_case *params = test->param_value;
@@ -192,10 +540,34 @@ static void test_dup_beacon_rssi_adjust(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, result, params->expected_adj);
 }
 
+static void test_psd_eirp_rssi_adjust(struct kunit *test)
+{
+	const struct psd_eirp_test_case *params = test->param_value;
+	struct ieee80211_bss_conf *link_conf;
+	int num_subchannels;
+	s8 result;
+
+	KUNIT_ALLOC_AND_ASSERT(test, link_conf);
+
+	link_conf->power_type = params->power_type;
+	link_conf->chanreq.oper = *params->chandef;
+	num_subchannels =
+		nl80211_chan_width_to_mhz(params->chandef->width) / 20;
+
+	setup_psd(link_conf, params, num_subchannels);
+	setup_eirp(link_conf, params, num_subchannels);
+
+	result = iwl_mld_get_psd_eirp_rssi_adjust(link_conf);
+
+	KUNIT_EXPECT_EQ(test, result, params->expected_adj);
+}
+
 static struct kunit_case link_cases[] = {
 	KUNIT_CASE_PARAM(test_missed_beacon, test_missed_beacon_gen_params),
 	KUNIT_CASE_PARAM(test_dup_beacon_rssi_adjust,
 			 test_dup_beacon_rssi_adjust_gen_params),
+	KUNIT_CASE_PARAM(test_psd_eirp_rssi_adjust,
+			 test_psd_eirp_rssi_adjust_gen_params),
 	{},
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
index cfed5acaac3a..7cc8cb6eedd6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
@@ -77,6 +77,8 @@ CHANNEL(chan_6ghz_221, NL80211_BAND_6GHZ, 7055);
 		NL80211_CHAN_WIDTH_160)				\
 	CHANDEF(chandef_6ghz_320mhz, chan_6ghz, 6105,		\
 		NL80211_CHAN_WIDTH_320)				\
+	CHANDEF(chandef_6ghz_320mhz_pri0, chan_6ghz, 6265,	\
+		NL80211_CHAN_WIDTH_320)				\
 	CHANDEF(chandef_6ghz_221_160mhz, chan_6ghz_221, 6985,	\
 		NL80211_CHAN_WIDTH_160)				\
 	/* Feel free to add more */
-- 
2.34.1


