Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F2D70FD0B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjEXRqO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjEXRqA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:46:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E819719C
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950326; x=1716486326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcS5SBngbU3tecePg1392NyEKwVLply1aPsM/Ichf/E=;
  b=dtS4ZMO9FZO87zc8kea0mb06ENZfd3WgZO8ONjkJ8K0FINKcuAIj/Ub+
   ZDAnLE1JruGiMUHr4eyv0k/Mvz9Drza5Q0oToNSApeFuJXsSKK3JLUDA1
   d1ibHYeo3K/HlbYcQ1BHdRZDclIZRLkH29rwcQu2HCZCV6MxmBBukwsr3
   ZXp29uujXtTF2xiejAfWzY1f2Ff8HRQXrN07Tc4vrFngQ5441qa1XjHZ6
   yawepl24iIs3hO+g362HdO56ESxSqiuEZFTZ5UBpi3TK7JeXOssu3sZOZ
   veZ00GlDSZp7I590h51qgpJjO4HDYpbuRW63DlHJfTz9hf4GopwVIsYSL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000444"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000444"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769548001"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769548001"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:52 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: mvm: adjust csa notifications and commands to MLO
Date:   Wed, 24 May 2023 20:42:06 +0300
Message-Id: <20230524203151.6aa6e394f5fe.Ie9e78918511ca901f9f3966d774fa74a71a186e3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524174211.1482360-1-gregory.greenman@intel.com>
References: <20230524174211.1482360-1-gregory.greenman@intel.com>
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

From: Gregory Greenman <gregory.greenman@intel.com>

In the following notifications and commands mac_id was replaced
with link_id:
* CANCEL_CHANNEL_SWITCH_CMD
* CHANNEL_SWITCH_START_NOTIF
* CHANNEL_SWITCH_ERROR_NOTIF

The logic around was not changed, so only adjust handling
mac/link id.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 30 +++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 51 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  4 +-
 4 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index edf9ac52a681..b4244fa0516b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -140,33 +140,53 @@ struct iwl_missed_vap_notif {
  *
  * @id_and_color: ID and color of the MAC
  */
-struct iwl_channel_switch_start_notif {
+struct iwl_channel_switch_start_notif_v1 {
 	__le32 id_and_color;
 } __packed; /* CHANNEL_SWITCH_START_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_channel_switch_start_notif - Channel switch start notification
+ *
+ * @link_id: FW link id
+ */
+struct iwl_channel_switch_start_notif {
+	__le32 link_id;
+} __packed; /* CHANNEL_SWITCH_START_NTFY_API_S_VER_3 */
+
 #define CS_ERR_COUNT_ERROR BIT(0)
 #define CS_ERR_LONG_DELAY_AFTER_CS BIT(1)
 #define CS_ERR_LONG_TX_BLOCK BIT(2)
 #define CS_ERR_TX_BLOCK_TIMER_EXPIRED BIT(3)
 
 /**
- * struct iwl_channel_switch_error_notif - Channel switch error notification
+ * struct iwl_channel_switch_error_notif_v1 - Channel switch error notification
  *
  * @mac_id: the mac for which the ucode sends the notification for
  * @csa_err_mask: mask of channel switch error that can occur
  */
-struct iwl_channel_switch_error_notif {
+struct iwl_channel_switch_error_notif_v1 {
 	__le32 mac_id;
 	__le32 csa_err_mask;
 } __packed; /* CHANNEL_SWITCH_ERROR_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_channel_switch_error_notif - Channel switch error notification
+ *
+ * @link_id: FW link id
+ * @csa_err_mask: mask of channel switch error that can occur
+ */
+struct iwl_channel_switch_error_notif {
+	__le32 link_id;
+	__le32 csa_err_mask;
+} __packed; /* CHANNEL_SWITCH_ERROR_NTFY_API_S_VER_2 */
+
 /**
  * struct iwl_cancel_channel_switch_cmd - Cancel Channel Switch command
  *
- * @mac_id: the mac that should cancel the channel switch
+ * @id: the id of the link or mac that should cancel the channel switch
  */
 struct iwl_cancel_channel_switch_cmd {
-	__le32 mac_id;
+	__le32 id;
 } __packed; /* MAC_CANCEL_CHANNEL_SWITCH_S_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index f049ef6a8707..059ede6f7b65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1747,20 +1747,44 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 					struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
-	struct iwl_channel_switch_start_notif *notif = (void *)pkt->data;
 	struct ieee80211_vif *csa_vif, *vif;
-	struct iwl_mvm_vif *mvmvif;
-	u32 id_n_color, csa_id, mac_id;
+	struct iwl_mvm_vif *mvmvif, *csa_mvmvif;
+	u32 id_n_color, csa_id;
+	/* save mac_id or link_id to use later to cancel csa if needed */
+	u32 id;
+	u8 notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, MAC_CONF_GROUP,
+					       CHANNEL_SWITCH_START_NOTIF, 0);
 
-	id_n_color = le32_to_cpu(notif->id_and_color);
-	mac_id = id_n_color & FW_CTXT_ID_MSK;
+	rcu_read_lock();
 
-	if (WARN_ON_ONCE(mac_id >= NUM_MAC_INDEX_DRIVER))
-		return;
+	if (notif_ver < 3) {
+		struct iwl_channel_switch_start_notif_v1 *notif = (void *)pkt->data;
+		u32 mac_id;
+
+		id_n_color = le32_to_cpu(notif->id_and_color);
+		mac_id = id_n_color & FW_CTXT_ID_MSK;
+
+		vif = iwl_mvm_rcu_dereference_vif_id(mvm, mac_id, true);
+		if (!vif)
+			goto out_unlock;
+
+		id = mac_id;
+	} else {
+		struct iwl_channel_switch_start_notif *notif = (void *)pkt->data;
+		u32 link_id = le32_to_cpu(notif->link_id);
+		struct ieee80211_bss_conf *bss_conf =
+			iwl_mvm_rcu_fw_link_id_to_link_conf(mvm, link_id, true);
+
+		if (!bss_conf)
+			goto out_unlock;
+
+		id = link_id;
+		vif = bss_conf->vif;
+	}
 
-	rcu_read_lock();
-	vif = rcu_dereference(mvm->vif_id_to_mac[mac_id]);
 	mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	if (notif_ver >= 3)
+		id_n_color = FW_CMD_ID_AND_COLOR(mvmvif->id, mvmvif->color);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
@@ -1769,7 +1793,8 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 			    csa_vif != vif))
 			goto out_unlock;
 
-		csa_id = FW_CMD_ID_AND_COLOR(mvmvif->id, mvmvif->color);
+		csa_mvmvif = iwl_mvm_vif_from_mac80211(csa_vif);
+		csa_id = FW_CMD_ID_AND_COLOR(csa_mvmvif->id, csa_mvmvif->color);
 		if (WARN(csa_id != id_n_color,
 			 "channel switch noa notification on unexpected vif (csa_vif=%d, notif=%d)",
 			 csa_id, id_n_color))
@@ -1796,7 +1821,7 @@ void iwl_mvm_channel_switch_start_notif(struct iwl_mvm *mvm,
 					    CHANNEL_SWITCH_ERROR_NOTIF,
 					    0) && !vif->bss_conf.csa_active) {
 			IWL_DEBUG_INFO(mvm, "Channel Switch was canceled\n");
-			iwl_mvm_cancel_channel_switch(mvm, vif, mac_id);
+			iwl_mvm_cancel_channel_switch(mvm, vif, id);
 			break;
 		}
 
@@ -1819,7 +1844,7 @@ void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	struct iwl_channel_switch_error_notif *notif = (void *)pkt->data;
 	struct ieee80211_vif *vif;
-	u32 id = le32_to_cpu(notif->mac_id);
+	u32 id = le32_to_cpu(notif->link_id);
 	u32 csa_err_mask = le32_to_cpu(notif->csa_err_mask);
 
 	rcu_read_lock();
@@ -1829,7 +1854,7 @@ void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 		return;
 	}
 
-	IWL_DEBUG_INFO(mvm, "FW reports CSA error: mac_id=%u, csa_err_mask=%u\n",
+	IWL_DEBUG_INFO(mvm, "FW reports CSA error: id=%u, csa_err_mask=%u\n",
 		       id, csa_err_mask);
 	if (csa_err_mask & (CS_ERR_COUNT_ERROR |
 			    CS_ERR_LONG_DELAY_AFTER_CS |
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index afccbd916a65..4e3f994654c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4360,10 +4360,10 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
-				   u32 mac_id)
+				   u32 id)
 {
 	struct iwl_cancel_channel_switch_cmd cancel_channel_switch_cmd = {
-		.mac_id = cpu_to_le32(mac_id),
+		.id = cpu_to_le32(id),
 	};
 	int ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index e396034b8795..9acc01b7a4c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -365,6 +365,7 @@ struct iwl_mvm_link_sta {
  * and from Tx response flow, it needs a spinlock.
  * @tid_data: per tid data + mgmt. Look at %iwl_mvm_tid_data.
  * @tid_to_baid: a simple map of TID to baid
+ * @vif: a vif pointer
  * @reserved_queue: the queue reserved for this STA for DQA purposes
  *	Every STA has is given one reserved queue to allow it to operate. If no
  *	such queue can be guaranteed, the STA addition will fail.
@@ -378,6 +379,7 @@ struct iwl_mvm_link_sta {
  *      debugfs.  If it's set to 0, it means that it is it's not set via
  *      debugfs.
  * @agg_tids: bitmap of tids whose status is operational aggregated (IWL_AGG_ON)
+ * @sleeping: sta sleep transitions in power management
  * @sleep_tx_count: the number of frames that we told the firmware to let out
  *	even when that station is asleep. This is useful in case the queue
  *	gets empty before all the frames were sent, which can happen when
@@ -580,7 +582,7 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 u8 *key, u32 key_len);
 void iwl_mvm_cancel_channel_switch(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif,
-				   u32 mac_id);
+				   u32 id);
 /* Queues */
 int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 			    struct ieee80211_sta *sta,
-- 
2.38.1

