Return-Path: <linux-wireless+bounces-36167-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHELIVfvAGqGOgEAu9opvQ
	(envelope-from <linux-wireless+bounces-36167-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF53506578
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 22:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2F7D3013888
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E11533507C;
	Sun, 10 May 2026 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NARs6mTr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243433B6EF
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446144; cv=none; b=DZWgg92r/OvpTx8ZAdmlF8w1wQF2vsMD0AhrXd8mYBZph8hr4o4h8Mo9SXc7Zak3hMN8AmvOUuahz/LW8w2m9UxqJzKuwzwnixOOCbZixvuIHkDTzIYCobsctsT258GSWIaQx+6E8shRbcXKHCF5xBVqpGjuhDLtI7wk1KPzhU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446144; c=relaxed/simple;
	bh=CpH0StW1gCEgt7ONu7PKO7cAOQ+kkKsXOnmIORFXnx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSoBAEh5O4kSaOHF7pD18yJE9D6FrP1eXB7O3hj8FlIP/2OkDTjaSnuYlxGdQMlcqYCY61LdE6eYM2XKGgEAA8JcAoswdVtKT0yFNvAuzsvAZInc2wLm9x/84KcXPDhYoYsgTqlbxdlYR2yZl0OFDxRgKO+C3z4YisiVCHLgMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NARs6mTr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778446143; x=1809982143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CpH0StW1gCEgt7ONu7PKO7cAOQ+kkKsXOnmIORFXnx0=;
  b=NARs6mTr+UyUccx9/jB6zz387TiVB68Htsc/+3hWtJUnN5TElkbnJINH
   03fZ5lN4GQF6TY+V5dHJaGf9F5PXtOEo0vFcU/thP2pF2P3YIaZoD7HzF
   yJ3jpHAEJUkfFL6lEmIKS7KnrZdBBd1U4ZBBFGjR7buM3e2ZXOdwfNe5N
   YPBzrcV/3WhUAM56OozkdPHHR7qm3iY/+9Sop5ouyQZytMLI3Jlqz7cVB
   V3JEWwZT6vIAEfGsZE+iL79YjWbSuuZODh7+1JEXjslpHyqWkwkjHeXpL
   ZmOStCGABmUl4tqG6fO8RGpNTDJqPwY7h4q+5tLp8rqz3fBvPd98SNBXG
   A==;
X-CSE-ConnectionGUID: hxnKA1uhQ7utNP+2EPr91A==
X-CSE-MsgGUID: aDDRh2BaRfieQkiuRrTjOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81904754"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81904754"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:03 -0700
X-CSE-ConnectionGUID: dP2tu+D9Tg6Hkyzb1fQGyQ==
X-CSE-MsgGUID: V5fo2LY9SaWRIJD3JSUb1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="239095046"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 13:49:01 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 06/15] wifi: iwlwifi: add NAN schedule command support
Date: Sun, 10 May 2026 23:48:31 +0300
Message-Id: <20260510234534.95fabd44a598.I7cbe877f3b13a44554d95e56b10d930dde4704c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
References: <20260510204840.133723-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EFF53506578
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
	TAGGED_FROM(0.00)[bounces-36167-lists,linux-wireless=lfdr.de];
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

From: Johannes Berg <johannes.berg@intel.com>

Add the NAN schedule command API definition and implementation
of the schedule updates.

Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 24 ++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 58 +++++++++++++++++--
 3 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index b398c582b867..d98c6d991a88 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -8,6 +8,7 @@
 #define __iwl_fw_api_mac_cfg_h__
 
 #include "mac.h"
+#include "phy-ctxt.h"
 
 /**
  * enum iwl_mac_conf_subcmd_ids - mac configuration command IDs
@@ -71,6 +72,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @NAN_CFG_CMD: &struct iwl_nan_config_cmd
 	 */
 	NAN_CFG_CMD = 0x12,
+	/**
+	 * @NAN_SCHEDULE_CMD: &struct iwl_nan_schedule_cmd
+	 */
+	NAN_SCHEDULE_CMD = 0x13,
 	/**
 	 * @NAN_DW_END_NOTIF: &struct iwl_nan_dw_end_notif
 	 */
@@ -1244,6 +1249,25 @@ struct iwl_nan_config_cmd {
 	u8 beacon_data[];
 } __packed; /*  NAN_CONFIG_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_nan_schedule_cmd - NAN schedule command
+ * @channels: per channel information
+ * @channels.availability_map: bitmap of slots this channel is advertising
+ *	availability on, will be ULW'ed out if no link/inactive link is
+ *	referenced by the link ID below
+ * @channels.channel_entry: NAN channel entry descriptor
+ * @channels.link_id: FW link ID, or %0xFF for unset
+ * @channels.reserved: (reserved)
+ */
+struct iwl_nan_schedule_cmd {
+	struct {
+		__le32 availability_map;
+		u8 channel_entry[6];
+		u8 link_id;
+		u8 reserved;
+	} __packed channels[NUM_PHY_CTX];
+} __packed; /* NAN_SCHEDULE_CMD_API_S_VER_1 */
+
 /**
  * enum iwl_nan_cluster_notif_flags - flags for the cluster notification
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 9af79297c3b6..c038a0cde36b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <linux/rtnetlink.h>
 #include <net/mac80211.h>
@@ -236,6 +236,7 @@ static const struct iwl_hcmd_names iwl_mld_mac_conf_names[] = {
 	HCMD_NAME(STA_REMOVE_CMD),
 	HCMD_NAME(ROC_CMD),
 	HCMD_NAME(NAN_CFG_CMD),
+	HCMD_NAME(NAN_SCHEDULE_CMD),
 	HCMD_NAME(NAN_DW_END_NOTIF),
 	HCMD_NAME(NAN_JOINED_CLUSTER_NOTIF),
 	HCMD_NAME(MISSED_BEACONS_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 6ea11b66a545..eba79aca8c06 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -401,8 +401,14 @@ iwl_mld_nan_link_add(struct iwl_mld *mld,
 	u8 fw_id;
 	int ret;
 
+	lockdep_assert_wiphy(mld->wiphy);
+
 	ret = iwl_mld_allocate_link_fw_id(mld, &fw_id, ERR_PTR(-ENODEV));
-	if (ret < 0)
+	/*
+	 * We should always have enough links. The schedule contains up to 3,
+	 * and the BSS vif cannot do EMLSR - so can only have 1.
+	 */
+	if (WARN_ON(ret < 0))
 		return NULL;
 
 	nan_link = &mld_vif->nan.links[fw_id];
@@ -504,19 +510,21 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 u64 changes)
 {
+	struct iwl_nan_schedule_cmd cmd = {};
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	bool previously_empty_schedule = !iwl_mld_nan_have_links(mld_vif);
 	struct ieee80211_nan_sched_cfg *sched_cfg = &vif->cfg.nan_sched;
 	struct iwl_mld_nan_link *links[ARRAY_SIZE(sched_cfg->channels)] = {};
+	struct ieee80211_nan_channel **slots = sched_cfg->schedule;
 	bool link_used[ARRAY_SIZE(mld_vif->nan.links)] = {};
 	struct iwl_mld_nan_link *nan_link;
 	bool empty_schedule = true;
-	int ret;
+	int ret, i;
 
 	if (!(changes & BSS_CHANGED_NAN_LOCAL_SCHED))
 		return;
 
-	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+	for (i = 0; i <  ARRAY_SIZE(sched_cfg->channels); i++) {
 		if (!sched_cfg->channels[i].chanreq.oper.chan)
 			continue;
 		empty_schedule = false;
@@ -539,8 +547,12 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 		return;
 	}
 
+	/* this currently just uses the same index */
+	BUILD_BUG_ON(ARRAY_SIZE(sched_cfg->channels) !=
+		     ARRAY_SIZE(cmd.channels));
+
 	/* find links we can keep (same chanctx/PHY) */
-	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+	for (i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
 		struct ieee80211_chanctx_conf *chanctx;
 		struct iwl_mld_nan_link *link;
 
@@ -556,7 +568,7 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 	}
 
 	/* add/reassign links for new channels */
-	for (int i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+	for (i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
 		struct ieee80211_chanctx_conf *chanctx;
 
 		/* already have an existing active link */
@@ -581,6 +593,39 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 		}
 	}
 
+	/* fill the command */
+	for (i = 0; i < ARRAY_SIZE(sched_cfg->channels); i++) {
+		cmd.channels[i].link_id = FW_CTXT_ID_INVALID;
+
+		if (!sched_cfg->channels[i].chanreq.oper.chan)
+			continue;
+
+		memcpy(cmd.channels[i].channel_entry,
+		       sched_cfg->channels[i].channel_entry, 6);
+		cmd.channels[i].link_id =
+			links[i] ? links[i]->fw_id : FW_CTXT_ID_INVALID;
+	}
+
+	for (i = 0; i < CFG80211_NAN_SCHED_NUM_TIME_SLOTS; i++) {
+		int chan_idx;
+
+		if (!slots[i])
+			continue;
+
+		chan_idx = slots[i] - sched_cfg->channels;
+		if (WARN_ON_ONCE(chan_idx < 0 ||
+				 chan_idx >= ARRAY_SIZE(cmd.channels)))
+			continue;
+
+		cmd.channels[chan_idx].availability_map |= cpu_to_le32(BIT(i));
+	}
+
+	ret = iwl_mld_send_cmd_pdu(mld,
+				   WIDE_ID(MAC_CONF_GROUP, NAN_SCHEDULE_CMD),
+				   &cmd);
+	if (ret)
+		IWL_ERR(mld, "NAN: failed to update schedule (%d)\n", ret);
+
 	/* delete unused links */
 	for_each_mld_nan_valid_link(mld_vif, nan_link) {
 		if (!link_used[nan_link->fw_id]) {
@@ -595,7 +640,8 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 		WARN_ON_ONCE(!mld_vif->nan.mac_added);
 
 		/* mac80211 should reconfigure same state */
-		if (!WARN_ON_ONCE(mld->fw_status.in_hw_restart))
+		if (!WARN_ON_ONCE(mld->fw_status.in_hw_restart &&
+				  !iwl_mld_error_before_recovery(mld)))
 			iwl_mld_rm_vif(mld, vif);
 	}
 }
-- 
2.34.1


