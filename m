Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287166B9D8F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCNRxh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjCNRxf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:53:35 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6E65F51D
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816375; x=1710352375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jyq43xP3tdqy9uh6vmEYXrsGj0TYAKrvgEtjX5q4rmQ=;
  b=SKyykKuj/QOgaSSPTIxqfITe0ITbfIsUU+rvaYIio1KH7M0OiHp43flL
   nS2Qape8aTUQyaU3pZGTfiTPhHuPyHmw5wkMbWRU0F/0RWi+0rj5MvkUq
   N7YS7pGIQQE0ugZrN+aAX4lmodRtWijOgnQpnIXnbOw92hUROEuASQc4a
   cZydmGACpM9QBbB+0Fh1b04Jq311vorRhOvZGIEo37T9qAmEK3wkeSesZ
   bNFnH3/Ot8Mxob2eZe/qUnysbJMRa+3hmZ2Bfue5RAM/9ftyBEo4FT5F5
   x9r7ZZzALxr18VtZtcRKxD4SVoJAgUtvaxp+HzhqArxFQJNmcv+Q/0VNT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149638"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149638"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200552"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200552"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/22] wifi: iwlwifi: mvm: refactor __iwl_mvm_unassign_vif_chanctx()
Date:   Tue, 14 Mar 2023 19:49:25 +0200
Message-Id: <20230314194113.fa05929badb9.I2222dc86cf7d7a7bb58c6a2f2529c8089bfe58b4@changeid>
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
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 53 ++++++++++++-------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d4a3d9259150..c006d68a785e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4545,52 +4545,69 @@ static int iwl_mvm_assign_vif_chanctx(struct ieee80211_hw *hw,
 	return ret;
 }
 
-static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
-					   struct ieee80211_vif *vif,
-					   struct ieee80211_chanctx_conf *ctx,
-					   bool switching_chanctx)
+/*
+ * This function executes the common part for MLD and non-MLD modes.
+ *
+ * Returns if chanctx unassign chanctx is done
+ * (either on failure or success)
+ */
+static bool __iwl_mvm_unassign_vif_chanctx_common(struct iwl_mvm *mvm,
+						  struct ieee80211_vif *vif,
+						  bool switching_chanctx)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct ieee80211_vif *disabled_vif = NULL;
 
 	lockdep_assert_held(&mvm->mutex);
 	iwl_mvm_remove_time_event(mvm, mvmvif, &mvmvif->time_event_data);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_ADHOC:
-		goto out;
+		return true;
 	case NL80211_IFTYPE_MONITOR:
 		mvmvif->monitor_active = false;
 		mvmvif->ps_disabled = false;
-		iwl_mvm_rm_snif_sta(mvm, vif);
 		break;
 	case NL80211_IFTYPE_AP:
 		/* This part is triggered only during CSA */
 		if (!switching_chanctx || !mvmvif->ap_ibss_active)
-			goto out;
+			return true;
 
 		mvmvif->csa_countdown = false;
 
-		/* Set CS bit on all the stations */
-		iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, true);
-
 		/* Save blocked iface, the timeout is set on the next beacon */
 		rcu_assign_pointer(mvm->csa_tx_blocked_vif, vif);
 
 		mvmvif->ap_ibss_active = false;
 		break;
-	case NL80211_IFTYPE_STATION:
-		if (!switching_chanctx)
-			break;
+	default:
+		break;
+	}
+	return false;
+}
 
-		disabled_vif = vif;
+static void __iwl_mvm_unassign_vif_chanctx(struct iwl_mvm *mvm,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_chanctx_conf *ctx,
+					   bool switching_chanctx)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_vif *disabled_vif = NULL;
+
+	if (__iwl_mvm_unassign_vif_chanctx_common(mvm, vif, switching_chanctx))
+		goto out;
 
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		iwl_mvm_rm_snif_sta(mvm, vif);
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		/* Set CS bit on all the stations */
+		iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, true);
+
+	if (vif->type == NL80211_IFTYPE_STATION && switching_chanctx) {
+		disabled_vif = vif;
 		if (!fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD))
 			iwl_mvm_mac_ctxt_changed(mvm, vif, true, NULL);
-		break;
-	default:
-		break;
 	}
 
 	iwl_mvm_update_quotas(mvm, false, disabled_vif);
-- 
2.38.1

