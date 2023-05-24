Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC8370FCEE
	for <lists+linux-wireless@lfdr.de>; Wed, 24 May 2023 19:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjEXRp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 May 2023 13:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbjEXRp0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 May 2023 13:45:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2011E48
        for <linux-wireless@vger.kernel.org>; Wed, 24 May 2023 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684950288; x=1716486288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uTmKuCLuuU0NgZx5Q6QuUNqo6yOr7a+gig9AwgUT5zg=;
  b=MtCsztfOBuxhDEPNllZQPVGdz0mEyBX0Mb2higg3HOYqV7iYYh8J+rOu
   bPY8k5nt/TWkVIjZ+WqwrJqq8HTtpJlqAdoXBKvM7sN/hY5L2ch9Lx4lH
   hhnAPhktVPtLyQzU3b+MYtEItBjix82RUlfFqbsICZPWbs7lDKMQJCQ6I
   Oe1zIVahjXVgiesAtTOBHJ+OjprPoZ2X8eZKktTmv2Bmyo3hhbnh09NF3
   cfvVegGccy09951dzVo7wKVI34c9r4NWh/XbkUt5e1BEBZZ2n9HoKdKL8
   7IzYVF3QDX0v8WNE4ICQ83US5jyEFR7pJjrvXOwb1g0okD+WBBgqt8K4U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="440000369"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="440000369"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="769547906"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="769547906"
Received: from hmozes-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.89.195])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:42:41 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/14] wifi: iwlwifi: mvm: dissolve iwl_mvm_mac_add_interface_common()
Date:   Wed, 24 May 2023 20:42:01 +0300
Message-Id: <20230524203151.44320ab2e842.Ie1d6b9c28caca3b541ca383a4c0c8799b0e72fe0@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

This wasn't really common anymore, so dissolve it, it has a
pretty strange calling convention that's confusing.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 90 ++++++++-----------
 1 file changed, 37 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5e28a53dad26..cac4aa062cd4 100644
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

