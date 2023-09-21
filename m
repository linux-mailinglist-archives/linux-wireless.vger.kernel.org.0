Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614477A9DC3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjIUTrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjIUTrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:47:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EB2400D1
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318623; x=1726854623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TXzX7WboN6zPe9QnJirdT0v311YDBJOVDUuXHyCYxDY=;
  b=bHhmM6DnyEFo4IQHAGxd+B92NsfMnzOJ0ZuY83X6k1Bf0QfBVKoNVo6s
   f4sIlFzzKrjp5ZKE2Z0GpyB2LVZan/fxp5URoFmWePWZMFiAKpWElKme9
   bhGt71I7n7ULg7nTDrQfYe52kghucw/uFVybBxpPNif7ANs+4l4Ye8VZ6
   EqfEm0NfivGgDgY0aSimJ4+m2LbHn7xXfA6yH2kYOMNFa2poJK5JPdOxz
   9eDjvrtI04GvhYDclHBvew4/OTAcXTnw9odBgZHbEXqh2y5ZALPzM0wXz
   wAL5PKRw2tyekc8vHmbmSj/BAhvyIn6FnEsg5H7MlkTNiKxteyb3MvINJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305303"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305303"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545483"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545483"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:41 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Ben Greear <greearb@candelatech.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/12] wifi: iwlwifi: mvm: support set_antenna()
Date:   Thu, 21 Sep 2023 11:57:59 +0300
Message-Id: <20230921110726.81d94d630c95.I9473da818cbeeb51b2f89dcc59b00019113e7f55@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

set_antenna() is supported only when the device is not started in
mac80211 which translates to the firmware not being loaded in iwlwifi.

The tricky part is that iwlwifi populates the sband data during its boot
and doesn't touch this data afterwards, but if the antenna settings
forbid MIMO, we need to update the sband data.

Rework the nvm parsing code to allow to get an existing nvm_data and
modify the sband with additional constraints (tx / rx chains masks).

Suggested-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c |  5 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 76 ++++++++++++++++---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    | 19 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 25 ++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 29 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  | 12 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  5 +-
 9 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index d7a7835b935c..5aab64c63a13 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021, 2023 Intel Corporation
  * Copyright (C) 2015 Intel Mobile Communications GmbH
  */
 #include <linux/types.h>
@@ -721,6 +721,9 @@ void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 	ht_info->ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
 
 	ht_info->mcs.rx_mask[0] = 0xFF;
+	ht_info->mcs.rx_mask[1] = 0x00;
+	ht_info->mcs.rx_mask[2] = 0x00;
+
 	if (rx_chains >= 2)
 		ht_info->mcs.rx_mask[1] = 0xFF;
 	if (rx_chains >= 3)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index cff1f97536e3..512af3605a2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -962,6 +962,9 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			}
 		}
 	} else {
+		struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp =
+			&iftype_data->he_cap.he_mcs_nss_supp;
+
 		if (iftype_data->eht_cap.has_eht) {
 			struct ieee80211_eht_mcs_nss_supp *mcs_nss =
 				&iftype_data->eht_cap.eht_mcs_nss_supp;
@@ -980,6 +983,19 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 			iftype_data->he_cap.he_cap_elem.phy_cap_info[7] |=
 				IEEE80211_HE_PHY_CAP7_MAX_NC_1;
 		}
+
+		he_mcs_nss_supp->rx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		he_mcs_nss_supp->tx_mcs_80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		he_mcs_nss_supp->rx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		he_mcs_nss_supp->tx_mcs_160 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		he_mcs_nss_supp->rx_mcs_80p80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
+		he_mcs_nss_supp->tx_mcs_80p80 |=
+			cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << 2);
 	}
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210 && !is_ap)
@@ -1052,10 +1068,6 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 	struct ieee80211_sband_iftype_data *iftype_data;
 	int i;
 
-	/* should only initialize once */
-	if (WARN_ON(sband->iftype_data))
-		return;
-
 	BUILD_BUG_ON(sizeof(data->iftd.low) != sizeof(iwl_he_eht_capa));
 	BUILD_BUG_ON(sizeof(data->iftd.high) != sizeof(iwl_he_eht_capa));
 	BUILD_BUG_ON(sizeof(data->iftd.uhb) != sizeof(iwl_he_eht_capa));
@@ -1087,6 +1099,37 @@ static void iwl_init_he_hw_capab(struct iwl_trans *trans,
 	iwl_init_he_6ghz_capa(trans, data, sband, tx_chains, rx_chains);
 }
 
+void iwl_reinit_cab(struct iwl_trans *trans, struct iwl_nvm_data *data,
+		    u8 tx_chains, u8 rx_chains, const struct iwl_fw *fw)
+{
+	struct ieee80211_supported_band *sband;
+
+	sband = &data->bands[NL80211_BAND_2GHZ];
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_2GHZ,
+			     tx_chains, rx_chains);
+
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
+				     fw);
+
+	sband = &data->bands[NL80211_BAND_5GHZ];
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_5GHZ,
+			     tx_chains, rx_chains);
+	if (data->sku_cap_11ac_enable && !iwlwifi_mod_params.disable_11ac)
+		iwl_init_vht_hw_capab(trans, data, &sband->vht_cap,
+				      tx_chains, rx_chains);
+
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
+				     fw);
+
+	sband = &data->bands[NL80211_BAND_6GHZ];
+	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
+		iwl_init_he_hw_capab(trans, data, sband, tx_chains, rx_chains,
+				     fw);
+}
+IWL_EXPORT_SYMBOL(iwl_reinit_cab);
+
 static void iwl_init_sbands(struct iwl_trans *trans,
 			    struct iwl_nvm_data *data,
 			    const void *nvm_ch_flags, u8 tx_chains,
@@ -1365,7 +1408,7 @@ iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 struct iwl_nvm_data *
 iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		       const struct iwl_mei_nvm *mei_nvm,
-		       const struct iwl_fw *fw)
+		       const struct iwl_fw *fw, u8 tx_ant, u8 rx_ant)
 {
 	struct iwl_nvm_data *data;
 	u32 sbands_flags = 0;
@@ -1392,6 +1435,10 @@ iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		tx_chains &= data->valid_tx_ant;
 	if (data->valid_rx_ant)
 		rx_chains &= data->valid_rx_ant;
+	if (tx_ant)
+		tx_chains &= tx_ant;
+	if (rx_ant)
+		rx_chains &= rx_ant;
 
 	data->sku_cap_mimo_disabled = false;
 	data->sku_cap_band_24ghz_enable = true;
@@ -1957,7 +2004,8 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 IWL_EXPORT_SYMBOL(iwl_read_external_nvm);
 
 struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
-				 const struct iwl_fw *fw)
+				 const struct iwl_fw *fw,
+				 u8 set_tx_ant, u8 set_rx_ant)
 {
 	struct iwl_nvm_get_info cmd = {};
 	struct iwl_nvm_data *nvm;
@@ -1971,6 +2019,9 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	bool empty_otp;
 	u32 mac_flags;
 	u32 sbands_flags = 0;
+	u8 tx_ant;
+	u8 rx_ant;
+
 	/*
 	 * All the values in iwl_nvm_get_info_rsp v4 are the same as
 	 * in v3, except for the channel profile part of the
@@ -2058,10 +2109,15 @@ struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 	channel_profile = v4 ? (void *)rsp->regulatory.channel_profile :
 			  (void *)rsp_v3->regulatory.channel_profile;
 
-	iwl_init_sbands(trans, nvm,
-			channel_profile,
-			nvm->valid_tx_ant & fw->valid_tx_ant,
-			nvm->valid_rx_ant & fw->valid_rx_ant,
+	tx_ant = nvm->valid_tx_ant & fw->valid_tx_ant;
+	rx_ant = nvm->valid_rx_ant & fw->valid_rx_ant;
+
+	if (set_tx_ant)
+		tx_ant &= set_tx_ant;
+	if (set_rx_ant)
+		rx_ant &= set_rx_ant;
+
+	iwl_init_sbands(trans, nvm, channel_profile, tx_ant, rx_ant,
 			sbands_flags, v4, fw);
 
 	iwl_free_resp(&hcmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index c79f72d54482..651ed25b683b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2015, 2018-2022 Intel Corporation
+ * Copyright (C) 2005-2015, 2018-2023 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_nvm_parse_h__
@@ -21,7 +21,7 @@ enum iwl_nvm_sbands_flags {
 	IWL_NVM_SBANDS_FLAGS_NO_WIDE_IN_5GHZ	= BIT(1),
 };
 
-/**
+/*
  * iwl_parse_nvm_data - parse NVM data and return values
  *
  * This function parses all NVM values we need and then
@@ -73,21 +73,28 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 void iwl_nvm_fixups(u32 hw_id, unsigned int section, u8 *data,
 		    unsigned int len);
 
-/**
+/*
  * iwl_get_nvm - retrieve NVM data from firmware
  *
  * Allocates a new iwl_nvm_data structure, fills it with
  * NVM data, and returns it to caller.
  */
 struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
-				 const struct iwl_fw *fw);
+				 const struct iwl_fw *fw,
+				 u8 set_tx_ant, u8 set_rx_ant);
 
-/**
+/*
  * iwl_parse_mei_nvm_data - parse the mei_nvm_data and get an iwl_nvm_data
  */
 struct iwl_nvm_data *
 iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		       const struct iwl_mei_nvm *mei_nvm,
-		       const struct iwl_fw *fw);
+		       const struct iwl_fw *fw, u8 set_tx_ant, u8 set_rx_ant);
+
+/*
+ * iwl_reinit_cab - to be called when the tx_chains or rx_chains are modified
+ */
+void iwl_reinit_cab(struct iwl_trans *trans, struct iwl_nvm_data *data,
+		    u8 tx_chains, u8 rx_chains, const struct iwl_fw *fw);
 
 #endif /* __iwl_nvm_parse_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 567b02754a43..6e5c0f81e041 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -681,7 +681,8 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm)
 
 	/* Read the NVM only at driver load time, no need to do this twice */
 	if (!IWL_MVM_PARSE_NVM && !mvm->nvm_data) {
-		mvm->nvm_data = iwl_get_nvm(mvm->trans, mvm->fw);
+		mvm->nvm_data = iwl_get_nvm(mvm->trans, mvm->fw,
+					    mvm->set_tx_ant, mvm->set_rx_ant);
 		if (IS_ERR(mvm->nvm_data)) {
 			ret = PTR_ERR(mvm->nvm_data);
 			mvm->nvm_data = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index ba3109d0eb2b..6fc5b3f22746 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -279,6 +279,30 @@ int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
 	return 0;
 }
 
+int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	/* This has been tested on those devices only */
+	if (mvm->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_9000 &&
+	    mvm->trans->trans_cfg->device_family != IWL_DEVICE_FAMILY_22000)
+		return -ENOTSUPP;
+
+	if (!mvm->nvm_data)
+		return -EBUSY;
+
+	/* mac80211 ensures the device is not started,
+	 * so the firmware cannot be running
+	 */
+
+	mvm->set_tx_ant = tx_ant;
+	mvm->set_rx_ant = rx_ant;
+
+	iwl_reinit_cab(mvm->trans, mvm->nvm_data, tx_ant, rx_ant, mvm->fw);
+
+	return 0;
+}
+
 int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 {
 	struct ieee80211_hw *hw = mvm->hw;
@@ -6202,6 +6226,7 @@ const struct ieee80211_ops iwl_mvm_hw_ops = {
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
 	.get_antenna = iwl_mvm_op_get_antenna,
+	.set_antenna = iwl_mvm_op_set_antenna,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 9615bfff7f7d..5449deb3c2d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1121,6 +1121,7 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
 	.ampdu_action = iwl_mvm_mac_ampdu_action,
 	.get_antenna = iwl_mvm_op_get_antenna,
+	.set_antenna = iwl_mvm_op_set_antenna,
 	.start = iwl_mvm_mac_start,
 	.reconfig_complete = iwl_mvm_mac_reconfig_complete,
 	.stop = iwl_mvm_mac_stop,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f0f9a1665443..8c1f6aa2bc70 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -980,6 +980,9 @@ struct iwl_mvm {
 	u8 scan_last_antenna_idx; /* to toggle TX between antennas */
 	u8 mgmt_last_antenna_idx;
 
+	u8 set_tx_ant;
+	u8 set_rx_ant;
+
 	/* last smart fifo state that was successfully sent to firmware */
 	enum iwl_sf_state sf_state;
 
@@ -1715,16 +1718,29 @@ int iwl_mvm_load_nvm_to_nic(struct iwl_mvm *mvm);
 
 static inline u8 iwl_mvm_get_valid_tx_ant(struct iwl_mvm *mvm)
 {
-	return mvm->nvm_data && mvm->nvm_data->valid_tx_ant ?
-	       mvm->fw->valid_tx_ant & mvm->nvm_data->valid_tx_ant :
-	       mvm->fw->valid_tx_ant;
+	u8 tx_ant = mvm->fw->valid_tx_ant;
+
+	if (mvm->nvm_data && mvm->nvm_data->valid_tx_ant)
+		tx_ant &= mvm->nvm_data->valid_tx_ant;
+
+	if (mvm->set_tx_ant)
+		tx_ant &= mvm->set_tx_ant;
+
+	return tx_ant;
 }
 
 static inline u8 iwl_mvm_get_valid_rx_ant(struct iwl_mvm *mvm)
 {
-	return mvm->nvm_data && mvm->nvm_data->valid_rx_ant ?
-	       mvm->fw->valid_rx_ant & mvm->nvm_data->valid_rx_ant :
-	       mvm->fw->valid_rx_ant;
+	u8 rx_ant = mvm->fw->valid_tx_ant;
+
+	if (mvm->nvm_data && mvm->nvm_data->valid_rx_ant)
+		rx_ant &= mvm->nvm_data->valid_tx_ant;
+
+	if (mvm->set_rx_ant)
+		rx_ant &= mvm->set_tx_ant;
+
+	return rx_ant;
+
 }
 
 static inline void iwl_mvm_toggle_tx_ant(struct iwl_mvm *mvm, u8 *ant)
@@ -2625,6 +2641,7 @@ int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
 			     struct ieee80211_ampdu_params *params);
 int iwl_mvm_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant);
+int iwl_mvm_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant);
 int iwl_mvm_mac_start(struct ieee80211_hw *hw);
 void iwl_mvm_mac_reconfig_complete(struct ieee80211_hw *hw,
 				   enum ieee80211_reconfig_type reconfig_type);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index f67ab8ee18c2..17a1e5717dde 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -220,6 +220,8 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 	struct iwl_nvm_section *sections = mvm->nvm_sections;
 	const __be16 *hw;
 	const __le16 *sw, *calib, *regulatory, *mac_override, *phy_sku;
+	u8 tx_ant = mvm->fw->valid_tx_ant;
+	u8 rx_ant = mvm->fw->valid_rx_ant;
 	int regulatory_type;
 
 	/* Checking for required sections */
@@ -270,9 +272,15 @@ iwl_parse_nvm_sections(struct iwl_mvm *mvm)
 		(const __le16 *)sections[NVM_SECTION_TYPE_REGULATORY_SDP].data :
 		(const __le16 *)sections[NVM_SECTION_TYPE_REGULATORY].data;
 
+	if (mvm->set_tx_ant)
+		tx_ant &= mvm->set_tx_ant;
+
+	if (mvm->set_rx_ant)
+		rx_ant &= mvm->set_rx_ant;
+
 	return iwl_parse_nvm_data(mvm->trans, mvm->cfg, mvm->fw, hw, sw, calib,
 				  regulatory, mac_override, phy_sku,
-				  mvm->fw->valid_tx_ant, mvm->fw->valid_rx_ant);
+				  tx_ant, rx_ant);
 }
 
 /* Loads the NVM data stored in mvm->nvm_sections into the NIC */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1c21a313f8f1..465090f67aaf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -751,7 +751,10 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 			 */
 			mvm->nvm_data =
 				iwl_parse_mei_nvm_data(trans, trans->cfg,
-						       mvm->mei_nvm_data, mvm->fw);
+						       mvm->mei_nvm_data,
+						       mvm->fw,
+						       mvm->set_tx_ant,
+						       mvm->set_rx_ant);
 			return 0;
 		}
 
-- 
2.38.1

