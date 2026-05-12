Return-Path: <linux-wireless+bounces-36341-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAdwCp6BA2pX6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-36341-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:38:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCD528BCE
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72B63310BF01
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67F429A9C3;
	Tue, 12 May 2026 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVFItXHU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EF3655CE
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614513; cv=none; b=RXlFqdbgp1iE49IMBYkHPLT0SHYmjqDXQ6HpcMrXRE/vugJ3AIUzKhF+8GkBco6EiZTJFcbjdN8wORgCJ/7yzonimzeQKzmzAbqMS7YI5FWRNKCNfP9xTkGz+FvexYa6vI1asyTk7v0TbYTWXFoSX0O4hoaTs57ahq/7ozhtvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614513; c=relaxed/simple;
	bh=SxhRlx6QoKk5rSb3Gs2WUf5oGEgA8aZ+Sr9msnw4k+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eo9uUyjNTvegNxVuT4NIfJyZ9RoiSDVMRCU/pPlb8Owo5jge9JNiY2P6gNqsd+OI+5t1H/iGSzd7+I0PjHSQ2nLI9ZutMPBJvJ0kgoL9iguR1ylujW97BMton6sUJgXZL4qdJY+86/bCDu70OeY3lMdt9fqgxLAPRpE6YzFH1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVFItXHU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778614512; x=1810150512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SxhRlx6QoKk5rSb3Gs2WUf5oGEgA8aZ+Sr9msnw4k+A=;
  b=TVFItXHUx73CZy+S0ZGW+Uj8b+C2JQQKohbBiZ551/kgsmjKJ069xJ1i
   J5ahDItzz5KfPvvpqB/Yj39Xo2YcdIT9yyLfMJWtHJYy1PQpm9hXRJV2r
   TYzg6FzGIR0w25HHnL4NxOPiZ2pdQ6FP+stUDCxv6De0BwAnl6oA99vnl
   5XpXbbS7+Uns63Rt60n/Lf0l5K2Mom6mEnZY9QJ/Ee6LcTIkk6+jJ1pYe
   MHAfB/lGWH6kb+wtpOOYsbJgPVGBFe9oOed2Qj5e/BeGQiMRjy+SezZbI
   DOnA3yySaNlHaZWxLZXh4VN6bc6tgNVgTsga+XxOuF+Bs3oGBpHNYJOV5
   w==;
X-CSE-ConnectionGUID: kQ9kmiF6Sf6j1+p0LpzDSg==
X-CSE-MsgGUID: lbMLKt7iSQ+L6HgBXPyM8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83148803"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83148803"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:11 -0700
X-CSE-ConnectionGUID: XhDxe7moRYW77CrUYb5X+Q==
X-CSE-MsgGUID: zkw8ZxN7RvO+R5wK1nu8jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231471844"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:35:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: Add support for multiple NAN Management stations
Date: Tue, 12 May 2026 22:34:40 +0300
Message-Id: <20260512222731.692bf627811d.I7170dbaa28a74519c012e2d7818e2999819dc478@changeid>
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
X-Rspamd-Queue-Id: 7CDCD528BCE
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
	TAGGED_FROM(0.00)[bounces-36341-lists,linux-wireless=lfdr.de];
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

The following limitations arise from the current FW support for NAN:

- While NAN synchronization and discovery beacons are sent
  internally by the firmware, the BIGTK is configured to the
  auxiliary station associated with the NAN operation. Thus,
  the beacons are transmitted unprotected.
- The auxiliary station cannot be configured with support for
  management frame protection as this is not supported by the
  firmware. Thus, there is no way to protect the SDFs and the
  NAFs.

To overcome the above limitations the firmware introduced the
following new station types:

- NAN broadcast station: Used for NAN synchronization and
  discovery. i.e., used for beacon transmissions. A BIGTK
  can be configured to this station and thus beacons can
  be transmitted with protection.
- NAN management station: Used for sending SDFs and NAFs.
  This station can be configured with support for management
  frame protection etc.

Modify the iwlmld logic to support the older and the newer
firmware designs. As no Tx queue is needed for the NAN
broadcast station, modify the internal station support
to allow adding/removing a station without a queue. In
addition, since no links are associated with these stations,
modify the internal station support to allow adding a station
without a link mask.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  15 ++-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |   8 ++
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   6 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 123 +++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  69 +++++++---
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |  13 ++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   5 +-
 8 files changed, 200 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index dd850aeebdec..1df81df5830e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -735,6 +735,10 @@ struct iwl_link_config_cmd {
  * @STATION_TYPE_NAN_PEER_NDI: NAN data peer station type. A station
  *	of this type can have any number of links (even none) set in the
  *	link_mask. (Supported since version 3.)
+ * @STATION_TYPE_NAN_BCAST: NAN station used for synchronization and
+ *	discovery. No queue is associated with this station.
+ * @STATION_TYPE_NAN_MGMT: NAN station used for NAN management frames, e.g.,
+ *	SDFs and NAFs.
  * @STATION_TYPE_MAX: maximum number of FW station types
  * @STATION_TYPE_AUX: aux sta. In the FW there is no need for a special type
  *	for the aux sta, so this type is only for driver - internal use.
@@ -745,6 +749,8 @@ enum iwl_fw_sta_type {
 	STATION_TYPE_MCAST,
 	STATION_TYPE_NAN_PEER_NMI,
 	STATION_TYPE_NAN_PEER_NDI,
+	STATION_TYPE_NAN_BCAST,
+	STATION_TYPE_NAN_MGMT,
 	STATION_TYPE_MAX,
 	STATION_TYPE_AUX = STATION_TYPE_MAX /* this doesn't exist in FW */
 }; /* STATION_TYPE_E_VER_1, _VER_2 */
@@ -882,7 +888,9 @@ struct iwl_sta_cfg_cmd_v2 {
  * ( STA_CONFIG_CMD = 0xA )
  *
  * @sta_id: index of station in uCode's station table
- * @link_mask: bitmap of link FW IDs used with this STA
+ * @link_mask: bitmap of link FW IDs used with this STA. Should be set to 0
+ *	for STATION_TYPE_NAN_BCAST and STATION_TYPE_NAN_MGMT as they are not
+ *	associated with any link added by the driver.
  * @peer_mld_address: the peers mld address
  * @reserved_for_peer_mld_address: reserved
  * @peer_link_address: the address of the link that is used to communicate
@@ -1213,7 +1221,8 @@ enum iwl_nan_flags {
  * @discovery_beacon_interval: discovery beacon interval in TUs
  * @cluster_id: lower last two bytes of the cluster ID, in case the local
  *	device starts a cluster
- * @sta_id: station ID of the NAN station
+ * @sta_id: station ID of the NAN station. Used only in version 1, in version 2
+ *	it is reserved.
  * @hb_channel: channel for 5 GHz if the device supports operation on 5 GHz.
  *	Valid values are 44 and 149, which correspond to the 5 GHz channel, and
  *	0 which means that NAN operation on the 5 GHz band is disabled.
@@ -1251,7 +1260,7 @@ struct iwl_nan_config_cmd {
 	__le32 nan_attr_len;
 	__le32 nan_vendor_elems_len;
 	u8 beacon_data[];
-} __packed; /*  NAN_CONFIG_CMD_API_S_VER_1 */
+} __packed; /*  NAN_CONFIG_CMD_API_S_VER_1, NAN_CONFIG_CMD_API_S_VER_2 */
 
 /**
  * struct iwl_nan_schedule_cmd_v1 - NAN schedule command
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 6f2590f9a69b..2a270d689de8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -61,6 +61,11 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 		/* Clean up NAN links */
 		for (int i = 0; i < ARRAY_SIZE(mld_vif->nan.links); i++)
 			iwl_mld_cleanup_nan_link(&mld_vif->nan.links[i]);
+
+		if (mld_vif->nan.bcast_sta.sta_id != IWL_INVALID_STA)
+			iwl_mld_free_internal_sta(mld, &mld_vif->nan.bcast_sta);
+		if (mld_vif->nan.mgmt_sta.sta_id != IWL_INVALID_STA)
+			iwl_mld_free_internal_sta(mld, &mld_vif->nan.mgmt_sta);
 	}
 
 	CLEANUP_STRUCT(mld_vif);
@@ -526,6 +531,9 @@ iwl_mld_init_vif(struct iwl_mld *mld, struct ieee80211_vif *vif)
 			memset(&mld_vif->nan.links[i], 0, sizeof(mld_vif->nan.links[i]));
 			mld_vif->nan.links[i].fw_id = FW_CTXT_ID_INVALID;
 		}
+
+		iwl_mld_init_internal_sta(&mld_vif->nan.bcast_sta);
+		iwl_mld_init_internal_sta(&mld_vif->nan.mgmt_sta);
 	}
 
 	iwl_mld_init_internal_sta(&mld_vif->aux_sta);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index d6fb58e785e5..75b6727503d3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -155,6 +155,10 @@ struct iwl_mld_emlsr {
  * @nan: NAN parameters
  * @nan.links: NAN links for FW (indexed by FW link ID)
  * @nan.mac_added: track whether or not the MAC was added to FW
+ * @nan.bcast_sta: internal station used for NAN synchronization and discovery
+ *	activities. No queue is associated with it.
+ * @nan.mgmt_sta: internal station used for NAN management frames, e.g., SDFs
+ *	and NAFs.
  */
 struct iwl_mld_vif {
 	/* Add here fields that need clean up on restart */
@@ -181,6 +185,8 @@ struct iwl_mld_vif {
 		/* use only with wiphy protection */
 		struct iwl_mld_nan_link links[IWL_FW_MAX_LINKS];
 		bool mac_added;
+		struct iwl_mld_int_sta bcast_sta;
+		struct iwl_mld_int_sta mgmt_sta;
 	} nan;
 
 	struct iwl_mld_emlsr emlsr;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 53a0c3b9bb33..351c726be51f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -50,6 +50,98 @@ static int iwl_mld_nan_send_config_cmd(struct iwl_mld *mld,
 	return iwl_mld_send_cmd(mld, &hcmd);
 }
 
+static bool iwl_mld_nan_use_nan_stations(struct iwl_mld *mld)
+{
+	/*
+	 * If the FW supports version 1 of the NAN config command, it means that
+	 * it needs to receive the station ID of the auxiliary station in the
+	 * NAN configuration command. Otherwise, use the NAN dedicated station
+	 * types.
+	 */
+	return iwl_fw_lookup_cmd_ver(mld->fw,
+				     WIDE_ID(MAC_CONF_GROUP,
+					     NAN_CFG_CMD), 1) != 1;
+}
+
+static const struct iwl_mld_int_sta *
+iwl_mld_nan_get_mgmt_sta(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	const struct iwl_mld_int_sta *sta;
+
+	if (iwl_mld_nan_use_nan_stations(mld))
+		sta = &mld_vif->nan.mgmt_sta;
+	else
+		sta = &mld_vif->aux_sta;
+
+	if (WARN_ON(sta->sta_id == IWL_INVALID_STA))
+		return NULL;
+
+	return sta;
+}
+
+int iwl_mld_nan_get_mgmt_queue(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	const struct iwl_mld_int_sta *sta = iwl_mld_nan_get_mgmt_sta(mld, vif);
+
+	if (!sta)
+		return IWL_MLD_INVALID_QUEUE;
+
+	return sta->queue_id;
+}
+
+static void iwl_mld_nan_flush(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	const struct iwl_mld_int_sta *sta = iwl_mld_nan_get_mgmt_sta(mld, vif);
+
+	if (!sta)
+		return;
+
+	if (WARN_ON(sta->queue_id == IWL_MLD_INVALID_QUEUE))
+		return;
+
+	IWL_DEBUG_INFO(mld, "NAN: flush queues for sta=%u\n",
+		       sta->sta_id);
+
+	iwl_mld_flush_link_sta_txqs(mld, sta->sta_id);
+}
+
+static void iwl_mld_nan_remove_stations(struct iwl_mld *mld,
+					struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	iwl_mld_nan_flush(mld, vif);
+
+	if (!iwl_mld_nan_use_nan_stations(mld)) {
+		iwl_mld_remove_aux_sta(mld, vif);
+		return;
+	}
+
+	iwl_mld_remove_nan_bcast_sta(mld, &mld_vif->nan.bcast_sta);
+	iwl_mld_remove_nan_mgmt_sta(mld, &mld_vif->nan.mgmt_sta);
+}
+
+static int iwl_mld_nan_add_stations(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	if (!iwl_mld_nan_use_nan_stations(mld))
+		return iwl_mld_add_aux_sta(mld, &mld_vif->aux_sta);
+
+	ret = iwl_mld_add_nan_bcast_sta(mld, &mld_vif->nan.bcast_sta);
+	if (ret)
+		return ret;
+
+	ret = iwl_mld_add_nan_mgmt_sta(mld, &mld_vif->nan.mgmt_sta);
+	if (ret)
+		iwl_mld_remove_nan_bcast_sta(mld, &mld_vif->nan.bcast_sta);
+
+	return ret;
+}
+
 static int iwl_mld_nan_config(struct iwl_mld *mld,
 			      struct ieee80211_vif *vif,
 			      struct cfg80211_nan_conf *conf,
@@ -126,7 +218,12 @@ static int iwl_mld_nan_config(struct iwl_mld *mld,
 			       conf->vendor_elems_len);
 	}
 
-	cmd.sta_id = mld_vif->aux_sta.sta_id;
+	/* FW needs to know about the station ID only with version 1 of the
+	 * NAN configuration command
+	 */
+	if (!iwl_mld_nan_use_nan_stations(mld))
+		cmd.sta_id = mld_vif->aux_sta.sta_id;
+
 	return iwl_mld_nan_send_config_cmd(mld, &cmd, data,
 					   conf->extra_nan_attrs_len +
 					   conf->vendor_elems_len);
@@ -136,8 +233,6 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      struct cfg80211_nan_conf *conf)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
-	struct iwl_mld_int_sta *aux_sta = &mld_vif->aux_sta;
 	int ret;
 
 	IWL_DEBUG_MAC80211(mld, "NAN: start: bands=0x%x\n", conf->bands);
@@ -146,19 +241,20 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	ret = iwl_mld_add_aux_sta(mld, aux_sta);
+	ret = iwl_mld_nan_add_stations(mld, vif);
 	if (ret)
 		goto unblock_emlsr;
 
 	ret = iwl_mld_nan_config(mld, vif, conf, FW_CTXT_ACTION_ADD);
 	if (ret) {
 		IWL_ERR(mld, "Failed to start NAN. ret=%d\n", ret);
-		goto remove_aux;
+		goto remove_stas;
 	}
+
 	return 0;
 
-remove_aux:
-	iwl_mld_remove_aux_sta(mld, vif);
+remove_stas:
+	iwl_mld_nan_remove_stations(mld, vif);
 unblock_emlsr:
 	iwl_mld_update_emlsr_block(mld, false, IWL_MLD_EMLSR_BLOCKED_NAN);
 
@@ -186,7 +282,6 @@ int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 		     struct ieee80211_vif *vif)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
-	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
 	struct iwl_nan_config_cmd cmd = {
 		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
 	};
@@ -203,9 +298,7 @@ int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 	/* assume that higher layer guarantees that no additional frames are
 	 * added before calling this callback
 	 */
-	if (!WARN_ON(mld_vif->aux_sta.sta_id == IWL_INVALID_STA))
-		iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
-	iwl_mld_remove_aux_sta(mld, vif);
+	iwl_mld_nan_remove_stations(mld, vif);
 
 	/* cancel based on object type being NAN, as the NAN objects do
 	 * not have a unique identifier associated with them
@@ -279,13 +372,7 @@ void iwl_mld_handle_nan_dw_end_notif(struct iwl_mld *mld,
 			 "NAN: DW end without NAN started\n"))
 		return;
 
-	if (WARN_ON(mld_vif->aux_sta.sta_id == IWL_INVALID_STA))
-		return;
-
-	IWL_DEBUG_INFO(mld, "NAN: flush queues for aux sta=%u\n",
-		       mld_vif->aux_sta.sta_id);
-
-	iwl_mld_flush_link_sta_txqs(mld, mld_vif->aux_sta.sta_id);
+	iwl_mld_nan_flush(mld, mld->nan_device_vif);
 
 	/* TODO: currently the notification specified the band on which the DW
 	 * ended. Need to change that to the actual channel on which the next DW
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index 80e18c4ddb33..caa98dbb4a75 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -53,4 +53,6 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 int iwl_mld_mac802111_nan_peer_sched_changed(struct ieee80211_hw *hw,
 					     struct ieee80211_sta *sta);
 
+int iwl_mld_nan_get_mgmt_queue(struct iwl_mld *mld, struct ieee80211_vif *vif);
+
 #endif /* __iwl_mld_nan_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index f794f80b0fdd..1fae5a6ba8d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -430,6 +430,8 @@ static int iwl_mld_send_sta_cmd(struct iwl_mld *mld,
 		cmd_v2->link_id = cpu_to_le32(__ffs(le32_to_cpu(cmd->link_mask)));
 	} else if (WARN_ON(cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_PEER_NMI) &&
 			   cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_PEER_NDI) &&
+			   cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_BCAST) &&
+			   cmd->station_type != cpu_to_le32(STATION_TYPE_NAN_MGMT) &&
 			   hweight32(le32_to_cpu(cmd->link_mask)) != 1)) {
 		return -EINVAL;
 	}
@@ -1063,8 +1065,7 @@ static int iwl_mld_send_aux_sta_cmd(struct iwl_mld *mld,
 static int
 iwl_mld_add_internal_sta_to_fw(struct iwl_mld *mld,
 			       const struct iwl_mld_int_sta *internal_sta,
-			       u8 fw_link_id,
-			       const u8 *addr)
+			       u32 link_mask, const u8 *addr)
 {
 	struct iwl_sta_cfg_cmd cmd = {};
 
@@ -1072,7 +1073,7 @@ iwl_mld_add_internal_sta_to_fw(struct iwl_mld *mld,
 		return iwl_mld_send_aux_sta_cmd(mld, internal_sta);
 
 	cmd.sta_id = cpu_to_le32((u8)internal_sta->sta_id);
-	cmd.link_mask = cpu_to_le32(BIT(fw_link_id));
+	cmd.link_mask = cpu_to_le32(link_mask);
 	cmd.station_type = cpu_to_le32(internal_sta->sta_type);
 
 	/* FW doesn't allow to add a IGTK/BIGTK if the sta isn't marked as MFP.
@@ -1094,7 +1095,8 @@ iwl_mld_add_internal_sta_to_fw(struct iwl_mld *mld,
 static int iwl_mld_add_internal_sta(struct iwl_mld *mld,
 				    struct iwl_mld_int_sta *internal_sta,
 				    enum iwl_fw_sta_type sta_type,
-				    u8 fw_link_id, const u8 *addr, u8 tid)
+				    u32 link_mask, const u8 *addr,
+				    u8 tid, bool add_txq)
 {
 	int ret, queue_id;
 
@@ -1106,11 +1108,14 @@ static int iwl_mld_add_internal_sta(struct iwl_mld *mld,
 
 	internal_sta->sta_type = sta_type;
 
-	ret = iwl_mld_add_internal_sta_to_fw(mld, internal_sta, fw_link_id,
+	ret = iwl_mld_add_internal_sta_to_fw(mld, internal_sta, link_mask,
 					     addr);
 	if (ret)
 		goto err;
 
+	if (!add_txq)
+		return 0;
+
 	queue_id = iwl_mld_allocate_internal_txq(mld, internal_sta, tid);
 	if (queue_id < 0) {
 		iwl_mld_rm_sta_from_fw(mld, internal_sta->sta_id);
@@ -1145,8 +1150,8 @@ int iwl_mld_add_bcast_sta(struct iwl_mld *mld,
 
 	return iwl_mld_add_internal_sta(mld, &mld_link->bcast_sta,
 					STATION_TYPE_BCAST_MGMT,
-					mld_link->fw_id, addr,
-					IWL_MGMT_TID);
+					BIT(mld_link->fw_id), addr,
+					IWL_MGMT_TID, true);
 }
 
 int iwl_mld_add_mcast_sta(struct iwl_mld *mld,
@@ -1165,14 +1170,16 @@ int iwl_mld_add_mcast_sta(struct iwl_mld *mld,
 
 	return iwl_mld_add_internal_sta(mld, &mld_link->mcast_sta,
 					STATION_TYPE_MCAST,
-					mld_link->fw_id, mcast_addr, 0);
+					BIT(mld_link->fw_id), mcast_addr,
+					0, true);
 }
 
 int iwl_mld_add_aux_sta(struct iwl_mld *mld,
 			struct iwl_mld_int_sta *internal_sta)
 {
 	return iwl_mld_add_internal_sta(mld, internal_sta, STATION_TYPE_AUX,
-					0, NULL, IWL_MAX_TID_COUNT);
+					0, NULL, IWL_MAX_TID_COUNT,
+					true);
 }
 
 int iwl_mld_add_mon_sta(struct iwl_mld *mld,
@@ -1189,23 +1196,25 @@ int iwl_mld_add_mon_sta(struct iwl_mld *mld,
 
 	return iwl_mld_add_internal_sta(mld, &mld_link->mon_sta,
 					STATION_TYPE_BCAST_MGMT,
-					mld_link->fw_id, NULL,
-					IWL_MAX_TID_COUNT);
+					BIT(mld_link->fw_id), NULL,
+					IWL_MAX_TID_COUNT,
+					true);
 }
 
 static void iwl_mld_remove_internal_sta(struct iwl_mld *mld,
 					struct iwl_mld_int_sta *internal_sta,
 					bool flush, u8 tid)
 {
-	if (WARN_ON_ONCE(internal_sta->sta_id == IWL_INVALID_STA ||
-			 internal_sta->queue_id == IWL_MLD_INVALID_QUEUE))
+	if (WARN_ON_ONCE(internal_sta->sta_id == IWL_INVALID_STA))
 		return;
 
-	if (flush)
+	if (flush && !WARN_ON_ONCE(internal_sta->queue_id ==
+				   IWL_MLD_INVALID_QUEUE))
 		iwl_mld_flush_link_sta_txqs(mld, internal_sta->sta_id);
 
-	iwl_mld_free_txq(mld, BIT(internal_sta->sta_id),
-			 tid, internal_sta->queue_id);
+	if (internal_sta->queue_id != IWL_MLD_INVALID_QUEUE)
+		iwl_mld_free_txq(mld, BIT(internal_sta->sta_id),
+				 tid, internal_sta->queue_id);
 
 	iwl_mld_rm_sta_from_fw(mld, internal_sta->sta_id);
 
@@ -1406,3 +1415,31 @@ int iwl_mld_update_link_stas(struct iwl_mld *mld,
 
 	return ret;
 }
+
+int iwl_mld_add_nan_bcast_sta(struct iwl_mld *mld,
+			      struct iwl_mld_int_sta *sta)
+{
+	const u8 bcast_addr[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
+
+	return iwl_mld_add_internal_sta(mld, sta, STATION_TYPE_NAN_BCAST,
+					0, bcast_addr, 0, false);
+}
+
+int iwl_mld_add_nan_mgmt_sta(struct iwl_mld *mld,
+			     struct iwl_mld_int_sta *sta)
+{
+	return iwl_mld_add_internal_sta(mld, sta, STATION_TYPE_NAN_MGMT,
+					0, NULL, IWL_MAX_TID_COUNT, true);
+}
+
+void iwl_mld_remove_nan_bcast_sta(struct iwl_mld *mld,
+				  struct iwl_mld_int_sta *sta)
+{
+	iwl_mld_remove_internal_sta(mld, sta, false, 0);
+}
+
+void iwl_mld_remove_nan_mgmt_sta(struct iwl_mld *mld,
+				 struct iwl_mld_int_sta *sta)
+{
+	iwl_mld_remove_internal_sta(mld, sta, true, IWL_MAX_TID_COUNT);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.h b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
index dff14ff0a5af..df859a9e5230 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.h
@@ -276,4 +276,17 @@ int iwl_mld_update_link_stas(struct iwl_mld *mld,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta,
 			     u16 old_links, u16 new_links);
+
+int iwl_mld_add_nan_bcast_sta(struct iwl_mld *mld,
+			      struct iwl_mld_int_sta *sta);
+
+int iwl_mld_add_nan_mgmt_sta(struct iwl_mld *mld,
+			     struct iwl_mld_int_sta *sta);
+
+void iwl_mld_remove_nan_bcast_sta(struct iwl_mld *mld,
+				  struct iwl_mld_int_sta *sta);
+
+void iwl_mld_remove_nan_mgmt_sta(struct iwl_mld *mld,
+				 struct iwl_mld_int_sta *sta);
+
 #endif /* __iwl_mld_sta_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
index 636d24633e57..39e1d959e42c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
@@ -680,11 +680,8 @@ iwl_mld_get_tx_queue_id(struct iwl_mld *mld, struct ieee80211_txq *txq,
 		WARN_ON(!ieee80211_is_mgmt(fc));
 		return mld_vif->aux_sta.queue_id;
 	case NL80211_IFTYPE_NAN:
-		mld_vif = iwl_mld_vif_from_mac80211(info->control.vif);
-
 		WARN_ON(!ieee80211_is_mgmt(fc));
-
-		return mld_vif->aux_sta.queue_id;
+		return iwl_mld_nan_get_mgmt_queue(mld, info->control.vif);
 	default:
 		WARN_ONCE(1, "Unsupported vif type\n");
 		break;
-- 
2.34.1


