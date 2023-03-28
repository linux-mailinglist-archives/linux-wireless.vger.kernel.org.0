Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD826CB8E9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjC1H7m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjC1H7k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 03:59:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBC640CA
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 00:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990378; x=1711526378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evFWNWZgc2QOZ5UdtNhc4eCfGYy3LtSMVBBfoWQdC7c=;
  b=TpjUOewaG2WhmLs4yBiLvR76s6ptQXNk4sWafdBC3pIIKkIky7X4RwkF
   bgbaOL/itYLNH6AQemQw/fVxEnElVH4oNfk6F/PZJCOaMFclUhGpdl0Lf
   a64tY6c7ylfRZmghHIcEVFEqk+tvl+0nxHI0eNDyaa1Uxh1KKn2OoEYND
   j3QavFVXl27N1bv536i0E+w1nR7uO30cZzY4jP0pFbsCLbXZXcjFuRXuX
   zW8uPexg3AHZ2b5unxFFScEytn9C1t4BfldEJ9GI0W8tS5V1PnPU1YQlf
   /JkgM0cJBIZNsaF7zZzGhL8FcSZsyy7owBexKZ45IXWOxrK3hsNqXcWyT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958080"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958080"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045124"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045124"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/31] wifi: iwlwifi: mvm: refactor iwl_mvm_roc()
Date:   Tue, 28 Mar 2023 10:58:46 +0300
Message-Id: <20230328104948.61bc077a7f3c.Ia3aa81d3293792bf8f80528dbc67a711ce334b32@changeid>
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

This flow is almost the same for both MLD and non-MLD modes,
except for some function calls. Therefore there is no reason to
add an MLD version of this flow. Instead - put the parts that are unique
for each mode in helper functions, and in the next patch each version of
this flow will call the common part with pointers to its specific
helper functions.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 100 ++++++++++--------
 1 file changed, 56 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index dae5e1b7d1cc..bb7e4e26d99f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4258,6 +4258,52 @@ static int iwl_mvm_send_aux_roc_cmd(struct iwl_mvm *mvm,
 	return res;
 }
 
+static int iwl_mvm_add_aux_sta_for_hs20(struct iwl_mvm *mvm, u32 lmac_id)
+{
+	int ret = 0;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_HOTSPOT_SUPPORT)) {
+		IWL_ERR(mvm, "hotspot not supported\n");
+		return -EINVAL;
+	}
+
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12) {
+		ret = iwl_mvm_add_aux_sta(mvm, lmac_id);
+		WARN(ret, "Failed to allocate aux station");
+	}
+
+	return ret;
+}
+
+static int iwl_mvm_roc_switch_binding(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct iwl_mvm_phy_ctxt *new_phy_ctxt)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret = 0;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	/* Unbind the P2P_DEVICE from the current PHY context,
+	 * and if the PHY context is not used remove it.
+	 */
+	ret = iwl_mvm_binding_remove_vif(mvm, vif);
+	if (WARN(ret, "Failed unbinding P2P_DEVICE\n"))
+		return ret;
+
+	iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
+
+	/* Bind the P2P_DEVICE to the current PHY Context */
+	mvmvif->deflink.phy_ctxt = new_phy_ctxt;
+
+	ret = iwl_mvm_binding_add_vif(mvm, vif);
+	WARN(ret, "Failed binding P2P_DEVICE\n");
+	return ret;
+}
+
 static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
 		       struct ieee80211_channel *channel,
@@ -4270,6 +4316,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
 	bool band_change_removal;
 	int ret, i;
+	u32 lmac_id;
 
 	IWL_DEBUG_MAC80211(mvm, "enter (%d, %d, %d)\n", channel->hw_value,
 			   duration, type);
@@ -4284,25 +4331,13 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
-		if (fw_has_capa(&mvm->fw->ucode_capa,
-				IWL_UCODE_TLV_CAPA_HOTSPOT_SUPPORT)) {
-			/* Use aux roc framework (HS20) */
-			if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12) {
-				u32 lmac_id;
-
-				lmac_id = iwl_mvm_get_lmac_id(mvm->fw,
-							      channel->band);
-				ret = iwl_mvm_add_aux_sta(mvm, lmac_id);
-				if (WARN(ret,
-					 "Failed to allocate aux station"))
-					goto out_unlock;
-			}
+		lmac_id = iwl_mvm_get_lmac_id(mvm->fw, channel->band);
+
+		/* Use aux roc framework (HS20) */
+		ret = iwl_mvm_add_aux_sta_for_hs20(mvm, lmac_id);
+		if (!ret)
 			ret = iwl_mvm_send_aux_roc_cmd(mvm, channel,
 						       vif, duration);
-			goto out_unlock;
-		}
-		IWL_ERR(mvm, "hotspot not supported\n");
-		ret = -EINVAL;
 		goto out_unlock;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		/* handle below */
@@ -4319,21 +4354,8 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 			continue;
 
 		if (phy_ctxt->ref && channel == phy_ctxt->channel) {
-			/*
-			 * Unbind the P2P_DEVICE from the current PHY context,
-			 * and if the PHY context is not used remove it.
-			 */
-			ret = iwl_mvm_binding_remove_vif(mvm, vif);
-			if (WARN(ret, "Failed unbinding P2P_DEVICE\n"))
-				goto out_unlock;
-
-			iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
-
-			/* Bind the P2P_DEVICE to the current PHY Context */
-			mvmvif->deflink.phy_ctxt = phy_ctxt;
-
-			ret = iwl_mvm_binding_add_vif(mvm, vif);
-			if (WARN(ret, "Failed binding P2P_DEVICE\n"))
+			ret = iwl_mvm_roc_switch_binding(mvm, vif, phy_ctxt);
+			if (ret)
 				goto out_unlock;
 
 			iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
@@ -4386,18 +4408,8 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 			goto out_unlock;
 		}
 
-		/* Unbind the P2P_DEVICE from the current PHY context */
-		ret = iwl_mvm_binding_remove_vif(mvm, vif);
-		if (WARN(ret, "Failed unbinding P2P_DEVICE\n"))
-			goto out_unlock;
-
-		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
-
-		/* Bind the P2P_DEVICE to the new allocated PHY context */
-		mvmvif->deflink.phy_ctxt = phy_ctxt;
-
-		ret = iwl_mvm_binding_add_vif(mvm, vif);
-		if (WARN(ret, "Failed binding P2P_DEVICE\n"))
+		ret = iwl_mvm_roc_switch_binding(mvm, vif, phy_ctxt);
+		if (ret)
 			goto out_unlock;
 
 		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
-- 
2.38.1

