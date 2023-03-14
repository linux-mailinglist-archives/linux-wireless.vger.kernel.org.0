Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B936B9D8E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCNRxG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCNRxF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:53:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D467FB4811
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816343; x=1710352343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l5hYVp3S/LnTHZbR11sBd+cGAidupWzwn2LxsCrESJQ=;
  b=kj+srsjQ+MvDVtnJlFW9NMKaLSTWBC635ixAfEbr+UrjsnfLe6Mt3Hjr
   HIY2HuMWgzv32G2qCxLGX5cbsymPxLFKlN9OQIXA+NhZMS6GgrNnQSa1r
   IMM13Ccn+GWnJKdbZOJbQptO3pqPTDmSVRZKGsqzeI+EN6SixdxxBf6lb
   eAMOiR9UexDU90udA99JQdgMnyRehkkjaK6zzOSqhNuYxIjPaF3ZAQU6p
   QlwUUN7p7WECMHKsFn/03xc09Afl3Q0PI9TSBuHPyvYh9l02GLQcR/7Yh
   ljea/0JeETht8nAKxFpmx+TMYB4PcCRsXLLNLRVSw/iY8B5EoDK5x6R5k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149608"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149608"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200544"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200544"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:17 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/22] wifi: iwlwifi: mvm: add an assign_vif_chanctx() callback for MLD mode
Date:   Tue, 14 Mar 2023 19:49:24 +0200
Message-Id: <20230314194113.d3753975e720.I45f89cc81370d2cf8d4f51748ccb3ec675eff1bd@changeid>
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

This is another patch in the series adding all the ops
for the new MLD ieee80211_ops.
The callback added here uses the new MLD FW API.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  9 ++-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 60 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 ++
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 8123dad3b710..d4a3d9259150 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4411,11 +4411,10 @@ static void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
  * Returns true if we're done assigning the chanctx
  * (either on failure or success)
  */
-static bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
-						struct ieee80211_vif *vif,
-						struct ieee80211_chanctx_conf *ctx,
-						bool switching_chanctx,
-						int *ret)
+bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_chanctx_conf *ctx,
+					 bool switching_chanctx, int *ret)
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8dca72ec55cb..81f88d1b0feb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -146,7 +146,67 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
+static int __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    struct ieee80211_chanctx_conf *ctx,
+					    bool switching_chanctx)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	if (__iwl_mvm_assign_vif_chanctx_common(mvm, vif, ctx,
+						switching_chanctx, &ret))
+		goto out;
+
+	ret = iwl_mvm_add_link(mvm, vif);
+	if (ret)
+		goto out;
+	ret = iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE,
+				   true);
+	if (ret)
+		goto out_remove_link;
+
+	/*
+	 * Power state must be updated before quotas,
+	 * otherwise fw will complain.
+	 */
+	iwl_mvm_power_update_mac(mvm);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR) {
+		ret = iwl_mvm_mld_add_snif_sta(mvm, vif);
+		if (ret)
+			goto out_remove_link;
+	}
+
+	goto out;
+
+out_remove_link:
+	/* Link needs to be deactivated before removal */
+	iwl_mvm_link_changed(mvm, vif, LINK_CONTEXT_MODIFY_ACTIVE, false);
+	iwl_mvm_remove_link(mvm, vif);
+	iwl_mvm_power_update_mac(mvm);
+out:
+	if (ret)
+		mvmvif->phy_ctxt = NULL;
+	return ret;
+}
+
+static int iwl_mvm_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_bss_conf *link_conf,
+					  struct ieee80211_chanctx_conf *ctx)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	int ret;
+
+	mutex_lock(&mvm->mutex);
+	ret = __iwl_mvm_mld_assign_vif_chanctx(mvm, vif, ctx, false);
+	mutex_unlock(&mvm->mutex);
+
+	return ret;
+}
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.add_interface = iwl_mvm_mld_mac_add_interface,
 	.remove_interface = iwl_mvm_mld_mac_remove_interface,
+	.assign_vif_chanctx = iwl_mvm_mld_assign_vif_chanctx,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 70c5e5d052d8..3da4b31da8d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2168,6 +2168,12 @@ static inline u8 iwl_mvm_phy_band_from_nl80211(enum nl80211_band band)
 /* Channel Switch */
 void iwl_mvm_channel_switch_disconnect_wk(struct work_struct *wk);
 
+/* Channel Context */
+bool __iwl_mvm_assign_vif_chanctx_common(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_chanctx_conf *ctx,
+					 bool switching_chanctx, int *ret);
+
 /* Channel info utils */
 static inline bool iwl_mvm_has_ultra_hb_channel(struct iwl_mvm *mvm)
 {
-- 
2.38.1

