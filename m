Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF19E72CABA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 17:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbjFLPw2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 11:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbjFLPwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 11:52:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B010E4
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686585141; x=1718121141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iujXkE5sAKNBMeSSGiuzQc7IZKZsfD3pnyXuEC/aRFI=;
  b=gB8hVVNTMIrY4zUqCKRqpM3OeoHS+2x9Iq+e0LtzTrH9N+NKtn3GAdu2
   5cpGJuNMeyEuJmrEBfDIZbQWL3Wew+EqvBzN2O+ssUSOFqQI54zB7xaKO
   ZkENHYULfvsZKLvnphf2mxcy5VwsKnhETjCs1l/exL0zD0ZYUpR7BU1uy
   hN0NkdsceXNqaUo8M1/ro+t/hbXH3ibPHzBiIJoCer1ApghJSvzmQRdr+
   YAbA9ou/HA761JwoM41GocS7W8IBJQvzobJrAL3jMWlttS+VpaMaRdTvs
   EDaMcYmKIE5jDMaXmh3zVn7k+RrnLyRRqqg4skMrsp5jUSJORoRVl2GkN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="421674307"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421674307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:52:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885499422"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885499422"
Received: from azvuluno-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.109])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 08:51:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: mvm: FTM responder MLO support
Date:   Mon, 12 Jun 2023 18:51:15 +0300
Message-Id: <20230612184434.b367f9bd19b8.I158c71998f39a6c15463ff5ae30129da8ad46d22@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230612155116.168000-1-gregory.greenman@intel.com>
References: <20230612155116.168000-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add a link configuration parameter to FTM responder start instead
of using the default link.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-responder.c         | 23 +++++++++++--------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +++--
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 1b6fb73ddfc7..b49781d1a07a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -104,7 +104,8 @@ iwl_mvm_ftm_responder_set_ndp(struct iwl_mvm *mvm,
 static int
 iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 			  struct ieee80211_vif *vif,
-			  struct cfg80211_chan_def *chandef)
+			  struct cfg80211_chan_def *chandef,
+			  struct ieee80211_bss_conf *link_conf)
 {
 	u32 cmd_id = WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_CONFIG_CMD);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
@@ -119,7 +120,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 			cpu_to_le32(IWL_TOF_RESPONDER_CMD_VALID_CHAN_INFO |
 				    IWL_TOF_RESPONDER_CMD_VALID_BSSID |
 				    IWL_TOF_RESPONDER_CMD_VALID_STA_ID),
-		.sta_id = mvmvif->deflink.bcast_sta.sta_id,
+		.sta_id = mvmvif->link[link_conf->link_id]->bcast_sta.sta_id,
 	};
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 6);
 	int err;
@@ -386,7 +387,8 @@ int iwl_mvm_ftm_resp_remove_pasn_sta(struct iwl_mvm *mvm,
 	return -EINVAL;
 }
 
-int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *bss_conf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct ieee80211_ftm_responder_params *params;
@@ -395,11 +397,11 @@ int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
 	int ret;
 
-	params = vif->bss_conf.ftmr_params;
+	params = bss_conf->ftmr_params;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN_ON_ONCE(!vif->bss_conf.ftm_responder))
+	if (WARN_ON_ONCE(!bss_conf->ftm_responder))
 		return -EINVAL;
 
 	if (vif->p2p || vif->type != NL80211_IFTYPE_AP ||
@@ -409,7 +411,7 @@ int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	}
 
 	rcu_read_lock();
-	pctx = rcu_dereference(vif->bss_conf.chanctx_conf);
+	pctx = rcu_dereference(bss_conf->chanctx_conf);
 	/* Copy the ctx to unlock the rcu and send the phy ctxt. We don't care
 	 * about changes in the ctx after releasing the lock because the driver
 	 * is still protected by the mutex. */
@@ -424,7 +426,7 @@ int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_ftm_responder_cmd(mvm, vif, &ctx.def);
+	ret = iwl_mvm_ftm_responder_cmd(mvm, vif, &ctx.def, bss_conf);
 	if (ret)
 		return ret;
 
@@ -446,13 +448,14 @@ void iwl_mvm_ftm_responder_clear(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_ftm_restart_responder(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif)
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *bss_conf)
 {
-	if (!vif->bss_conf.ftm_responder)
+	if (!bss_conf->ftm_responder)
 		return;
 
 	iwl_mvm_ftm_responder_clear(mvm, vif);
-	iwl_mvm_ftm_start_responder(mvm, vif);
+	iwl_mvm_ftm_start_responder(mvm, vif, bss_conf);
 }
 
 void iwl_mvm_ftm_responder_stats(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f7e2ca7eebf0..bf78b7df4700 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2890,7 +2890,7 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	if (iwl_mvm_phy_ctx_count(mvm) > 1)
 		iwl_mvm_teardown_tdls_peers(mvm);
 
-	iwl_mvm_ftm_restart_responder(mvm, vif);
+	iwl_mvm_ftm_restart_responder(mvm, vif, &vif->bss_conf);
 
 	goto out_unlock;
 
@@ -3032,7 +3032,7 @@ iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
 		IWL_WARN(mvm, "Failed updating beacon data\n");
 
 	if (changes & BSS_CHANGED_FTM_RESPONDER) {
-		int ret = iwl_mvm_ftm_start_responder(mvm, vif);
+		int ret = iwl_mvm_ftm_start_responder(mvm, vif, &vif->bss_conf);
 
 		if (ret)
 			IWL_WARN(mvm, "Failed to enable FTM responder (%d)\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 5e28a1645aa9..ff99bf91f931 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -422,7 +422,7 @@ static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
 	if (iwl_mvm_phy_ctx_count(mvm) > 1)
 		iwl_mvm_teardown_tdls_peers(mvm);
 
-	iwl_mvm_ftm_restart_responder(mvm, vif);
+	iwl_mvm_ftm_restart_responder(mvm, vif, link_conf);
 
 	goto out_unlock;
 
@@ -711,7 +711,7 @@ iwl_mvm_mld_link_info_changed_ap_ibss(struct iwl_mvm *mvm,
 
 	/* FIXME: need to decide if we need FTM responder per link */
 	if (changes & BSS_CHANGED_FTM_RESPONDER) {
-		int ret = iwl_mvm_ftm_start_responder(mvm, vif);
+		int ret = iwl_mvm_ftm_start_responder(mvm, vif, link_conf);
 
 		if (ret)
 			IWL_WARN(mvm, "Failed to enable FTM responder (%d)\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cb0a8b860e67..3f9cc4502db1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2242,9 +2242,11 @@ int iwl_mvm_sf_update(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		      bool added_vif);
 
 /* FTM responder */
-int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_ftm_start_responder(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *bss_conf);
 void iwl_mvm_ftm_restart_responder(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif);
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *bss_conf);
 void iwl_mvm_ftm_responder_stats(struct iwl_mvm *mvm,
 				 struct iwl_rx_cmd_buffer *rxb);
 int iwl_mvm_ftm_resp_remove_pasn_sta(struct iwl_mvm *mvm,
-- 
2.38.1

