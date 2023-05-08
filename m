Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AE6FA225
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjEHIZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjEHIY6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:24:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43EA1FA95
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683534295; x=1715070295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=adPYkZ5CERsLOCZuyz7WzbKSMDSkLKKu/hdnJyMhrTk=;
  b=gC8E+dilSkJxU+tzqFCYW3jmkOY6srlZoRZZWwRRhRSXJnBxZsWh370w
   1gd+1iwxoYGPeZwNnThFAaxpodlkPIo76QyZ9EWp/BBNk7CNN4mlai85z
   PTpHxKo1PZe3yRfJ3NbdjQBg99E1XG8bhZcum0HUOzVQCBMc50ZIWqkdR
   S1eITY0lkSUnpY07DgzlDYMxwtvI/ttXhixO1OinrO7C+6rmytrOfRfTK
   FaAYiPoGvI6OeOUl97/W3BMXjiydPcW9oeemoV3WNCDEi1kbdeIQHhVyZ
   WpPTZTayBOss9aEtN19qU8+ZH+p2KXIgWaMzzD+uFz0ny4/ZGikj5BhGT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="329949871"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="329949871"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="767982608"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; 
   d="scan'208";a="767982608"
Received: from shemert-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.224.248])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 01:24:54 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_add_interface_common()
Date:   Mon,  8 May 2023 11:24:24 +0300
Message-Id: <20230508082433.1349733-6-gregory.greenman@intel.com>
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

From: Johannes Berg <johannes.berg@intel.com>

This wasn't really common anymore, so dissolve it, it has a
pretty strange calling convention that's confusing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 90 ++++++++-----------
 1 file changed, 37 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 13bbc9a627b8..2ae665ba2ac9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1478,21 +1478,37 @@ iwl_mvm_chandef_get_primary_80(struct cfg80211_chan_def *chandef)
 	return (control_start - data_start) / 80;
 }
 
-/*
- * Returns true if addding the interface is done
- * (either with success or failure)
- *
- * FIXME: remove this again and merge it in
- */
-static bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
-					     struct ieee80211_hw *hw,
-					     struct ieee80211_vif *vif,
-					     int *ret)
+static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	ret = iwl_mvm_alloc_bcast_sta(mvm, vif);
+	if (ret) {
+		IWL_ERR(mvm, "Failed to allocate bcast sta\n");
+		return ret;
+	}
+
+	/* Only queue for this station is the mcast queue,
+	 * which shouldn't be in TFD mask anyway
+	 */
+	return iwl_mvm_allocate_int_sta(mvm, &mvmvif->deflink.mcast_sta, 0,
+					vif->type,
+					IWL_STA_MULTICAST);
+}
+
+static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+
 	mvmvif->mvm = mvm;
 
 	/* the first link always points to the default one */
@@ -1510,12 +1526,18 @@ static bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
 			mvmvif->deflink.beacon_stats.num_beacons;
 
 	/* Allocate resources for the MAC context, and add it to the fw  */
-	*ret = iwl_mvm_mac_ctxt_init(mvm, vif);
-	if (*ret)
-		return true;
+	ret = iwl_mvm_mac_ctxt_init(mvm, vif);
+	if (ret)
+		goto out;
 
 	rcu_assign_pointer(mvm->vif_id_to_mac[mvmvif->id], vif);
 
+	/* Currently not much to do for NAN */
+	if (vif->type == NL80211_IFTYPE_NAN) {
+		ret = 0;
+		goto out;
+	}
+
 	/*
 	 * The AP binding flow can be done only after the beacon
 	 * template is configured (which happens only in the mac80211
@@ -1530,50 +1552,12 @@ static bool iwl_mvm_mac_add_interface_common(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
 		iwl_mvm_vif_dbgfs_register(mvm, vif);
-		return true;
+		ret = 0;
+		goto out;
 	}
 
 	mvmvif->features |= hw->netdev_features;
 
-	return false;
-}
-
-static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
-					 struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	ret = iwl_mvm_alloc_bcast_sta(mvm, vif);
-	if (ret) {
-		IWL_ERR(mvm, "Failed to allocate bcast sta\n");
-		return ret;
-	}
-
-	/*
-	 * Only queue for this station is the mcast queue,
-	 * which shouldn't be in TFD mask anyway
-	 */
-	return iwl_mvm_allocate_int_sta(mvm, &mvmvif->deflink.mcast_sta, 0,
-					vif->type,
-					IWL_STA_MULTICAST);
-}
-
-static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
-				     struct ieee80211_vif *vif)
-{
-	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret;
-
-	mutex_lock(&mvm->mutex);
-
-	/* Common for MLD and non-MLD API */
-	if (iwl_mvm_mac_add_interface_common(mvm, hw, vif, &ret))
-		goto out;
-
 	ret = iwl_mvm_mac_ctxt_add(mvm, vif);
 	if (ret)
 		goto out_unlock;
-- 
2.38.1

