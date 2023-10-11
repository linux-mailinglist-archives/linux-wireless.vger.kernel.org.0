Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367C17C4FB9
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjJKKJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346085AbjJKKJB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:09:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504A9136
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018884; x=1728554884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NR9HCwokfn72XBrKnOTAHGKu3hFapf89OjMzOxp0Fhg=;
  b=CJzEXGltOm69d0LazURkAPxN7iGz2zc0viKSep+qlZo1p66f9DIgDSrR
   oVLlM+fcrwaS3Ehof/IUREW+3aN+XO/gPsH5cD4yGoZe/aEqZMLl9wEtO
   ibqHhp5Gq1/LM96EAxaR237PH9TUNH5pQbiskx+Bt6Rzsg9TWOSFYa/U6
   +IvGUc+dbxXzV7MoauofbxAcqDI0ENJODJrIXwCj0w5vvSXAbPoo+uQr4
   YcjdlUPH71s57znV9Bw2XVB+Lv7tJTk22lXwzlmueU42B+tPMK37F3xOP
   QdrwxoEQ82wvCXx1fxoPObDi/si3gEzhXOGsz6D5SX5kdqG60SrbnIKup
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670606"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670606"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050300"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050300"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/16] wifi: iwlwifi: mvm: don't add dummy phy context
Date:   Wed, 11 Oct 2023 13:07:24 +0300
Message-Id: <20231011130030.55a1a78719be.I2032a7d227b57f4fc4370a2793476d47538404fd@changeid>
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

From its very first stages of development, iwlmvm added all the PHY
context immediately upon firmware boot. Then, all we needed to do is to
modify the contexts. This was fine if the addition of a PHY context that
we don't need is free. This was true until now. Newer devices will run
calibrations upon the addition of a PHY context.

Change the way we work with PHY context in iwlmvm. Fortunately, we
already have all the ref counting in place so that it is not very hard
to do.

Also, since we now remove the PHY context before the link is removed
(but after it has been de-activated of course), it'll confuse the
firmware if we put the late phy_id into the LINK command that removes
the link. Change this to put an invalid phy_id just like we do when we
add a link that has no PHY context yet.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 17 -------
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 19 ++++---
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 49 +++++--------------
 4 files changed, 27 insertions(+), 59 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 233c839de502..d791132b3a33 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1535,8 +1535,6 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 int iwl_mvm_up(struct iwl_mvm *mvm)
 {
 	int ret, i;
-	struct ieee80211_channel *chan;
-	struct cfg80211_chan_def chandef;
 	struct ieee80211_supported_band *sband = NULL;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -1661,21 +1659,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		goto error;
 	}
 
-	chan = &sband->channels[0];
-
-	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
-	for (i = 0; i < NUM_PHY_CTX; i++) {
-		/*
-		 * The channel used here isn't relevant as it's
-		 * going to be overwritten in the other flows.
-		 * For now use the first channel we have.
-		 */
-		ret = iwl_mvm_phy_ctxt_add(mvm, &mvm->phy_ctxts[i],
-					   &chandef, 1, 1);
-		if (ret)
-			goto error;
-	}
-
 	if (iwl_mvm_is_tt_in_fw(mvm)) {
 		/* in order to give the responsibility of ct-kill and
 		 * TX backoff to FW we need to send empty temperature reporting
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 6e1ad65527d1..d0d5ebc03d53 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -252,6 +252,7 @@ int iwl_mvm_remove_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
 	link_info->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 	cmd.spec_link_id = link_conf->link_id;
+	cmd.phy_id = cpu_to_le32(FW_CTXT_INVALID);
 
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_REMOVE);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ce65d74413fb..0d78a9efbe2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4693,6 +4693,9 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		}
 	}
 
+	/* Configure the PHY context */
+	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
+
 	/* If the currently used PHY context is configured with a matching
 	 * channel use it
 	 */
@@ -4707,12 +4710,16 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		}
 
 		mvmvif->deflink.phy_ctxt = phy_ctxt;
+		ret = iwl_mvm_phy_ctxt_add(mvm, phy_ctxt, &chandef, 1, 1);
+		if (ret) {
+			IWL_ERR(mvm, "Failed to change PHY context\n");
+			goto out_unlock;
+		}
+
 		iwl_mvm_phy_ctxt_ref(mvm, mvmvif->deflink.phy_ctxt);
+		goto link_and_start_p2p_roc;
 	}
 
-	/* Configure the PHY context */
-	cfg80211_chandef_create(&chandef, channel, NL80211_CHAN_NO_HT);
-
 	ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, &chandef,
 				       1, 1);
 	if (ret) {
@@ -4797,9 +4804,9 @@ static int __iwl_mvm_add_chanctx(struct iwl_mvm *mvm,
 		goto out;
 	}
 
-	ret = iwl_mvm_phy_ctxt_changed(mvm, phy_ctxt, def,
-				       ctx->rx_chains_static,
-				       ctx->rx_chains_dynamic);
+	ret = iwl_mvm_phy_ctxt_add(mvm, phy_ctxt, def,
+				   ctx->rx_chains_static,
+				   ctx->rx_chains_dynamic);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to add PHY context\n");
 		goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index a5b432bc9e2f..c3c1b57a05ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -301,7 +301,11 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP, RLC_CONFIG_CMD), 0) >= 2 &&
+	if (WARN_ON_ONCE(!ctxt->ref))
+		return -EINVAL;
+
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP,
+						   RLC_CONFIG_CMD), 0) >= 2 &&
 	    ctxt->channel == chandef->chan &&
 	    ctxt->width == chandef->width &&
 	    ctxt->center_freq1 == chandef->center_freq1)
@@ -335,6 +339,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 
 void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
 {
+	struct cfg80211_chan_def chandef;
 	lockdep_assert_held(&mvm->mutex);
 
 	if (WARN_ON_ONCE(!ctxt))
@@ -342,41 +347,13 @@ void iwl_mvm_phy_ctxt_unref(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt)
 
 	ctxt->ref--;
 
-	/*
-	 * Move unused phy's to a default channel. When the phy is moved the,
-	 * fw will cleanup immediate quiet bit if it was previously set,
-	 * otherwise we might not be able to reuse this phy.
-	 */
-	if (ctxt->ref == 0) {
-		struct ieee80211_channel *chan = NULL;
-		struct cfg80211_chan_def chandef;
-		struct ieee80211_supported_band *sband;
-		enum nl80211_band band;
-		int channel;
-
-		for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
-			sband = mvm->hw->wiphy->bands[band];
-
-			if (!sband)
-				continue;
-
-			for (channel = 0; channel < sband->n_channels; channel++)
-				if (!(sband->channels[channel].flags &
-						IEEE80211_CHAN_DISABLED)) {
-					chan = &sband->channels[channel];
-					break;
-				}
-
-			if (chan)
-				break;
-		}
-
-		if (WARN_ON(!chan))
-			return;
-
-		cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
-		iwl_mvm_phy_ctxt_changed(mvm, ctxt, &chandef, 1, 1);
-	}
+	if (ctxt->ref)
+		return;
+
+	cfg80211_chandef_create(&chandef, ctxt->channel, NL80211_CHAN_NO_HT);
+
+	iwl_mvm_phy_ctxt_apply(mvm, ctxt, &chandef, 1, 1,
+			       FW_CTXT_ACTION_REMOVE);
 }
 
 static void iwl_mvm_binding_iterator(void *_data, u8 *mac,
-- 
2.38.1

