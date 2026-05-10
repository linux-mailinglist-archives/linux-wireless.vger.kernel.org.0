Return-Path: <linux-wireless+bounces-36153-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEz4IyjRAGoMNAEAu9opvQ
	(envelope-from <linux-wireless+bounces-36153-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2E1505BB8
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 20:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C930F300FF8F
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2026 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B1315D5B;
	Sun, 10 May 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heHIhbUM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8E31A570
	for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778438403; cv=none; b=J3bpXmhiZUyPXjaomHYEeZmPSOXrPb7ZELwldM44MAtYtfowcjU9kJEiLgMOkK0eozLClHCLQf6ic2cN5sAzLbl/Yl69V9UwgS1Uknl+sUZYYv9fMfVmLNUVOm3pjwDWfFk1Ua1Qr5S7XcTFvSdAOF6JbBxTUyVG5PWuiEO12zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778438403; c=relaxed/simple;
	bh=ebcZhgT4xxpCDhNKccu8stCO+jV3UVEYIVESD2yITUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPQgXw8Ow6feZwf+9272alQCAbfpsC882bhactemp+un2oJaj3AmXPUTE+A0vwaywb6WbUxexAkEMYQk9dVAyXk8ecxJxuXVUzBL9bt/Uh6DXbVVNEAZjxNsXWZR4EuxU6Td96V4mLE70n8ysZu2Eq7Mld+71PsojwgZKYOKpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heHIhbUM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778438402; x=1809974402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebcZhgT4xxpCDhNKccu8stCO+jV3UVEYIVESD2yITUw=;
  b=heHIhbUMwdi+Hgwr+MehYcsPLBt27XXo7TkrxGOUO4lysLqxkc07GfAp
   /9ZCKLbUHVnB9hKOS7YpbDwYoM+w7IbmhzmdlU8MMQ4Y5zYR5se9+VN9X
   48A46M9I/XP2X8BybzKYjjDiWWzK9dxPnj71W/0R4tvAPDC1ieO1MCyj6
   JjXYTzGPqGKKCiDK8GjEBpXmcvHcfmaJrAfFbLIznIVg+NkYD+8mOiF6l
   tDkdHUJ03UwQ4v3/2KB8i9qpwe0eovYbKGZGcoe46/3XmkZ29akjDhQaO
   elafFObYPfkeKEwNzQ7O3XhHShwK6HFgpmCV1I7vpssTbwZRwgKD0dyNA
   Q==;
X-CSE-ConnectionGUID: IfzAmx+PRJm9FoS0Umwe0A==
X-CSE-MsgGUID: xjEbS4d3R+yAb0PC7vVqgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="83208980"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="83208980"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:02 -0700
X-CSE-ConnectionGUID: V5llh079SueR+uDOcT3d/Q==
X-CSE-MsgGUID: eTuwwugDRP2FP4zrt5g2mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="267626778"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:40:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mld: add peer schedule support
Date: Sun, 10 May 2026 21:39:31 +0300
Message-Id: <20260510213745.570842fce362.I8e483edd1e917dfa59901b520db595cea28906e3@changeid>
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
X-Rspamd-Queue-Id: 1F2E1505BB8
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
	TAGGED_FROM(0.00)[bounces-36153-lists,linux-wireless=lfdr.de];
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

Add support for NAN peer schedule configuration and update.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 42 ++++++++++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |  1 +
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 84 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.h  |  3 +
 5 files changed, 131 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index d98c6d991a88..75b477319096 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -76,6 +76,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @NAN_SCHEDULE_CMD: &struct iwl_nan_schedule_cmd
 	 */
 	NAN_SCHEDULE_CMD = 0x13,
+	/**
+	 * @NAN_PEER_CMD: &struct iwl_nan_peer_cmd
+	 */
+	NAN_PEER_CMD = 0x14,
 	/**
 	 * @NAN_DW_END_NOTIF: &struct iwl_nan_dw_end_notif
 	 */
@@ -1268,6 +1272,44 @@ struct iwl_nan_schedule_cmd {
 	} __packed channels[NUM_PHY_CTX];
 } __packed; /* NAN_SCHEDULE_CMD_API_S_VER_1 */
 
+/**
+ * struct iwl_nan_peer_cmd - NAN peer command
+ * @nmi_sta_id: NAN management station ID
+ * @sequence_id: NAN Availability attribute sequence ID
+ * @committed_dw_info: committed DW info from the NAN Device
+ *	Capability attribute
+ * @max_channel_switch_time: maximum channel switch time
+ *	(in microseconds); 0 means unavailable
+ * @reserved: (reserved)
+ * @per_phy: per-PHY information for this peer, indexed by PHY ID
+ * @per_phy.availability_map: bitmap of which slots this peer
+ *	is available in on this PHY. 0 indicates the this per-PHY entry
+ *	is unused.
+ * @per_phy.channel_entry: the channel description the peer is using,
+ *	used for comparisons in ULW management
+ * @per_phy.link_id: FW link ID, should be a valid id.
+ * @per_phy.map_id: map ID from peer's NAN Availability attributec
+ * @initial_ulw_size: size of the initial ULW blob
+ * @initial_ulw: initial ULW data from the peer
+ */
+struct iwl_nan_peer_cmd {
+	u8 nmi_sta_id;
+	u8 sequence_id;
+	__le16 committed_dw_info;
+	__le16 max_channel_switch_time;
+	__le16 reserved;
+
+	struct {
+		__le32 availability_map;
+		u8 channel_entry[6];
+		u8 link_id;
+		u8 map_id;
+	} __packed per_phy[NUM_PHY_CTX];
+
+	__le32 initial_ulw_size;
+	u8 initial_ulw[];
+} __packed; /* NAN_PEER_SCHEDULE_CMD_API_S_VER_1 */
+
 /**
  * enum iwl_nan_cluster_notif_flags - flags for the cluster notification
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 6b4b2683cd1e..cabf47367fda 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2863,4 +2863,5 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.start_nan = iwl_mld_start_nan,
 	.stop_nan = iwl_mld_stop_nan,
 	.nan_change_conf = iwl_mld_nan_change_config,
+	.nan_peer_sched_changed = iwl_mld_mac802111_nan_peer_sched_changed,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index c038a0cde36b..dfd4798c103a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -237,6 +237,7 @@ static const struct iwl_hcmd_names iwl_mld_mac_conf_names[] = {
 	HCMD_NAME(ROC_CMD),
 	HCMD_NAME(NAN_CFG_CMD),
 	HCMD_NAME(NAN_SCHEDULE_CMD),
+	HCMD_NAME(NAN_PEER_CMD),
 	HCMD_NAME(NAN_DW_END_NOTIF),
 	HCMD_NAME(NAN_JOINED_CLUSTER_NOTIF),
 	HCMD_NAME(MISSED_BEACONS_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index 53d39717deab..ceea66c01205 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -664,3 +664,87 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 			iwl_mld_rm_vif(mld, vif);
 	}
 }
+
+int iwl_mld_mac802111_nan_peer_sched_changed(struct ieee80211_hw *hw,
+					     struct ieee80211_sta *sta)
+{
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct ieee80211_nan_peer_sched *sched = sta->nan_sched;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(mld_sta->vif);
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_mld_nan_link *nan_link;
+	struct iwl_nan_peer_cmd cmd = {
+		.nmi_sta_id = mld_sta->deflink.fw_id,
+		.sequence_id = sched->seq_id,
+		.committed_dw_info = cpu_to_le16(sched->committed_dw),
+		.max_channel_switch_time = cpu_to_le16(sched->max_chan_switch),
+		.initial_ulw_size = cpu_to_le32(sched->ulw_size),
+		.per_phy[0 ... NUM_PHY_CTX - 1] = {
+			/* unused by FW if availability_map == 0 */
+			.map_id = CFG80211_NAN_INVALID_MAP_ID,
+			.link_id = FW_CTXT_ID_INVALID,
+		},
+		/* .initial_ulw directly provided below by data[1]/len[1] */
+	};
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(MAC_CONF_GROUP, NAN_PEER_CMD),
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+		.data[1] = sched->init_ulw,
+		.len[1] = sched->ulw_size,
+		.dataflags[1] = IWL_HCMD_DFL_DUP,
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(sched->maps); i++) {
+		if (sched->maps[i].map_id == CFG80211_NAN_INVALID_MAP_ID)
+			continue;
+
+		BUILD_BUG_ON(ARRAY_SIZE(sched->maps[i].slots) != 32);
+		for (int slot = 0;
+		     slot < ARRAY_SIZE(sched->maps[i].slots);
+		     slot++) {
+			struct ieee80211_chanctx_conf *ctx;
+			struct ieee80211_nan_channel *chan;
+			struct iwl_mld_phy *phy;
+
+			chan = sched->maps[i].slots[slot];
+			if (!chan)
+				continue;
+
+			ctx = chan->chanctx_conf;
+			if (!ctx)
+				continue;
+
+			phy = iwl_mld_phy_from_mac80211(ctx);
+
+			for_each_mld_nan_valid_link(mld_vif, nan_link) {
+				if (nan_link->chanctx == ctx) {
+					cmd.per_phy[phy->fw_id].link_id =
+						nan_link->fw_id;
+					break;
+				}
+			}
+
+			if (WARN_ON(cmd.per_phy[phy->fw_id].link_id ==
+				    FW_CTXT_ID_INVALID))
+				continue;
+
+			/*
+			 * each channel can only appear in one map,
+			 * upper layers enforce that
+			 */
+			if (WARN_ON(cmd.per_phy[phy->fw_id].map_id != CFG80211_NAN_INVALID_MAP_ID &&
+				    cmd.per_phy[phy->fw_id].map_id != sched->maps[i].map_id))
+				continue;
+
+			cmd.per_phy[phy->fw_id].map_id = sched->maps[i].map_id;
+			memcpy(cmd.per_phy[phy->fw_id].channel_entry,
+			       chan->channel_entry,
+			       sizeof(cmd.per_phy[phy->fw_id].channel_entry));
+			cmd.per_phy[phy->fw_id].availability_map |=
+				cpu_to_le32(BIT(slot));
+		}
+	}
+
+	return iwl_mld_send_cmd(mld, &hcmd);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.h b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
index 933e16c3c274..80e18c4ddb33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.h
@@ -50,4 +50,7 @@ void iwl_mld_nan_vif_cfg_changed(struct iwl_mld *mld,
 				 struct ieee80211_vif *vif,
 				 u64 changes);
 
+int iwl_mld_mac802111_nan_peer_sched_changed(struct ieee80211_hw *hw,
+					     struct ieee80211_sta *sta);
+
 #endif /* __iwl_mld_nan_h__ */
-- 
2.34.1


