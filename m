Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07E6CB8F1
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjC1IAZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjC1IAS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AFC44AB
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990417; x=1711526417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sADVFicwtVdDy8GNK40vJIU8lrVV1j5zUdGui+JoUpI=;
  b=Mqggfcporn/BfITE0/XFSBPVlumGiv4TudBrbx5HUpskUUsftTKT7+N7
   7VxbrRLP1PzJDprEdI/gyZLzTYRhI0oC7XiWFBzK+DLqxpx3ggMdY8/lf
   WPK1H9WgPLGbJiWdfgivWqimA6mRpmg1lBXRIvLWcmPuUHHMV0HStKkJw
   WDgbusq7sfM4QGoi8FNA/E2X/HVK+jMeyDZ89fkV3SLuDKRgO6is6AVH3
   4gZLBW0X0lKszZuLO7EpIQIfwSnitXMOA1fzVjCYkFYhzvWYnq5z+PeQu
   v9b7tnQNLqm8IOWiZnkAkFf9N4jhcV2KIbUfouEj7gVcXmeAJzmZiHy7K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958197"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958197"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045198"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045198"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 18/31] wifi: iwlwifi: mvm: adjust some PS and PM methods to MLD
Date:   Tue, 28 Mar 2023 10:58:58 +0300
Message-Id: <20230328104949.8d9e18f7d74b.I048fc17405ecdddc1f6fe72859013cc4878b2a3b@changeid>
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

When using mvm vif PS/PM related properties, consider all links.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++++
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 16 +++++----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 33 +++++++++++++++++++
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d9caf326535f..2989285d451a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1278,8 +1278,8 @@ struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm)
 	return NULL;
 }
 
-static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				s16 tx_power)
+int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 s16 tx_power)
 {
 	u32 cmd_id = REDUCE_TX_POWER_CMD;
 	int len;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9c5e772d619e..ae9c165197e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2599,4 +2599,10 @@ int iwl_mvm_start_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct cfg80211_pmsr_request *request);
 void iwl_mvm_abort_pmsr(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			struct cfg80211_pmsr_request *request);
+
+bool iwl_mvm_have_links_same_channel(struct iwl_mvm_vif *vif1,
+				     struct iwl_mvm_vif *vif2);
+bool iwl_mvm_vif_is_active(struct iwl_mvm_vif *mvmvif);
+int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			 s16 tx_power);
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 6e2e3127843f..45a652cce491 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -553,8 +553,7 @@ static void iwl_mvm_power_ps_disabled_iterator(void *_data, u8* mac,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	bool *disable_ps = _data;
 
-	if (mvmvif->deflink.phy_ctxt &&
-	    mvmvif->deflink.phy_ctxt->id < NUM_PHY_CTX)
+	if (iwl_mvm_vif_is_active(mvmvif))
 		*disable_ps |= mvmvif->ps_disabled;
 }
 
@@ -563,11 +562,13 @@ static void iwl_mvm_power_get_vifs_iterator(void *_data, u8 *mac,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_power_vifs *power_iterator = _data;
-	bool active = mvmvif->deflink.phy_ctxt && mvmvif->deflink.phy_ctxt->id < NUM_PHY_CTX;
+	bool active;
 
 	if (!mvmvif->uploaded)
 		return;
 
+	active = iwl_mvm_vif_is_active(mvmvif);
+
 	switch (ieee80211_vif_type_p2p(vif)) {
 	case NL80211_IFTYPE_P2P_DEVICE:
 		break;
@@ -651,11 +652,12 @@ static void iwl_mvm_power_set_pm(struct iwl_mvm *mvm,
 	}
 
 	if (vifs->bss_active && vifs->p2p_active)
-		client_same_channel = (bss_mvmvif->deflink.phy_ctxt->id ==
-				       p2p_mvmvif->deflink.phy_ctxt->id);
+		client_same_channel =
+			iwl_mvm_have_links_same_channel(bss_mvmvif, p2p_mvmvif);
+
 	if (vifs->bss_active && vifs->ap_active)
-		ap_same_channel = (bss_mvmvif->deflink.phy_ctxt->id ==
-				   ap_mvmvif->deflink.phy_ctxt->id);
+		ap_same_channel =
+			iwl_mvm_have_links_same_channel(bss_mvmvif, ap_mvmvif);
 
 	/* clients are not stand alone: enable PM if DCM */
 	if (!(client_same_channel || ap_same_channel)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index c1f6dd8f7d10..026856c8f5f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1138,3 +1138,36 @@ void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, int clock_type,
 		iwl_mvm_power_update_device(mvm);
 	}
 }
+
+/* Find if at least two links from different vifs use same channel
+ * FIXME: consider having a refcount array in struct iwl_mvm_vif for
+ * used phy_ctxt ids.
+ */
+bool iwl_mvm_have_links_same_channel(struct iwl_mvm_vif *vif1,
+				     struct iwl_mvm_vif *vif2)
+{
+	unsigned int i, j;
+
+	for_each_mvm_vif_valid_link(vif1, i) {
+		for_each_mvm_vif_valid_link(vif2, j) {
+			if (vif1->link[i]->phy_ctxt == vif2->link[j]->phy_ctxt)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+bool iwl_mvm_vif_is_active(struct iwl_mvm_vif *mvmvif)
+{
+	unsigned int i;
+
+	/* FIXME: can it fail when phy_ctxt is assigned? */
+	for_each_mvm_vif_valid_link(mvmvif, i) {
+		if (mvmvif->link[i]->phy_ctxt &&
+		    mvmvif->link[i]->phy_ctxt->id < NUM_PHY_CTX)
+			return true;
+	}
+
+	return false;
+}
-- 
2.38.1

