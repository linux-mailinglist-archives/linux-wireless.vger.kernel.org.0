Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B466CB8FD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjC1IAs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjC1IAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:31 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1140EA
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990429; x=1711526429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D4q4iP3pthtEDLIPjWlck1Px2bmh/VPpa8NXc/0RafA=;
  b=MX1BTvXN9cK1jp1kpIWkANtOsLFa88BN5oUyYjkgKygv+HNI67IqTEFA
   FYV1fbdK52zlqhQxJInzgcyi32/5Em8oEDX88wOD8qu4IInIqEICxGywg
   Qp834KDEMlDnRe92oE7pLikIDYouPBJLGJIs3suS7ifIX9TivA3qIpGaG
   jsNKLDUWFmi1uwuT4IUGEjhW3o5lByJqPl6kmWu+Tv3b5W+1FrGKJvooJ
   TV8XEjiXkYuiLdzo+mST7JICkAbSFJ+EDr1aT3Dhmx5nWUdnYyQlZ+vfH
   vJwD+oh7Hd+U/w0mga2UsJF3JoMkWUZ9Fii7JwAzQ45kdu+n+rkkuQhMD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958322"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958322"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045364"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045364"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:28 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 31/31] wifi: iwlwifi: mvm: implement link change ops
Date:   Tue, 28 Mar 2023 10:59:11 +0300
Message-Id: <20230328104949.6186c5a37e99.Ifd00d3ee93356ddef273aa18f1e081cd8f2c84ae@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

Implement the link change ops for links and stations.
Note that the stations one is empty for now as we only
have support for a single link so far, and then the
stations are created with the first link as deflink by
mac80211, so right now we don't really need anything.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  43 ++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  12 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 145 ++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 4 files changed, 187 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 7a70b6ee65ac..0cd40672fade 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2022 - 2023 Intel Corporation
  */
 #include "mvm.h"
+#include "time-event.h"
 
 static u32 iwl_mvm_get_free_fw_link_id(struct iwl_mvm *mvm,
 				       struct iwl_mvm_vif *mvm_vif)
@@ -108,6 +109,28 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	    mvmvif->fw_active_links_num >= IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM)
 		return -EINVAL;
 
+	if (changes & LINK_CONTEXT_MODIFY_ACTIVE) {
+		/* When activating a link, phy context should be valid;
+		 * when deactivating a link, it also should be valid since
+		 * the link was active before. So, do nothing in this case.
+		 * Since a link is added first with FW_CTXT_INVALID, then we
+		 * can get here in case it's removed before it was activated.
+		 */
+		if (!link_info->phy_ctxt)
+			return 0;
+
+		/* Catch early if driver tries to activate or deactivate a link
+		 * twice.
+		 */
+		WARN_ON_ONCE(active == link_info->active);
+
+		/* When deactivating a link session protection should
+		 * be stopped
+		 */
+		if (!active && vif->type == NL80211_IFTYPE_STATION)
+			iwl_mvm_stop_session_protection(mvm, vif);
+	}
+
 	cmd.link_id = cpu_to_le32(link_info->fw_link_id);
 
 	/* The phy_id, link address and listen_lmac can be modified only until
@@ -248,3 +271,23 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	return ret;
 }
+
+/* link should be deactivated before removal, so in most cases we need to
+ * perform these two operations together
+ */
+int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *link_conf)
+{
+	int ret;
+
+	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
+				   LINK_CONTEXT_MODIFY_ACTIVE, false);
+	if (ret)
+		return ret;
+
+	ret = iwl_mvm_remove_link(mvm, vif, link_conf);
+	if (ret)
+		return ret;
+
+	return ret;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9e825e3cf630..c60aff0df801 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -983,6 +983,7 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 {
 	struct iwl_mvm *mvm = data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_probe_resp_data *probe_data;
 	unsigned int link_id;
 
 	mvmvif->uploaded = false;
@@ -993,13 +994,19 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 
 	memset(&mvmvif->bf_data, 0, sizeof(mvmvif->bf_data));
 
+	mvmvif->fw_active_links_num = 0;
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
 		mvmvif->link[link_id]->ap_sta_id = IWL_MVM_INVALID_STA;
 		mvmvif->link[link_id]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 		mvmvif->link[link_id]->phy_ctxt = NULL;
-		memset(&mvmvif->link[link_id]->probe_resp_data, 0,
-		       sizeof(mvmvif->link[link_id]->probe_resp_data));
+		mvmvif->link[link_id]->active = 0;
 	}
+
+	probe_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
+					       lockdep_is_held(&mvm->mutex));
+	if (probe_data)
+		kfree_rcu(probe_data, rcu_head);
+	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 }
 
 static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
@@ -1455,7 +1462,6 @@ static bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
 	lockdep_assert_held(&mvm->mutex);
 
 	mvmvif->mvm = mvm;
-	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 
 	/* the first link always points to the default one */
 	mvmvif->link[0] = &mvmvif->deflink;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 0c233d151231..7463cb8a271a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -14,7 +14,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	mutex_lock(&mvm->mutex);
 
 	mvmvif->mvm = mvm;
-	RCU_INIT_POINTER(mvmvif->deflink.probe_resp_data, NULL);
 
 	/* Not much to do here. The stack will not allow interface
 	 * types or combinations that we didn't advertise, so we
@@ -35,8 +34,10 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 
 	mvmvif->features |= hw->netdev_features;
 
-	/* the first link always points to the default one */
+	/* reset deflink MLO parameters */
 	mvmvif->deflink.fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
+	mvmvif->deflink.active = 0;
+	/* the first link always points to the default one */
 	mvmvif->link[0] = &mvmvif->deflink;
 
 	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
@@ -119,10 +120,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	goto out_unlock;
 
  out_remove_link:
-	/* Link needs to be deactivated before removal */
-	iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-			     LINK_CONTEXT_MODIFY_ACTIVE, false);
-	iwl_mvm_remove_link(mvm, vif, &vif->bss_conf);
+	iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
  out_unref_phy:
 	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
  out_free_bf:
@@ -198,14 +196,11 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 
 		/* P2P device uses only one link */
 		iwl_mvm_mld_rm_bcast_sta(mvm, vif, &vif->bss_conf);
-		/* Link needs to be deactivated before removal */
-		iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-				     LINK_CONTEXT_MODIFY_ACTIVE, false);
-		iwl_mvm_remove_link(mvm, vif, &vif->bss_conf);
+		iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
 		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
 		mvmvif->deflink.phy_ctxt = NULL;
 	} else {
-		iwl_mvm_remove_link(mvm, vif, &vif->bss_conf);
+		iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
 	}
 
 	iwl_mvm_mld_mac_ctxt_remove(mvm, vif);
@@ -359,7 +354,10 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (ret)
 		goto out_unlock;
 
-	ret = iwl_mvm_link_changed(mvm, vif, link_conf, LINK_CONTEXT_MODIFY_ALL,
+	/* the link should be already activated when assigning chan context */
+	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
+				   LINK_CONTEXT_MODIFY_ALL &
+				   ~LINK_CONTEXT_MODIFY_ACTIVE,
 				   true);
 	if (ret)
 		goto out_unlock;
@@ -839,6 +837,126 @@ static int iwl_mvm_mld_roc(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	return iwl_mvm_roc_common(hw, vif, channel, duration, type, &ops);
 }
+
+static int
+iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     u16 old_links, u16 new_links,
+			     struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
+{
+	struct iwl_mvm_vif_link_info *new_link[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	u16 removed = old_links & ~new_links;
+	u16 added = new_links & ~old_links;
+	int err, i;
+
+	if (hweight16(new_links) > 2) {
+		return -EOPNOTSUPP;
+	} else if (hweight16(new_links) > 1) {
+		unsigned int n_active = 0;
+
+		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+			struct ieee80211_bss_conf *link_conf;
+
+			link_conf = link_conf_dereference_protected(vif, i);
+			if (link_conf &&
+			    rcu_access_pointer(link_conf->chanctx_conf))
+				n_active++;
+		}
+
+		if (n_active > 1)
+			return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		int r;
+
+		if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+			break;
+
+		if (!(added & BIT(i)))
+			continue;
+		new_link[i] = kzalloc(sizeof(*new_link[i]), GFP_KERNEL);
+		if (!new_link[i]) {
+			err = -ENOMEM;
+			goto free;
+		}
+
+		new_link[i]->bcast_sta.sta_id = IWL_MVM_INVALID_STA;
+		new_link[i]->mcast_sta.sta_id = IWL_MVM_INVALID_STA;
+		new_link[i]->ap_sta_id = IWL_MVM_INVALID_STA;
+		new_link[i]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
+
+		for (r = 0; r < NUM_IWL_MVM_SMPS_REQ; r++)
+			new_link[i]->smps_requests[r] =
+				IEEE80211_SMPS_AUTOMATIC;
+	}
+
+	mutex_lock(&mvm->mutex);
+
+	if (old_links == 0) {
+		err = iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
+		if (err)
+			goto out_err;
+		mvmvif->link[0] = NULL;
+	}
+
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
+		if (removed & BIT(i)) {
+			struct ieee80211_bss_conf *link_conf = old[i];
+
+			err = iwl_mvm_disable_link(mvm, vif, link_conf);
+			if (err)
+				goto out_err;
+			kfree(mvmvif->link[i]);
+			mvmvif->link[i] = NULL;
+		}
+
+		if (added & BIT(i)) {
+			struct ieee80211_bss_conf *link_conf;
+
+			/* FIXME: allow use of sdata_dereference()? */
+			link_conf = rcu_dereference_protected(vif->link_conf[i],
+							      1);
+			if (WARN_ON(!link_conf))
+				continue;
+
+			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
+				      &mvm->status))
+				mvmvif->link[i] = new_link[i];
+			new_link[i] = NULL;
+			err = iwl_mvm_add_link(mvm, vif, link_conf);
+			if (err)
+				goto out_err;
+		}
+	}
+
+	err = 0;
+	if (new_links == 0) {
+		mvmvif->link[0] = &mvmvif->deflink;
+		err = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
+	}
+
+out_err:
+	/* we really don't have a good way to roll back here ... */
+	mutex_unlock(&mvm->mutex);
+
+free:
+	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
+		kfree(new_link[i]);
+	return err;
+}
+
+static int
+iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_sta *sta,
+			     u16 old_links, u16 new_links)
+{
+	return 0;
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -928,4 +1046,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.sta_add_debugfs = iwl_mvm_sta_add_debugfs,
 #endif
 	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
+
+	.change_vif_links = iwl_mvm_mld_change_vif_links,
+	.change_sta_links = iwl_mvm_mld_change_sta_links,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3a9ece67aff7..dfe1aff10548 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1824,6 +1824,8 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 u32 changes, bool active);
 int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			struct ieee80211_bss_conf *link_conf);
+int iwl_mvm_disable_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 struct ieee80211_bss_conf *link_conf);
 
 /* AP and IBSS */
 bool iwl_mvm_start_ap_ibss_common(struct ieee80211_hw *hw,
-- 
2.38.1

