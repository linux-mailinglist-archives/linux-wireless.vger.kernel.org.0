Return-Path: <linux-wireless+bounces-37032-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBzlKpxOF2qaAggAu9opvQ
	(envelope-from <linux-wireless+bounces-37032-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431C5E9E38
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 22:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F15C4305E65D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E589D3B19D0;
	Wed, 27 May 2026 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6p/dPNK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E988A3B4EA1
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779912338; cv=none; b=OeJ3RCVBi0zrV6XT5byu5yqEmDHQwzY+PmjCZjpq+ziNtht6ub5LPLrm+1ANuhUkUBuQ2ytQFrK8gYo/ArU/ut8UIhA7HdyAJYmerIMfrSjAQ+WhAm6pfXi+gt02d74DDKU+XImcHhufHWlaGZhd+dnaexlOhXXaHxoasCWkxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779912338; c=relaxed/simple;
	bh=AgIUsg6UHrDxuj+8U2UaLkH3yN8NQFSAGO3qmQ68ej0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JE7IOZb7Xlu65MFLGsGwRLQxBuPb0wss3XlT3nSQVMM0mFLNlwshTH7RSlsTpBPPDb+bYLhqQUWz+CotrGQu++jCiK6UWbJOIki+g+YeOxikcYPoBq9AhPGcumjGvZZt4br3DP0TaOEwZwxgYMteCYA3S6Sd6NIuLkVszvTQSyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6p/dPNK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779912338; x=1811448338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AgIUsg6UHrDxuj+8U2UaLkH3yN8NQFSAGO3qmQ68ej0=;
  b=B6p/dPNKTglAsayXppcXX+k9EZ5u+pTPztbazSd5JD8hFvkf5C8OB3cv
   l3wKcijYHZDlAWDrBXf+MuDBuygzhzoFbFmJ6VUUtacT3uXMYKHqeENdL
   F5ci+oJ3nvF5tjDbv5X47gMUDPdSckxZeRbtEP6GN9SR0e2GtZs8elunm
   DOkUDNuv+jSWQINUk23+FJjvrBWv317hOhXhrtKoUaIFZovzlCIJHV1ss
   h7HPEEGfjyNPTFHGH6XouTNNU4LXz3SPOgckI+CqI6H1yJ7mILM11ehBX
   P83T5myN5w6NyRXpRNat58BtfyZUOA95380NziJX08I8QGHgW8iFKVI32
   g==;
X-CSE-ConnectionGUID: n7VFNdACRK6XA5u4dlVpqA==
X-CSE-MsgGUID: qgTxBPDYSNWonU2tfTgFgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80940868"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80940868"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:37 -0700
X-CSE-ConnectionGUID: zJUm3xenSt+t6E47oyg+RA==
X-CSE-MsgGUID: kcx94wYxRFCITfMZvFJEtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="247286963"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:05:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: move iwl_fw_rate_idx_to_plcp() to mvm
Date: Wed, 27 May 2026 23:05:04 +0300
Message-Id: <20260527230313.87769f13c7d7.I3875d768694b9484317a3253f479a2a2100244f4@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37032-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5431C5E9E38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

It's only needed by mvm, so there's no need to have it in
iwlwifi and export it, just move it to mvm itself.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 27 -----------------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 +
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 30 +++++++++++++++++--
 5 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index ae6be3ed32f8..f90e743caa7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022, 2024-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022, 2024-2026 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_rs_h__
@@ -889,7 +889,6 @@ struct iwl_lq_cmd {
 	__le32 ss_params;
 }; /* LINK_QUALITY_CMD_API_S_VER_1 */
 
-u8 iwl_fw_rate_idx_to_plcp(int idx);
 const struct iwl_rate_mcs_info *iwl_rate_mcs(int idx);
 const char *iwl_rs_pretty_ant(u8 ant);
 const char *iwl_rs_pretty_bw(int bw);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index 2aa300b26158..ccdd6856572b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -8,27 +8,6 @@
 #include "iwl-drv.h"
 #include "iwl-config.h"
 
-#define IWL_DECLARE_RATE_INFO(r) \
-	[IWL_RATE_##r##M_INDEX] = IWL_RATE_##r##M_PLCP
-
-/*
- * Translate from fw_rate_index (IWL_RATE_XXM_INDEX) to PLCP
- * */
-static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
-	IWL_DECLARE_RATE_INFO(1),
-	IWL_DECLARE_RATE_INFO(2),
-	IWL_DECLARE_RATE_INFO(5),
-	IWL_DECLARE_RATE_INFO(11),
-	IWL_DECLARE_RATE_INFO(6),
-	IWL_DECLARE_RATE_INFO(9),
-	IWL_DECLARE_RATE_INFO(12),
-	IWL_DECLARE_RATE_INFO(18),
-	IWL_DECLARE_RATE_INFO(24),
-	IWL_DECLARE_RATE_INFO(36),
-	IWL_DECLARE_RATE_INFO(48),
-	IWL_DECLARE_RATE_INFO(54),
-};
-
 /* mbps, mcs */
 static const struct iwl_rate_mcs_info rate_mcs[IWL_RATE_COUNT] = {
 	{  "1", "BPSK DSSS"},
@@ -61,12 +40,6 @@ static const char * const pretty_bw[] = {
 	"320Mhz",
 };
 
-u8 iwl_fw_rate_idx_to_plcp(int idx)
-{
-	return fw_rate_idx_to_plcp[idx];
-}
-IWL_EXPORT_SYMBOL(iwl_fw_rate_idx_to_plcp);
-
 const struct iwl_rate_mcs_info *iwl_rate_mcs(int idx)
 {
 	return &rate_mcs[idx];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 3e5084d10a60..d6a8624b1ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -937,7 +937,7 @@ u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 	if (iwl_fw_lookup_cmd_ver(fw, TX_CMD, 0) > 8)
 		flags |= iwl_mvm_rate_idx_to_fw_idx(fw, rate_idx);
 	else
-		flags |= iwl_fw_rate_idx_to_plcp(rate_idx);
+		flags |= iwl_mvm_rate_idx_to_plcp(rate_idx);
 
 	return flags;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 393acf5c5f55..e09b63516230 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1646,6 +1646,7 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm);
 int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm);
 
 /* Utils */
+u8 iwl_mvm_rate_idx_to_plcp(int idx);
 int iwl_mvm_legacy_hw_idx_to_mac80211_idx(u32 rate_n_flags,
 					  enum nl80211_band band);
 int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 8aba9768afcf..2e12f93ad32b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -14,6 +14,30 @@
 #include "fw/api/rs.h"
 #include "fw/img.h"
 
+#define IWL_DECLARE_RATE_INFO(r) \
+	[IWL_RATE_##r##M_INDEX] = IWL_RATE_##r##M_PLCP
+
+/* Translate from fw_rate_index (IWL_RATE_XXM_INDEX) to PLCP */
+static const u8 fw_rate_idx_to_plcp[IWL_RATE_COUNT] = {
+	IWL_DECLARE_RATE_INFO(1),
+	IWL_DECLARE_RATE_INFO(2),
+	IWL_DECLARE_RATE_INFO(5),
+	IWL_DECLARE_RATE_INFO(11),
+	IWL_DECLARE_RATE_INFO(6),
+	IWL_DECLARE_RATE_INFO(9),
+	IWL_DECLARE_RATE_INFO(12),
+	IWL_DECLARE_RATE_INFO(18),
+	IWL_DECLARE_RATE_INFO(24),
+	IWL_DECLARE_RATE_INFO(36),
+	IWL_DECLARE_RATE_INFO(48),
+	IWL_DECLARE_RATE_INFO(54),
+};
+
+u8 iwl_mvm_rate_idx_to_plcp(int idx)
+{
+	return fw_rate_idx_to_plcp[idx];
+}
+
 /*
  * Will return 0 even if the cmd failed when RFKILL is asserted unless
  * CMD_WANT_SKB is set in cmd->flags.
@@ -151,7 +175,7 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 	if (band != NL80211_BAND_2GHZ)
 		band_offset = IWL_FIRST_OFDM_RATE;
 	for (idx = band_offset; idx < IWL_RATE_COUNT_LEGACY; idx++)
-		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
+		if (iwl_mvm_rate_idx_to_plcp(idx) == rate)
 			return idx - band_offset;
 
 	return -1;
@@ -1243,7 +1267,7 @@ static u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
 	int last = ofdm ? IWL_RATE_COUNT_LEGACY : IWL_FIRST_OFDM_RATE;
 
 	for (idx = offset; idx < last; idx++)
-		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
+		if (iwl_mvm_rate_idx_to_plcp(idx) == rate)
 			return idx - offset;
 	return IWL_RATE_INVALID;
 }
@@ -1353,7 +1377,7 @@ __le32 iwl_mvm_v3_rate_to_fw(u32 rate, u8 rate_ver)
 		rate_idx = u32_get_bits(rate, RATE_LEGACY_RATE_MSK);
 		if (!(result & RATE_MCS_CCK_MSK_V1))
 			rate_idx += IWL_FIRST_OFDM_RATE;
-		result |= u32_encode_bits(iwl_fw_rate_idx_to_plcp(rate_idx),
+		result |= u32_encode_bits(iwl_mvm_rate_idx_to_plcp(rate_idx),
 					  RATE_LEGACY_RATE_MSK_V1);
 		break;
 	case RATE_MCS_MOD_TYPE_HT:
-- 
2.34.1


