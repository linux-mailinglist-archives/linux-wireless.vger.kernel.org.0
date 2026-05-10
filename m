Return-Path: <linux-wireless+bounces-36152-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLHxEAzRAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36152-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B79F505B9B
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B381300288B
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9712FF641;
	Sun, 10 May 2026 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7dS+Z5q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148F315D5B
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438402; cv=none; b=huMCP7p4sy0sQxHEwjjXhWe2K4JO1RbP9D1JNg+PTzZD7kHDYDoJAEPPf5resGmqXtjVqxoQSBG5KL9VZ3vy61Q+1cdNTdT5EIaj1FT9W5hIsrB1+p7i1P4qHhaIzY2oGlyuSD4RdpMMt2KXh2qQ6EQNBdDS6e/xZTxUSCfsmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438402; c=relaxed/simple;
	bh=fIM9dYnNXKPnNvkWH26idswA/I6YD1ImfWVSA7CrQHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdSh2qWxKOLI1inm1eUq6Fk0UIkjunbvraz/uxs8G0IY2gxLW8aIv1faLsYcHEQQPfKttFECNk0LWY9zkigjhPO9mhWOppd+rgmQocclhfrejTuJgwe6jeJ2TwMxTqeIRlZ1w2DsNY5FIvt0C4Xil+ObrYMSGAOys5hHAHgx8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7dS+Z5q; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438401; x=1809974401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fIM9dYnNXKPnNvkWH26idswA/I6YD1ImfWVSA7CrQHI=;
  b=g7dS+Z5qOscfTDK6wxwFJHafk+lH/2hZl5TRbSZwKI6d9FAHvRq1Q8QL
   nVaYopmftd+EBhHXV5JRpNpPM5gc1XZ7Y/zjd7NbF3JDf0OM5ykBcLt3z
   V4iRsCVBosTXJl0VN52To9fetWmYfb4zX0J13dEz0s7K9hhATsDRq619p
   IzJOeXGf0uvslNTMZkqnU4cQmWaTyFglhV94DK/QqIre3Gg6JbHtIdBoY
   cdGCGsPfWFG1EkSUI0aplppHXiu3z+4yhKjetw+7j7sdYFnZX1u9PWN37
   rKYPiSqKqs3spmP9uHcOKBPMjGoJz1E5Eq1d6wHUNr045kYSxch+/cay6
   g==;
X-CSE-ConnectionGUID: w/rh8a9MSBOUJfZc99sZbw==
X-CSE-MsgGUID: C8Y+kUi+SOKeEC9Tf+NpGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208977"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208977"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:01 -0700
X-CSE-ConnectionGUID: cC00pvs4SLCw0qx1ZxC7Wg==
X-CSE-MsgGUID: 9joC3unQSvuTnI1eUo606w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626775"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:39:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: implement NAN peer station management
Date: Sun, 10 May 2026 21:39:30 +0300
Message-Id: <20260510213745.31762a2ad747.I3bd01266e47f24fb7f1240db62ac3bd47c479127@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
References: <20260510183938.4182886-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B79F505B9B
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-36152-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

Implement peer station management for NAN, i.e. support for adding,
removing, and updating NMI and NDI stations.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 35 +++++--
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  | 96 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |  4 +-
 4 files changed, 109 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 3c84c6b0faaa..6b4b2683cd1e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1841,7 +1841,7 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 		   new_state == IEEE80211_STA_AUTHORIZED) {
 		ret = 0;
 
-		if (!sta->tdls) {
+		if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 			mld_vif->authorized = true;
 
 			/* Ensure any block due to a non-BSS link is synced */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index eba79aca8c06..53d39717deab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -464,19 +464,17 @@ static int iwl_mld_nan_link_set_active(struct iwl_mld *mld,
 }
 
 static void iwl_mld_nan_link_remove(struct iwl_mld *mld,
-				    struct iwl_mld_nan_link *nan_link)
+				    struct iwl_mld_nan_link *nan_link,
+				    u32 link_id)
 {
 	struct iwl_link_config_cmd cmd = {
-		.link_id = cpu_to_le32(nan_link->fw_id),
+		.link_id = cpu_to_le32(link_id),
 		.phy_id = cpu_to_le32(FW_CTXT_ID_INVALID),
 	};
 
-	if (WARN_ON_ONCE(nan_link->fw_id == FW_CTXT_ID_INVALID))
-		return;
-
 	iwl_mld_send_link_cmd(mld, &cmd, FW_CTXT_ACTION_REMOVE);
 
-	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[nan_link->fw_id], NULL);
+	RCU_INIT_POINTER(mld->fw_id_to_bss_conf[link_id], NULL);
 	nan_link->fw_id = FW_CTXT_ID_INVALID;
 	nan_link->active = false;
 	nan_link->chanctx = NULL;
@@ -518,6 +516,8 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 	struct ieee80211_nan_channel **slots = sched_cfg->schedule;
 	bool link_used[ARRAY_SIZE(mld_vif->nan.links)] = {};
 	struct iwl_mld_nan_link *nan_link;
+	unsigned long remove_link_ids = 0;
+	bool added_links = false;
 	bool empty_schedule = true;
 	int ret, i;
 
@@ -588,6 +588,7 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 
 		/* we have a link, activate it */
 		if (links[i]) {
+			added_links = true;
 			link_used[links[i]->fw_id] = true;
 			iwl_mld_nan_link_set_active(mld, links[i], true);
 		}
@@ -626,14 +627,32 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 	if (ret)
 		IWL_ERR(mld, "NAN: failed to update schedule (%d)\n", ret);
 
-	/* delete unused links */
+	/* prepare stations for links we'll remove */
 	for_each_mld_nan_valid_link(mld_vif, nan_link) {
 		if (!link_used[nan_link->fw_id]) {
 			iwl_mld_nan_link_set_active(mld, nan_link, false);
-			iwl_mld_nan_link_remove(mld, nan_link);
+			remove_link_ids |= BIT(nan_link->fw_id);
+			/* mark unused for STA updates */
+			nan_link->fw_id = FW_CTXT_ID_INVALID;
+		}
+	}
+
+	if (added_links || remove_link_ids) {
+		struct ieee80211_sta *sta;
+
+		for_each_station(sta, mld->hw) {
+			struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+
+			if (mld_sta->sta_type == STATION_TYPE_NAN_PEER_NMI ||
+			    mld_sta->sta_type == STATION_TYPE_NAN_PEER_NDI)
+				iwl_mld_add_modify_sta_cmd(mld, &sta->deflink);
 		}
 	}
 
+	/* delete unused links */
+	for_each_set_bit(i, &remove_link_ids, ARRAY_SIZE(mld_vif->nan.links))
+		iwl_mld_nan_link_remove(mld, &mld_vif->nan.links[i], i);
+
 	/* remove MAC if needed */
 	if (!previously_empty_schedule && empty_schedule) {
 		/* must have been added */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 4c97d12ce2d0..f794f80b0fdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -13,6 +13,7 @@
 #include "key.h"
 #include "agg.h"
 #include "tlc.h"
+#include "nan.h"
 #include "fw/api/sta.h"
 #include "fw/api/mac.h"
 #include "fw/api/rx.h"
@@ -43,13 +44,13 @@ int iwl_mld_fw_sta_id_from_link_sta(struct iwl_mld *mld,
 
 static void
 iwl_mld_fill_ampdu_size_and_dens(struct ieee80211_link_sta *link_sta,
-				 struct ieee80211_bss_conf *link,
+				 bool is_6ghz,
 				 __le32 *tx_ampdu_max_size,
 				 __le32 *tx_ampdu_spacing)
 {
 	u32 agg_size = 0, mpdu_dens = 0;
 
-	if (WARN_ON(!link_sta || !link))
+	if (WARN_ON(!link_sta))
 		return;
 
 	/* Note that we always use only legacy & highest supported PPDUs, so
@@ -63,7 +64,7 @@ iwl_mld_fill_ampdu_size_and_dens(struct ieee80211_link_sta *link_sta,
 		mpdu_dens = link_sta->ht_cap.ampdu_density;
 	}
 
-	if (link->chanreq.oper.chan->band == NL80211_BAND_6GHZ) {
+	if (is_6ghz) {
 		/* overwrite HT values on 6 GHz */
 		mpdu_dens =
 			le16_get_bits(link_sta->he_6ghz_capa.capa,
@@ -439,29 +440,56 @@ static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
 	return ret;
 }
 
-static int
-iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
-			   struct ieee80211_link_sta *link_sta)
+int iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
+			      struct ieee80211_link_sta *link_sta)
 {
 	struct ieee80211_sta *sta = link_sta->sta;
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
-	struct ieee80211_bss_conf *link;
-	struct iwl_mld_link *mld_link;
 	struct iwl_sta_cfg_cmd cmd = {};
 	int fw_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+	bool is_6ghz, uora_exists;
+	u32 link_mask;
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	link = link_conf_dereference_protected(mld_sta->vif,
-					       link_sta->link_id);
+	if (WARN_ON(fw_id < 0))
+		return -EINVAL;
+
+	if (mld_sta->sta_type == STATION_TYPE_NAN_PEER_NMI ||
+	    mld_sta->sta_type == STATION_TYPE_NAN_PEER_NDI) {
+		struct iwl_mld_nan_link *nan_link;
+		struct iwl_mld_vif *nan_dev;
 
-	mld_link = iwl_mld_link_from_mac80211(link);
+		is_6ghz = false;
+		uora_exists = false;
 
-	if (WARN_ON(!link || !mld_link) || fw_id < 0)
-		return -EINVAL;
+		if (WARN_ON(!mld->nan_device_vif))
+			return -EINVAL;
+
+		nan_dev = iwl_mld_vif_from_mac80211(mld->nan_device_vif);
+
+		link_mask = 0;
+
+		for_each_mld_nan_valid_link(nan_dev, nan_link)
+			link_mask |= BIT(nan_link->fw_id);
+	} else {
+		struct ieee80211_bss_conf *link;
+		struct iwl_mld_link *mld_link;
+
+		link = link_conf_dereference_protected(mld_sta->vif,
+						       link_sta->link_id);
+		mld_link = iwl_mld_link_from_mac80211(link);
+
+		if (WARN_ON(!link || !mld_link))
+			return -EINVAL;
+
+		link_mask = BIT(mld_link->fw_id);
+		is_6ghz = link->chanreq.oper.chan->band == NL80211_BAND_6GHZ;
+		uora_exists = link->uora_exists;
+	}
 
 	cmd.sta_id = cpu_to_le32(fw_id);
-	cmd.link_mask = cpu_to_le32(BIT(mld_link->fw_id));
+	cmd.link_mask = cpu_to_le32(link_mask);
 	cmd.station_type = cpu_to_le32(mld_sta->sta_type);
 
 	memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
@@ -499,7 +527,7 @@ iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 		break;
 	}
 
-	iwl_mld_fill_ampdu_size_and_dens(link_sta, link,
+	iwl_mld_fill_ampdu_size_and_dens(link_sta, is_6ghz,
 					 &cmd.tx_ampdu_max_size,
 					 &cmd.tx_ampdu_spacing);
 
@@ -511,7 +539,7 @@ iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 
 	if (link_sta->he_cap.has_he) {
 		cmd.trig_rnd_alloc =
-			cpu_to_le32(link->uora_exists ? 1 : 0);
+			cpu_to_le32(uora_exists ? 1 : 0);
 
 		/* PPE Thresholds */
 		iwl_mld_fill_pkt_ext(mld, link_sta, &cmd.pkt_ext);
@@ -525,6 +553,25 @@ iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 			cmd.ack_enabled = cpu_to_le32(1);
 	}
 
+	if (mld_sta->sta_type == STATION_TYPE_NAN_PEER_NDI) {
+		struct ieee80211_sta *nmi_sta =
+			wiphy_dereference(mld->wiphy, sta->nmi);
+		int nmi_fw_id;
+
+		/* copy the local NDI address */
+		ether_addr_copy(cmd.ndi_local_addr, mld_sta->vif->addr);
+
+		if (WARN_ON(!nmi_sta))
+			return -EINVAL;
+
+		nmi_fw_id = iwl_mld_fw_sta_id_from_link_sta(mld,
+					&nmi_sta->deflink);
+		if (nmi_fw_id < 0)
+			return -EINVAL;
+
+		cmd.nmi_sta_id = (u8) nmi_fw_id;
+	}
+
 	return iwl_mld_send_sta_cmd(mld, &cmd);
 }
 
@@ -759,10 +806,23 @@ int iwl_mld_add_sta(struct iwl_mld *mld, struct ieee80211_sta *sta,
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
 	struct ieee80211_link_sta *link_sta;
+	enum iwl_fw_sta_type type;
 	int link_id;
 	int ret;
 
-	ret = iwl_mld_init_sta(mld, sta, vif, STATION_TYPE_PEER);
+	switch (vif->type) {
+	case NL80211_IFTYPE_NAN:
+		type = STATION_TYPE_NAN_PEER_NMI;
+		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		type = STATION_TYPE_NAN_PEER_NDI;
+		break;
+	default:
+		type = STATION_TYPE_PEER;
+		break;
+	}
+
+	ret = iwl_mld_init_sta(mld, sta, vif, type);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index 36288c2fb38c..13644ffd185d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 
 #ifndef __iwl_mld_sta_h__
@@ -195,6 +195,8 @@ void iwl_mld_remove_sta(struct iwl_mld *mld, struct ieee80211_sta *sta);
 int iwl_mld_fw_sta_id_from_link_sta(struct iwl_mld *mld,
 				    struct ieee80211_link_sta *link_sta);
 u32 iwl_mld_fw_sta_id_mask(struct iwl_mld *mld, struct ieee80211_sta *sta);
+int iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
+			       struct ieee80211_link_sta *link_sta);
 int iwl_mld_update_all_link_stations(struct iwl_mld *mld,
 				     struct ieee80211_sta *sta);
 void iwl_mld_flush_sta_txqs(struct iwl_mld *mld, struct ieee80211_sta *sta);
-- 
2.34.1


