Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAF86CB8F5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjC1IAj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjC1IA0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789E423F
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990423; x=1711526423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P4rRwMTvpxwZ1czvpOluArD54Ipgr/laXVwUF/d+OiA=;
  b=oInO11yOo4Krz3ZQOKqOJnK+asy+8JWfhSzrwnwAtJAExADrjajkncZm
   4ou2fgHygYZt5SeADYH8W0c2Itazf61XM/DmCyNToe4AqZWni0kz/9wJH
   uPixybdBNnTZSRbz50+UIUq7rLeW1DzQj3dsd0DiI+56fn7Z33SnvrX6Q
   OpmIIy7E+k5N5P4EBdCGVv+CY/AS6BAr7KJfVMbCamUKwtf1SXOzF3RaU
   2CqPHTSBUf7dO6hzFhPOfCQEOHD2iOGcGuzwyNLYW4MV3A4Xbojc1H4uK
   TeTg/RCvYhLw8SHqEcpbgXBCUMMrWcUDaeMBVJLPg4cVVfdkCIlvMKxRk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958279"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958279"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045326"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045326"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:17 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 26/31] wifi: iwlwifi: mvm: add fw link id allocation
Date:   Tue, 28 Mar 2023 10:59:06 +0300
Message-Id: <20230328104949.a53e5df49c33.I02b25648d2d5ca370c0697bf19d0d34724eae8a1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Driver uses link_id as an index in the array. FW currently can
support only 2 concurrently active links per vif with the ids in the
range 0-3. Add a mapping of dirver link ids to fw link id and track the
number of active link ids.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  6 ++
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 87 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  6 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 25 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 10 +++
 8 files changed, 121 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index b644274e4a31..e236d1b0aae2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -483,6 +483,12 @@ struct iwl_link_config_cmd {
 	__le32 reserved1[8];
 } __packed; /* LINK_CONTEXT_CONFIG_CMD_API_S_VER_1 */
 
+/* Currently FW supports link ids in the range 0-3 and can have
+ * at most two active links for each vif.
+ */
+#define IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM 2
+#define IWL_MVM_FW_MAX_LINK_ID 3
+
 /**
  * enum iwl_fw_sta_type - FW station types
  * @STATION_TYPE_PEER: represents a peer - AP in BSS, a TDLS sta, a client in
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 2c72f5cb19f1..527daaf46f96 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1442,7 +1442,11 @@ static int _iwl_dbgfs_inject_beacon_ie(struct iwl_mvm *mvm, char *bin, int len)
 			cpu_to_le16(iwl_mvm_mac_ctxt_get_beacon_flags(mvm->fw,
 								      rate));
 		beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
-		beacon_cmd.link_id = cpu_to_le32((u32)mvmvif->id);
+		if (iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD, 0) > 12)
+			beacon_cmd.link_id =
+				cpu_to_le32(mvmvif->link[link_id]->fw_link_id);
+		else
+			beacon_cmd.link_id = cpu_to_le32((u32)mvmvif->id);
 
 		iwl_mvm_mac_ctxt_set_tim(mvm, &beacon_cmd.tim_idx,
 					 &beacon_cmd.tim_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6d6fa35c2b21..d302d98b7631 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1573,6 +1573,8 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++)
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[i], NULL);
 
+	memset(&mvm->fw_link_ids_map, 0, sizeof(mvm->fw_link_ids_map));
+
 	mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
 
 	/* reset quota debouncing buffer - 0xff will yield invalid data */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 320a3bc4e9c0..7a70b6ee65ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -1,9 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022 - 2023 Intel Corporation
  */
 #include "mvm.h"
 
+static u32 iwl_mvm_get_free_fw_link_id(struct iwl_mvm *mvm,
+				       struct iwl_mvm_vif *mvm_vif)
+{
+	u32 link_id;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	link_id = ffz(mvm->fw_link_ids_map);
+
+	/* this case can happen if there're deactivated but not removed links */
+	if (link_id > IWL_MVM_FW_MAX_LINK_ID)
+		return IWL_MVM_FW_LINK_ID_INVALID;
+
+	mvm->fw_link_ids_map |= BIT(link_id);
+	return link_id;
+}
+
+static void iwl_mvm_release_fw_link_id(struct iwl_mvm *mvm, u32 link_id)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!WARN_ON(link_id > IWL_MVM_FW_MAX_LINK_ID))
+		mvm->fw_link_ids_map &= ~BIT(link_id);
+}
+
 static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
 				 struct iwl_link_config_cmd *cmd,
 				 enum iwl_ctxt_action action)
@@ -25,23 +50,30 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	unsigned int link_id = link_conf->link_id;
+	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
 	struct iwl_link_config_cmd cmd = {};
 	struct iwl_mvm_phy_ctxt *phyctxt;
 
-	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
+	if (WARN_ON_ONCE(!link_info))
 		return -EINVAL;
 
+	if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID) {
+		link_info->fw_link_id = iwl_mvm_get_free_fw_link_id(mvm,
+								    mvmvif);
+		if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
+			return -EINVAL;
+	}
+
 	/* Update SF - Disable if needed. if this fails, SF might still be on
 	 * while many macs are bound, which is forbidden - so fail the binding.
 	 */
 	if (iwl_mvm_sf_update(mvm, vif, false))
 		return -EINVAL;
 
-	/* FIXME: add proper link id allocation */
-	cmd.link_id = cpu_to_le32(mvmvif->id);
+	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 	cmd.mac_id = cpu_to_le32(mvmvif->id);
 	/* P2P-Device already has a valid PHY context during add */
-	phyctxt = mvmvif->link[link_id]->phy_ctxt;
+	phyctxt = link_info->phy_ctxt;
 	if (phyctxt)
 		cmd.phy_id = cpu_to_le32(phyctxt->id);
 	else
@@ -61,20 +93,27 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	unsigned int link_id = link_conf->link_id;
+	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
 	struct iwl_mvm_phy_ctxt *phyctxt;
 	struct iwl_link_config_cmd cmd = {};
 	u32 ht_flag, flags = 0, flags_mask = 0;
+	int ret;
+
+	if (WARN_ON_ONCE(!link_info ||
+			 link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
+		return -EINVAL;
 
-	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
+	/* cannot activate third link */
+	if (!link_info->active && active &&
+	    mvmvif->fw_active_links_num >= IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM)
 		return -EINVAL;
 
-	/* FIXME: add proper link id allocation */
-	cmd.link_id = cpu_to_le32(mvmvif->id);
+	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 
 	/* The phy_id, link address and listen_lmac can be modified only until
 	 * the link becomes active, otherwise they will be ignored.
 	 */
-	phyctxt = mvmvif->link[link_id]->phy_ctxt;
+	phyctxt = link_info->phy_ctxt;
 	if (phyctxt)
 		cmd.phy_id = cpu_to_le32(phyctxt->id);
 	else
@@ -151,7 +190,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd.frame_time_rts_th = cpu_to_le16(link_conf->frame_time_rts_th);
 
 	/* Block 26-tone RU OFDMA transmissions */
-	if (mvmvif->deflink.he_ru_2mhz_block) {
+	if (link_info->he_ru_2mhz_block) {
 		flags |= LINK_FLG_RU_2MHZ_BLOCK;
 		flags_mask |= LINK_FLG_RU_2MHZ_BLOCK;
 	}
@@ -167,18 +206,40 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd.flags = cpu_to_le32(flags);
 	cmd.flags_mask = cpu_to_le32(flags_mask);
 
-	return iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_MODIFY);
+	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_MODIFY);
+	if (!ret) {
+		/* the FW is updated, so now it's possible to update the
+		 * activation status. If activating a link, it was already
+		 * checked above that we didn't reach the FW limit.
+		 */
+		if (link_info->active && !active)
+			mvmvif->fw_active_links_num--;
+		else if (!link_info->active && active)
+			mvmvif->fw_active_links_num++;
+
+		link_info->active = active;
+	}
+
+	return ret;
 }
 
 int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int link_id = link_conf->link_id;
+	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
 	struct iwl_link_config_cmd cmd = {};
 	int ret;
 
-	/* FIXME: add proper link id allocation */
-	cmd.link_id = cpu_to_le32(mvmvif->id);
+	if (WARN_ON(!link_info ||
+		    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
+	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
+	link_info->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
+
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
 
 	if (!ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 432b9cbcd8a4..82fad042a281 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1078,7 +1078,11 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 
 	beacon_cmd.flags = cpu_to_le16(flags);
 	beacon_cmd.byte_cnt = cpu_to_le16((u16)beacon->len);
-	beacon_cmd.link_id = cpu_to_le32((u32)mvmvif->id);
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD, 0) > 12)
+		beacon_cmd.link_id =
+			cpu_to_le32(mvmvif->link[link_conf->link_id]->fw_link_id);
+	else
+		beacon_cmd.link_id = cpu_to_le32((u32)mvmvif->id);
 
 	if (vif->type == NL80211_IFTYPE_AP)
 		iwl_mvm_mac_ctxt_set_tim(mvm, &beacon_cmd.tim_idx,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index c81b92d2e8f7..b861b5478e08 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -36,6 +36,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	mvmvif->features |= hw->netdev_features;
 
 	/* the first link always points to the default one */
+	mvmvif->deflink.fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 	mvmvif->link[0] = &mvmvif->deflink;
 
 	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 75d4585c0b21..3791f37afa78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -197,8 +197,8 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	return iwl_mvm_mld_add_int_sta(mvm, bsta, queue,
 				       ieee80211_vif_type_p2p(vif),
 				       STATION_TYPE_BCAST_MGMT,
-				       mvmvif->id, baddr, IWL_MAX_TID_COUNT,
-				       &wdg_timeout);
+				       mvm_link->fw_link_id, baddr,
+				       IWL_MAX_TID_COUNT, &wdg_timeout);
 }
 
 /* Allocate a new station entry for the broadcast station to the given vif,
@@ -232,7 +232,8 @@ int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	return iwl_mvm_mld_add_int_sta(mvm, msta, &mvm_link->cab_queue,
 				       vif->type, STATION_TYPE_MCAST,
-				       mvmvif->id, maddr, 0, &timeout);
+				       mvm_link->fw_link_id, maddr, 0,
+				       &timeout);
 }
 
 /* Allocate a new station entry for the sniffer station to the given vif,
@@ -242,13 +243,15 @@ int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     struct ieee80211_bss_conf *link_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *mvm_link =
+		mvmvif->link[link_conf->link_id];
 
 	lockdep_assert_held(&mvm->mutex);
 
 	return iwl_mvm_mld_add_int_sta(mvm, &mvm->snif_sta, &mvm->snif_queue,
 				       vif->type, STATION_TYPE_BCAST_MGMT,
-				       mvmvif->id, NULL, IWL_MAX_TID_COUNT,
-				       NULL);
+				       mvm_link->fw_link_id, NULL,
+				       IWL_MAX_TID_COUNT, NULL);
 }
 
 int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
@@ -380,15 +383,23 @@ static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			       struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif *mvm_vif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta_cfg_cmd cmd = {
 		.sta_id = cpu_to_le32(mvm_sta->deflink.sta_id),
-		.link_id = cpu_to_le32(mvmvif->id),
 		.station_type = cpu_to_le32(mvm_sta->sta_type),
 		.mfp = cpu_to_le32(sta->mfp),
 	};
+	/* FIXME: use proper link_id */
+	unsigned int link_id = 0;
+	struct iwl_mvm_vif_link_info *link_info = mvm_vif->link[link_id];
 	u32 agg_size = 0, mpdu_dens = 0;
 
+	/* when adding sta, link should exist in FW */
+	if (WARN_ON(link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
+		return -EINVAL;
+
+	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
+
 	/* For now the link addr is the same as the mld addr */
 	memcpy(&cmd.peer_mld_address, sta->addr, ETH_ALEN);
 	memcpy(&cmd.peer_link_address, sta->addr, ETH_ALEN);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 03e035b12783..ad67a9b71807 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -73,6 +73,9 @@
 /* offchannel queue towards mac80211 */
 #define IWL_MVM_OFFCHANNEL_QUEUE 0
 
+/* invalid value for FW link id */
+#define IWL_MVM_FW_LINK_ID_INVALID 0xff
+
 extern const struct ieee80211_ops iwl_mvm_hw_ops;
 extern const struct ieee80211_ops iwl_mvm_mld_hw_ops;
 
@@ -283,6 +286,7 @@ struct iwl_probe_resp_data {
 /**
  * struct iwl_mvm_vif_link_info - per link data in Virtual Interface
  * @ap_sta_id: the sta_id of the AP - valid only if VIF type is STA
+ * @fw_link_id: the id of the link according to the FW API
  * @bssid: BSSID for this (client) interface
  * @bcast_sta: station used for broadcast packets. Used by the following
  *	vifs: P2P_DEVICE, GO and AP.
@@ -299,6 +303,7 @@ struct iwl_probe_resp_data {
 struct iwl_mvm_vif_link_info {
 	u8 bssid[ETH_ALEN];
 	u8 ap_sta_id;
+	u8 fw_link_id;
 
 	struct iwl_mvm_int_sta bcast_sta;
 	struct iwl_mvm_int_sta mcast_sta;
@@ -312,6 +317,7 @@ struct iwl_mvm_vif_link_info {
 	struct iwl_probe_resp_data __rcu *probe_resp_data;
 
 	bool he_ru_2mhz_block;
+	bool active;
 
 	u16 cab_queue;
 	/* Assigned while mac80211 has the link in a channel context,
@@ -349,6 +355,7 @@ struct iwl_mvm_vif_link_info {
  * @csa_failed: CSA failed to schedule time event, report an error later
  * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
  * @features: hw features active for this vif
+ * @fw_active_links_num: the number of activated links
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -432,6 +439,8 @@ struct iwl_mvm_vif {
 		struct ieee80211_key_conf __rcu *keys[2];
 	} bcn_prot;
 
+	u32 fw_active_links_num;
+
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
@@ -896,6 +905,7 @@ struct iwl_mvm {
 	/* data related to data path */
 	struct iwl_rx_phy_info last_phy_info;
 	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_MVM_STATION_COUNT_MAX];
+	unsigned long fw_link_ids_map;
 	u8 rx_ba_sessions;
 
 	/* configured by mac80211 */
-- 
2.38.1

