Return-Path: <linux-wireless+bounces-36488-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLNbBqsaB2rnrgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36488-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:07:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C4155031D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD969313F352
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A61448033A;
	Fri, 15 May 2026 12:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeOGZWRh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EBE47DF89;
	Fri, 15 May 2026 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847321; cv=none; b=O5V0778lKh6kWtvvFBndZ3NmhLlWj7O75QGh5zMQnWM4FCcVjeLaVjt8sZ0vk23Ht2GhT3cZ5c9rsKxNLaHcCZ9UA+5SwkhIoxmD5KKulzilnDXYqJYsyOYcVrwZlta7Hh6jnm/8rs5plINoR6vAySiqFCmo2RkT0jqMfr9QovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847321; c=relaxed/simple;
	bh=9yhMYisN2YqM32BkXc93nnuhe6Q3/sEfeDeDR0iYjOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oMU27k0O/x5qR2UpaN1bDAqmVnyMfbc5AmoLun0EWh+hTx5rFODeVfyvc6jJQi5h2E+fqUmnLumv1UncbvvCbpYmS8bf5LKTnT4VpWnoFVPxKpew2JVDnpuknfJ1TDZ6NcyGf+6a/oZKcDiaMRQulhITraDvgKGeoAuOuYKSTmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeOGZWRh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847318; x=1810383318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9yhMYisN2YqM32BkXc93nnuhe6Q3/sEfeDeDR0iYjOk=;
  b=ZeOGZWRhq6/3TW5K0hozGoWuQWZjD8kRm3Qzuj1BBE+O0NknUxdGKVzF
   OIImhLe9gayCFiopNtblf0HqdohUvlXAC3CLI3ufxUaW2Pq/HPpnwP5s3
   O7gOqKBsAGMiqYgIJA0eiqiYWcrqKVy6MeJgsC44kQyyIHO/exVgJjj6s
   fdzdJ7eVYEsrEc5uiafGYvFaE4FD4Ll7KTjIKlCmaIesESl2nS2QA/RXH
   LP7DOlpB35ERvctY+q3zBRx742IAp2HYdOFPReU/6sA8pJUHNnp9wc+bi
   ytPkITXyUqHsHShqoP1zCplDHETgHddUMZya0VzzlNNJAi6MmX6YqBxl8
   g==;
X-CSE-ConnectionGUID: RPOREEUySHCHxWg0As1nMA==
X-CSE-MsgGUID: 09I3CPC7TwOsXFzvD9BQ4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79657844"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79657844"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:17 -0700
X-CSE-ConnectionGUID: GpuZHwg/Q4eqP8bHjszaTg==
X-CSE-MsgGUID: Xcmm30ydRQOjf4/jjBs4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="262201049"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:15:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwlwifi-fixes 2/5] wifi: iwlwifi: mvm: fix driver-set TX rates on old devices
Date: Fri, 15 May 2026 15:14:57 +0300
Message-Id: <20260515151351.7407e293dff7.I4ea1a17f8fe99c933d3f3e30d077cf4246125c3e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
References: <20260515121500.1170852-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 12C4155031D
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36488-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

On old devices such as 7265D, rates are still encoded in version 1
format, which doesn't use the CCK/OFDM rate index (0-3/0-7) but
rather their PLCP value (e.g. 10 for 1 Mbps CCK rate.)

While introducing v3 rates, I changed the driver from internally
handling v1 rates and converting to v2, to internally handling v3
and converting to v1 or v2 according to the firmware. I accordingly
changed the code in iwl_mvm_mac80211_idx_to_hwrate() to no longer
have different values for different APIs. This was correct.

However, I later reverted this part of the change, because it was
reported that I had broken beacon rates, causing a FW assert/crash.
This caused TX_CMD rates to be set incorrectly, potentially causing
a warning when reported back from the device as having been used.

Fix this (hopefully correctly now) by handling beacon rates in the
TX_CMD that's embedded in the beacon template command separately.
Restore iwl_mvm_mac80211_idx_to_hwrate() to return only the rate
index, not PLCP value, fixing the real TX_CMD.

Fixes: 3592c0083fb2 ("wifi: iwlwifi: mvm: fix beacon template/fixed rate")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 27 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 14 +++-------
 2 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index c523c5e82d4a..8ffa72aca3cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -927,13 +927,18 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct iwl_mvm *mvm,
 
 u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 {
-	u16 flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
 	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw, BEACON_TEMPLATE_CMD, 0) > 10;
+	u16 flags = 0;
 
 	if (rate_idx <= IWL_LAST_CCK_RATE)
 		flags |= is_new_rate ? IWL_MAC_BEACON_CCK
 			  : IWL_MAC_BEACON_CCK_V1;
 
+	if (iwl_fw_lookup_cmd_ver(fw, TX_CMD, 0) > 8)
+		flags |= iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
+	else
+		flags |= iwl_fw_rate_idx_to_plcp(rate_idx);
+
 	return flags;
 }
 
@@ -962,6 +967,7 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_tx_info *info;
+	u32 rate_n_flags = 0;
 	u8 rate;
 	u32 tx_flags;
 
@@ -981,18 +987,21 @@ static void iwl_mvm_mac_ctxt_set_tx(struct iwl_mvm *mvm,
 			 IWL_UCODE_TLV_CAPA_BEACON_ANT_SELECTION)) {
 		iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
 
-		tx_params->rate_n_flags =
-			cpu_to_le32(BIT(mvm->mgmt_last_antenna_idx) <<
-				    RATE_MCS_ANT_POS);
+		rate_n_flags |= BIT(mvm->mgmt_last_antenna_idx) <<
+					RATE_MCS_ANT_POS;
 	}
 
 	rate = iwl_mvm_mac_ctxt_get_beacon_rate(mvm, info, vif);
 
-	tx_params->rate_n_flags |=
-		cpu_to_le32(iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate));
-	if (rate == IWL_FIRST_CCK_RATE)
-		tx_params->rate_n_flags |= cpu_to_le32(RATE_MCS_CCK_MSK_V1);
+	if (rate < IWL_FIRST_OFDM_RATE)
+		rate_n_flags |= RATE_MCS_MOD_TYPE_CCK;
+	else
+		rate_n_flags |= RATE_MCS_MOD_TYPE_LEGACY_OFDM;
+
+	rate_n_flags |= iwl_mvm_mac80211_idx_to_hwrate(mvm->fw, rate);
 
+	tx_params->rate_n_flags = iwl_mvm_v3_rate_to_fw(rate_n_flags,
+							mvm->fw_rates_ver);
 }
 
 int iwl_mvm_mac_ctxt_send_beacon_cmd(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 4a33a032c2a7..f052537e9567 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -159,15 +159,9 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 
 u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx)
 {
-	if (iwl_fw_lookup_cmd_ver(fw, TX_CMD, 0) > 8)
-		/* In the new rate legacy rates are indexed:
-		 * 0 - 3 for CCK and 0 - 7 for OFDM.
-		 */
-		return (rate_idx >= IWL_FIRST_OFDM_RATE ?
-			rate_idx - IWL_FIRST_OFDM_RATE :
-			rate_idx);
-
-	return iwl_fw_rate_idx_to_plcp(rate_idx);
+	return rate_idx >= IWL_FIRST_OFDM_RATE ?
+		rate_idx - IWL_FIRST_OFDM_RATE :
+		rate_idx;
 }
 
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac)
-- 
2.34.1


