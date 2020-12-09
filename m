Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A32D4CE8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgLIVd3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:33:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35864 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727984AbgLIVd3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:33:29 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pe-003Drx-D2; Wed, 09 Dec 2020 23:17:07 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:20 +0200
Message-Id: <iwlwifi.20201209231352.1eb4c8625f36.I1b17b68d4a8e77071da3e15ffbd902d15c1d4938@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.4
Subject: [PATCH v2 16/47] iwlwifi: follow the new inclusive terminology
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The new inclusive terminology requires to change a few
terms that were used in iwlwifi.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 20 ++++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 10 ++++----
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  8 +++----
 .../net/wireless/intel/iwlwifi/fw/api/scan.h  | 12 +++++-----
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  6 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 10 ++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 24 +++++++++----------
 11 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 3e5a35e26ad3..8c78c6180d05 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -229,8 +229,8 @@ union acpi_object *iwl_acpi_get_wifi_pkg(struct device *dev,
 IWL_EXPORT_SYMBOL(iwl_acpi_get_wifi_pkg);
 
 int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-		     __le32 *black_list_array,
-		     int *black_list_size)
+		     __le32 *block_list_array,
+		     int *block_list_size)
 {
 	union acpi_object *wifi_pkg, *data;
 	int ret, tbl_rev, i;
@@ -257,7 +257,7 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 	enabled = !!wifi_pkg->package.elements[0].integer.value;
 
 	if (!enabled) {
-		*black_list_size = -1;
+		*block_list_size = -1;
 		IWL_DEBUG_RADIO(fwrt, "TAS not enabled\n");
 		ret = 0;
 		goto out_free;
@@ -271,17 +271,17 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		ret = -EINVAL;
 		goto out_free;
 	}
-	*black_list_size = wifi_pkg->package.elements[1].integer.value;
+	*block_list_size = wifi_pkg->package.elements[1].integer.value;
 
-	IWL_DEBUG_RADIO(fwrt, "TAS array size %d\n", *black_list_size);
-	if (*black_list_size > APCI_WTAS_BLACK_LIST_MAX) {
+	IWL_DEBUG_RADIO(fwrt, "TAS array size %d\n", *block_list_size);
+	if (*block_list_size > APCI_WTAS_BLACK_LIST_MAX) {
 		IWL_DEBUG_RADIO(fwrt, "TAS invalid array size value %u\n",
-				*black_list_size);
+				*block_list_size);
 		ret = -EINVAL;
 		goto out_free;
 	}
 
-	for (i = 0; i < *black_list_size; i++) {
+	for (i = 0; i < *block_list_size; i++) {
 		u32 country;
 
 		if (wifi_pkg->package.elements[2 + i].type !=
@@ -293,8 +293,8 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 		}
 
 		country = wifi_pkg->package.elements[2 + i].integer.value;
-		black_list_array[i] = cpu_to_le32(country);
-		IWL_DEBUG_RADIO(fwrt, "TAS black list country %d\n", country);
+		block_list_array[i] = cpu_to_le32(country);
+		IWL_DEBUG_RADIO(fwrt, "TAS block list country %d\n", country);
 	}
 
 	ret = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index bddf8a44e163..dfd341421adc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -100,7 +100,7 @@
 #define ACPI_ECKV_WIFI_DATA_SIZE	2
 
 /*
- * 1 type, 1 enabled, 1 black list size, 16 black list array
+ * 1 type, 1 enabled, 1 block list size, 16 block list array
  */
 #define APCI_WTAS_BLACK_LIST_MAX	16
 #define ACPI_WTAS_WIFI_DATA_SIZE	(3 + APCI_WTAS_BLACK_LIST_MAX)
@@ -197,8 +197,8 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
 int iwl_sar_geo_init(struct iwl_fw_runtime *fwrt,
 		     struct iwl_per_chain_offset *table, u32 n_bands);
 
-int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *black_list_array,
-		     int *black_list_size);
+int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt, __le32 *block_list_array,
+		     int *block_list_size);
 
 #else /* CONFIG_ACPI */
 
@@ -269,8 +269,8 @@ static inline bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 }
 
 static inline int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
-				   __le32 *black_list_array,
-				   int *black_list_size)
+				   __le32 *block_list_array,
+				   int *block_list_size)
 {
 	return -ENOENT;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index 8cc36dbb2311..21543bc21c16 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -323,7 +323,7 @@ enum iwl_legacy_cmds {
 
 	/**
 	 * @SCAN_OFFLOAD_UPDATE_PROFILES_CMD:
-	 * update scan offload (scheduled scan) profiles/blacklist/etc.
+	 * update scan offload (scheduled scan) profiles/blocklist/etc.
 	 */
 	SCAN_OFFLOAD_UPDATE_PROFILES_CMD = 0x6E,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 55573168444e..dd79bac98657 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -449,12 +449,12 @@ enum iwl_mcc_source {
 #define IWL_TAS_BLACK_LIST_MAX 16
 /**
  * struct iwl_tas_config_cmd - configures the TAS
- * @black_list_size: size of relevant field in black_list_array
- * @black_list_array: black list countries (without TAS)
+ * @block_list_size: size of relevant field in block_list_array
+ * @block_list_array: block list countries (without TAS)
  */
 struct iwl_tas_config_cmd {
-	__le32 black_list_size;
-	__le32 black_list_array[IWL_TAS_BLACK_LIST_MAX];
+	__le32 block_list_size;
+	__le32 block_list_array[IWL_TAS_BLACK_LIST_MAX];
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_2 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index b6c29196d935..ef6222d6b4b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -117,12 +117,12 @@ enum scan_framework_client {
 };
 
 /**
- * struct iwl_scan_offload_blacklist - SCAN_OFFLOAD_BLACKLIST_S
+ * struct iwl_scan_offload_blocklist - SCAN_OFFLOAD_BLACKLIST_S
  * @ssid:		MAC address to filter out
  * @reported_rssi:	AP rssi reported to the host
  * @client_bitmap: clients ignore this entry  - enum scan_framework_client
  */
-struct iwl_scan_offload_blacklist {
+struct iwl_scan_offload_blocklist {
 	u8 ssid[ETH_ALEN];
 	u8 reported_rssi;
 	u8 client_bitmap;
@@ -162,7 +162,7 @@ struct iwl_scan_offload_profile {
 
 /**
  * struct iwl_scan_offload_profile_cfg_data
- * @blacklist_len:	length of blacklist
+ * @blocklist_len:	length of blocklist
  * @num_profiles:	num of profiles in the list
  * @match_notify:	clients waiting for match found notification
  * @pass_match:		clients waiting for the results
@@ -171,7 +171,7 @@ struct iwl_scan_offload_profile {
  * @reserved:		reserved
  */
 struct iwl_scan_offload_profile_cfg_data {
-	u8 blacklist_len;
+	u8 blocklist_len;
 	u8 num_profiles;
 	u8 match_notify;
 	u8 pass_match;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index a187253a59bc..e79c1faca95f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -220,7 +220,7 @@ struct iwl_ucode_capa {
  *	treats good CRC threshold as a boolean
  * @IWL_UCODE_TLV_FLAGS_MFP: This uCode image supports MFP (802.11w).
  * @IWL_UCODE_TLV_FLAGS_UAPSD_SUPPORT: This uCode image supports uAPSD
- * @IWL_UCODE_TLV_FLAGS_SHORT_BL: 16 entries of black list instead of 64 in scan
+ * @IWL_UCODE_TLV_FLAGS_SHORT_BL: 16 entries of block list instead of 64 in scan
  *	offload profile config command.
  * @IWL_UCODE_TLV_FLAGS_D3_6_IPV6_ADDRS: D3 image supports up to six
  *	(rather than two) IPv6 addresses
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index ca4967b81d01..ea3ac7ae9e14 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -376,7 +376,7 @@ struct iwl_fw_mon_regs {
  *	mode set
  * @nvm_hw_section_num: the ID of the HW NVM section
  * @mac_addr_from_csr: read HW address from CSR registers
- * @features: hw features, any combination of feature_whitelist
+ * @features: hw features, any combination of feature_passlist
  * @pwr_tx_backoffs: translation table between power limits and backoffs
  * @max_tx_agg_size: max TX aggregation size of the ADDBA request/response
  * @max_ht_ampdu_factor: the exponent of the max length of A-MPDU that the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index c29e55720179..726e402f9be4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1096,7 +1096,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 	struct iwl_tas_config_cmd cmd = {};
 	int list_size;
 
-	BUILD_BUG_ON(ARRAY_SIZE(cmd.black_list_array) <
+	BUILD_BUG_ON(ARRAY_SIZE(cmd.block_list_array) <
 		     APCI_WTAS_BLACK_LIST_MAX);
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_TAS_CFG)) {
@@ -1104,7 +1104,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	ret = iwl_acpi_get_tas(&mvm->fwrt, cmd.black_list_array, &list_size);
+	ret = iwl_acpi_get_tas(&mvm->fwrt, cmd.block_list_array, &list_size);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"TAS table invalid or unavailable. (%d)\n",
@@ -1116,7 +1116,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 
 	/* list size if TAS enabled can only be non-negative */
-	cmd.black_list_size = cpu_to_le32((u32)list_size);
+	cmd.block_list_size = cpu_to_le32((u32)list_size);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(REGULATORY_AND_NVM_GROUP,
 						TAS_CONFIG),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index ca8983cf3a4f..b661e8bd4f36 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -116,12 +116,12 @@ static void iwl_mvm_mac_tsf_id_iter(void *_data, u8 *mac,
 	 * client in the system.
 	 *
 	 * The firmware will decide according to the MAC type which
-	 * will be the master and slave. Clients that need to sync
-	 * with a remote station will be the master, and an AP or GO
-	 * will be the slave.
+	 * will be the leader and follower. Clients that need to sync
+	 * with a remote station will be the leader, and an AP or GO
+	 * will be the follower.
 	 *
-	 * Depending on the new interface type it can be slaved to
-	 * or become the master of an existing interface.
+	 * Depending on the new interface type it can be following
+	 * or become the leader of an existing interface.
 	 */
 	switch (data->vif->type) {
 	case NL80211_IFTYPE_STATION:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b40b88740b48..76e04abd60bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2285,9 +2285,9 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 	int ret;
 
 	/*
-	 * Re-calculate the tsf id, as the master-slave relations depend on the
-	 * beacon interval, which was not known when the station interface was
-	 * added.
+	 * Re-calculate the tsf id, as the leader-follower relations depend
+	 * on the beacon interval, which was not known when the station
+	 * interface was added.
 	 */
 	if (changes & BSS_CHANGED_ASSOC && bss_conf->assoc) {
 		if (vif->bss_conf.he_support &&
@@ -2505,8 +2505,9 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 		goto out_unlock;
 
 	/*
-	 * Re-calculate the tsf id, as the master-slave relations depend on the
-	 * beacon interval, which was not known when the AP interface was added.
+	 * Re-calculate the tsf id, as the leader-follower relations depend on
+	 * the beacon interval, which was not known when the AP interface
+	 * was added.
 	 */
 	if (vif->type == NL80211_IFTYPE_AP)
 		iwl_mvm_mac_ctxt_recalc_tsf_id(mvm, vif);
@@ -3122,7 +3123,7 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 		 * than 16. We can't avoid connecting at all, so refuse the
 		 * station state change, this will cause mac80211 to abandon
 		 * attempts to connect to this AP, and eventually wpa_s will
-		 * blacklist the AP...
+		 * blocklist the AP...
 		 */
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    vif->bss_conf.beacon_int < 16) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index ea10d6e906dc..3ec01a301857 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -572,7 +572,7 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 {
 	struct iwl_scan_offload_profile *profile;
 	struct iwl_scan_offload_profile_cfg_v1 *profile_cfg_v1;
-	struct iwl_scan_offload_blacklist *blacklist;
+	struct iwl_scan_offload_blocklist *blocklist;
 	struct iwl_scan_offload_profile_cfg_data *data;
 	int max_profiles = iwl_umac_scan_get_max_profiles(mvm->fw);
 	int profile_cfg_size = sizeof(*data) +
@@ -583,7 +583,7 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 		.dataflags[1] = IWL_HCMD_DFL_NOCOPY,
 	};
-	int blacklist_len;
+	int blocklist_len;
 	int i;
 	int ret;
 
@@ -591,22 +591,22 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 		return -EIO;
 
 	if (mvm->fw->ucode_capa.flags & IWL_UCODE_TLV_FLAGS_SHORT_BL)
-		blacklist_len = IWL_SCAN_SHORT_BLACKLIST_LEN;
+		blocklist_len = IWL_SCAN_SHORT_BLACKLIST_LEN;
 	else
-		blacklist_len = IWL_SCAN_MAX_BLACKLIST_LEN;
+		blocklist_len = IWL_SCAN_MAX_BLACKLIST_LEN;
 
-	blacklist = kcalloc(blacklist_len, sizeof(*blacklist), GFP_KERNEL);
-	if (!blacklist)
+	blocklist = kcalloc(blocklist_len, sizeof(*blocklist), GFP_KERNEL);
+	if (!blocklist)
 		return -ENOMEM;
 
 	profile_cfg_v1 = kzalloc(profile_cfg_size, GFP_KERNEL);
 	if (!profile_cfg_v1) {
 		ret = -ENOMEM;
-		goto free_blacklist;
+		goto free_blocklist;
 	}
 
-	cmd.data[0] = blacklist;
-	cmd.len[0] = sizeof(*blacklist) * blacklist_len;
+	cmd.data[0] = blocklist;
+	cmd.len[0] = sizeof(*blocklist) * blocklist_len;
 	cmd.data[1] = profile_cfg_v1;
 
 	/* if max_profile is MAX_PROFILES_V2, we have the new API */
@@ -619,7 +619,7 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 		data = &profile_cfg_v1->data;
 	}
 
-	/* No blacklist configuration */
+	/* No blocklist configuration */
 	data->num_profiles = req->n_match_sets;
 	data->active_clients = SCAN_CLIENT_SCHED_SCAN;
 	data->pass_match = SCAN_CLIENT_SCHED_SCAN;
@@ -643,8 +643,8 @@ iwl_mvm_config_sched_scan_profiles(struct iwl_mvm *mvm,
 
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
 	kfree(profile_cfg_v1);
-free_blacklist:
-	kfree(blacklist);
+free_blocklist:
+	kfree(blocklist);
 
 	return ret;
 }
-- 
2.29.2

