Return-Path: <linux-wireless+bounces-36306-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JZHBs27AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36306-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:34:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E851A22B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE7333067517
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F5633B6D5;
	Tue, 12 May 2026 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvWqLgR3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD734402B
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563420; cv=none; b=gUgYBBFQOuYfcJbC5JZ0VJtbgRJF03YU7v1u5g2YBh16Pnq03zHk4FbSHiaM/1uaNNNEkdPOTsm1DuMmDhUncLLx67/73Ss//jMixZGsg8+GQkogCI/Q28TjGWoLWJWTartn2bFQLDhLT5C7sQ9w4T6q9mJS65RkpyVrPVQS9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563420; c=relaxed/simple;
	bh=F+xitSzKAGgPAf1Jrsj2G5I+PCjg2HHhdJ3edCCrlUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaHg/AJrzubqoW6ryOfb3Kuz8rp1ZIino1ASUDFURL4O7Z/Gb4SrCn7/UVmBNBYcdYnN6a5LeMprYmZd/SI1xiOQsk6Zd+6T2eedo7D4C8s6Mi1DFtrOtQzxmH8N41Kej3DJ/gyHz2w3OYBXix6ci5lPQFQQvk2ZPc+lrRlT9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvWqLgR3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563418; x=1810099418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F+xitSzKAGgPAf1Jrsj2G5I+PCjg2HHhdJ3edCCrlUc=;
  b=nvWqLgR3tQTcbX3s/nKcdXqFlRMXzeggjYfJADq7hz7PhELsqNJ8vrD5
   DQJxQ7m++OxQ4sZ7WnbEvV+fGUGS2xr2Er304h9j3NSbc80ShOFn0pKtR
   MyL6qW5psjEErjwTXqkSXhoQ2Sflw0yZn4JELozIHp+NhIpEr4oorV7yS
   IqgAmBTc0OROX+f/mioAUso9YNV9FB8yUL1tWVilwlVXkaVFBv3YtS6Hv
   UoTdtmbFJDaAv2/XLerBZea4wBSZpLH5t/E4X4eDIIvIzUU5YYAWGgP7q
   Xuse8cwwRzi/uszWeMZ6ZB3T7dilRKfgAtJh/V6InoWl+VYwdCD5WJkgm
   g==;
X-CSE-ConnectionGUID: JutFutwnRCmU3FbmmYxQsw==
X-CSE-MsgGUID: 5cq05nmNSuOk2bRciNDWBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495106"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495106"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:38 -0700
X-CSE-ConnectionGUID: JB1BpIJJS2q/TxSw10Gxsg==
X-CSE-MsgGUID: Cx5gjN/9SleNgma72lEtlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187597"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: stop supporting rate_n_flags version 2
Date: Tue, 12 May 2026 08:23:07 +0300
Message-Id: <20260512082114.39e460bc8235.I4cd02612a68a3f183d51f428569448670bd19d9b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
References: <20260512052307.1603442-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 344E851A22B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36306-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

Now as the oldest fw we support is core 101, and it supports only
version 3, remove version 2.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c |  3 +--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c    | 16 ----------------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c     |  3 ---
 drivers/net/wireless/intel/iwlwifi/mld/mld.h     |  5 +----
 drivers/net/wireless/intel/iwlwifi/mld/rx.c      |  3 +--
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c     |  4 +---
 drivers/net/wireless/intel/iwlwifi/mld/tx.c      | 10 ++++------
 7 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index b05b58eb1281..9ec8ddce0c38 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include "mld.h"
@@ -1035,7 +1035,6 @@ static ssize_t _iwl_dbgfs_fixed_rate_write(struct iwl_mld *mld, char *buf,
 
 	/* input is in FW format (v2 or v3) so convert to v3 */
 	rate = iwl_v3_rate_from_v2_v3(cpu_to_le32(rate), v3);
-	rate = le32_to_cpu(iwl_v3_rate_to_v2_v3(rate, mld->fw_rates_ver_3));
 
 	ret = iwl_mld_send_tlc_dhc(mld, fw_sta_id,
 				   partial ? IWL_TLC_DEBUG_PARTIAL_FIXED_RATE :
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index f37a365a87a4..4315b1b2b36b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -455,22 +455,6 @@ static void iwl_mac_hw_set_misc(struct iwl_mld *mld)
 
 static int iwl_mld_hw_verify_preconditions(struct iwl_mld *mld)
 {
-	int ratecheck;
-
-	/* check for rates version 3 */
-	ratecheck =
-		(iwl_fw_lookup_cmd_ver(mld->fw, TX_CMD, 0) >= 11) +
-		(iwl_fw_lookup_notif_ver(mld->fw, DATA_PATH_GROUP,
-					 TLC_MNG_UPDATE_NOTIF, 0) >= 4) +
-		(iwl_fw_lookup_notif_ver(mld->fw, LEGACY_GROUP,
-					 REPLY_RX_MPDU_CMD, 0) >= 6) +
-		(iwl_fw_lookup_notif_ver(mld->fw, LONG_GROUP, TX_CMD, 0) >= 9);
-
-	if (ratecheck != 0 && ratecheck != 4) {
-		IWL_ERR(mld, "Firmware has inconsistent rates\n");
-		return -EINVAL;
-	}
-
 	/* 11ax is expected to be enabled for all supported devices */
 	if (WARN_ON(!mld->nvm_data->sku_cap_11ax_enable))
 		return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index dfd4798c103a..9a3b768fce7a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -413,9 +413,6 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_rf_cfg *cfg,
 
 	iwl_construct_mld(mld, trans, cfg, fw, hw, dbgfs_dir);
 
-	/* we'll verify later it matches between commands */
-	mld->fw_rates_ver_3 = iwl_fw_lookup_cmd_ver(mld->fw, TX_CMD, 0) >= 11;
-
 	iwl_mld_construct_fw_runtime(mld, trans, fw, dbgfs_dir);
 
 	iwl_mld_get_bios_tables(mld);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 69da3c346394..1a59b3e4014d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #ifndef __iwl_mld_h__
 #define __iwl_mld_h__
@@ -189,7 +189,6 @@
  *	TX rate_n_flags for non-STA mgmt frames (toggles on every TX failure).
  * @set_tx_ant: stores the last TX antenna bitmask set by user space (if any)
  * @set_rx_ant: stores the last RX antenna bitmask set by user space (if any)
- * @fw_rates_ver_3: FW rates are in version 3
  * @low_latency: low-latency manager.
  * @tzone: thermal zone device's data
  * @cooling_dev: cooling device's related data
@@ -299,8 +298,6 @@ struct iwl_mld {
 	u8 set_tx_ant;
 	u8 set_rx_ant;
 
-	bool fw_rates_ver_3;
-
 	struct iwl_mld_low_latency low_latency;
 
 	bool ibss_manager;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/rx.c b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
index a9f08f984633..01603dc07f0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/rx.c
@@ -39,8 +39,7 @@ iwl_mld_fill_phy_data_from_mpdu(struct iwl_mld *mld,
 	}
 
 	phy_data->phy_info = le16_to_cpu(desc->phy_info);
-	phy_data->rate_n_flags = iwl_v3_rate_from_v2_v3(desc->v3.rate_n_flags,
-							mld->fw_rates_ver_3);
+	phy_data->rate_n_flags = le32_to_cpu(desc->v3.rate_n_flags);
 	phy_data->gp2_on_air_rise = le32_to_cpu(desc->v3.gp2_on_air_rise);
 	phy_data->energy_a = desc->v3.energy_a;
 	phy_data->energy_b = desc->v3.energy_b;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index 7db56eefc7df..fb68d8810e14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -956,9 +956,7 @@ void iwl_mld_handle_tlc_notif(struct iwl_mld *mld,
 		if (WARN_ON(!mld_link_sta))
 			return;
 
-		mld_link_sta->last_rate_n_flags =
-			iwl_v3_rate_from_v2_v3(notif->rate,
-					       mld->fw_rates_ver_3);
+		mld_link_sta->last_rate_n_flags = le32_to_cpu(notif->rate);
 
 		rs_pretty_print_rate(pretty_rate, sizeof(pretty_rate),
 				     mld_link_sta->last_rate_n_flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index dec8ecd6b805..636d24633e57 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -494,7 +494,7 @@ static __le32 iwl_mld_get_tx_rate_n_flags(struct iwl_mld *mld,
 		rate = iwl_mld_mac80211_rate_idx_to_fw(mld, info, -1) |
 		       iwl_mld_get_tx_ant(mld, info, sta, fc);
 
-	return iwl_v3_rate_to_v2_v3(rate, mld->fw_rates_ver_3);
+	return cpu_to_le32(rate);
 }
 
 static void
@@ -1012,14 +1012,11 @@ void iwl_mld_tx_from_txq(struct iwl_mld *mld, struct ieee80211_txq *txq)
 	rcu_read_unlock();
 }
 
-static void iwl_mld_hwrate_to_tx_rate(struct iwl_mld *mld,
-				      __le32 rate_n_flags_fw,
+static void iwl_mld_hwrate_to_tx_rate(u32 rate_n_flags,
 				      struct ieee80211_tx_info *info)
 {
 	enum nl80211_band band = info->band;
 	struct ieee80211_tx_rate *tx_rate = &info->status.rates[0];
-	u32 rate_n_flags = iwl_v3_rate_from_v2_v3(rate_n_flags_fw,
-						  mld->fw_rates_ver_3);
 	u32 sgi = rate_n_flags & RATE_MCS_SGI_MSK;
 	u32 chan_width = rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK;
 	u32 format = rate_n_flags & RATE_MCS_MOD_TYPE_MSK;
@@ -1150,7 +1147,8 @@ void iwl_mld_handle_tx_resp_notif(struct iwl_mld *mld,
 			iwl_dbg_tlv_time_point(&mld->fwrt, tp, NULL);
 		}
 
-		iwl_mld_hwrate_to_tx_rate(mld, tx_resp->initial_rate, info);
+		iwl_mld_hwrate_to_tx_rate(le32_to_cpu(tx_resp->initial_rate),
+					  info);
 
 		if (likely(!iwl_mld_time_sync_frame(mld, skb, hdr->addr1)))
 			ieee80211_tx_status_skb(mld->hw, skb);
-- 
2.34.1


