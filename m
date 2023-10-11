Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30667C4FBB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346179AbjJKKJy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346276AbjJKKJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:09:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DFC194
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018887; x=1728554887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0FOA4BF/HVvF8fdGPP5hNg91BJOWiAKn4EVmtuS0Cjc=;
  b=Ed84wr+NicIbMAY3AOPNihyc7l8ufCusfM7XvFu1iuBa3d7++gYqEUTb
   HJZwi+BXjQY1RVZ5R+fsiNV9WooYAIdK3wjSX6Dc49ixaBdZcTulXJSHx
   nZyuqxBkUwI+B97c62/ydkAfWvM3fh7piABN7XPr5Zy+2ditOpCkBGiHS
   GdIViga1K3Cz32H3R3VooN+jVdcK/YUWgIxvLEgyNTxBQkV2dhxrctFZJ
   MCjx0un3bQ++yVPrefLvaz01Dkara2vmW/63+oqm0lZA0ZD5qUefesGyi
   3rDgy327jUSj4iKZFHA0Adt0uhrgImgXsQsXxM760pXmqyfjExGvtwuAt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670619"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670619"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050310"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050310"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:06 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/16] wifi: iwlwifi: mvm: fix the PHY context resolution for p2p device
Date:   Wed, 11 Oct 2023 13:07:26 +0300
Message-Id: <20231011130030.4bc8b90d7be0.I1232dca3fe007362ec0ae0cf1d96217f2544e0d2@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We seem to have an issue in case we had a BSS and a P2P device on
channel 1 and then, the P2P device gets an ROC on channel 6. We would
change the channel of the PHY context to channel 6 even if the BSS was
using that same PHY context.

Revamp that code and don't try to change a PHY context, it doesn't mean
much for the firmware anyway. Just remove it and allocate a new one.
This makes the logic easier to follow.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 101 +++++++++---------
 1 file changed, 49 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index d161e2ea1ac5..7d96725da176 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4634,6 +4634,52 @@ static int iwl_mvm_roc_station(struct iwl_mvm *mvm,
 	return ret;
 }
 
+static int iwl_mvm_p2p_find_phy_ctxt(struct iwl_mvm *mvm,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_channel *channel)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct cfg80211_chan_def chandef;
+	int i;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (mvmvif->deflink.phy_ctxt &&
+	    channel == mvmvif->deflink.phy_ctxt->channel)
+		return 0;
+
+	/* Try using a PHY context that is already in use */
+	for (i = 0; i < NUM_PHY_CTX; i++) {
+		struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[i];
+
+		if (!phy_ctxt->ref || mvmvif->deflink.phy_ctxt == phy_ctxt)
+			continue;
+
+		if (channel == phy_ctxt->channel) {
+			if (mvmvif->deflink.phy_ctxt)
+				iwl_mvm_phy_ctxt_unref(mvm,
+						       mvmvif->deflink.phy_ctxt);
+
+			mvmvif->deflink.phy_ctxt = phy_ctxt;
+			iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
+			return 0;
+		}
+	}
+
+	/* We already have a phy_ctxt, but it's not on the right channel */
+	if (mvmvif->deflink.phy_ctxt)
+		iwl_mvm_phy_ctxt_unref(mvm, mvmvif->deflink.phy_ctxt);
+
+	mvmvif->deflink.phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
+	if (!mvmvif->deflink.phy_ctxt)
+		return -ENOSPC;
+
+	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
+
+	return iwl_mvm_phy_ctxt_add(mvm, mvmvif->deflink.phy_ctxt,
+				    &chandef, 1, 1);
+}
+
 /* Execute the common part for MLD and non-MLD modes */
 int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       struct ieee80211_channel *channel, int duration,
@@ -4641,11 +4687,8 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		       const struct iwl_mvm_roc_ops *ops)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct cfg80211_chan_def chandef;
-	struct iwl_mvm_phy_ctxt *phy_ctxt;
-	int ret, i;
 	u32 lmac_id;
+	int ret;
 
 	IWL_DEBUG_MAC80211(mvm, "enter (%d, %d, %d)\n", channel->hw_value,
 			   duration, type);
@@ -4676,57 +4719,11 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out_unlock;
 	}
 
-	/* Try using a PHY context that is already in use */
-	for (i = 0; i < NUM_PHY_CTX; i++) {
-		phy_ctxt = &mvm->phy_ctxts[i];
-		if (!phy_ctxt->ref || mvmvif->deflink.phy_ctxt == phy_ctxt)
-			continue;
-
-		if (channel == phy_ctxt->channel) {
-			if (mvmvif->deflink.phy_ctxt)
-				iwl_mvm_phy_ctxt_unref(mvm,
-						       mvmvif->deflink.phy_ctxt);
-
-			mvmvif->deflink.phy_ctxt = phy_ctxt;
-			iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
-			goto link_and_start_p2p_roc;
-		}
-	}
 
-	/* Configure the PHY context */
-	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
-
-	/* If the currently used PHY context is configured with a matching
-	 * channel use it
-	 */
-	if (mvmvif->deflink.phy_ctxt) {
-		if (channel == mvmvif->deflink.phy_ctxt->channel)
-			goto link_and_start_p2p_roc;
-	} else {
-		phy_ctxt = iwl_mvm_get_free_phy_ctxt(mvm);
-		if (!phy_ctxt) {
-			ret = -ENOSPC;
-			goto out_unlock;
-		}
-
-		mvmvif->deflink.phy_ctxt = phy_ctxt;
-		ret = iwl_mvm_phy_ctxt_add(mvm, phy_ctxt, &chandef, 1, 1);
-		if (ret) {
-			IWL_ERR(mvm, "Failed to change PHY context\n");
-			goto out_unlock;
-		}
-
-		goto link_and_start_p2p_roc;
-	}
-
-	ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &chandef,
-				       1, 1);
-	if (ret) {
-		IWL_ERR(mvm, "Failed to change PHY context\n");
+	ret = iwl_mvm_p2p_find_phy_ctxt(mvm, vif, channel);
+	if (ret)
 		goto out_unlock;
-	}
 
-link_and_start_p2p_roc:
 	ret = ops->link(mvm, vif);
 	if (ret)
 		goto out_unlock;
-- 
2.38.1

