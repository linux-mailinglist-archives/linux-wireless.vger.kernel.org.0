Return-Path: <linux-wireless+bounces-36304-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJLzNN26AmonwAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36304-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:30:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11451A12A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 07:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330EC30D9FF7
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 05:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3056238945D;
	Tue, 12 May 2026 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mpv2RT4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907DE33F59B
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563418; cv=none; b=TLVcGuRrlAF2WcZ3b4yGTyUWNLZXFxZSPDqYgFF/gyjffV7nb51EGI8FPp3DBACzEvdA/4eLeBwowJkuxvtCdsL6RLIcx0m67xpqPwOg9mjFOo9SfkeJ6e/TRVubZMpfdS9zlrG6F/g97bGDogsSXWz4r4WmHrjGY6YXnFSvk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563418; c=relaxed/simple;
	bh=UWwTS5mNiXur1n99ITCQl9FryjrTaHCojvuR92p0jFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbj24L81elXfgj3DjzCDYVG+idg8A1q14cLSoJ1XDJysIOwYkROtP3FkBfKvO8IJ56o4eCPEHFhQmB0n3fXWFuT7f7IeD24TuRiDSbIB7KHWEaJzcjNOkpd9lBbvfjz6KJjGw0QoDa2c3NlHvvwM92fUwyst97t/U/PjK02fIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mpv2RT4z; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778563416; x=1810099416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWwTS5mNiXur1n99ITCQl9FryjrTaHCojvuR92p0jFo=;
  b=Mpv2RT4zzNJtpm2Hp/zrHfvKUtpPowTaRswv1Ggz1br6jG/2TCdtKB0c
   6Eih1hOdb6IT3kH8fkWGkWV1iVD2yv9EnXu9Wmu/T1iN2WcwoJWHzS5k0
   KGY+v3N0928lHN9jYt6AGnXfeIYvuUGJDGh0A+XYkYNMAOGnUdoZPu8NM
   Xmm3UCzCUOb5+ofsw0R2GPCv/X4mEZfXHbJ0teXUxesMcalL10no1joKl
   Rw8sOvWwgPPVESau0pQCn7DEzaAlFhD5Gq1aMAHjEwVQcD+DNdIGJN5J8
   yPYgpA82KJhcR7bvmB86Axk8AKQlsjCfgIQUNF7FzLTarYy3Huw0moIhR
   w==;
X-CSE-ConnectionGUID: wlc2HIayRmmm0ruBNNkHkA==
X-CSE-MsgGUID: MvYmMrf1Ta+XiOlU6f1PgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="78495104"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="78495104"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:36 -0700
X-CSE-ConnectionGUID: /HlLlEgCSGqTOOxlOKwnVw==
X-CSE-MsgGUID: jUMJKL62TpCYQmcvPwcjJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233187589"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 22:23:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 13/15] wifi: iwlwifi: mld: stop supporting MAC_PM_POWER_TABLE version 1
Date: Tue, 12 May 2026 08:23:05 +0300
Message-Id: <20260512082114.e42cff396ea8.I9175bf4aaba0c846fbea54c9bede4d18ad1c252b@changeid>
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
X-Rspamd-Queue-Id: 5C11451A12A
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36304-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

The oldest core that iwmld loads is now 101, which supports version 2,
so remove version 1.
This allows to remove the smps workaround.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 --
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 28 +---------------
 .../net/wireless/intel/iwlwifi/mld/power.c    | 33 ++-----------------
 3 files changed, 4 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 147ff6787ed9..71c794204475 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -138,7 +138,6 @@ struct iwl_mld_emlsr {
  * @beacon_inject_active: indicates an active debugfs beacon ie injection
  * @low_latency_causes: bit flags, indicating the causes for low-latency,
  *	see @iwl_mld_low_latency_cause.
- * @ps_disabled: indicates that PS is disabled for this interface
  * @last_link_activation_time: last time a link was activated, for
  *	deferring MLO scans (to make them more reliable)
  * @mld: pointer to the mld structure.
@@ -171,7 +170,6 @@ struct iwl_mld_vif {
 		bool beacon_inject_active;
 #endif
 		u8 low_latency_causes;
-		bool ps_disabled;
 		time64_t last_link_activation_time;
 	);
 	/* And here fields that survive a fw restart */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 8856f96a9760..f37a365a87a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1368,28 +1368,6 @@ iwl_mld_mac80211_link_info_changed(struct ieee80211_hw *hw,
 		iwl_mld_set_tx_power(mld, link_conf, link_conf->txpower);
 }
 
-static void
-iwl_mld_smps_workaround(struct iwl_mld *mld, struct ieee80211_vif *vif, bool enable)
-{
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	bool workaround_required =
-		iwl_fw_lookup_cmd_ver(mld->fw, MAC_PM_POWER_TABLE, 0) < 2;
-
-	if (!workaround_required)
-		return;
-
-	/* Send the device-level power commands since the
-	 * firmware checks the POWER_TABLE_CMD's POWER_SAVE_EN bit to
-	 * determine SMPS mode.
-	 */
-	if (mld_vif->ps_disabled == !enable)
-		return;
-
-	mld_vif->ps_disabled = !enable;
-
-	iwl_mld_update_device_power(mld, false);
-}
-
 static
 void iwl_mld_mac80211_vif_cfg_changed(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
@@ -1427,10 +1405,8 @@ void iwl_mld_mac80211_vif_cfg_changed(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (changes & BSS_CHANGED_PS) {
-		iwl_mld_smps_workaround(mld, vif, vif->cfg.ps);
+	if (changes & BSS_CHANGED_PS)
 		iwl_mld_update_mac_power(mld, vif, false);
-	}
 
 	/* TODO: task=MLO BSS_CHANGED_MLD_VALID_LINKS/CHANGED_MLD_TTLM */
 }
@@ -1837,7 +1813,6 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 						    FW_CTXT_ACTION_MODIFY);
 			if (ret)
 				return ret;
-			iwl_mld_smps_workaround(mld, vif, vif->cfg.ps);
 		}
 
 		/* MFP is set by default before the station is authorized.
@@ -1882,7 +1857,6 @@ static int iwl_mld_move_sta_state_down(struct iwl_mld *mld,
 						  &mld_vif->mlo_scan_start_wk);
 
 			iwl_mld_reset_cca_40mhz_workaround(mld, vif);
-			iwl_mld_smps_workaround(mld, vif, true);
 		}
 
 		/* once we move into assoc state, need to update the FW to
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/power.c b/drivers/net/wireless/intel/iwlwifi/mld/power.c
index 49b0d9f8f865..fe71da8b9c89 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/power.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <net/mac80211.h>
 
@@ -11,36 +11,11 @@
 #include "link.h"
 #include "constants.h"
 
-static void iwl_mld_vif_ps_iterator(void *data, u8 *mac,
-				    struct ieee80211_vif *vif)
-{
-	bool *ps_enable = (bool *)data;
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-
-	if (vif->type != NL80211_IFTYPE_STATION)
-		return;
-
-	*ps_enable &= !mld_vif->ps_disabled;
-}
-
 int iwl_mld_update_device_power(struct iwl_mld *mld, bool d3)
 {
 	struct iwl_device_power_cmd cmd = {};
-	bool enable_ps = false;
 
-	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM) {
-		enable_ps = true;
-
-		/* Disable power save if any STA interface has
-		 * power save turned off
-		 */
-		ieee80211_iterate_active_interfaces_mtx(mld->hw,
-							IEEE80211_IFACE_ITER_NORMAL,
-							iwl_mld_vif_ps_iterator,
-							&enable_ps);
-	}
-
-	if (enable_ps)
+	if (iwlmld_mod_params.power_scheme != IWL_POWER_SCHEME_CAM)
 		cmd.flags |=
 			cpu_to_le16(DEVICE_POWER_FLAGS_POWER_SAVE_ENA_MSK);
 
@@ -252,9 +227,7 @@ static void iwl_mld_power_build_cmd(struct iwl_mld *mld,
 		return;
 
 	cmd->flags |= cpu_to_le16(POWER_FLAGS_POWER_MANAGEMENT_ENA_MSK);
-
-	if (iwl_fw_lookup_cmd_ver(mld->fw, MAC_PM_POWER_TABLE, 0) >= 2)
-		cmd->flags |= cpu_to_le16(POWER_FLAGS_ENABLE_SMPS_MSK);
+	cmd->flags |= cpu_to_le16(POWER_FLAGS_ENABLE_SMPS_MSK);
 
 	/* firmware supports LPRX for beacons at rate 1 Mbps or 6 Mbps only */
 	if (link_conf->beacon_rate &&
-- 
2.34.1


