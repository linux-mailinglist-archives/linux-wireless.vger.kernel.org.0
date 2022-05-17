Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA3529D7D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244643AbiEQJIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244367AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1EC23BC9
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778408; x=1684314408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jl4RyGZZPEyke7QJXvPrNWpHaYFehclnKVrLVMPCLOA=;
  b=WgHmNENbKVncaNye4VFKN1ZFWdH/+fH+QVhU16RWD8ZDSN6vPXEi6Zu/
   xpoB9Uv/jkDbKd8WW4PoMxT3slNpNLonI9M0vtKgWrYLswhAJiIjJCWDD
   Vxtb+i3G1hYs/zGLCu9QfyW5oI20JiNTA8SHdVk7kf4A+Jm3DAcoAhhHS
   sLaYf255p2YdUSsvHkp9y2IrfkKwHThVIsIplBmvST+1P2Z8vW6rJVieq
   ISOFeqckgviT9JVFwJhS4BLp84DFNWhyB8vVqS1hr7/HwJv8AiY3NvSgg
   eEPdPhdnE2ngfiRrD8bD/h/dT0SplDFcC5HvZjHjaWeBRDwXlkHWSICem
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064836"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064836"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679760"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:31 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 08/10] iwlwifi: mvm: remove vif_count
Date:   Tue, 17 May 2022 12:05:12 +0300
Message-Id: <20220517120045.8c91ae023b15.Ia6145e4930b1d28f3fcedc316b4f177295b00557@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

We used to count the number of ieee80211_vifs in mvm.
This was needed for the legacy PM API, which is no longer
supported. Remove it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c   | 17 +++--------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    |  1 -
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4fda6c3ba9f3..bb9bd2165355 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -976,7 +976,6 @@ static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 
 	ieee80211_wake_queues(mvm->hw);
 
-	mvm->vif_count = 0;
 	mvm->rx_ba_sessions = 0;
 	mvm->fwrt.dump.conf = FW_DBG_INVALID;
 	mvm->monitor_on = false;
@@ -1380,10 +1379,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(mvm->vif_id_to_mac[mvmvif->id], vif);
 
-	/* Counting number of interfaces is needed for legacy PM */
-	if (vif->type != NL80211_IFTYPE_P2P_DEVICE)
-		mvm->vif_count++;
-
 	/*
 	 * The AP binding flow can be done only after the beacon
 	 * template is configured (which happens only in the mac80211
@@ -1400,7 +1395,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 		ret = iwl_mvm_alloc_bcast_sta(mvm, vif);
 		if (ret) {
 			IWL_ERR(mvm, "Failed to allocate bcast sta\n");
-			goto out_release;
+			goto out_unlock;
 		}
 
 		/*
@@ -1411,7 +1406,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 					       0, vif->type,
 					       IWL_STA_MULTICAST);
 		if (ret)
-			goto out_release;
+			goto out_unlock;
 
 		iwl_mvm_vif_dbgfs_register(mvm, vif);
 		goto out_unlock;
@@ -1421,7 +1416,7 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 
 	ret = iwl_mvm_mac_ctxt_add(mvm, vif);
 	if (ret)
-		goto out_release;
+		goto out_unlock;
 
 	ret = iwl_mvm_power_update_mac(mvm);
 	if (ret)
@@ -1498,9 +1493,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
  out_remove_mac:
 	mvmvif->phy_ctxt = NULL;
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
- out_release:
-	if (vif->type != NL80211_IFTYPE_P2P_DEVICE)
-		mvm->vif_count--;
  out_unlock:
 	mutex_unlock(&mvm->mutex);
 
@@ -1582,9 +1574,6 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvmvif->phy_ctxt = NULL;
 	}
 
-	if (mvm->vif_count && vif->type != NL80211_IFTYPE_P2P_DEVICE)
-		mvm->vif_count--;
-
 	iwl_mvm_power_update_mac(mvm);
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index c6bc85d4600a..bf35e130c876 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -934,7 +934,6 @@ struct iwl_mvm {
 	unsigned long fw_key_table[BITS_TO_LONGS(STA_KEY_MAX_NUM)];
 	u8 fw_key_deleted[STA_KEY_MAX_NUM];
 
-	u8 vif_count;
 	struct ieee80211_vif __rcu *vif_id_to_mac[NUM_MAC_INDEX_DRIVER];
 
 	/* -1 for always, 0 for never, >0 for that many times */
-- 
2.35.1

