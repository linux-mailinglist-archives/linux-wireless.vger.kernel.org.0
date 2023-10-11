Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801C87C4FB7
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbjJKKJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345978AbjJKKIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:08:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FC1FF3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018881; x=1728554881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Urc8UCFsmxqWVxQ8DbcIYcscWfE+33F/a8fgKYYkJ+I=;
  b=D0xDVuM2Y31Rz3ZyFyJdW3yySa8lZXttOX2zN1nzA3AA9jKslvu8Koaz
   3lN0O2NvKdMRnKmsteDLr/RkaUQyGfQED2NYz9DeYdcwQGFPpdyybAaDo
   M9fun9v+tQy7O2DFbpi6QGxCF+G1d4DgqnsOkfE92X0wKZjDHeGQ3PsAG
   LbiUrIMBB9avCC+/8ORYa+s/7uI9BNLi4toMFMlOzZ6VMXQxcaHQkKFNh
   3WhdgQyH/BWwK5ZDJa29uObwDCw8x4F1f8B53C8aEdeRAmRsxV2b0SFXB
   jd8DL/SyXSI13WGrGk0111Ec3Qn12fB1ZrUS2ezIRoC1iKq9Y2mEA8gOV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670601"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670601"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050284"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050284"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:07:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/16] wifi: iwlwifi: mvm: cleanup MLO and non-MLO unification code
Date:   Wed, 11 Oct 2023 13:07:23 +0300
Message-Id: <20231011130030.b65fbcdb9295.I2a64a6f1178ee0466755d728addc77acbb2ed6f4@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

bss_info_changed() callback of mac80211 was originally in both
MLD and non-MLD API. Therefore, we extracted the common part
to a function which receives a callback structure with the
mode-specific (non-MLO\MLO) ops. Eventually, for MLO API,
bss_info_changed() callback was split into 2 callbacks:
link_info_changed() and vif_cfg_changed() so it is no longer in use
for MLO, only for non-MLO.
Remove the code that uses the mode-specific callback structure.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 21 +---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 39 ++-----------------
 2 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 387642ea2fff..ce65d74413fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3036,22 +3036,6 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *bss_conf,
 				     u64 changes)
-{
-	static const struct iwl_mvm_bss_info_changed_ops callbacks = {
-		.bss_info_changed_sta = iwl_mvm_bss_info_changed_station,
-		.bss_info_changed_ap_ibss = iwl_mvm_bss_info_changed_ap_ibss,
-	};
-
-	iwl_mvm_bss_info_changed_common(hw, vif, bss_conf, &callbacks,
-					changes);
-}
-
-void
-iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct ieee80211_bss_conf *bss_conf,
-				const struct iwl_mvm_bss_info_changed_ops *callbacks,
-				u64 changes)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
@@ -3062,12 +3046,11 @@ iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
-		callbacks->bss_info_changed_sta(mvm, vif, bss_conf, changes);
+		iwl_mvm_bss_info_changed_station(mvm, vif, bss_conf, changes);
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_ADHOC:
-		callbacks->bss_info_changed_ap_ibss(mvm, vif, bss_conf,
-						    changes);
+		iwl_mvm_bss_info_changed_ap_ibss(mvm, vif, bss_conf, changes);
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		if (changes & BSS_CHANGED_MU_GROUPS)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 866753218ec8..fda5ad4723ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1921,41 +1921,10 @@ void iwl_mvm_stop_ap_ibss_common(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 
 /* BSS Info */
-/**
- * struct iwl_mvm_bss_info_changed_ops - callbacks for the bss_info_changed()
- *
- * Since the only difference between both MLD and
- * non-MLD versions of bss_info_changed() is these function calls,
- * each version will send its specific function calls to
- * %iwl_mvm_bss_info_changed_common().
- *
- * @bss_info_changed_sta: pointer to the function that handles changes
- *	in bss_info in sta mode
- * @bss_info_changed_ap_ibss: pointer to the function that handles changes
- *	in bss_info in ap and ibss modes
- */
-struct iwl_mvm_bss_info_changed_ops {
-	void (*bss_info_changed_sta)(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     struct ieee80211_bss_conf *bss_conf,
-				     u64 changes);
-	void (*bss_info_changed_ap_ibss)(struct iwl_mvm *mvm,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_bss_conf *bss_conf,
-					 u64 changes);
-};
-
-void
-iwl_mvm_bss_info_changed_common(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif,
-				struct ieee80211_bss_conf *bss_conf,
-				const struct iwl_mvm_bss_info_changed_ops *callbacks,
-				u64 changes);
-void
-iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
-					struct ieee80211_vif *vif,
-					struct ieee80211_bss_conf *link_conf,
-					u64 changes);
+void iwl_mvm_bss_info_changed_station_common(struct iwl_mvm *mvm,
+					     struct ieee80211_vif *vif,
+					     struct ieee80211_bss_conf *link_conf,
+					     u64 changes);
 void iwl_mvm_bss_info_changed_station_assoc(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
 					    u64 changes);
-- 
2.38.1

