Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B116FA22C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjEHIZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjEHIZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:25:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F81FA98
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534311; x=1715070311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Jtaic8REm+deO+U/fDQp+CbQ1yOAQRM0AJVR4jFpPk=;
  b=lDtnE/gzPC5AjaO2PXp6u2wZdZL/eIQz0tc268C0m7LnzuF+UFiy+ALh
   ZtNdMWHxWP+aOrkCMGNycsZNgeWh4VUs+XZKeSs2NZjJsG5C3CbDcxyNc
   nU1qtiEvB94joofbbKAFmknahy3827cUcKtLR+XExQeMVErdv47vES5Px
   2HRZYS/EvvtteVWTdCPEklN1FHO81+qfc2qcdQcQYyHBmqoO774ozteuM
   34iQwwxCoQGOTEXbB0uBAQigdynaVpk8GdiyfpFHYm/ozE5mLKezf4yUX
   cVLlhu2CJicCFBsrLU4DRYov/7qtW0V1yV4W/fkL4zc2mqoMYawJQS+5b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949911"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949911"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982675"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982675"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:25:07 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: mvm: adjust csa notifications and commands to MLO
Date:   Mon,  8 May 2023 11:24:31 +0300
Message-Id: <20230508082433.1349733-13-gregory.greenman@intel.com>
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
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 28 ++++++++--
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 51 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +-
 4 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index edf9ac52a681..f68edbff0d29 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -140,10 +140,19 @@ struct iwl_missed_vap_notif {
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
@@ -155,18 +164,29 @@ struct iwl_channel_switch_start_notif {
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
index 54bcd65cde2d..e0917ee6f436 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4357,10 +4357,10 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
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
index e396034b8795..e8f79f6e07b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -580,7 +580,7 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
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

