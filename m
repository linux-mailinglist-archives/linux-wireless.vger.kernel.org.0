Return-Path: <linux-wireless+bounces-36337-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHYrLSGBA2pX6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36337-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1A5528B1D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DA70307650B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA8299959;
	Tue, 12 May 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzAG58NW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B53367295
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614508; cv=none; b=h7n0GujJr64p1MJJnPoTHZTnUdK0jdhFh70xFHifyv5GJhgz28aOy7nULYpVEtd6w4BPFX+zOvLGBvC1aeTM3IheEAp5ENBhD8hRnYucZoMgPDAi2cIL6VVa83LSmrXYUURTC//wEYY4S8Oio5ufCu5/XidaQKstjE+Rot7Fj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614508; c=relaxed/simple;
	bh=R0qCdNp38qyQKjNxlWZMmUjXIv7ZsQAZ4f79kWgbZkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSiPLqSyTkYkLNoDX8yF0aW7Ax6aQOWSpLWYOf61/EEEyWs1lXNDuROKiiaJFIdNmOLcRX55jV0AGflYqIAYefjL5aY9VDdHdWphQvUvQmKoHO/ITFEjEoxIHo0xYM506yefo1cMslUEjC0rDTwmugzCbrF1pfRpZfuyaOnnI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzAG58NW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614507; x=1810150507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R0qCdNp38qyQKjNxlWZMmUjXIv7ZsQAZ4f79kWgbZkw=;
  b=TzAG58NWgkQf9grPJjKGvVbdJ7Bk9l49nhQJdNvFg0TkHMRiUzmie1K5
   i3VdIzz7kkO7/tpmOW6WBHWGVSCCqUpKja0uX8WN6N3n2c4bh02919aI3
   l5yjTYK5wuZX5WHYXOqvCDHLDfhRpM1fVxtXggqryTrr0vzz0WUbVAFbq
   zISuCo54H75w9rD+q6/L9/ZkAK17dsA+m7m0q/d2jaMkO4/Yu64dxsmUn
   qK3FWbK2Nq8Ieo6iHD0UxA+5hFdmYYoPxbDM3wt4050K5Vhg1lXey2Skv
   NVL1IJuA1YLX/+OARfakq7FbY7U3R+O5oiLIIuWnG/RkLvd5iNRiJUITB
   Q==;
X-CSE-ConnectionGUID: BcvpoFIxQwSSyMdVwXHx8w==
X-CSE-MsgGUID: sg+bbGaYRrK1Vo8H5zzoyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148793"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148793"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:07 -0700
X-CSE-ConnectionGUID: xXyZEVjMSN2PYfGyM/mZ7A==
X-CSE-MsgGUID: rWRZSmHsQl+RQsGBhVu+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471791"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:05 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avinash Bhatt <avinash.bhatt@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: add chan-load hysteresis for MLO scan triggers
Date: Tue, 12 May 2026 22:34:36 +0300
Message-Id: <20260512222731.2db48151d32d.I8660f0660a95358bda067af806d28bc2fa6f7f76@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
References: <20260512193441.2352467-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A1A5528B1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36337-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Avinash Bhatt <avinash.bhatt@intel.com>

Introduce a three-level, table-driven hysteresis mechanism for
deciding when to trigger internal MLO scans based on MCLM Chan
Load. Prevents repeated triggers under fluctuating load conditions.

Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 61 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/link.h | 15 +++++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 29 ++++++++-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  4 ++
 4 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 9e40b334ee1f..a8d146edc4bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -16,6 +16,23 @@
 #include "fw/api/context.h"
 #include "fw/dbg.h"
 
+/**
+ * struct iwl_mld_link_chan_load_threshold - channel load thresholds
+ * @high_lim: level up transition thresholds, in percentage
+ * @low_lim: level down transition thresholds, in percentage
+ */
+struct iwl_mld_link_chan_load_threshold {
+	u8 high_lim;
+	u8 low_lim;
+};
+
+static const struct iwl_mld_link_chan_load_threshold
+link_chan_load_thresh_tbl[] = {
+	[LINK_CHAN_LOAD_LVL1] = { .high_lim = 45, .low_lim = 40 },
+	[LINK_CHAN_LOAD_LVL2] = { .high_lim = 70, .low_lim = 65 },
+	[LINK_CHAN_LOAD_LVL3] = { .high_lim = 85, .low_lim = 80 },
+};
+
 int iwl_mld_send_link_cmd(struct iwl_mld *mld,
 			  struct iwl_link_config_cmd *cmd,
 			  enum iwl_ctxt_action action)
@@ -792,6 +809,50 @@ int iwl_mld_get_chan_load_by_others(struct iwl_mld *mld,
 	return chan_load;
 }
 
+/* Returns whether internal MLO Scan needs to be triggered */
+bool iwl_mld_chan_load_requires_scan(struct iwl_mld *mld,
+				     struct ieee80211_bss_conf *link_conf,
+				     u32 new_chan_load)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link_conf);
+	enum iwl_mld_link_chan_load_level new_lvl;
+	bool scan_trig = false;
+
+	if (WARN_ON(!mld_link))
+		return false;
+
+	/* For each Level,
+	 * First check if high limit threshold crosses
+	 * If not then, check if low limit threshold crosses
+	 * Set new level based on low limit thresh only if old level
+	 * is not lower than level threshold
+	 */
+	for (new_lvl = LINK_CHAN_LOAD_LVL_MAX;
+	     new_lvl > LINK_CHAN_LOAD_LVL_NONE; new_lvl--) {
+		if (new_chan_load >=
+		    link_chan_load_thresh_tbl[new_lvl].high_lim)
+			break;
+		if (new_chan_load >=
+		    link_chan_load_thresh_tbl[new_lvl].low_lim &&
+		    mld_link->chan_load_lvl >= new_lvl)
+			break;
+	}
+
+	/* Trigger scan only for Level Up Transition */
+	if (new_lvl > mld_link->chan_load_lvl)
+		scan_trig = true;
+
+	IWL_DEBUG_EHT(mld,
+		      "Link %d: chan_load=%d%%, old_lvl=%d, new_lvl=%d, scan_trig=%d\n",
+		      link_conf->link_id, new_chan_load,
+		      mld_link->chan_load_lvl, new_lvl, scan_trig);
+
+	/* Update computed new level */
+	mld_link->chan_load_lvl = new_lvl;
+
+	return scan_trig;
+}
+
 static unsigned int
 iwl_mld_get_default_chan_load(struct ieee80211_bss_conf *link_conf)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 2b3e6b55367f..4527f054ce92 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -10,6 +10,14 @@
 #include "mld.h"
 #include "sta.h"
 
+enum iwl_mld_link_chan_load_level {
+	LINK_CHAN_LOAD_LVL_NONE,
+	LINK_CHAN_LOAD_LVL1,
+	LINK_CHAN_LOAD_LVL2,
+	LINK_CHAN_LOAD_LVL3,
+	LINK_CHAN_LOAD_LVL_MAX  = LINK_CHAN_LOAD_LVL3
+};
+
 /**
  * struct iwl_probe_resp_data - data for NoA/CSA updates
  * @rcu_head: used for freeing the data on update
@@ -50,6 +58,8 @@ struct iwl_probe_resp_data {
  * @silent_deactivation: next deactivation needs to be silent.
  * @probe_resp_data: data from FW notification to store NOA related data to be
  *	inserted into probe response.
+ * @chan_load_lvl: current channel load level for a link, computed based on
+ *	channel load by others on a link.
  */
 struct iwl_mld_link {
 	struct rcu_head rcu_head;
@@ -63,6 +73,7 @@ struct iwl_mld_link {
 		bool he_ru_2mhz_block;
 		struct ieee80211_key_conf *tx_igtk;
 		struct ieee80211_key_conf __rcu *bigtks[2];
+		enum iwl_mld_link_chan_load_level chan_load_lvl;
 	);
 	/* And here fields that survive a fw restart */
 	struct iwl_mld_int_sta bcast_sta;
@@ -135,6 +146,10 @@ int iwl_mld_get_chan_load_by_others(struct iwl_mld *mld,
 				    struct ieee80211_bss_conf *link_conf,
 				    bool expect_active_link);
 
+bool  iwl_mld_chan_load_requires_scan(struct iwl_mld *mld,
+				      struct ieee80211_bss_conf *link_conf,
+				      u32 new_chan_load);
+
 void iwl_mld_handle_beacon_filter_notif(struct iwl_mld *mld,
 					struct iwl_rx_packet *pkt);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 8227ccb31d60..2a3b2c883fc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include "mlo.h"
 #include "phy.h"
@@ -1081,8 +1081,13 @@ static void iwl_mld_chan_load_update_iter(void *_data, u8 *mac,
 		container_of((const void *)phy, struct ieee80211_chanctx_conf,
 			     drv_priv);
 	struct iwl_mld *mld = iwl_mld_vif_from_mac80211(vif)->mld;
-	struct ieee80211_bss_conf *prim_link;
+	u32 new_chan_load = phy->avg_channel_load_not_by_us;
+	struct ieee80211_bss_conf *prim_link, *link_conf;
 	unsigned int prim_link_id;
+	int link_id;
+
+	if (!ieee80211_vif_is_mld(vif) || hweight16(vif->valid_links) <= 1)
+		return;
 
 	prim_link_id = iwl_mld_get_primary_link(vif);
 	prim_link = link_conf_dereference_protected(vif, prim_link_id);
@@ -1090,6 +1095,25 @@ static void iwl_mld_chan_load_update_iter(void *_data, u8 *mac,
 	if (WARN_ON(!prim_link))
 		return;
 
+	/* Evaluate MLO Internal Scan for high chan load beyond thresholds */
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		if (rcu_access_pointer(link_conf->chanctx_conf) != chanctx)
+			continue;
+
+		if (iwl_mld_chan_load_requires_scan(mld,
+						    link_conf,
+						    new_chan_load)) {
+			/* When EMLSR is active, only trigger scan based on
+			 * primary link
+			 */
+			if (iwl_mld_emlsr_active(vif) && link_conf != prim_link)
+				continue;
+
+			iwl_mld_int_mlo_scan(mld, vif);
+			return;
+		}
+	}
+
 	if (chanctx != rcu_access_pointer(prim_link->chanctx_conf))
 		return;
 
@@ -1107,7 +1131,6 @@ static void iwl_mld_chan_load_update_iter(void *_data, u8 *mac,
 					   prim_link_id);
 	} else {
 		u32 old_chan_load = data->prev_chan_load_not_by_us;
-		u32 new_chan_load = phy->avg_channel_load_not_by_us;
 		u32 min_thresh = iwl_mld_get_min_chan_load_thresh(chanctx);
 
 #define THRESHOLD_CROSSED(threshold) \
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index 6e826797f637..b93e0f8ab5fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -515,6 +515,10 @@ static void iwl_mld_fill_chanctx_stats(struct ieee80211_hw *hw,
 						  (old_load >> 1);
 	}
 
+	IWL_DEBUG_EHT(phy->mld,
+		      "PHY %d: load_by_us=%u%% load_not_by_us=%u%%\n",
+		      phy->fw_id, phy->channel_load_by_us, new_load);
+
 	iwl_mld_emlsr_check_chan_load(hw, phy, old_load);
 }
 
-- 
2.34.1


