Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3647B7C45
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242030AbjJDJhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbjJDJhH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0C2D8
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412222; x=1727948222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tAo6CobBd43932f/xOwAUGu49+5+y7vEWGN8AJdabfA=;
  b=amEiNkQjnWiKxJjk2m3S9hQHc1vWBmSWrUcl/hANhuJTerzVtBzXZlb2
   jJ2c3a0AwQkXisBsfBRkEluEiBKetnu6whgDl+yPPNXKmusAYeFyvxoRL
   J9aSgVnMzI0Cw1TlU11vZoDZV4D4MKFI+hp1cXSI0cMoNSKc3TTXT7SNT
   WOUOCS3cUWbkQqoZAUWxqtTy9cYFox7MAX1K3VbHgVk1Bx7hibuce5PuA
   jAKA5V7N5/uW7W4Tzqhzc3fnbBcF7SLCoCoFJcJt7fNaHkNq2O0SsBmMd
   pqY2UVm+jPpLnjdPHqUR5niG7L9MqErNqY0COu8cI5UXFE4dejAnWpwPI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611753"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611753"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415159"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415159"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: rework debugfs handling
Date:   Wed,  4 Oct 2023 12:36:23 +0300
Message-Id: <20231004123422.818810e242e6.I805a28f9fbef5c52a3a575d04e7a6a909ecf9078@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

mac80211 added a new callback to add a vif debugfs.
Implement it instead of adding the debugfs directly,
which will make it properly preserved over switching
the vif from non-MLD/MLD and back.

This requires some rework so that we still have the
symlink but trust mac80211 to add/remove the debugfs.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  | 32 +++++++++----------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  7 ++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  5 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  9 +++---
 4 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
index cb4ecad6103f..3a42fb38b32f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c
@@ -699,19 +699,11 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(rx_phyinfo, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(quota_min, 32);
 MVM_DEBUGFS_READ_FILE_OPS(os_device_timediff);
 
-
-void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct dentry *dbgfs_dir = vif->debugfs_dir;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	char buf[100];
-
-	/*
-	 * Check if debugfs directory already exist before creating it.
-	 * This may happen when, for example, resetting hw or suspend-resume
-	 */
-	if (!dbgfs_dir || mvmvif->dbgfs_dir)
-		return;
 
 	mvmvif->dbgfs_dir = debugfs_create_dir("iwlmvm", dbgfs_dir);
 	if (IS_ERR_OR_NULL(mvmvif->dbgfs_dir)) {
@@ -737,6 +729,17 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
 	    mvmvif == mvm->bf_allowed_vif)
 		MVM_DEBUGFS_ADD_FILE_VIF(bf_params, mvmvif->dbgfs_dir, 0600);
+}
+
+void iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct dentry *dbgfs_dir = vif->debugfs_dir;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	char buf[100];
+
+	/* this will happen in monitor mode */
+	if (!dbgfs_dir)
+		return;
 
 	/*
 	 * Create symlink for convenience pointing to interface specific
@@ -745,21 +748,16 @@ void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * find
 	 * netdev:wlan0 -> ../../../ieee80211/phy0/netdev:wlan0/iwlmvm/
 	 */
-	snprintf(buf, 100, "../../../%pd3/%pd",
-		 dbgfs_dir,
-		 mvmvif->dbgfs_dir);
+	snprintf(buf, 100, "../../../%pd3/iwlmvm", dbgfs_dir);
 
 	mvmvif->dbgfs_slink = debugfs_create_symlink(dbgfs_dir->d_name.name,
 						     mvm->debugfs_dir, buf);
 }
 
-void iwl_mvm_vif_dbgfs_clean(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+void iwl_mvm_vif_dbgfs_rm_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
 	debugfs_remove(mvmvif->dbgfs_slink);
 	mvmvif->dbgfs_slink = NULL;
-
-	debugfs_remove_recursive(mvmvif->dbgfs_dir);
-	mvmvif->dbgfs_dir = NULL;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d342a53a8c46..56965d6e6499 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1580,7 +1580,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	 */
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
-		iwl_mvm_vif_dbgfs_register(mvm, vif);
+		iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 		ret = 0;
 		goto out;
 	}
@@ -1644,7 +1644,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 			iwl_mvm_chandef_get_primary_80(&vif->bss_conf.chandef);
 	}
 
-	iwl_mvm_vif_dbgfs_register(mvm, vif);
+	iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
@@ -1732,7 +1732,7 @@ static bool iwl_mvm_mac_remove_interface_common(struct ieee80211_hw *hw,
 	if (vif->bss_conf.ftm_responder)
 		memset(&mvm->ftm_resp_stats, 0, sizeof(mvm->ftm_resp_stats));
 
-	iwl_mvm_vif_dbgfs_clean(mvm, vif);
+	iwl_mvm_vif_dbgfs_rm_link(mvm, vif);
 
 	/*
 	 * For AP/GO interface, the tear down of the resources allocated to the
@@ -6324,6 +6324,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 
 	.can_aggregate_in_amsdu = iwl_mvm_mac_can_aggregate,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
+	.vif_add_debugfs = iwl_mvm_vif_add_debugfs,
 	.link_sta_add_debugfs = iwl_mvm_link_sta_add_debugfs,
 #endif
 	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 726a3276f715..2a55ba01fc78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -107,7 +107,7 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		ieee80211_hw_set(mvm->hw, RX_INCLUDES_FCS);
 	}
 
-	iwl_mvm_vif_dbgfs_register(mvm, vif);
+	iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
@@ -168,7 +168,7 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	if (vif->bss_conf.ftm_responder)
 		memset(&mvm->ftm_resp_stats, 0, sizeof(mvm->ftm_resp_stats));
 
-	iwl_mvm_vif_dbgfs_clean(mvm, vif);
+	iwl_mvm_vif_dbgfs_rm_link(mvm, vif);
 
 	/* For AP/GO interface, the tear down of the resources allocated to the
 	 * interface is be handled as part of the stop_ap flow.
@@ -1204,6 +1204,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.abort_pmsr = iwl_mvm_abort_pmsr,
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
+	.vif_add_debugfs = iwl_mvm_vif_add_debugfs,
 	.link_sta_add_debugfs = iwl_mvm_link_sta_add_debugfs,
 #endif
 	.set_hw_timestamp = iwl_mvm_set_hw_timestamp,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 74cb2f863472..5ec79bea5af1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2048,18 +2048,19 @@ void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
 /* MVM debugfs */
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm);
-void iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
-void iwl_mvm_vif_dbgfs_clean(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+void iwl_mvm_vif_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
+void iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+void iwl_mvm_vif_dbgfs_rm_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 #else
 static inline void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 {
 }
 static inline void
-iwl_mvm_vif_dbgfs_register(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+iwl_mvm_vif_dbgfs_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 }
 static inline void
-iwl_mvm_vif_dbgfs_clean(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+iwl_mvm_vif_dbgfs_rm_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 }
 #endif /* CONFIG_IWLWIFI_DEBUGFS */
-- 
2.38.1

