Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524456FA21E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjEHIYy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjEHIYu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:24:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE291707
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534289; x=1715070289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jpKLEsw59/RfAh3pFbSju4xzIou/KeZ5fmagQTop+JM=;
  b=ne6E/Jaqop+0MNwUjqD+Gh8LjLpeI/7aVkns/lI8ooGA9LzS3uZz40I1
   HX+P+tKZqCFSPjDtVi761Zo2YzR+GGwPjKzjgidPfAh9SyVb3J96hcuOE
   ReKG/1ypqG9PF4N4wncryE13VdPSomOFbhz2hIa9BGdSPe2qtv8yg73zZ
   FJhYRHNkT+RTG/i85fczf/bYbD/di5YxjA8rA1YMupk5cL/NerJhASXES
   /9CD2+6xs73yw1VJGiPchlQGm3hajsNd4XTHkq32RQZwxoxohIN2fjWeQ
   G6E6d7tt/JhOhvfcjY6NgJX9LaL4DYD+aZPH9sWnPfFkFZxkE4ybOLWBQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949853"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949853"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982571"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982571"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:47 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: mvm: use link ID in missed beacon notification
Date:   Mon,  8 May 2023 11:24:21 +0300
Message-Id: <20230508082433.1349733-3-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230508082433.1349733-1-gregory.greenman@intel.com>
References: <20230508082433.1349733-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

This new version of missed beacon notification uses link_id
instead of mac_id. Also add an option to use link id for
retrieving vif.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   | 22 ++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  3 ++
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  5 ++++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 29 +++++++++++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 15 ++++++++++
 5 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index e3eda251c728..c51c6c3a69ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -353,7 +353,7 @@ struct iwl_nonqos_seq_query_cmd {
 } __packed; /* NON_QOS_TX_COUNTER_GET_SET_API_S_VER_1 */
 
 /**
- * struct iwl_missed_beacons_notif - information on missed beacons
+ * struct iwl_missed_beacons_notif_ver_3 - information on missed beacons
  * ( MISSED_BEACONS_NOTIFICATION = 0xa2 )
  * @mac_id: interface ID
  * @consec_missed_beacons_since_last_rx: number of consecutive missed
@@ -362,7 +362,7 @@ struct iwl_nonqos_seq_query_cmd {
  * @num_expected_beacons: number of expected beacons
  * @num_recvd_beacons: number of received beacons
  */
-struct iwl_missed_beacons_notif {
+struct iwl_missed_beacons_notif_ver_3 {
 	__le32 mac_id;
 	__le32 consec_missed_beacons_since_last_rx;
 	__le32 consec_missed_beacons;
@@ -370,6 +370,24 @@ struct iwl_missed_beacons_notif {
 	__le32 num_recvd_beacons;
 } __packed; /* MISSED_BEACON_NTFY_API_S_VER_3 */
 
+/**
+ * struct iwl_missed_beacons_notif - information on missed beacons
+ * ( MISSED_BEACONS_NOTIFICATION = 0xa2 )
+ * @link_id: fw link ID
+ * @consec_missed_beacons_since_last_rx: number of consecutive missed
+ *	beacons since last RX.
+ * @consec_missed_beacons: number of consecutive missed beacons
+ * @num_expected_beacons: number of expected beacons
+ * @num_recvd_beacons: number of received beacons
+ */
+struct iwl_missed_beacons_notif {
+	__le32 link_id;
+	__le32 consec_missed_beacons_since_last_rx;
+	__le32 consec_missed_beacons;
+	__le32 num_expected_beacons;
+	__le32 num_recvd_beacons;
+} __packed; /* MISSED_BEACON_NTFY_API_S_VER_4 */
+
 /**
  * struct iwl_he_backoff_conf - used for backoff configuration
  * Per each trigger-based AC, (set by MU EDCA Parameter set info-element)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b35c96cf7ad2..08b1e15241ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1591,6 +1591,9 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[i], NULL);
 	}
 
+	for (i = 0; i < IWL_MVM_FW_MAX_LINK_ID + 1; i++)
+		RCU_INIT_POINTER(mvm->link_id_to_link_conf[i], NULL);
+
 	memset(&mvm->fw_link_ids_map, 0, sizeof(mvm->fw_link_ids_map));
 
 	mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index eb828de40a3c..c94aca398789 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -63,6 +63,9 @@ int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 								    mvmvif);
 		if (link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID)
 			return -EINVAL;
+
+		rcu_assign_pointer(mvm->link_id_to_link_conf[link_info->fw_link_id],
+				   link_conf);
 	}
 
 	/* Update SF - Disable if needed. if this fails, SF might still be on
@@ -260,6 +263,8 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		    link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
 		return -EINVAL;
 
+	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
+			 NULL);
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
 	link_info->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index cc90f2884cff..0ecf4159e139 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1555,21 +1555,38 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	u32 stop_trig_missed_bcon, stop_trig_missed_bcon_since_rx;
 	u32 rx_missed_bcon, rx_missed_bcon_since_rx;
 	struct ieee80211_vif *vif;
-	u32 id = le32_to_cpu(mb->mac_id);
+	/* Id can be mac/link id depending on the notification version */
+	u32 id = le32_to_cpu(mb->link_id);
 	union iwl_dbg_tlv_tp_data tp_data = { .fw_pkt = pkt };
 	u32 mac_type;
+	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					       MISSED_BEACONS_NOTIFICATION,
+					       0);
+
+	rcu_read_lock();
+
+	/* before version four the ID in the notification refers to mac ID */
+	if (notif_ver < 4) {
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
+	} else {
+		struct ieee80211_bss_conf *bss_conf =
+			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, id, true);
+
+		if (!bss_conf)
+			goto out;
+
+		vif = bss_conf->vif;
+	}
 
 	IWL_DEBUG_INFO(mvm,
-		       "missed bcn mac_id=%u, consecutive=%u (%u, %u, %u)\n",
-		       le32_to_cpu(mb->mac_id),
+		       "missed bcn %s_id=%u, consecutive=%u (%u, %u, %u)\n",
+		       notif_ver < 4 ? "mac" : "link",
+		       id,
 		       le32_to_cpu(mb->consec_missed_beacons),
 		       le32_to_cpu(mb->consec_missed_beacons_since_last_rx),
 		       le32_to_cpu(mb->num_recvd_beacons),
 		       le32_to_cpu(mb->num_expected_beacons));
 
-	rcu_read_lock();
-
-	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
 	if (!vif)
 		goto out;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6e7470d3a826..b9975af671db 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1003,6 +1003,8 @@ struct iwl_mvm {
 
 	struct ieee80211_vif __rcu *vif_id_to_mac[NUM_MAC_INDEX_DRIVER];
 
+	struct ieee80211_bss_conf __rcu *link_id_to_link_conf[IWL_MVM_FW_MAX_LINK_ID + 1];
+
 	/* -1 for always, 0 for never, >0 for that many times */
 	s8 fw_restart;
 	u8 *error_recovery_buf;
@@ -1302,6 +1304,19 @@ iwl_mvm_rcu_dereference_vif_id(struct iwl_mvm *mvm, u8 vif_id, bool rcu)
 					 lockdep_is_held(&mvm->mutex));
 }
 
+static inline struct ieee80211_bss_conf *
+iwl_mvm_rcu_fw_link_id_to_link_conf(struct iwl_mvm *mvm, u8 link_id, bool rcu)
+{
+	if (WARN_ON(link_id >= ARRAY_SIZE(mvm->link_id_to_link_conf)))
+		return NULL;
+
+	if (rcu)
+		return rcu_dereference(mvm->link_id_to_link_conf[link_id]);
+
+	return rcu_dereference_protected(mvm->link_id_to_link_conf[link_id],
+					 lockdep_is_held(&mvm->mutex));
+}
+
 static inline bool iwl_mvm_is_adaptive_dwell_supported(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
-- 
2.38.1

