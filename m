Return-Path: <linux-wireless+bounces-22780-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 581CAAB1108
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E254C310D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99728FAA8;
	Fri,  9 May 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPY+sIgv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865F28FFDA
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787525; cv=none; b=Xdsm71pOWV8ThpQvZZrR3uN5c/fKVpP7CuJE7DYhnYzMblX4vdyOdDiniZXN4MiySHOu3QMVCmP+gyFHGRp4mfQSbKVXk6MuM8xj6UTrCGm6S+5CQBbiIH3SP06nhhXcq+0rBebyyELkWFFRoB+wqWZzL9jWZKgKTDw5rPb2/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787525; c=relaxed/simple;
	bh=dZQqkF0J9hMPstf+Eu1YQJ/At0V+0N/BH1LIyClWqgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBSRVOOQJhyCxvK5MqDMkYqp5y8Eg3B0YrnnUQyJ899u4mWV8muVmNlqBHoZ/Ro+WIHMS9kxiMBNRzs96y6riI2uSuHGKxSs2lJtC3WDRKFhGPFPIpovX6B5AVsvsxXiwgq4JEWsbRmarfpDoMm+RFqVndXWug3G2atF3VZ0lzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPY+sIgv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787523; x=1778323523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dZQqkF0J9hMPstf+Eu1YQJ/At0V+0N/BH1LIyClWqgQ=;
  b=XPY+sIgvOsZv+JSWYLEV6CYCMcNccTO1Qdcx8jq+6oPcjCGsQxHOocs8
   zzUvBnkK8beHa7LazgtUgA+P+2Aro11VlACLtRaY6WZbZUczRRwO1vDQM
   HcJLuwnesMaj401L8LJsRk8WlJaxnYisD9Y/+KwS08MdncH0VLeDGL1cB
   AV1dEdnQvcBPsv+T0MJzK57ytDUkpEynpZnAiIk5HiF/AA4ZHhcXyQtAz
   8/3iWJHMWfKvl3gBQ22oMYBPRwUrl2vkxjq7Hv/BbXkxH3KNlE24BFVZp
   tsUwT7X432gUFUU7oL54drRaC1btuQ3f4UCu3k8J46D081uCA73NlXXP0
   A==;
X-CSE-ConnectionGUID: DkM/8khSQ0WsA869exIWew==
X-CSE-MsgGUID: VjnVTV1nTZir+iSo8Mwk6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239903"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239903"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:23 -0700
X-CSE-ConnectionGUID: kDERtkVlTBmAWkMItq2rag==
X-CSE-MsgGUID: tMEA4PLPSpKVUh9OtBGXyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537048"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: mld: move aux_sta member from iwl_mld_link to iwl_mld_vif
Date: Fri,  9 May 2025 13:44:50 +0300
Message-Id: <20250509104454.2582160-12-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
References: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

This change reflects the correct ownership of aux_sta,
as it is not a property of the link but rather of the virtual interface.
Updated the initialization, cleanup and access logic for the aux_sta member
to align with its new location within iwl_mld_vif.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Message-Id: <20250509134302.d74e0bd6f605.Ia5e0d50f7f0a605b8873a040a828b1672e070bf8@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c |  4 ++++
 drivers/net/wireless/intel/iwlwifi/mld/iface.h |  2 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.c  |  1 -
 drivers/net/wireless/intel/iwlwifi/mld/link.h  |  4 ----
 drivers/net/wireless/intel/iwlwifi/mld/roc.c   |  9 +++------
 drivers/net/wireless/intel/iwlwifi/mld/sta.c   | 10 +++-------
 drivers/net/wireless/intel/iwlwifi/mld/sta.h   |  3 +--
 drivers/net/wireless/intel/iwlwifi/mld/tx.c    |  2 +-
 8 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index fdb7a3b3107d..3aacca5ed6a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -22,6 +22,9 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 	struct iwl_mld *mld = mld_vif->mld;
 	struct iwl_mld_link *link;
 
+	if (mld_vif->aux_sta.sta_id != IWL_INVALID_STA)
+		iwl_mld_free_internal_sta(mld, &mld_vif->aux_sta);
+
 	/* EMLSR is turned back on during recovery */
 	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
 
@@ -408,6 +411,7 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 		wiphy_delayed_work_init(&mld_vif->emlsr.tmp_non_bss_done_wk,
 					iwl_mld_emlsr_tmp_non_bss_done_wk);
 	}
+	iwl_mld_init_internal_sta(&mld_vif->aux_sta);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 3437f0c422cf..15b437110351 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -143,6 +143,7 @@ struct iwl_mld_emlsr {
  * @dbgfs_slink: debugfs symlink for this interface
  * @roc_activity: the id of the roc_activity running. Relevant for p2p device
  *	only. Set to %ROC_NUM_ACTIVITIES when not in use.
+ * @aux_sta: station used for remain on channel. Used in P2P device.
  */
 struct iwl_mld_vif {
 	/* Add here fields that need clean up on restart */
@@ -177,6 +178,7 @@ struct iwl_mld_vif {
 	struct dentry *dbgfs_slink;
 #endif
 	enum iwl_roc_activity roc_activity;
+	struct iwl_mld_int_sta aux_sta;
 };
 
 static inline struct iwl_mld_vif *
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 80f7290ef8b2..d0f56189ad3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -782,7 +782,6 @@ iwl_mld_init_link(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 
 	iwl_mld_init_internal_sta(&mld_link->bcast_sta);
 	iwl_mld_init_internal_sta(&mld_link->mcast_sta);
-	iwl_mld_init_internal_sta(&mld_link->aux_sta);
 	iwl_mld_init_internal_sta(&mld_link->mon_sta);
 
 	if (!mld->fw_status.in_hw_restart)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.h b/drivers/net/wireless/intel/iwlwifi/mld/link.h
index 86ca5b9286f8..39f04aae5579 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.h
@@ -39,7 +39,6 @@ struct iwl_probe_resp_data {
  * @vif: the vif this link belongs to
  * @bcast_sta: station used for broadcast packets. Used in AP, GO and IBSS.
  * @mcast_sta: station used for multicast packets. Used in AP, GO and IBSS.
- * @aux_sta: station used for remain on channel. Used in P2P device.
  * @mon_sta: station used for TX injection in monitor interface.
  * @link_id: over the air link ID
  * @ap_early_keys: The firmware cannot install keys before bcast/mcast STAs,
@@ -73,7 +72,6 @@ struct iwl_mld_link {
 	struct ieee80211_vif *vif;
 	struct iwl_mld_int_sta bcast_sta;
 	struct iwl_mld_int_sta mcast_sta;
-	struct iwl_mld_int_sta aux_sta;
 	struct iwl_mld_int_sta mon_sta;
 	u8 link_id;
 
@@ -107,8 +105,6 @@ iwl_mld_cleanup_link(struct iwl_mld *mld, struct iwl_mld_link *link)
 		iwl_mld_free_internal_sta(mld, &link->bcast_sta);
 	if (link->mcast_sta.sta_id != IWL_INVALID_STA)
 		iwl_mld_free_internal_sta(mld, &link->mcast_sta);
-	if (link->aux_sta.sta_id != IWL_INVALID_STA)
-		iwl_mld_free_internal_sta(mld, &link->aux_sta);
 	if (link->mon_sta.sta_id != IWL_INVALID_STA)
 		iwl_mld_free_internal_sta(mld, &link->mon_sta);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/roc.c b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
index b87faca23ceb..ac52cc06e4d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/roc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/roc.c
@@ -37,7 +37,7 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct iwl_mld_int_sta *aux_sta;
+	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
 	struct iwl_roc_req cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
 	};
@@ -79,9 +79,6 @@ int iwl_mld_start_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (WARN_ON(mld_vif->roc_activity != ROC_NUM_ACTIVITIES))
 		return -EBUSY;
 
-	/* No MLO on P2P device */
-	aux_sta = &mld_vif->deflink.aux_sta;
-
 	ret = iwl_mld_add_aux_sta(mld, aux_sta);
 	if (ret)
 		return ret;
@@ -136,9 +133,9 @@ static void iwl_mld_destroy_roc(struct iwl_mld *mld,
 	 * we can flush the Tx on the queues
 	 */
 
-	iwl_mld_flush_link_sta_txqs(mld, mld_vif->deflink.aux_sta.sta_id);
+	iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
 
-	iwl_mld_remove_aux_sta(mld, vif, &vif->bss_conf);
+	iwl_mld_remove_aux_sta(mld, vif);
 }
 
 int iwl_mld_cancel_roc(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 317388ad2170..bc5313f44fde 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -1160,19 +1160,15 @@ void iwl_mld_remove_mcast_sta(struct iwl_mld *mld,
 }
 
 void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
-			    struct ieee80211_vif *vif,
-			    struct ieee80211_bss_conf *link)
+			    struct ieee80211_vif *vif)
 {
-	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
-
-	if (WARN_ON(!mld_link))
-		return;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 
 	/* TODO: Hotspot 2.0 */
 	if (WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE))
 		return;
 
-	iwl_mld_remove_internal_sta(mld, &mld_link->aux_sta, false,
+	iwl_mld_remove_internal_sta(mld, &mld_vif->aux_sta, false,
 				    IWL_MAX_TID_COUNT);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index c45d815d0c73..1897b121aae2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -260,8 +260,7 @@ void iwl_mld_remove_mcast_sta(struct iwl_mld *mld,
 			      struct ieee80211_bss_conf *link);
 
 void iwl_mld_remove_aux_sta(struct iwl_mld *mld,
-			    struct ieee80211_vif *vif,
-			    struct ieee80211_bss_conf *link);
+			    struct ieee80211_vif *vif);
 
 void iwl_mld_remove_mon_sta(struct iwl_mld *mld,
 			    struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index e478afbc61f4..96ea6320c084 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -645,7 +645,7 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 
 		WARN_ON(!ieee80211_is_mgmt(fc));
 
-		return mld_vif->deflink.aux_sta.queue_id;
+		return mld_vif->aux_sta.queue_id;
 	case NL80211_IFTYPE_MONITOR:
 		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
 		return mld_vif->deflink.mon_sta.queue_id;
-- 
2.34.1


