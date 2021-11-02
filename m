Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA4E442811
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Nov 2021 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhKBHSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Nov 2021 03:18:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:22772 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhKBHSg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Nov 2021 03:18:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="218394171"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="218394171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 00:16:01 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="638099996"
Received: from egrumbac-mobl1.jer.intel.com ([10.13.16.230])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 00:16:00 -0700
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] iwlwifi: integrate with iwlmei
Date:   Tue,  2 Nov 2021 09:15:47 +0200
Message-Id: <20211102071549.5833-4-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211102071549.5833-1-emmanuel.grumbach@intel.com>
References: <20211102071549.5833-1-emmanuel.grumbach@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iwlmei needs to know about the follwing events:

* Association
* De-association
* Country Code change
* SW Rfkill change
* SAR table changes

iwlmei can take the device away from us, so report the new
rfkill type when this happens.
Advertise the required data from the CSME firmware to the
usersapce: mostly, the AP that the CSME firmware is currently
associated to in case there is an active link protection
session.
Generate the HOST_ASSOC / HOST_DISSASSOC messages.

Don't support WPA1 (non-RSNA) for now.
Don't support shared wep either.
We can then determine the AUTH parameter by checking the AKM.
Feed the cipher from the key installation.

SW Rfkill will be implemented later when cfg80211 will
allow us to read the SW Rfkill state.

Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

v7: Ayala added her signed-off
    remove pointless function declaration
    fix a bug due to merge conflict in the HOST_ASSOC message
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  61 ++++++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  11 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 114 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  62 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 200 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  25 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  16 +-
 11 files changed, 476 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index f470f9aea50f..0cd4718372f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -22,6 +22,7 @@
 #include "fw/api/commands.h"
 #include "fw/api/cmdhdr.h"
 #include "fw/img.h"
+#include "mei/iwl-mei.h"
 
 /* NVM offsets (in words) definitions */
 enum nvm_offsets {
@@ -1114,6 +1115,66 @@ iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	return false;
 }
 
+struct iwl_nvm_data *
+iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+		       const struct iwl_mei_nvm *mei_nvm,
+		       const struct iwl_fw *fw)
+{
+	struct iwl_nvm_data *data;
+	u32 sbands_flags = 0;
+	u8 rx_chains = fw->valid_rx_ant;
+	u8 tx_chains = fw->valid_rx_ant;
+
+	if (cfg->uhb_supported)
+		data = kzalloc(struct_size(data, channels,
+					   IWL_NVM_NUM_CHANNELS_UHB),
+					   GFP_KERNEL);
+	else
+		data = kzalloc(struct_size(data, channels,
+					   IWL_NVM_NUM_CHANNELS_EXT),
+					   GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	BUILD_BUG_ON(ARRAY_SIZE(mei_nvm->channels) !=
+		     IWL_NVM_NUM_CHANNELS_UHB);
+	data->nvm_version = mei_nvm->nvm_version;
+
+	iwl_set_radio_cfg(cfg, data, mei_nvm->radio_cfg);
+	if (data->valid_tx_ant)
+		tx_chains &= data->valid_tx_ant;
+	if (data->valid_rx_ant)
+		rx_chains &= data->valid_rx_ant;
+
+	data->sku_cap_mimo_disabled = false;
+	data->sku_cap_band_24ghz_enable = true;
+	data->sku_cap_band_52ghz_enable = true;
+	data->sku_cap_11n_enable =
+		!(iwlwifi_mod_params.disable_11n & IWL_DISABLE_HT_ALL);
+	data->sku_cap_11ac_enable = true;
+	data->sku_cap_11ax_enable =
+		mei_nvm->caps & MEI_NVM_CAPS_11AX_SUPPORT;
+
+	data->lar_enabled = mei_nvm->caps & MEI_NVM_CAPS_LARI_SUPPORT;
+
+	data->n_hw_addrs = mei_nvm->n_hw_addrs;
+	/* If no valid mac address was found - bail out */
+	if (iwl_set_hw_address(trans, cfg, data, NULL, NULL)) {
+		kfree(data);
+		return NULL;
+	}
+
+	if (data->lar_enabled &&
+	    fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_LAR_SUPPORT))
+		sbands_flags |= IWL_NVM_SBANDS_FLAGS_LAR;
+
+	iwl_init_sbands(trans, data, mei_nvm->channels, tx_chains, rx_chains,
+			sbands_flags, true, fw);
+
+	return data;
+}
+IWL_EXPORT_SYMBOL(iwl_parse_mei_nvm_data);
+
 struct iwl_nvm_data *
 iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		   const struct iwl_fw *fw,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
index e1f5a9741850..e01f7751cf11 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2015, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2015, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_nvm_parse_h__
@@ -8,6 +8,7 @@
 
 #include <net/cfg80211.h>
 #include "iwl-eeprom-parse.h"
+#include "mei/iwl-mei.h"
 
 /**
  * enum iwl_nvm_sbands_flags - modification flags for the channel profiles
@@ -81,4 +82,12 @@ void iwl_nvm_fixups(u32 hw_id, unsigned int section, u8 *data,
 struct iwl_nvm_data *iwl_get_nvm(struct iwl_trans *trans,
 				 const struct iwl_fw *fw);
 
+/**
+ * iwl_parse_mei_nvm_data - parse the mei_nvm_data and get an iwl_nvm_data
+ */
+struct iwl_nvm_data *
+iwl_parse_mei_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
+		       const struct iwl_mei_nvm *mei_nvm,
+		       const struct iwl_fw *fw);
+
 #endif /* __iwl_nvm_parse_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 4ebb1871bd1f..a4060af50201 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -924,6 +924,7 @@ struct iwl_trans_txqs {
 /**
  * struct iwl_trans - transport common data
  *
+ * @csme_own - true if we couldn't get ownership on the device
  * @ops - pointer to iwl_trans_ops
  * @op_mode - pointer to the op_mode
  * @trans_cfg: the trans-specific configuration part
@@ -958,6 +959,7 @@ struct iwl_trans_txqs {
  * @iwl_trans_txqs: transport tx queues data.
  */
 struct iwl_trans {
+	bool csme_own;
 	const struct iwl_trans_ops *ops;
 	struct iwl_op_mode *op_mode;
 	const struct iwl_cfg_trans_params *trans_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 863fec150e53..6ce78c03e51f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -757,6 +757,8 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	if (ret)
 		return ret;
 
+	iwl_mei_set_power_limit(per_chain);
+
 	IWL_DEBUG_RADIO(mvm, "Sending REDUCE_TX_POWER_CMD per chain\n");
 	return iwl_mvm_send_cmd_pdu(mvm, REDUCE_TX_POWER_CMD, 0, len, &cmd);
 }
@@ -1401,7 +1403,6 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 	if (iwl_mvm_has_unified_ucode(mvm))
 		return iwl_run_unified_mvm_ucode(mvm);
 
-	WARN_ON(!mvm->nvm_data);
 	ret = iwl_run_init_mvm_ucode(mvm);
 
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9fb9c7dad314..c96a0ece8066 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -190,6 +190,7 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 	if (IS_ERR_OR_NULL(resp)) {
 		IWL_DEBUG_LAR(mvm, "Could not get update from FW %d\n",
 			      PTR_ERR_OR_ZERO(resp));
+		resp = NULL;
 		goto out;
 	}
 
@@ -211,7 +212,6 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 				      __le16_to_cpu(resp->cap), resp_ver);
 	/* Store the return source id */
 	src_id = resp->source_id;
-	kfree(resp);
 	if (IS_ERR_OR_NULL(regd)) {
 		IWL_DEBUG_LAR(mvm, "Could not get parse update from FW %d\n",
 			      PTR_ERR_OR_ZERO(regd));
@@ -223,7 +223,10 @@ struct ieee80211_regdomain *iwl_mvm_get_regdomain(struct wiphy *wiphy,
 	mvm->lar_regdom_set = true;
 	mvm->mcc_src = src_id;
 
+	iwl_mei_set_country_code(__le16_to_cpu(resp->mcc));
+
 out:
+	kfree(resp);
 	return regd;
 }
 
@@ -1083,6 +1086,27 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 
 	lockdep_assert_held(&mvm->mutex);
 
+	ret = iwl_mvm_mei_get_ownership(mvm);
+	if (ret)
+		return ret;
+
+	if (mvm->mei_nvm_data) {
+		/* We got the NIC, we can now free the MEI NVM data */
+		kfree(mvm->mei_nvm_data);
+		mvm->mei_nvm_data = NULL;
+
+		/*
+		 * We can't free the nvm_data we allocated based on the SAP
+		 * data because we registered to cfg80211 with the channels
+		 * allocated on mvm->nvm_data. Keep a pointer in temp_nvm_data
+		 * just in order to be able free it later.
+		 * NULLify nvm_data so that we will read the NVM from the
+		 * firmware this time.
+		 */
+		mvm->temp_nvm_data = mvm->nvm_data;
+		mvm->nvm_data = NULL;
+	}
+
 	if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status)) {
 		/*
 		 * Now convert the HW_RESTART_REQUESTED flag to IN_HW_RESTART
@@ -1509,6 +1533,15 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 		mvm->monitor_on = true;
 
 	iwl_mvm_vif_dbgfs_register(mvm, vif);
+
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
+	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
+	    !mvm->csme_vif && mvm->mei_registered) {
+		iwl_mei_set_nic_info(vif->addr, mvm->nvm_data->hw_addr);
+		iwl_mei_set_netdev(ieee80211_vif_to_wdev(vif)->netdev);
+		mvm->csme_vif = vif;
+	}
+
 	goto out_unlock;
 
  out_unbind:
@@ -1561,6 +1594,11 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
+	if (vif == mvm->csme_vif) {
+		iwl_mei_set_netdev(NULL);
+		mvm->csme_vif = NULL;
+	}
+
 	probe_data = rcu_dereference_protected(mvmvif->probe_resp_data,
 					       lockdep_is_held(&mvm->mutex));
 	RCU_INIT_POINTER(mvmvif->probe_resp_data, NULL);
@@ -2371,6 +2409,7 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 						    IEEE80211_SMPS_DYNAMIC);
 			}
 		} else if (mvmvif->ap_sta_id != IWL_MVM_INVALID_STA) {
+			iwl_mvm_mei_host_disassociated(mvm);
 			/*
 			 * If update fails - SF might be running in associated
 			 * mode while disassociated - which is forbidden.
@@ -3107,6 +3146,69 @@ static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_mei_host_associated(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					struct iwl_mvm_sta *mvm_sta)
+{
+#if IS_ENABLED(CONFIG_IWLMEI)
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mei_conn_info conn_info = {
+		.ssid_len = vif->bss_conf.ssid_len,
+		.channel = vif->bss_conf.chandef.chan->hw_value,
+	};
+
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		return;
+
+	if (!mvm->mei_registered)
+		return;
+
+	switch (mvm_sta->pairwise_cipher) {
+	case WLAN_CIPHER_SUITE_CCMP:
+		conn_info.pairwise_cipher = IWL_MEI_CIPHER_CCMP;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP:
+		conn_info.pairwise_cipher = IWL_MEI_CIPHER_GCMP;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		conn_info.pairwise_cipher = IWL_MEI_CIPHER_GCMP_256;
+		break;
+	case 0:
+		/* open profile */
+		break;
+	default:
+		/* cipher not supported, don't send anything to iwlmei */
+		return;
+	}
+
+	switch (mvmvif->rekey_data.akm) {
+	case WLAN_AKM_SUITE_SAE & 0xff:
+		conn_info.auth_mode = IWL_MEI_AKM_AUTH_SAE;
+		break;
+	case WLAN_AKM_SUITE_PSK & 0xff:
+		conn_info.auth_mode = IWL_MEI_AKM_AUTH_RSNA_PSK;
+		break;
+	case WLAN_AKM_SUITE_8021X & 0xff:
+		conn_info.auth_mode = IWL_MEI_AKM_AUTH_RSNA;
+		break;
+	case 0:
+		/* open profile */
+		conn_info.auth_mode = IWL_MEI_AKM_AUTH_OPEN;
+		break;
+	default:
+		/* auth method / AKM not supported */
+		/* TODO: All the FT vesions of these? */
+		return;
+	}
+
+	memcpy(conn_info.ssid, vif->bss_conf.ssid, vif->bss_conf.ssid_len);
+	memcpy(conn_info.bssid,  vif->bss_conf.bssid, ETH_ALEN);
+
+	/* TODO: add support for collocated AP data */
+	iwl_mei_host_associated(&conn_info, NULL);
+#endif
+}
+
 static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
@@ -3251,6 +3353,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			 * multicast data frames can be forwarded to the driver
 			 */
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
+			iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 		}
 
 		iwl_mvm_rs_rate_init(mvm, sta, mvmvif->phy_ctxt->channel->band,
@@ -3460,6 +3563,8 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	int ret, i;
 	u8 key_offset;
 
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
 		if (!mvm->trans->trans_cfg->gen2) {
@@ -3568,7 +3673,6 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			struct ieee80211_key_seq seq;
 			int tid, q;
 
-			mvmsta = iwl_mvm_sta_from_mac80211(sta);
 			WARN_ON(rcu_access_pointer(mvmsta->ptk_pn[keyidx]));
 			ptk_pn = kzalloc(struct_size(ptk_pn, q,
 						     mvm->trans->num_rx_queues),
@@ -3595,6 +3699,9 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		else
 			key_offset = STA_KEY_IDX_INVALID;
 
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+			mvmsta->pairwise_cipher = key->cipher;
+
 		IWL_DEBUG_MAC80211(mvm, "set hwcrypto key\n");
 		ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, key_offset);
 		if (ret) {
@@ -3640,7 +3747,6 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		    (key->cipher == WLAN_CIPHER_SUITE_CCMP ||
 		     key->cipher == WLAN_CIPHER_SUITE_GCMP ||
 		     key->cipher == WLAN_CIPHER_SUITE_GCMP_256)) {
-			mvmsta = iwl_mvm_sta_from_mac80211(sta);
 			ptk_pn = rcu_dereference_protected(
 						mvmsta->ptk_pn[keyidx],
 						lockdep_is_held(&mvm->mutex));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2b1dcd60e00f..515591b29b0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -30,6 +30,7 @@
 #include "fw/runtime.h"
 #include "fw/dbg.h"
 #include "fw/acpi.h"
+#include "mei/iwl-mei.h"
 #include "iwl-nvm-parse.h"
 
 #include <linux/average.h>
@@ -830,6 +831,18 @@ struct iwl_mvm {
 
 	const char *nvm_file_name;
 	struct iwl_nvm_data *nvm_data;
+	struct iwl_mei_nvm *mei_nvm_data;
+	struct iwl_mvm_csme_conn_info __rcu *csme_conn_info;
+	bool mei_rfkill_blocked;
+	bool mei_registered;
+	struct work_struct sap_connected_wk;
+
+	/*
+	 * NVM built based on the SAP data but that we can't free even after
+	 * we get ownership because it contains the cfg80211's channel.
+	 */
+	struct iwl_nvm_data *temp_nvm_data;
+
 	/* NVM sections */
 	struct iwl_nvm_section nvm_sections[NVM_MAX_NUM_SECTIONS];
 
@@ -1021,6 +1034,8 @@ struct iwl_mvm {
 	/* Indicate if 32Khz external clock is valid */
 	u32 ext_clock_valid;
 
+	/* This vif used by CSME to send / receive traffic */
+	struct ieee80211_vif *csme_vif;
 	struct ieee80211_vif __rcu *csa_vif;
 	struct ieee80211_vif __rcu *csa_tx_blocked_vif;
 	u8 csa_tx_block_bcn_timeout;
@@ -1136,6 +1151,11 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_IN_D3,
 };
 
+struct iwl_mvm_csme_conn_info {
+	struct rcu_head rcu_head;
+	struct iwl_mei_conn_info conn_info;
+};
+
 /* Keep track of completed init configuration */
 enum iwl_mvm_init_status {
 	IWL_MVM_INIT_STATUS_THERMAL_INIT_COMPLETE = BIT(0),
@@ -2158,4 +2178,46 @@ enum iwl_location_cipher iwl_mvm_cipher_to_location_cipher(u32 cipher)
 		return IWL_LOCATION_CIPHER_INVALID;
 	}
 }
+
+struct iwl_mvm_csme_conn_info *iwl_mvm_get_csme_conn_info(struct iwl_mvm *mvm);
+static inline int iwl_mvm_mei_get_ownership(struct iwl_mvm *mvm)
+{
+	if (mvm->mei_registered)
+		return iwl_mei_get_ownership();
+	return 0;
+}
+
+static inline void iwl_mvm_mei_tx_copy_to_csme(struct iwl_mvm *mvm,
+					       struct sk_buff *skb,
+					       unsigned int ivlen)
+{
+	if (mvm->mei_registered)
+		iwl_mei_tx_copy_to_csme(skb, ivlen);
+}
+
+static inline void iwl_mvm_mei_host_disassociated(struct iwl_mvm *mvm)
+{
+	if (mvm->mei_registered)
+		iwl_mei_host_disassociated();
+}
+
+static inline void iwl_mvm_mei_device_down(struct iwl_mvm *mvm)
+{
+	if (mvm->mei_registered)
+		iwl_mei_device_down();
+}
+
+static inline void iwl_mvm_mei_set_sw_rfkill_state(struct iwl_mvm *mvm, bool sw_rfkill)
+{
+	if (mvm->mei_registered)
+		iwl_mei_set_rfkill_state(iwl_mvm_is_radio_killed(mvm), sw_rfkill);
+}
+
+static inline void iwl_mvm_send_roaming_forbidden_event(struct iwl_mvm *mvm,
+							struct ieee80211_vif *vif,
+							bool forbidden)
+{
+	/* TODO */
+}
+
 #endif /* __IWL_MVM_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 232ad531d612..82fea029d4d0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -683,13 +683,42 @@ static const struct iwl_fw_runtime_ops iwl_mvm_fwrt_ops = {
 
 static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 {
+	struct iwl_trans *trans = mvm->trans;
 	int ret;
 
+	if (trans->csme_own) {
+		if (WARN(!mvm->mei_registered,
+			 "csme is owner, but we aren't registered to iwlmei\n"))
+			goto get_nvm_from_fw;
+
+		mvm->mei_nvm_data = iwl_mei_get_nvm();
+		if (mvm->mei_nvm_data) {
+			/*
+			 * mvm->mei_nvm_data is set and because of that,
+			 * we'll load the NVM from the FW when we'll get
+			 * ownership.
+			 */
+			mvm->nvm_data =
+				iwl_parse_mei_nvm_data(trans, trans->cfg,
+						       mvm->mei_nvm_data, mvm->fw);
+			return 0;
+		}
+
+		IWL_ERR(mvm,
+			"Got a NULL NVM from CSME, trying to get it from the device\n");
+	}
+
+get_nvm_from_fw:
 	rtnl_lock();
 	mutex_lock(&mvm->mutex);
 
-	ret = iwl_run_init_mvm_ucode(mvm);
+	ret = iwl_trans_start_hw(mvm->trans);
+	if (ret) {
+		mutex_unlock(&mvm->mutex);
+		return ret;
+	}
 
+	ret = iwl_run_init_mvm_ucode(mvm);
 	if (ret && ret != -ERFKILL)
 		iwl_fw_dbg_error_collect(&mvm->fwrt, FW_DBG_TRIGGER_DRIVER);
 	if (!ret && iwl_mvm_is_lar_supported(mvm)) {
@@ -703,7 +732,7 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 	mutex_unlock(&mvm->mutex);
 	rtnl_unlock();
 
-	if (ret < 0)
+	if (ret)
 		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", ret);
 
 	return ret;
@@ -711,6 +740,7 @@ static int iwl_mvm_start_get_nvm(struct iwl_mvm *mvm)
 
 static int iwl_mvm_start_post_nvm(struct iwl_mvm *mvm)
 {
+	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
 	int ret;
 
 	iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
@@ -718,10 +748,14 @@ static int iwl_mvm_start_post_nvm(struct iwl_mvm *mvm)
 	ret = iwl_mvm_mac_setup_register(mvm);
 	if (ret)
 		return ret;
+
 	mvm->hw_registered = true;
 
 	iwl_mvm_dbgfs_register(mvm);
 
+	wiphy_rfkill_set_hw_state_reason(mvm->hw->wiphy,
+					 mvm->mei_rfkill_blocked,
+					 RFKILL_HARD_BLOCK_NOT_OWNER);
 	return 0;
 }
 
@@ -902,6 +936,109 @@ static const struct iwl_dump_sanitize_ops iwl_mvm_sanitize_ops = {
 	.frob_mem = iwl_mvm_frob_mem,
 };
 
+static void iwl_mvm_me_conn_status(void *priv, const struct iwl_mei_conn_info *conn_info)
+{
+	struct iwl_mvm *mvm = priv;
+	struct iwl_mvm_csme_conn_info *prev_conn_info, *curr_conn_info;
+
+	/*
+	 * This is protected by the guarantee that this function will not be
+	 * called twice on two different threads
+	 */
+	prev_conn_info = rcu_dereference_protected(mvm->csme_conn_info, true);
+
+	curr_conn_info = kzalloc(sizeof(*curr_conn_info), GFP_KERNEL);
+	if (!curr_conn_info)
+		return;
+
+	curr_conn_info->conn_info = *conn_info;
+
+	rcu_assign_pointer(mvm->csme_conn_info, curr_conn_info);
+
+	if (prev_conn_info)
+		kfree_rcu(prev_conn_info, rcu_head);
+}
+
+static void iwl_mvm_mei_rfkill(void *priv, bool blocked)
+{
+	struct iwl_mvm *mvm = priv;
+
+	mvm->mei_rfkill_blocked = blocked;
+	if (!mvm->hw_registered)
+		return;
+
+	wiphy_rfkill_set_hw_state_reason(mvm->hw->wiphy,
+					 mvm->mei_rfkill_blocked,
+					 RFKILL_HARD_BLOCK_NOT_OWNER);
+}
+
+static void iwl_mvm_mei_roaming_forbidden(void *priv, bool forbidden)
+{
+	struct iwl_mvm *mvm = priv;
+
+	if (!mvm->hw_registered || !mvm->csme_vif)
+		return;
+
+	iwl_mvm_send_roaming_forbidden_event(mvm, mvm->csme_vif, forbidden);
+}
+
+static void iwl_mvm_sap_connected_wk(struct work_struct *wk)
+{
+	struct iwl_mvm *mvm =
+		container_of(wk, struct iwl_mvm, sap_connected_wk);
+	int ret;
+
+	ret = iwl_mvm_start_get_nvm(mvm);
+	if (ret)
+		goto out_free;
+
+	ret = iwl_mvm_start_post_nvm(mvm);
+	if (ret)
+		goto out_free;
+
+	return;
+
+out_free:
+	IWL_ERR(mvm, "Couldn't get started...\n");
+	iwl_mei_start_unregister();
+	iwl_mei_unregister_complete();
+	iwl_fw_flush_dumps(&mvm->fwrt);
+	iwl_mvm_thermal_exit(mvm);
+	iwl_fw_runtime_free(&mvm->fwrt);
+	iwl_phy_db_free(mvm->phy_db);
+	kfree(mvm->scan_cmd);
+	iwl_trans_op_mode_leave(mvm->trans);
+	kfree(mvm->nvm_data);
+	kfree(mvm->mei_nvm_data);
+
+	ieee80211_free_hw(mvm->hw);
+}
+
+static void iwl_mvm_mei_sap_connected(void *priv)
+{
+	struct iwl_mvm *mvm = priv;
+
+	if (!mvm->hw_registered)
+		schedule_work(&mvm->sap_connected_wk);
+}
+
+static void iwl_mvm_mei_nic_stolen(void *priv)
+{
+	struct iwl_mvm *mvm = priv;
+
+	rtnl_lock();
+	cfg80211_shutdown_all_interfaces(mvm->hw->wiphy);
+	rtnl_unlock();
+}
+
+static const struct iwl_mei_ops mei_ops = {
+	.me_conn_status = iwl_mvm_me_conn_status,
+	.rfkill = iwl_mvm_mei_rfkill,
+	.roaming_forbidden = iwl_mvm_mei_roaming_forbidden,
+	.sap_connected = iwl_mvm_mei_sap_connected,
+	.nic_stolen = iwl_mvm_mei_nic_stolen,
+};
+
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -913,9 +1050,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	static const u8 no_reclaim_cmds[] = {
 		TX_CMD,
 	};
-	int err, scan_size;
+	int scan_size;
 	u32 min_backoff;
 	enum iwl_amsdu_size rb_size_default;
+	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
 
 	/*
 	 * We use IWL_MVM_STATION_COUNT_MAX to check the validity of the station
@@ -1015,6 +1153,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	INIT_WORK(&mvm->async_handlers_wk, iwl_mvm_async_handlers_wk);
 	INIT_WORK(&mvm->roc_done_wk, iwl_mvm_roc_done_wk);
+	INIT_WORK(&mvm->sap_connected_wk, iwl_mvm_sap_connected_wk);
 	INIT_DELAYED_WORK(&mvm->tdls_cs.dwork, iwl_mvm_tdls_ch_switch_work);
 	INIT_DELAYED_WORK(&mvm->scan_timeout_dwork, iwl_mvm_scan_timeout_wk);
 	INIT_WORK(&mvm->add_stream_wk, iwl_mvm_add_new_dqa_stream_wk);
@@ -1137,10 +1276,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		IWL_DEBUG_EEPROM(mvm->trans->dev,
 				 "working without external nvm file\n");
 
-	err = iwl_trans_start_hw(mvm->trans);
-	if (err)
-		goto out_free;
-
 	scan_size = iwl_mvm_scan_size(mvm);
 
 	mvm->scan_cmd = kmalloc(scan_size, GFP_KERNEL);
@@ -1165,8 +1300,14 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	mvm->debugfs_dir = dbgfs_dir;
 
-	if (iwl_mvm_start_get_nvm(mvm))
-		goto out_thermal_exit;
+	mvm->mei_registered = !iwl_mei_register(mvm, &mei_ops);
+
+	/*
+	 * Get NVM failed, but we are registered to MEI, we'll get
+	 * the NVM later when it'll be possible to get it from CSME.
+	 */
+	if (iwl_mvm_start_get_nvm(mvm) && mvm->mei_registered)
+		return op_mode;
 
 	if (iwl_mvm_start_post_nvm(mvm))
 		goto out_thermal_exit;
@@ -1175,6 +1316,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
  out_thermal_exit:
 	iwl_mvm_thermal_exit(mvm);
+	if (mvm->mei_registered) {
+		iwl_mei_start_unregister();
+		iwl_mei_unregister_complete();
+	}
  out_free:
 	iwl_fw_flush_dumps(&mvm->fwrt);
 	iwl_fw_runtime_free(&mvm->fwrt);
@@ -1201,6 +1346,7 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
 	iwl_fw_dump_conf_clear(&mvm->fwrt);
+	iwl_mvm_mei_device_down(mvm);
 }
 
 static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
@@ -1208,11 +1354,33 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 	int i;
 
+	if (mvm->mei_registered) {
+		rtnl_lock();
+		iwl_mei_set_netdev(NULL);
+		rtnl_unlock();
+		iwl_mei_start_unregister();
+	}
+
+	/*
+	 * After we unregister from mei, the worker can't be scheduled
+	 * anymore.
+	 */
+	cancel_work_sync(&mvm->sap_connected_wk);
+
 	iwl_mvm_leds_exit(mvm);
 
 	iwl_mvm_thermal_exit(mvm);
 
-	ieee80211_unregister_hw(mvm->hw);
+	/*
+	 * If we couldn't get ownership on the device and we couldn't
+	 * get the NVM from CSME, we haven't registered to mac80211.
+	 * In that case, we didn't fail op_mode_start, because we are
+	 * waiting for CSME to allow us to get the NVM to register to
+	 * mac80211. If that didn't happen, we haven't registered to
+	 * mac80211, hence the if below.
+	 */
+	if (mvm->hw_registered)
+		ieee80211_unregister_hw(mvm->hw);
 
 	kfree(mvm->scan_cmd);
 	kfree(mvm->mcast_filter_cmd);
@@ -1227,6 +1395,9 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 	mvm->phy_db = NULL;
 
 	kfree(mvm->nvm_data);
+	kfree(mvm->mei_nvm_data);
+	kfree(rcu_access_pointer(mvm->csme_conn_info));
+	kfree(mvm->temp_nvm_data);
 	for (i = 0; i < NVM_MAX_NUM_SECTIONS; i++)
 		kfree(mvm->nvm_sections[i].data);
 
@@ -1235,6 +1406,9 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 	iwl_fw_runtime_free(&mvm->fwrt);
 	mutex_destroy(&mvm->mutex);
 
+	if (mvm->mei_registered)
+		iwl_mei_unregister_complete();
+
 	ieee80211_free_hw(mvm->hw);
 }
 
@@ -1517,6 +1691,12 @@ void iwl_mvm_set_hw_ctkill_state(struct iwl_mvm *mvm, bool state)
 	iwl_mvm_set_rfkill_state(mvm);
 }
 
+struct iwl_mvm_csme_conn_info *iwl_mvm_get_csme_conn_info(struct iwl_mvm *mvm)
+{
+	return rcu_dereference_protected(mvm->csme_conn_info,
+					 lockdep_is_held(&mvm->mutex));
+}
+
 static bool iwl_mvm_set_hw_rfkill_state(struct iwl_op_mode *op_mode, bool state)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 32b4d1935788..e34b82b2a288 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -373,6 +373,7 @@ struct iwl_mvm_rxq_dup_data {
  * @tx_ant: the index of the antenna to use for data tx to this station. Only
  *	used during connection establishment (e.g. for the 4 way handshake
  *	exchange).
+ * @pairwise_cipher: used to feed iwlmei upon authorization
  *
  * When mac80211 creates a station it reserves some space (hw->sta_data_size)
  * in the structure for use by driver. This structure is placed in that
@@ -415,6 +416,7 @@ struct iwl_mvm_sta {
 	u8 sleep_tx_count;
 	u8 avg_energy;
 	u8 tx_ant;
+	u32 pairwise_cipher;
 };
 
 u16 iwl_mvm_tid_queued(struct iwl_mvm *mvm, struct iwl_mvm_tid_data *tid_data);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index bdd4ee432548..1883d98abb2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1128,6 +1128,11 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 	/* From now on, we cannot access info->control */
 	iwl_mvm_skb_prepare_status(skb, dev_cmd);
 
+	if (ieee80211_is_data(fc))
+		iwl_mvm_mei_tx_copy_to_csme(mvm, skb,
+					    info->control.hw_key ?
+					    info->control.hw_key->iv_len : 0);
+
 	if (iwl_trans_tx(mvm->trans, skb, dev_cmd, txq_id))
 		goto drop_unlock_sta;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index c574f041f096..5c56da36fc84 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1422,15 +1422,18 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * first trying to load the firmware etc. and potentially only
 	 * detecting any problems when the first interface is brought up.
 	 */
-	ret = iwl_finish_nic_init(iwl_trans);
-	if (ret)
-		goto out_free_trans;
-	if (iwl_trans_grab_nic_access(iwl_trans)) {
-		/* all good */
-		iwl_trans_release_nic_access(iwl_trans);
-	} else {
-		ret = -EIO;
-		goto out_free_trans;
+	ret = iwl_pcie_prepare_card_hw(iwl_trans);
+	if (!ret) {
+		ret = iwl_finish_nic_init(iwl_trans);
+		if (ret)
+			goto out_free_trans;
+		if (iwl_trans_grab_nic_access(iwl_trans)) {
+			/* all good */
+			iwl_trans_release_nic_access(iwl_trans);
+		} else {
+			ret = -EIO;
+			goto out_free_trans;
+		}
 	}
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
@@ -1563,6 +1566,10 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out_free_trans;
 
 	pci_set_drvdata(pdev, iwl_trans);
+
+	/* try to get ownership so that we'll know if we don't own it */
+	iwl_pcie_prepare_card_hw(iwl_trans);
+
 	iwl_trans->drv = iwl_drv_start(iwl_trans);
 
 	if (IS_ERR(iwl_trans->drv)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 1efb53f78a62..07a4b06066db 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -24,6 +24,7 @@
 #include "fw/error-dump.h"
 #include "fw/dbg.h"
 #include "fw/api/tx.h"
+#include "mei/iwl-mei.h"
 #include "internal.h"
 #include "iwl-fh.h"
 #include "iwl-context-info-gen3.h"
@@ -594,8 +595,10 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 
 	ret = iwl_pcie_set_hw_ready(trans);
 	/* If the card is ready, exit 0 */
-	if (ret >= 0)
+	if (ret >= 0) {
+		trans->csme_own = false;
 		return 0;
+	}
 
 	iwl_set_bit(trans, CSR_DBG_LINK_PWR_MGMT_REG,
 		    CSR_RESET_LINK_PWR_MGMT_DISABLED);
@@ -608,8 +611,17 @@ int iwl_pcie_prepare_card_hw(struct iwl_trans *trans)
 
 		do {
 			ret = iwl_pcie_set_hw_ready(trans);
-			if (ret >= 0)
+			if (ret >= 0) {
+				trans->csme_own = false;
 				return 0;
+			}
+
+			if (iwl_mei_is_connected()) {
+				IWL_WARN(trans,
+					 "Couldn't prepare the card but SAP is connected\n");
+				trans->csme_own = true;
+				return -EBUSY;
+			}
 
 			usleep_range(200, 1000);
 			t += 200;
-- 
2.25.1

