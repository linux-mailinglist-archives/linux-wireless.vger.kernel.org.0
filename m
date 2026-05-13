Return-Path: <linux-wireless+bounces-36371-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJIrFUYQBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36371-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF13E52DB79
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A5D30D459C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211983A5E8C;
	Wed, 13 May 2026 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9uPpK72"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2353A6B67
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651076; cv=none; b=tu1KdkIFLjElbJoOJntqkI7LQPhJx1nMrSmF2wdGsh28iUdWjDd9LeW5dqyx6dGoePcLxAudGzmrfEYY6WWK1mpMNnHd9SShbEF1pxHyN84BfKIgxhpA3HvqvHncwBOCkthq35JYwT7WXudyVL1W+JXGH4bmKl9/lZ7shMtrBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651076; c=relaxed/simple;
	bh=qH1O9YAWQL4xW3ydzZ0s+oEONkza4ZXLIDjhOvQX404=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDyLCqVLrILHn+UX8QT1ZwcuIhKAV/mD52Hd/4cYjujmLKV8sKH8TgSZIg75dN5ohOZ1aVGjCQiGZcSwbCN+n53GuaeR+UDLBSns4xGYVaThRp2ii1lHEFE2B9XwZUbs2biF0sVkz4zXPSTD/QFbOfVj1kgRygWoafqVu6JN4FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9uPpK72; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651074; x=1810187074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qH1O9YAWQL4xW3ydzZ0s+oEONkza4ZXLIDjhOvQX404=;
  b=h9uPpK72jx2C/tlXZ5Nq7Q/8KVZHmupxP7XKFKWX/CU9nV/94XUgtcfB
   TMchi+DsKXPkMF9Q20xt5kmenuhC8/ewoFlod+1z+QLlJ+9eKXoV1rXS7
   HMJY+x2VzPydRjVE+CMjpFnMDPT6yFRiIKb1Wh74XTQCnzjqxwnKNK9M8
   +hORzesCIV7PeirDRmhzrbsIrSJ3tmFBTDH+9ZKXzjagntwRJdNX9f/sq
   kWExYpl//kMvKewa4uC4wDT4hsXKOgKDPqCq9dOa9QiFM8eJ+alzyW2kp
   NWNfdDNe9JnjU8xqJe+MgaTmvY1yqqOfEhQOJoIEdZBWMCRzjcojPjeJ/
   g==;
X-CSE-ConnectionGUID: sk4uka5DSd6lR4C9bNIZRg==
X-CSE-MsgGUID: 2HwuYHG8TWqaj2+3jjgdsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552851"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552851"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:34 -0700
X-CSE-ConnectionGUID: D7WgC7tZRDy0ZKhBC4XhAw==
X-CSE-MsgGUID: rpzCDYEcQjKwCKj9e4eL0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077950"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: Add support for NAN multicast data
Date: Wed, 13 May 2026 08:44:01 +0300
Message-Id: <20260513084215.1d8e3463717d.I57deaea42bce9afee63f284a57eb8755485e7ea8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CF13E52DB79
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
	TAGGED_FROM(0.00)[bounces-36371-lists,linux-wireless=lfdr.de];
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

From: Ilan Peer <ilan.peer@intel.com>

The FW added a new station type to allow NAN multicast
data to be transmitted. The queue of the station is
opened by the firmware when all the NAN Peer NDI stations
associated with the NDI are scheduled at the same time.

Add the corresponding support in iwlmld:

- When a NAN data interface is added, add a NAN multicast
  data station and allocate a queue to it.
- When a NAN data interface is removed, remove the NAN
  multicast station.
- On the Tx path, when a multicast data frame is received
  on a NAN data interface, direct it to the NAN multicast
  data queue.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  6 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  6 ++
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 32 ++++++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 29 +++++-
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  | 94 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  | 11 +++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   | 11 ++-
 9 files changed, 172 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 604281eb29c7..d03a2bda4e68 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -747,6 +747,8 @@ struct iwl_link_config_cmd {
  *	discovery. No queue is associated with this station.
  * @STATION_TYPE_NAN_MGMT: NAN station used for NAN management frames, e.g.,
  *	SDFs and NAFs.
+ * @STATION_TYPE_NAN_MCAST_DATA: NAN station used for multicast NAN data
+ *	frames.
  * @STATION_TYPE_MAX: maximum number of FW station types
  * @STATION_TYPE_AUX: aux sta. In the FW there is no need for a special type
  *	for the aux sta, so this type is only for driver - internal use.
@@ -759,6 +761,7 @@ enum iwl_fw_sta_type {
 	STATION_TYPE_NAN_PEER_NDI,
 	STATION_TYPE_NAN_BCAST,
 	STATION_TYPE_NAN_MGMT,
+	STATION_TYPE_NAN_MCAST_DATA,
 	STATION_TYPE_MAX,
 	STATION_TYPE_AUX = STATION_TYPE_MAX /* this doesn't exist in FW */
 }; /* STATION_TYPE_E_VER_1, _VER_2 */
@@ -933,7 +936,8 @@ struct iwl_sta_cfg_cmd_v2 {
  * @mic_prep_pad_delay: MIC prep time padding
  * @mic_compute_pad_delay: MIC compute time padding
  * @nmi_sta_id: for an NDI peer STA, the NMI peer STA ID it relates to
- * @ndi_local_addr: for an NDI peer STA, the local NDI interface MAC address
+ * @ndi_local_addr: for an NDI peer STA or NAN multicast data station,
+ *	the local NDI interface MAC address
  * @reserved: Reserved for alignment
  */
 struct iwl_sta_cfg_cmd {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index f7a0a8efe374..399efeb469f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -68,6 +68,10 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 			iwl_mld_free_internal_sta(mld, &mld_vif->nan.mgmt_sta);
 	}
 
+	if (vif->type == NL80211_IFTYPE_NAN_DATA &&
+	    mld_vif->nan.mcast_data_sta.sta_id != IWL_INVALID_STA)
+		iwl_mld_free_internal_sta(mld, &mld_vif->nan.mcast_data_sta);
+
 	CLEANUP_STRUCT(mld_vif);
 }
 
@@ -534,6 +538,8 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 
 		iwl_mld_init_internal_sta(&mld_vif->nan.bcast_sta);
 		iwl_mld_init_internal_sta(&mld_vif->nan.mgmt_sta);
+	} else if (vif->type == NL80211_IFTYPE_NAN_DATA) {
+		iwl_mld_init_internal_sta(&mld_vif->nan.mcast_data_sta);
 	}
 
 	iwl_mld_init_internal_sta(&mld_vif->aux_sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index 75b6727503d3..c6a7588df1fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -159,6 +159,7 @@ struct iwl_mld_emlsr {
  *	activities. No queue is associated with it.
  * @nan.mgmt_sta: internal station used for NAN management frames, e.g., SDFs
  *	and NAFs.
+ * @nan.mcast_data_sta: internal station used for multicast NAN Data frames.
  */
 struct iwl_mld_vif {
 	/* Add here fields that need clean up on restart */
@@ -187,6 +188,7 @@ struct iwl_mld_vif {
 		bool mac_added;
 		struct iwl_mld_int_sta bcast_sta;
 		struct iwl_mld_int_sta mgmt_sta;
+		struct iwl_mld_int_sta mcast_data_sta;
 	} nan;
 
 	struct iwl_mld_emlsr emlsr;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 1f2843af39c1..b6df09812dae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -663,8 +663,27 @@ int iwl_mld_mac80211_add_interface(struct ieee80211_hw *hw,
 	if (ret)
 		return ret;
 
-	if (vif->type == NL80211_IFTYPE_NAN_DATA)
+	if (vif->type == NL80211_IFTYPE_NAN_DATA) {
+		if (WARN_ON(!mld->nan_device_vif)) {
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (iwl_mld_nan_use_nan_stations(mld)) {
+			struct iwl_mld_vif *mld_vif =
+				iwl_mld_vif_from_mac80211(vif);
+			struct iwl_mld_int_sta *sta =
+				&mld_vif->nan.mcast_data_sta;
+
+			ret = iwl_mld_add_nan_mcast_data_sta(mld,
+							     vif->addr,
+							     sta);
+			if (ret)
+				goto err;
+		}
+
 		return 0;
+	}
 
 	/*
 	 * Add the default link, but not if this is an MLD vif as that implies
@@ -732,10 +751,17 @@ void iwl_mld_mac80211_remove_interface(struct ieee80211_hw *hw,
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		mld->p2p_device_vif = NULL;
 
-	if (vif->type == NL80211_IFTYPE_NAN)
+	if (vif->type == NL80211_IFTYPE_NAN) {
 		mld->nan_device_vif = NULL;
-	else if (vif->type != NL80211_IFTYPE_NAN_DATA)
+	} else if (vif->type != NL80211_IFTYPE_NAN_DATA) {
 		iwl_mld_remove_link(mld, &vif->bss_conf);
+	} else if (iwl_mld_nan_use_nan_stations(mld)) {
+		struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+		struct iwl_mld_int_sta *sta = &mld_vif->nan.mcast_data_sta;
+
+		if (sta->sta_id != IWL_INVALID_STA)
+			iwl_mld_remove_nan_mcast_data_sta(mld, sta);
+	}
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove(iwl_mld_vif_from_mac80211(vif)->dbgfs_slink);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 8f35687c58b1..530ba263c5f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -50,7 +50,7 @@ static int iwl_mld_nan_send_config_cmd(struct iwl_mld *mld,
 	return iwl_mld_send_cmd(mld, &hcmd);
 }
 
-static bool iwl_mld_nan_use_nan_stations(struct iwl_mld *mld)
+bool iwl_mld_nan_use_nan_stations(struct iwl_mld *mld)
 {
 	/*
 	 * If the FW supports version 1 of the NAN config command, it means that
@@ -650,6 +650,20 @@ iwl_mld_nan_find_link(struct iwl_mld_vif *mld_vif,
 	return NULL;
 }
 
+static void iwl_mld_nan_set_mcast_data_links(struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	if (vif->type != NL80211_IFTYPE_NAN_DATA)
+		return;
+
+	/* Note that all errors are handled internally so nothing to do
+	 * with the return value (used only to silence compilation warnings)
+	 */
+	iwl_mld_update_nan_mcast_data_sta(mld_vif->mld, vif->addr,
+					  &mld_vif->nan.mcast_data_sta);
+}
+
 void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 u64 changes)
@@ -807,6 +821,19 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 			    mld_sta->sta_type == STATION_TYPE_NAN_PEER_NDI)
 				iwl_mld_add_modify_sta_cmd(mld, &sta->deflink);
 		}
+
+		/*
+		 * Iterate over all the NAN Data interfaces and update the links
+		 * for the internal multicast data station.
+		 * In recovery - the station will be added later in
+		 * drv_add_interface
+		 */
+		if (iwl_mld_nan_use_nan_stations(mld) && !mld->fw_status.in_hw_restart) {
+			struct ieee80211_vif *iter;
+
+			for_each_active_interface(iter, mld->hw)
+				iwl_mld_nan_set_mcast_data_links(iter);
+		}
 	}
 
 	/* delete unused links */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index 40152dc7d906..f4e4cd4b4e8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -60,4 +60,6 @@ int iwl_mld_mac802111_nan_peer_sched_changed(struct ieee80211_hw *hw,
 
 int iwl_mld_nan_get_mgmt_queue(struct iwl_mld *mld, struct ieee80211_vif *vif);
 
+bool iwl_mld_nan_use_nan_stations(struct iwl_mld *mld);
+
 #endif /* __iwl_mld_nan_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index 4c168ad53b0f..cd13238ed613 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -428,6 +428,10 @@ static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
 
 		len = sizeof(struct iwl_sta_cfg_cmd_v2);
 		cmd_v2->link_id = cpu_to_le32(__ffs(le32_to_cpu(cmd->link_mask)));
+	} else if (cmd->station_type ==
+		   cpu_to_le32(STATION_TYPE_NAN_MCAST_DATA)) {
+		if (WARN_ON(!hweight32(le32_to_cpu(cmd->link_mask))))
+			return -EINVAL;
 	} else if (WARN_ON(cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_PEER_NMI) &&
 			   cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_PEER_NDI) &&
 			   cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_BCAST) &&
@@ -442,6 +446,19 @@ static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
 	return ret;
 }
 
+static u32 iwl_mld_get_nan_link_mask(struct iwl_mld *mld)
+{
+	struct iwl_mld_vif *nan_dev =
+		iwl_mld_vif_from_mac80211(mld->nan_device_vif);
+	struct iwl_mld_nan_link *nan_link;
+	u32 link_mask = 0;
+
+	for_each_mld_nan_valid_link(nan_dev, nan_link)
+		link_mask |= BIT(nan_link->fw_id);
+
+	return link_mask;
+}
+
 int iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 			      struct ieee80211_link_sta *link_sta)
 {
@@ -459,21 +476,13 @@ int iwl_mld_add_modify_sta_cmd(struct iwl_mld *mld,
 
 	if (mld_sta->sta_type == STATION_TYPE_NAN_PEER_NMI ||
 	    mld_sta->sta_type == STATION_TYPE_NAN_PEER_NDI) {
-		struct iwl_mld_nan_link *nan_link;
-		struct iwl_mld_vif *nan_dev;
-
-		is_6ghz = false;
-		uora_exists = false;
-
 		if (WARN_ON(!mld->nan_device_vif))
 			return -EINVAL;
 
-		nan_dev = iwl_mld_vif_from_mac80211(mld->nan_device_vif);
-
-		link_mask = 0;
+		is_6ghz = false;
+		uora_exists = false;
 
-		for_each_mld_nan_valid_link(nan_dev, nan_link)
-			link_mask |= BIT(nan_link->fw_id);
+		link_mask = iwl_mld_get_nan_link_mask(mld);
 	} else {
 		struct ieee80211_bss_conf *link;
 		struct iwl_mld_link *mld_link;
@@ -1063,7 +1072,7 @@ static int iwl_mld_send_aux_sta_cmd(struct iwl_mld *mld,
 }
 
 static int
-iwl_mld_add_internal_sta_to_fw(struct iwl_mld *mld,
+iwl_mld_set_internal_sta_to_fw(struct iwl_mld *mld,
 			       const struct iwl_mld_int_sta *internal_sta,
 			       u32 link_mask, const u8 *addr)
 {
@@ -1085,8 +1094,12 @@ iwl_mld_add_internal_sta_to_fw(struct iwl_mld *mld,
 		cmd.mfp = cpu_to_le32(1);
 
 	if (addr) {
-		memcpy(cmd.peer_mld_address, addr, ETH_ALEN);
-		memcpy(cmd.peer_link_address, addr, ETH_ALEN);
+		if (internal_sta->sta_type == STATION_TYPE_NAN_MCAST_DATA) {
+			ether_addr_copy(cmd.ndi_local_addr, addr);
+		} else {
+			memcpy(cmd.peer_mld_address, addr, ETH_ALEN);
+			memcpy(cmd.peer_link_address, addr, ETH_ALEN);
+		}
 	}
 
 	return iwl_mld_send_sta_cmd(mld, &cmd);
@@ -1108,7 +1121,7 @@ static int iwl_mld_add_internal_sta(struct iwl_mld *mld,
 
 	internal_sta->sta_type = sta_type;
 
-	ret = iwl_mld_add_internal_sta_to_fw(mld, internal_sta, link_mask,
+	ret = iwl_mld_set_internal_sta_to_fw(mld, internal_sta, link_mask,
 					     addr);
 	if (ret)
 		goto err;
@@ -1432,6 +1445,51 @@ int iwl_mld_add_nan_mgmt_sta(struct iwl_mld *mld,
 					0, NULL, IWL_MAX_TID_COUNT, true);
 }
 
+int iwl_mld_add_nan_mcast_data_sta(struct iwl_mld *mld,
+				   const u8 *ndi_addr,
+				   struct iwl_mld_int_sta *sta)
+{
+	u32 link_mask = iwl_mld_get_nan_link_mask(mld);
+
+	/* In case that there are no NAN links, nothing to do */
+	if (!link_mask)
+		return 0;
+
+	return iwl_mld_add_internal_sta(mld, sta,
+					STATION_TYPE_NAN_MCAST_DATA,
+					link_mask, ndi_addr,
+					0, true);
+}
+
+int iwl_mld_update_nan_mcast_data_sta(struct iwl_mld *mld,
+				      const u8 *ndi_addr,
+				      struct iwl_mld_int_sta *sta)
+{
+	u32 link_mask;
+
+	if (WARN_ON(!mld->nan_device_vif))
+		return -EINVAL;
+
+	/* If the sta doesn't exist, add it */
+	if (sta->sta_id == IWL_INVALID_STA)
+		return iwl_mld_add_nan_mcast_data_sta(mld, ndi_addr, sta);
+
+	/* The station was already added */
+	if (WARN_ON(sta->sta_type != STATION_TYPE_NAN_MCAST_DATA))
+		return -EINVAL;
+
+	link_mask = iwl_mld_get_nan_link_mask(mld);
+	if (link_mask)
+		return iwl_mld_set_internal_sta_to_fw(mld,
+						      sta, link_mask,
+						      ndi_addr);
+
+	/* If no links are associated with NAN, remove the station */
+	iwl_mld_remove_nan_mcast_data_sta(mld, sta);
+
+	return 0;
+}
+
 void iwl_mld_remove_nan_bcast_sta(struct iwl_mld *mld,
 				  struct iwl_mld_int_sta *sta)
 {
@@ -1443,3 +1501,9 @@ void iwl_mld_remove_nan_mgmt_sta(struct iwl_mld *mld,
 {
 	iwl_mld_remove_internal_sta(mld, sta, true, IWL_MAX_TID_COUNT);
 }
+
+void iwl_mld_remove_nan_mcast_data_sta(struct iwl_mld *mld,
+				       struct iwl_mld_int_sta *sta)
+{
+	iwl_mld_remove_internal_sta(mld, sta, true, 0);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index df859a9e5230..98d693235c66 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -283,10 +283,21 @@ int iwl_mld_add_nan_bcast_sta(struct iwl_mld *mld,
 int iwl_mld_add_nan_mgmt_sta(struct iwl_mld *mld,
 			     struct iwl_mld_int_sta *sta);
 
+int iwl_mld_add_nan_mcast_data_sta(struct iwl_mld *mld,
+				   const u8 *ndi_addr,
+				   struct iwl_mld_int_sta *sta);
+
+int iwl_mld_update_nan_mcast_data_sta(struct iwl_mld *mld,
+				      const u8 *ndi_addr,
+				      struct iwl_mld_int_sta *sta);
+
 void iwl_mld_remove_nan_bcast_sta(struct iwl_mld *mld,
 				  struct iwl_mld_int_sta *sta);
 
 void iwl_mld_remove_nan_mgmt_sta(struct iwl_mld *mld,
 				 struct iwl_mld_int_sta *sta);
 
+void iwl_mld_remove_nan_mcast_data_sta(struct iwl_mld *mld,
+				       struct iwl_mld_int_sta *sta);
+
 #endif /* __iwl_mld_sta_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 39e1d959e42c..1100f7f1e76f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -351,7 +351,8 @@ u8 iwl_mld_get_lowest_rate(struct iwl_mld *mld,
 	iwl_mld_get_basic_rates_and_band(mld, vif, info, &basic_rates, &band);
 
 	if (band >= NUM_NL80211_BANDS) {
-		WARN_ON(vif->type != NL80211_IFTYPE_NAN);
+		WARN_ON(vif->type != NL80211_IFTYPE_NAN &&
+			vif->type != NL80211_IFTYPE_NAN_DATA);
 		return IWL_FIRST_OFDM_RATE;
 	}
 
@@ -682,6 +683,14 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 	case NL80211_IFTYPE_NAN:
 		WARN_ON(!ieee80211_is_mgmt(fc));
 		return iwl_mld_nan_get_mgmt_queue(mld, info->control.vif);
+	case NL80211_IFTYPE_NAN_DATA:
+		WARN_ON(!ieee80211_is_data(fc));
+
+		if (!iwl_mld_nan_use_nan_stations(mld))
+			break;
+
+		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
+		return mld_vif->nan.mcast_data_sta.queue_id;
 	default:
 		WARN_ONCE(1, "Unsupported vif type\n");
 		break;
-- 
2.34.1


