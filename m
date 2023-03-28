Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5A6CB8E6
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjC1H7n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjC1H7m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53F140CA
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990380; x=1711526380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a4zW73HFtTUCSQZhlfAK8Gvt51S5Lt3TZBB98FJZq28=;
  b=IW2PDU8C27+wrDp/xvaGm0t/JtjJtRdofbc8rrZZyCYRV/63nAL3z1Ww
   AWVLjY08I7i5kXa1SwMY60reLijBfGFOjUNpt+TC2fgzsmuHd8zyaewhA
   jmRcVSTkmXqjH44SiwHTRpK62MC+51L65jlMvLiOh42tS3lnIYsK+5oy8
   4vnqygQGTWvovjeGTjFjGSbynzP9o/emfLXHla2vcGxxHvlUj41qKVyD9
   3n268xZwZPWBtTXR5LfPvdMuwsrSJf/zRsAiM6w7P5YcX7gy4Y7wHbBI5
   ICpHX4oGhW4ZLQJ0eYrxmSe7lWI6UdlUxt5MaIqm304mAdlVpJWSlVeWk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958092"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958092"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045127"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045127"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/31] wifi: iwlwifi: mvm: add cancel/remain_on_channel for MLD mode
Date:   Tue, 28 Mar 2023 10:58:47 +0300
Message-Id: <20230328104948.b51813dbebd4.Ia25bbd63d3138e4759237ce2be0cd0436fe01c0a@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add an MLD version of the remain_on_channel and
cancel_remain_on_channel callbacks.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  3 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 24 +++++++---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 43 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 44 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 26 +++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  6 +++
 7 files changed, 142 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index a111e7366d49..3c540aa9c0c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -491,11 +491,14 @@ struct iwl_link_config_cmd {
  * @STATION_TYPE_MCAST: the station used for BCAST / MCAST in GO. Will be
  *	suspended / resumed at the right timing depending on the clients'
  *	power save state and the DTIM timing
+ * @STATION_TYPE_AUX: aux sta. In the FW there is no need for a special type
+ *	for the aux sta, so this type is only for driver - internal use.
  */
 enum iwl_fw_sta_type {
 	STATION_TYPE_PEER,
 	STATION_TYPE_BCAST_MGMT,
 	STATION_TYPE_MCAST,
+	STATION_TYPE_AUX,
 }; /* STATION_TYPE_E_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bb7e4e26d99f..d36319bd9247 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4309,6 +4309,20 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		       struct ieee80211_channel *channel,
 		       int duration,
 		       enum ieee80211_roc_type type)
+{
+	struct iwl_mvm_roc_ops ops = {
+		.add_aux_sta_for_hs20 = iwl_mvm_add_aux_sta_for_hs20,
+		.switch_phy_ctxt = iwl_mvm_roc_switch_binding,
+	};
+
+	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
+}
+
+/* Execute the common part for MLD and non-MLD modes */
+int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct ieee80211_channel *channel, int duration,
+		       enum ieee80211_roc_type type,
+		       struct iwl_mvm_roc_ops *ops)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -4334,7 +4348,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		lmac_id = iwl_mvm_get_lmac_id(mvm->fw, channel->band);
 
 		/* Use aux roc framework (HS20) */
-		ret = iwl_mvm_add_aux_sta_for_hs20(mvm, lmac_id);
+		ret = ops->add_aux_sta_for_hs20(mvm, lmac_id);
 		if (!ret)
 			ret = iwl_mvm_send_aux_roc_cmd(mvm, channel,
 						       vif, duration);
@@ -4354,7 +4368,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 			continue;
 
 		if (phy_ctxt->ref && channel == phy_ctxt->channel) {
-			ret = iwl_mvm_roc_switch_binding(mvm, vif, phy_ctxt);
+			ret = ops->switch_phy_ctxt(mvm, vif, phy_ctxt);
 			if (ret)
 				goto out_unlock;
 
@@ -4408,7 +4422,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 			goto out_unlock;
 		}
 
-		ret = iwl_mvm_roc_switch_binding(mvm, vif, phy_ctxt);
+		ret = ops->switch_phy_ctxt(mvm, vif, phy_ctxt);
 		if (ret)
 			goto out_unlock;
 
@@ -4425,8 +4439,8 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
-			      struct ieee80211_vif *vif)
+int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
+		       struct ieee80211_vif *vif)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 9d97098ab57c..871da586ebb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -592,10 +592,53 @@ iwl_mvm_mld_mac_conf_tx(struct ieee80211_hw *hw,
 	return 0;
 }
 
+static int iwl_mvm_link_switch_phy_ctx(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif,
+				       struct iwl_mvm_phy_ctxt *new_phy_ctxt)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret = 0;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* Inorder to change the phy_ctx of a link, the link needs to be
+	 * inactive. Therefore, first deactivate the link, then change its
+	 * phy_ctx, and then activate it again.
+	 */
+	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	if (WARN(ret, "Failed to deactivate link\n"))
+		return ret;
+
+	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
+
+	mvmvif->deflink.phy_ctxt = new_phy_ctxt;
+
+	ret = iwl_mvm_link_changed(mvm, vif, 0, false);
+	if (WARN(ret, "Failed to deactivate link\n"))
+		return ret;
+
+	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, true);
+	WARN(ret, "Failed binding P2P_DEVICE\n");
+	return ret;
+}
+
+static int iwl_mvm_mld_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_channel *channel, int duration,
+			   enum ieee80211_roc_type type)
+{
+	struct iwl_mvm_roc_ops ops = {
+		.add_aux_sta_for_hs20 = iwl_mvm_mld_add_aux_sta,
+		.switch_phy_ctxt = iwl_mvm_link_switch_phy_ctx,
+	};
+
+	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
+}
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
 	.config_iface_filter = iwl_mvm_mld_config_iface_filter,
+	.remain_on_channel = iwl_mvm_mld_roc,
+	.cancel_remain_on_channel = iwl_mvm_cancel_roc,
 	.assign_vif_chanctx = iwl_mvm_mld_assign_vif_chanctx,
 	.unassign_vif_chanctx = iwl_mvm_mld_unassign_vif_chanctx,
 	.switch_vif_chanctx = iwl_mvm_mld_switch_vif_chanctx,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 16723d581a3d..643eb58317f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -75,6 +75,24 @@ static int iwl_mvm_mld_rm_sta_from_fw(struct iwl_mvm *mvm, u32 sta_id)
 	return 0;
 }
 
+static int iwl_mvm_add_aux_sta_to_fw(struct iwl_mvm *mvm,
+				     struct iwl_mvm_int_sta *sta,
+				     u32 lmac_id)
+{
+	int ret;
+
+	struct iwl_mvm_aux_sta_cmd cmd = {
+		.sta_id = cpu_to_le32(sta->sta_id),
+		.lmac_id = cpu_to_le32(lmac_id),
+	};
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(MAC_CONF_GROUP, AUX_STA_CMD),
+				   0, sizeof(cmd), &cmd);
+	if (ret)
+		IWL_ERR(mvm, "Failed to send AUX_STA_CMD\n");
+	return ret;
+}
+
 /*
  * Adds an internal sta to the FW table with its queues
  */
@@ -91,7 +109,10 @@ static int iwl_mvm_mld_add_int_sta_with_queue(struct iwl_mvm *mvm,
 	if (WARN_ON_ONCE(sta->sta_id == IWL_MVM_INVALID_STA))
 		return -ENOSPC;
 
-	ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, sta, addr, phy_id);
+	if (sta->type == STATION_TYPE_AUX)
+		ret = iwl_mvm_add_aux_sta_to_fw(mvm, sta, phy_id);
+	else
+		ret = iwl_mvm_mld_add_int_sta_to_fw(mvm, sta, addr, phy_id);
 	if (ret)
 		return ret;
 
@@ -224,6 +245,19 @@ int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 				       IWL_MAX_TID_COUNT, NULL);
 }
 
+int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	/* In CDB NICs we need to specify which lmac to use for aux activity
+	 * using the phy_id argument place to send lmac_id to the function
+	 */
+	return iwl_mvm_mld_add_int_sta(mvm, &mvm->aux_sta, &mvm->aux_queue,
+				       NL80211_IFTYPE_UNSPECIFIED,
+				       STATION_TYPE_AUX, lmac_id, NULL,
+				       IWL_MAX_TID_COUNT, NULL);
+}
+
 static int iwl_mvm_mld_disable_txq(struct iwl_mvm *mvm,
 				   struct ieee80211_sta *sta,
 				   u16 *queueptr, u8 tid)
@@ -332,6 +366,14 @@ int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 				      IWL_MAX_TID_COUNT, &mvm->snif_queue);
 }
 
+int iwl_mvm_mld_rm_aux_sta(struct iwl_mvm *mvm)
+{
+	lockdep_assert_held(&mvm->mutex);
+
+	return iwl_mvm_mld_rm_int_sta(mvm, &mvm->aux_sta, false,
+				      IWL_MAX_TID_COUNT, &mvm->aux_queue);
+}
+
 /* send a cfg sta command to add/update a sta in firmware */
 static int iwl_mvm_mld_cfg_sta(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			       struct ieee80211_vif *vif, u16 phy_id)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2ea224acdea1..ba59a6c30529 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1827,6 +1827,32 @@ void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
 					    u64 changes);
 
+/* ROC */
+/**
+ * struct iwl_mvm_roc_ops - callbacks for the remain_on_channel()
+ *
+ * Since the only difference between both MLD and
+ * non-MLD versions of remain_on_channel() is these function calls,
+ * each version will send its specific function calls to
+ * %iwl_mvm_roc_common().
+ *
+ * @add_aux_sta_for_hs20: pointer to the function that adds an aux sta
+ *	for Hot Spot 2.0
+ * @switch_phy_ctxt: pointer to the function that switches a vif from one
+ *	phy_ctx to another
+ */
+struct iwl_mvm_roc_ops {
+	int (*add_aux_sta_for_hs20)(struct iwl_mvm *mvm, u32 lmac_id);
+	int (*switch_phy_ctxt)(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct iwl_mvm_phy_ctxt *new_phy_ctxt);
+};
+
+int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		       struct ieee80211_channel *channel, int duration,
+		       enum ieee80211_roc_type type,
+		       struct iwl_mvm_roc_ops *ops);
+int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
+		       struct ieee80211_vif *vif);
 /*Session Protection */
 void iwl_mvm_protect_assoc(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			   u32 duration_override);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 770516b20303..5436e52ca639 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -622,9 +622,11 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_add_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id);
 int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mld_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_rm_aux_sta(struct iwl_mvm *mvm);
 int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta);
 int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 3b17dd998d19..6b7b6250f1bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -95,6 +95,11 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 		/* do the same in case of hot spot 2.0 */
 		iwl_mvm_flush_sta(mvm, &mvm->aux_sta, true);
 
+		if (mvm->mld_api_is_used) {
+			iwl_mvm_mld_rm_aux_sta(mvm);
+			goto out_unlock;
+		}
+
 		/* In newer version of this command an aux station is added only
 		 * in cases of dedicated tx queue and need to be removed in end
 		 * of use */
@@ -102,6 +107,7 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
+out_unlock:
 	mutex_unlock(&mvm->mutex);
 }
 
-- 
2.38.1

