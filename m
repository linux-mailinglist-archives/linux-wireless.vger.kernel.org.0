Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6314D72E378
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbjFMM56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242232AbjFMM5w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:57:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333491996
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661071; x=1718197071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wuRA6/Hl0RGt6ckEO3CBWaQhWlrsMJ1QFks1+XSZBE4=;
  b=SjWjD4uEUYs4NMPG4KW3rowfMhO2HpVNiCkzulbiBVoH/kiqsKU4Yyyn
   wftkH3Y8bUNwM11y5HgJ7g9rcUMXhZFA57THvs4guv7lEPv85ZsYtNxrN
   CSrLsJdJ60TxIRsGd7QYoVY/XxTvpuLJfjptAtSnT6c/vKJsSf48UYg3+
   Vr8LC+meS8FL7LLVlfhAFuwrPkmbuxHb1WK/2mh4OJa7bAj+AyHcJcaIS
   aME1jfrNfly/joRkya2G/0BHig3Po31KtVa7lW2SF0Pt9qfN43Zz+jmnA
   DTQ4avsQnSbIbpJeP5rjrlOMNbT2DUHqiIYtQX4j0oqj/so7fP74VmH1c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973728"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973728"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880797"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880797"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Ariel Malamud <ariel.malamud@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/14] wifi: iwlwifi: mvm: Refactor iwl_mvm_get_lmac_id()
Date:   Tue, 13 Jun 2023 15:57:18 +0300
Message-Id: <20230613155501.507b2f9f64eb.I0ec91310e1911c33faf396b5e17bcb11a164f6ea@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ariel Malamud <ariel.malamud@intel.com>

The iwl_mvm_get_lmac_id() function is currently
defined as a static inline function under fw/api
and receives mvm's fw pointer. It will need the
ability to access other mvm struct members for
future capabilities such as debug. Move the function
out of the fw/api and into mvm proper as a regular
function and have it receive the pointer to mvm.

Signed-off-by: Ariel Malamud <ariel.malamud@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/binding.h |  8 --------
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c    | 10 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c         |  2 +-
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
index b6b5959cb259..d9044ada6a43 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/binding.h
@@ -59,14 +59,6 @@ struct iwl_binding_cmd {
 #define IWL_LMAC_24G_INDEX		0
 #define IWL_LMAC_5G_INDEX		1
 
-static inline u32 iwl_mvm_get_lmac_id(const struct iwl_fw *fw,
-				      enum nl80211_band band){
-	if (!fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_CDB_SUPPORT) ||
-	    band == NL80211_BAND_2GHZ)
-		return IWL_LMAC_24G_INDEX;
-	return IWL_LMAC_5G_INDEX;
-}
-
 /* The maximal number of fragments in the FW's schedule session */
 #define IWL_MVM_MAX_QUOTA 128
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
index ef50ccabcc73..458b97930059 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/binding.c
@@ -32,7 +32,7 @@ static int iwl_mvm_binding_cmd(struct iwl_mvm *mvm, u32 action,
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT)) {
 		size = sizeof(cmd);
-		cmd.lmac_id = cpu_to_le32(iwl_mvm_get_lmac_id(mvm->fw,
+		cmd.lmac_id = cpu_to_le32(iwl_mvm_get_lmac_id(mvm,
 							      phyctxt->channel->band));
 	} else {
 		size = IWL_BINDING_CMD_SIZE_V1;
@@ -164,3 +164,11 @@ int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	return ret;
 }
+
+u32 iwl_mvm_get_lmac_id(struct iwl_mvm *mvm, enum nl80211_band band)
+{
+	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_CDB_SUPPORT) ||
+	    band == NL80211_BAND_2GHZ)
+		return IWL_LMAC_24G_INDEX;
+	return IWL_LMAC_5G_INDEX;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index bf78b7df4700..f1c7d0bef609 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4595,7 +4595,7 @@ int iwl_mvm_roc_common(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_STATION:
-		lmac_id = iwl_mvm_get_lmac_id(mvm->fw, channel->band);
+		lmac_id = iwl_mvm_get_lmac_id(mvm, channel->band);
 
 		/* Use aux roc framework (HS20) */
 		ret = ops->add_aux_sta_for_hs20(mvm, lmac_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3f9cc4502db1..b1b46a50f764 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1844,6 +1844,7 @@ void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 /* Bindings */
 int iwl_mvm_binding_add_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_binding_remove_vif(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+u32 iwl_mvm_get_lmac_id(struct iwl_mvm *mvm, enum nl80211_band band);
 
 /* Links */
 int iwl_mvm_add_link(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 3ab6fb83a175..55541e90770a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -151,7 +151,7 @@ static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 				      struct cfg80211_chan_def *chandef,
 				      u8 chains_static, u8 chains_dynamic)
 {
-	cmd->lmac_id = cpu_to_le32(iwl_mvm_get_lmac_id(mvm->fw,
+	cmd->lmac_id = cpu_to_le32(iwl_mvm_get_lmac_id(mvm,
 						       chandef->chan->band));
 
 	/* Set the channel info data */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 547694c89ffa..bacc3045ea16 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -896,7 +896,7 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 			band = mvmsta->vif->bss_conf.chandef.chan->band;
 		}
 
-		lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
+		lmac = iwl_mvm_get_lmac_id(mvm, band);
 	} else if (fw_has_capa(&mvm->fw->ucode_capa,
 			       IWL_UCODE_TLV_CAPA_CDB_SUPPORT)) {
 		/* for real MLO restrict to both LMACs if they exist */
-- 
2.38.1

