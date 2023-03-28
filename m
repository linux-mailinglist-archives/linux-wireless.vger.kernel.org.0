Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6106CB8FE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjC1IAl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjC1IA1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827414206
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990424; x=1711526424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gR+I5efLatV9DAX6L1vQxuclAhSiiq9+t8DhaiCXVSg=;
  b=UrwUEyeMH5ZxU68jEYEbvb1JyPi0qfG0vDYAntDENCZad5XFACxEZ5/m
   krdc29bTHjQ63zZTs7nLyKOLxpoLyLszUHgi2x8HhWTTFomeM2mMmdp/v
   a/0xvUv6u5OXPTNQ/8a7japOE1UNfPeONv7lR5LfL+0FsTuKEI8aNgeUY
   3C68OASv9p6rhVdbJ808/5aa5Cp6W5gpYQCJlFwX2k5RRqosdU3twSmAs
   NjmVo7iEi/SIPaw8Y0HrgnpfffIRMyOWAeaSE8lJM9iUuBoZE9ocAaFMO
   17epsJQqlNuS87qcvN262RhBwF4j2lvm/3z2z+afozLAHrMtVe3larjSn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958292"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958292"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045335"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045335"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:00:20 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 27/31] wifi: iwlwifi: mvm: adjust to MLO assign/unassign/switch_vif_chanctx()
Date:   Tue, 28 Mar 2023 10:59:07 +0300
Message-Id: <20230328104949.dc1074239c5b.I30db722af9009f1b274fa929f276fd2b78520dea@changeid>
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

Pass link_conf when it's necessary and change the code accordingly.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 46 +++++++++-------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 52 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 10 +---
 3 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b90b0a973cec..82e7a66c5828 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4608,10 +4608,11 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
  * Returns true if we're done assigning the chanctx
  * (either on failure or success)
  */
-bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_chanctx_conf *ctx,
-					 bool switching_chanctx, int *ret)
+static bool
+__iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_chanctx_conf *ctx,
+				    bool switching_chanctx, int *ret)
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
@@ -4651,12 +4652,16 @@ bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
 
 static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 					struct ieee80211_vif *vif,
+					struct ieee80211_bss_conf *link_conf,
 					struct ieee80211_chanctx_conf *ctx,
 					bool switching_chanctx)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 
+	if (WARN_ON(!link_conf))
+		return -EINVAL;
+
 	if (__iwl_mvm_assign_vif_chanctx_common(mvm, vif, ctx,
 						switching_chanctx, &ret))
 		goto out;
@@ -4736,7 +4741,7 @@ static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-	ret = __iwl_mvm_assign_vif_chanctx(mvm, vif, ctx, false);
+	ret = __iwl_mvm_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 	mutex_unlock(&mvm->mutex);
 
 	return ret;
@@ -4748,9 +4753,9 @@ static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
  * Returns if chanctx unassign chanctx is done
  * (either on failure or success)
  */
-bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
-					   struct ieee80211_vif *vif,
-					   bool switching_chanctx)
+static bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
+						  struct ieee80211_vif *vif,
+						  bool switching_chanctx)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
@@ -4788,6 +4793,7 @@ bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
 
 static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
 					   struct ieee80211_vif *vif,
+					   struct ieee80211_bss_conf *link_conf,
 					   struct ieee80211_chanctx_conf *ctx,
 					   bool switching_chanctx)
 {
@@ -4827,7 +4833,7 @@ static void iwl_mvm_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	mutex_lock(&mvm->mutex);
-	__iwl_mvm_unassign_vif_chanctx(mvm, vif, ctx, false);
+	__iwl_mvm_unassign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 	mutex_unlock(&mvm->mutex);
 }
 
@@ -4839,7 +4845,8 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx, true);
+	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
+				    vifs[0].old_ctx, true);
 	__iwl_mvm_remove_chanctx(mvm, vifs[0].old_ctx);
 
 	ret = __iwl_mvm_add_chanctx(mvm, vifs[0].new_ctx);
@@ -4848,8 +4855,8 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 		goto out_reassign;
 	}
 
-	ret = ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].new_ctx,
-					   true);
+	ret = ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
+					vifs[0].new_ctx, true);
 	if (ret) {
 		IWL_ERR(mvm,
 			"failed to assign new_ctx during channel switch\n");
@@ -4871,8 +4878,8 @@ iwl_mvm_switch_vif_chanctx_swap(struct iwl_mvm *mvm,
 		goto out_restart;
 	}
 
-	if (ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx,
-				      true)) {
+	if (ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
+				      vifs[0].old_ctx, true)) {
 		IWL_ERR(mvm, "failed to reassign old_ctx after failure.\n");
 		goto out_restart;
 	}
@@ -4897,10 +4904,11 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx, true);
+	ops->__unassign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
+				    vifs[0].old_ctx, true);
 
-	ret = ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].new_ctx,
-					   true);
+	ret = ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
+					vifs[0].new_ctx, true);
 	if (ret) {
 		IWL_ERR(mvm,
 			"failed to assign new_ctx during channel switch\n");
@@ -4910,8 +4918,8 @@ iwl_mvm_switch_vif_chanctx_reassign(struct iwl_mvm *mvm,
 	goto out;
 
 out_reassign:
-	if (ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].old_ctx,
-				      true)) {
+	if (ops->__assign_vif_chanctx(mvm, vifs[0].vif, vifs[0].link_conf,
+				      vifs[0].old_ctx, true)) {
 		IWL_ERR(mvm, "failed to reassign old_ctx after failure.\n");
 		goto out_restart;
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index b861b5478e08..0c233d151231 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -220,17 +220,23 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
-					    struct ieee80211_vif *vif,
-					    struct ieee80211_chanctx_conf *ctx,
-					    bool switching_chanctx)
+static int
+__iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *link_conf,
+				 struct ieee80211_chanctx_conf *ctx,
+				 bool switching_chanctx)
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int link_id = link_conf->link_id;
 	int ret;
 
-	mvmvif->deflink.phy_ctxt = phy_ctxt;
+	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
+		return -EINVAL;
+
+	mvmvif->link[link_id]->phy_ctxt = phy_ctxt;
 
 	if (switching_chanctx) {
 		/* reactivate if we turned this off during channel switch */
@@ -239,12 +245,12 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	}
 
 	/* send it first with phy context ID */
-	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf, 0, false);
+	ret = iwl_mvm_link_changed(mvm, vif, link_conf, 0, false);
 	if (ret)
 		goto out;
 
 	/* then activate */
-	ret = iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
 				   LINK_CONTEXT_MODIFY_ACTIVE |
 				   LINK_CONTEXT_MODIFY_RATES_INFO,
 				   true);
@@ -258,8 +264,7 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	iwl_mvm_power_update_mac(mvm);
 
 	if (vif->type == NL80211_IFTYPE_MONITOR) {
-		ret = iwl_mvm_mld_add_snif_sta(mvm, vif,
-					       &vif->bss_conf);
+		ret = iwl_mvm_mld_add_snif_sta(mvm, vif, link_conf);
 		if (ret)
 			goto deactivate;
 	}
@@ -267,10 +272,10 @@ static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	return 0;
 
 deactivate:
-	iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
-			     LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_link_changed(mvm, vif, link_conf, LINK_CONTEXT_MODIFY_ACTIVE,
+			     false);
 out:
-	mvmvif->deflink.phy_ctxt = NULL;
+	mvmvif->link[link_id]->phy_ctxt = NULL;
 	iwl_mvm_power_update_mac(mvm);
 	return ret;
 }
@@ -284,18 +289,25 @@ static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	int ret;
 
 	mutex_lock(&mvm->mutex);
-	ret = __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, ctx, false);
+	ret = __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 	mutex_unlock(&mvm->mutex);
 
 	return ret;
 }
 
-static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
-					       struct ieee80211_vif *vif,
-					       struct ieee80211_chanctx_conf *ctx,
-					       bool switching_chanctx)
+static void
+__iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf,
+				   struct ieee80211_chanctx_conf *ctx,
+				   bool switching_chanctx)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int link_id = link_conf->link_id;
+
+	/* shouldn't happen, but verify link_id is valid before accessing */
+	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
+		return;
 
 	if (vif->type == NL80211_IFTYPE_AP && switching_chanctx) {
 		mvmvif->csa_countdown = false;
@@ -312,12 +324,12 @@ static void __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
-	iwl_mvm_link_changed(mvm, vif, &vif->bss_conf,
+	iwl_mvm_link_changed(mvm, vif, link_conf,
 			     LINK_CONTEXT_MODIFY_ACTIVE, false);
 
 	if (switching_chanctx)
 		return;
-	mvmvif->deflink.phy_ctxt = NULL;
+	mvmvif->link[link_id]->phy_ctxt = NULL;
 	iwl_mvm_power_update_mac(mvm);
 }
 
@@ -329,7 +341,7 @@ static void iwl_mvm_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
 	mutex_lock(&mvm->mutex);
-	__iwl_mvm_mld_unassign_vif_chanctx(mvm, vif, ctx, false);
+	__iwl_mvm_mld_unassign_vif_chanctx(mvm, vif, link_conf, ctx, false);
 	mutex_unlock(&mvm->mutex);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ad67a9b71807..811647c8aa71 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2365,10 +2365,12 @@ int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
 struct iwl_mvm_switch_vif_chanctx_ops {
 	int (*__assign_vif_chanctx)(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif,
+				    struct ieee80211_bss_conf *link_conf,
 				    struct ieee80211_chanctx_conf *ctx,
 				    bool switching_chanctx);
 	void (*__unassign_vif_chanctx)(struct iwl_mvm *mvm,
 				       struct ieee80211_vif *vif,
+				       struct ieee80211_bss_conf *link_conf,
 				       struct ieee80211_chanctx_conf *ctx,
 				       bool switching_chanctx);
 };
@@ -2380,14 +2382,6 @@ iwl_mvm_switch_vif_chanctx_common(struct ieee80211_hw *hw,
 				  enum ieee80211_chanctx_switch_mode mode,
 				  struct iwl_mvm_switch_vif_chanctx_ops *ops);
 
-bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
-					 struct ieee80211_vif *vif,
-					 struct ieee80211_chanctx_conf *ctx,
-					 bool switching_chanctx, int *ret);
-bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
-					   struct ieee80211_vif *vif,
-					   bool switching_chanctx);
-
 /* Channel info utils */
 static inline bool iwl_mvm_has_ultra_hb_channel(struct iwl_mvm *mvm)
 {
-- 
2.38.1

