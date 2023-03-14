Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CECD6B9D8D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCNRxE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCNRxD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:53:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86170B421A
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816341; x=1710352341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uofsplzJI0RkPVRMzzWPs5WfXLNo1ywxLtqVAiCXTc=;
  b=JiH9KfC976hHrmjrPAvoA27FNw1UBX1bO7cnWhC6UTLJPsmSLFcaSPEj
   pX1GzW/CdsKnvpv/4z/F9OvgaJ20EH7U9Da0G7EezG0YaLVHydLZC9MBJ
   xRBnYL1FrElj66oGKrz6NRFje3ztvCIBO6Gett21w6pfDhjovDkR8yDwc
   KVyPxdQaFqWlEMydvAJiySR8s5kBlSPfPit/fmuGZ4Mq+7usdpyGsvQn6
   ZEQvoOP8Fb+OWrBkCCW+Wap9YB0HxWK3D9mla6SwNLyUKiGJKpE3dKScg
   HH0jPttmByAWkkRC/6NZgVcVOuaFv4x1elRTHx0zZpApnfewCEJtJB2S0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149600"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149600"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200539"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200539"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:15 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/22] wifi: iwlwifi: mvm: refactor __iwl_mvm_assign_vif_chanctx()
Date:   Tue, 14 Mar 2023 19:49:23 +0200
Message-Id: <20230314194113.844755701cac.I1c650718ad2381eabc38f4103c1aac67936a1ffc@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Since parts of the functionality of this function is going to be used
also by the MLD version of it, put in a separate function the parts
that are common for both MLD and non-MLD modes.
The common function will later be used in the MLD ops.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 47 ++++++++++++++-----
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bdec5ae5e83a..8123dad3b710 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4405,15 +4405,21 @@ static void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
-					struct ieee80211_vif *vif,
-					struct ieee80211_chanctx_conf *ctx,
-					bool switching_chanctx)
+/*
+ * This function executes the common part for MLD and non-MLD modes.
+ *
+ * Returns true if we're done assigning the chanctx
+ * (either on failure or success)
+ */
+static bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
+						struct ieee80211_vif *vif,
+						struct ieee80211_chanctx_conf *ctx,
+						bool switching_chanctx,
+						int *ret)
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -4432,19 +4438,32 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 		 * The AP binding flow is handled as part of the start_ap flow
 		 * (in bss_info_changed), similarly for IBSS.
 		 */
-		ret = 0;
-		goto out;
+		*ret = 0;
+		return true;
 	case NL80211_IFTYPE_STATION:
-		mvmvif->csa_bcn_pending = false;
 		break;
 	case NL80211_IFTYPE_MONITOR:
 		/* always disable PS when a monitor interface is active */
 		mvmvif->ps_disabled = true;
 		break;
 	default:
-		ret = -EINVAL;
-		goto out;
+		*ret = -EINVAL;
+		return true;
 	}
+	return false;
+}
+
+static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct ieee80211_chanctx_conf *ctx,
+					bool switching_chanctx)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	if (__iwl_mvm_assign_vif_chanctx_common(mvm, vif, ctx,
+						switching_chanctx, &ret))
+		goto out;
 
 	ret = iwl_mvm_binding_add_vif(mvm, vif);
 	if (ret)
@@ -4478,7 +4497,12 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 		iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 	}
 
-	if (switching_chanctx && vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		if (!switching_chanctx) {
+			mvmvif->csa_bcn_pending = false;
+			goto out;
+		}
+
 		mvmvif->csa_bcn_pending = true;
 
 		if (!fw_has_capa(&mvm->fw->ucode_capa,
@@ -4506,6 +4530,7 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 		mvmvif->phy_ctxt = NULL;
 	return ret;
 }
+
 static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_bss_conf *link_conf,
-- 
2.38.1

