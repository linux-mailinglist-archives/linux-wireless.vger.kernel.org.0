Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E06B9D7C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCNRvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjCNRvH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:51:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D73A0299
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816238; x=1710352238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wm9BSxuVRaMQax0/baAwwlw7sAggTxQv7QvFKNK44b4=;
  b=GKf24l92ArRD8VZSOSbORDp+EvepcnBsS1K8RBDYTd5919Ojo0FWc7la
   RzEgZ2cxSUpqE69hdAz633slkrvt68zRHW4CdcEN3crylKcQiBf2S7eIp
   s4ecLabd3ZEfoWwXPkJldTj5AkN/RhF8s2sidqzN+Bsgj/SFuu9x3yCgp
   BNWvYLZium/sb7JcqrqY3UAN6vRp7wxQkq9U8sTvM6wd3jMPueEY9UYbZ
   NRWcZOfxuu9/LW5jt6yPsaLiIAVbktp2tYTnpR87VjXP8xG4y0X2OH+Zl
   OOmNL3/fWDyfW3Lqa70mu+KoQd1EFFvRq7pqBdjDJsbruZw69bnND22RG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149534"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200471"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200471"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:49:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/22] wifi: iwlwifi: mvm: Refactor STA_HE_CTXT_CMD sending flow
Date:   Tue, 14 Mar 2023 19:49:16 +0200
Message-Id: <20230314194113.7ca960596953.Ifc3e816461abbd69c6fd87752342afcedfebc293@changeid>
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

Refactor STA_HE_CTXT_CMD sending flow:

1. As the new MLD API is introduced, there are some common fields in
both the old and new APIs. The STA_HE_CTXT_CMD of the non-MLD API
has common fields with the link and mac commands of the new MLD API.
Put this common parts in functions so it can be used later by the
new MLD API.

2. The HE capability which indicates whether the NIC is ack-enabled or
not is the same for all bands. No need to take it from the specific
band which is currently in use. Take it from the low band - this
simplifies the code and doesn't require a phy_ctxt.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 94 +++++++++++--------
 1 file changed, 57 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ab02c6076276..b1f638af4b2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1996,6 +1996,59 @@ static void iwl_mvm_get_optimal_ppe_info(struct iwl_he_pkt_ext_v2 *pkt_ext,
 	}
 }
 
+/*
+ * This function sets the MU EDCA parameters ans returns whether MU EDCA
+ * is enabled or not
+ */
+static bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
+					  struct iwl_mvm_vif *mvmvif,
+					  struct iwl_he_backoff_conf
+					  *trig_based_txf)
+{
+	int i;
+	/* Mark MU EDCA as enabled, unless none detected on some AC */
+	bool mu_edca_enabled = true;
+
+	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+		struct ieee80211_he_mu_edca_param_ac_rec *mu_edca =
+			&mvmvif->queue_params[i].mu_edca_param_rec;
+		u8 ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
+
+		if (!mvmvif->queue_params[i].mu_edca) {
+			mu_edca_enabled = false;
+			break;
+		}
+
+		trig_based_txf[ac].cwmin =
+			cpu_to_le16(mu_edca->ecw_min_max & 0xf);
+		trig_based_txf[ac].cwmax =
+			cpu_to_le16((mu_edca->ecw_min_max & 0xf0) >> 4);
+		trig_based_txf[ac].aifsn =
+			cpu_to_le16(mu_edca->aifsn & 0xf);
+		trig_based_txf[ac].mu_time =
+			cpu_to_le16(mu_edca->mu_edca_timer);
+	}
+
+	return mu_edca_enabled;
+}
+
+static bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif)
+{
+	const struct ieee80211_supported_band *sband;
+	const struct ieee80211_sta_he_cap *own_he_cap = NULL;
+
+	/* This capability is the same for all bands,
+	 * so take it from one of them.
+	 */
+	sband = mvm->hw->wiphy->bands[NL80211_BAND_2GHZ];
+	own_he_cap = ieee80211_get_he_iftype_cap(sband,
+						 ieee80211_vif_type_p2p(vif));
+
+	return (own_he_cap && (own_he_cap->he_cap_elem.mac_cap_info[2] &
+			       IEEE80211_HE_MAC_CAP2_ACK_EN));
+}
+
 static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			       struct ieee80211_vif *vif, u8 sta_id)
 {
@@ -2015,9 +2068,6 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	struct ieee80211_sta *sta;
 	u32 flags;
 	int i;
-	const struct ieee80211_sta_he_cap *own_he_cap = NULL;
-	struct ieee80211_chanctx_conf *chanctx_conf;
-	const struct ieee80211_supported_band *sband;
 	void *cmd;
 	u8 nominal_padding;
 
@@ -2045,16 +2095,6 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	rcu_read_lock();
 
-	chanctx_conf = rcu_dereference(vif->bss_conf.chanctx_conf);
-	if (WARN_ON(!chanctx_conf)) {
-		rcu_read_unlock();
-		return;
-	}
-
-	sband = mvm->hw->wiphy->bands[chanctx_conf->def.chan->band];
-	own_he_cap = ieee80211_get_he_iftype_cap(sband,
-						 ieee80211_vif_type_p2p(vif));
-
 	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_ctxt_cmd.sta_id]);
 	if (IS_ERR_OR_NULL(sta)) {
 		rcu_read_unlock();
@@ -2211,28 +2251,9 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	rcu_read_unlock();
 
-	/* Mark MU EDCA as enabled, unless none detected on some AC */
-	flags |= STA_CTXT_HE_MU_EDCA_CW;
-	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-		struct ieee80211_he_mu_edca_param_ac_rec *mu_edca =
-			&mvmvif->queue_params[i].mu_edca_param_rec;
-		u8 ac = iwl_mvm_mac80211_ac_to_ucode_ac(i);
-
-		if (!mvmvif->queue_params[i].mu_edca) {
-			flags &= ~STA_CTXT_HE_MU_EDCA_CW;
-			break;
-		}
-
-		sta_ctxt_cmd.trig_based_txf[ac].cwmin =
-			cpu_to_le16(mu_edca->ecw_min_max & 0xf);
-		sta_ctxt_cmd.trig_based_txf[ac].cwmax =
-			cpu_to_le16((mu_edca->ecw_min_max & 0xf0) >> 4);
-		sta_ctxt_cmd.trig_based_txf[ac].aifsn =
-			cpu_to_le16(mu_edca->aifsn);
-		sta_ctxt_cmd.trig_based_txf[ac].mu_time =
-			cpu_to_le16(mu_edca->mu_edca_timer);
-	}
-
+	if (iwl_mvm_set_fw_mu_edca_params(mvm, mvmvif,
+					  &sta_ctxt_cmd.trig_based_txf[0]))
+		flags |= STA_CTXT_HE_MU_EDCA_CW;
 
 	if (vif->bss_conf.uora_exists) {
 		flags |= STA_CTXT_HE_TRIG_RND_ALLOC;
@@ -2243,8 +2264,7 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 			(vif->bss_conf.uora_ocw_range >> 3) & 0x7;
 	}
 
-	if (own_he_cap && !(own_he_cap->he_cap_elem.mac_cap_info[2] &
-			    IEEE80211_HE_MAC_CAP2_ACK_EN))
+	if (!iwl_mvm_is_nic_ack_enabled(mvm, vif))
 		flags |= STA_CTXT_HE_NIC_NOT_ACK_ENABLED;
 
 	if (vif->bss_conf.nontransmitted) {
-- 
2.38.1

