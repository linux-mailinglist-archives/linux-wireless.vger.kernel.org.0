Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625766B9D7E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjCNRvY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCNRvM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:51:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047CB1A41
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816245; x=1710352245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qABz0e4YrXsyPLRRCqH5Z8jqjsHE4Wzj15QWBYWHlJE=;
  b=GlANenfefBMmH3UjK5SWF9suZUFFdTHZMd5KdRT3CnrnKqvyjsNKAyTK
   A3SciNQgLqz+qQwPIfW8l7OVGOjWPhLeEUrX9WV5uMxtkAWKuYQQSjMaE
   2arvvKZNnr+fmx1imEt7Oq+pHXj6GfcO3+ld4MGbXT5HXLGyDNN6+4y5a
   diRBdF4MV/CHrbHqWBM79B9EyP1m5DfnEJaaE27yXwoQdK8JBB++keb0O
   FNS8h5C4DNULhwQQ5T6+6pXe2ummksId3f2YMD26jIGaVTtMg1U3g4dzl
   Vs0W6oIipUAPP2bGwjQheFK13NYimtI7KfBTKEZj/n3+HPME8XL51fgq9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149548"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149548"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200507"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200507"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/22] wifi: iwlwifi: mvm: add support for the new MAC CTXT command
Date:   Tue, 14 Mar 2023 19:49:18 +0200
Message-Id: <20230314194113.99a41a5bc55f.I310312c829f5f2f69b64fcddce487b1eab80165b@changeid>
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

As a part of the new MLD FW API changes, we have a new MAC CTXT command.
Add structures and enum definitions, along with the functions that
sends this command (i.e. add, remove and change mac ctxt).
This functions will be in used in the next patches.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 109 ++++++-
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  24 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   3 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  | 271 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  18 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 7 files changed, 411 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 712532f17630..f12b2a25cd3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019, 2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2021-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_mac_cfg_h__
 #define __iwl_fw_api_mac_cfg_h__
 
+#include "mac.h"
+
 /**
  * enum iwl_mac_conf_subcmd_ids - mac configuration command IDs
  */
@@ -31,7 +33,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @CANCEL_CHANNEL_SWITCH_CMD: &struct iwl_cancel_channel_switch_cmd
 	 */
 	CANCEL_CHANNEL_SWITCH_CMD = 0x6,
-
+	/**
+	 * @MAC_CONFIG_CMD: &struct iwl_mac_config_cmd
+	 */
+	MAC_CONFIG_CMD = 0x8,
 	/**
 	 * @SESSION_PROTECTION_NOTIF: &struct iwl_mvm_session_prot_notif
 	 */
@@ -182,4 +187,104 @@ struct iwl_mac_low_latency_cmd {
 	__le16 reserved;
 } __packed; /* MAC_LOW_LATENCY_API_S_VER_1 */
 
+/**
+ * struct iwl_mac_client_data - configuration data for client MAC context
+ *
+ * @is_assoc: 1 for associated state, 0 otherwise
+ * @assoc_id: unique ID assigned by the AP during association
+ * @data_policy: see &enum iwl_mac_data_policy
+ * @ctwin: client traffic window in TU (period after TBTT when GO is present).
+ *	0 indicates that there is no CT window.
+ */
+struct iwl_mac_client_data {
+	__le32 is_assoc;
+	__le32 assoc_id;
+	__le32 data_policy;
+	__le32 ctwin;
+} __packed; /* MAC_CONTEXT_CONFIG_CLIENT_DATA_API_S_VER_1 */
+
+/**
+ * struct iwl_mac_go_ibss_data - configuration data for GO and IBSS MAC context
+ *
+ * @beacon_template: beacon template ID
+ */
+struct iwl_mac_go_ibss_data {
+	__le32 beacon_template;
+} __packed; /* MAC_CONTEXT_CONFIG_GO_IBSS_DATA_API_S_VER_1 */
+
+/**
+ * struct iwl_mac_p2p_dev_data  - configuration data for P2P device MAC context
+ *
+ * @is_disc_extended: if set to true, P2P Device discoverability is enabled on
+ *	other channels as well. This should be to true only in case that the
+ *	device is discoverable and there is an active GO. Note that setting this
+ *	field when not needed, will increase the number of interrupts and have
+ *	effect on the platform power, as this setting opens the Rx filters on
+ *	all macs.
+ */
+struct iwl_mac_p2p_dev_data {
+	__le32 is_disc_extended;
+} __packed; /* MAC_CONTEXT_CONFIG_P2P_DEV_DATA_API_S_VER_1 */
+
+/**
+ * enum iwl_mac_config_filter_flags - MAC context configuration filter flags
+ *
+ * @MAC_CFG_FILTER_PROMISC: accept all data frames
+ * @MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT: pass all management and
+ *	control frames to the host
+ * @MAC_CFG_FILTER_ACCEPT_GRP: accept multicast frames
+ * @MAC_CFG_FILTER_ACCEPT_BEACON: accept beacon frames
+ * @MAC_CFG_FILTER_ACCEPT_BCAST_PROBE_RESP: accept broadcast probe response
+ * @MAC_CFG_FILTER_ACCEPT_PROBE_REQ: accept probe requests
+ */
+enum iwl_mac_config_filter_flags {
+	MAC_CFG_FILTER_PROMISC			= BIT(0),
+	MAC_CFG_FILTER_ACCEPT_CONTROL_AND_MGMT	= BIT(1),
+	MAC_CFG_FILTER_ACCEPT_GRP		= BIT(2),
+	MAC_CFG_FILTER_ACCEPT_BEACON		= BIT(3),
+	MAC_CFG_FILTER_ACCEPT_BCAST_PROBE_RESP	= BIT(4),
+	MAC_CFG_FILTER_ACCEPT_PROBE_REQ		= BIT(5),
+}; /* MAC_FILTER_FLAGS_MASK_E_VER_1 */
+
+/**
+ * struct iwl_mac_config_cmd - command structure to configure MAC contexts in
+ *	MLD API
+ * ( MAC_CONTEXT_CONFIG_CMD = 0x8 )
+ *
+ * @id_and_color: ID and color of the MAC
+ * @action: action to perform, one of FW_CTXT_ACTION_*
+ * @mac_type: one of &enum iwl_mac_types
+ * @local_mld_addr: mld address
+ * @reserved_for_local_mld_addr: reserved
+ * @filter_flags: combination of &enum iwl_mac_config_filter_flags
+ * @he_support: does this MAC support HE
+ * @eht_support: does this MAC support EHT. Requires he_support
+ * @nic_not_ack_enabled: mark that the NIC doesn't support receiving
+ *	ACK-enabled AGG, (i.e. both BACK and non-BACK frames in single AGG).
+ *	If the NIC is not ACK_ENABLED it may use the EOF-bit in first non-0
+ *	len delim to determine if AGG or single.
+ * @client: client mac data
+ * @go_ibss: mac data for go or ibss
+ * @p2p_dev: mac data for p2p device
+ */
+struct iwl_mac_config_cmd {
+	/* COMMON_INDEX_HDR_API_S_VER_1 */
+	__le32 id_and_color;
+	__le32 action;
+	/* MAC_CONTEXT_TYPE_API_E */
+	__le32 mac_type;
+	u8 local_mld_addr[6];
+	__le16 reserved_for_local_mld_addr;
+	__le32 filter_flags;
+	__le32 he_support;
+	__le32 eht_support;
+	__le32 nic_not_ack_enabled;
+	/* MAC_CONTEXT_CONFIG_SPECIFIC_DATA_API_U_VER_1 */
+	union {
+		struct iwl_mac_client_data client;
+		struct iwl_mac_go_ibss_data go_ibss;
+		struct iwl_mac_p2p_dev_data p2p_dev;
+	};
+} __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_mac_cfg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index b28fcf0cf9cf..d71f0a99b7c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -7,7 +7,7 @@ iwlmvm-y += power.o coex.o
 iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
 iwlmvm-y += rfi.o
-iwlmvm-y += mld-key.o
+iwlmvm-y += mld-key.o mld-mac.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index a30385b85a60..b21327ec4401 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -488,7 +488,7 @@ static void iwl_mvm_set_fw_qos_params(struct iwl_mvm *mvm,
 		*qos_flags |= cpu_to_le32(MAC_QOS_FLG_TGN);
 }
 
-static int iwl_mvm_get_mac_type(struct ieee80211_vif *vif)
+int iwl_mvm_get_mac_type(struct ieee80211_vif *vif)
 {
 	u32 mac_type = FW_MAC_TYPE_BSS_STA;
 
@@ -612,8 +612,8 @@ static void iwl_mvm_set_fw_dtim_tbtt(struct iwl_mvm *mvm,
 		       dtim_offs);
 }
 
-static __le32 iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(struct iwl_mvm *mvm,
-							   struct ieee80211_vif *vif)
+__le32 iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(struct iwl_mvm *mvm,
+						    struct ieee80211_vif *vif)
 {
 	struct ieee80211_p2p_noa_attr *noa =
 		&vif->bss_conf.p2p_noa_attr;
@@ -622,8 +622,8 @@ static __le32 iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(struct iwl_mvm *mvm,
 			IEEE80211_P2P_OPPPS_CTWINDOW_MASK);
 }
 
-static __le32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
-						      struct ieee80211_vif *vif)
+__le32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
+					       struct ieee80211_vif *vif)
 {
 	__le32 twt_policy = cpu_to_le32(0);
 
@@ -785,8 +785,8 @@ static void iwl_mvm_go_iterator(void *_data, u8 *mac, struct ieee80211_vif *vif)
 		data->go_active = true;
 }
 
-static __le32 iwl_mac_ctxt_p2p_dev_has_extended_disc(struct iwl_mvm *mvm,
-						     struct ieee80211_vif *vif)
+__le32 iwl_mac_ctxt_p2p_dev_has_extended_disc(struct iwl_mvm *mvm,
+					      struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_go_iterator_data data = {};
 
@@ -1167,11 +1167,11 @@ static void iwl_mvm_mac_ap_iterator(void *_data, u8 *mac,
 /*
  * Fill the filter flags for mac context of type AP or P2P GO.
  */
-static void iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(struct iwl_mvm *mvm,
-						     struct iwl_mvm_vif *mvmvif,
-						     __le32 *filter_flags,
-						     int accept_probe_req_flag,
-						     int accept_beacon_flag)
+void iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(struct iwl_mvm *mvm,
+					      struct iwl_mvm_vif *mvmvif,
+					      __le32 *filter_flags,
+					      int accept_probe_req_flag,
+					      int accept_beacon_flag)
 {
 	/*
 	 * in AP mode, pass probe requests and beacons from other APs
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b1f638af4b2c..210b134c735f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2032,8 +2032,7 @@ static bool iwl_mvm_set_fw_mu_edca_params(struct iwl_mvm *mvm,
 	return mu_edca_enabled;
 }
 
-static bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm,
-				       struct ieee80211_vif *vif)
+bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
 	const struct ieee80211_supported_band *sband;
 	const struct ieee80211_sta_he_cap *own_he_cap = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
new file mode 100644
index 000000000000..240f51d2fd53
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#include "mvm.h"
+
+static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    struct iwl_mac_config_cmd *cmd,
+					    u32 action)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	cmd->id_and_color = cpu_to_le32(mvmvif->id);
+	cmd->action = cpu_to_le32(action);
+
+	cmd->mac_type = cpu_to_le32(iwl_mvm_get_mac_type(vif));
+
+	memcpy(cmd->local_mld_addr, vif->addr, ETH_ALEN);
+
+	cmd->filter_flags = cpu_to_le32(0);
+	cmd->he_support = cpu_to_le32(0);
+	cmd->eht_support = cpu_to_le32(0);
+
+	cmd->nic_not_ack_enabled =
+		cpu_to_le32(!iwl_mvm_is_nic_ack_enabled(mvm, vif));
+
+	if (iwlwifi_mod_params.disable_11ax)
+		return;
+	cmd->he_support = cpu_to_le32(vif->bss_conf.he_support);
+
+	if (!iwlwifi_mod_params.disable_11be && cmd->he_support)
+		cmd->eht_support = cpu_to_le32(vif->bss_conf.eht_support);
+}
+
+static int iwl_mvm_mld_mac_ctxt_send_cmd(struct iwl_mvm *mvm,
+					 struct iwl_mac_config_cmd *cmd)
+{
+	int ret = iwl_mvm_send_cmd_pdu(mvm,
+				       WIDE_ID(MAC_CONF_GROUP, MAC_CONFIG_CMD),
+				       0, sizeof(*cmd), cmd);
+	if (ret)
+		IWL_ERR(mvm, "Failed to send MAC_CONFIG_CMD (action:%d): %d\n",
+			le32_to_cpu(cmd->action), ret);
+	return ret;
+}
+
+static int iwl_mvm_mld_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
+					struct ieee80211_vif *vif,
+					u32 action, bool force_assoc_off)
+{
+	struct iwl_mac_config_cmd cmd = {};
+
+	WARN_ON(vif->type != NL80211_IFTYPE_STATION);
+
+	/* Fill the common data for all mac context types */
+	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
+
+	/*
+	 * We always want to hear MCAST frames, if we're not authorized yet,
+	 * we'll drop them.
+	 */
+	cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_GRP);
+
+	if (vif->p2p)
+		cmd.client.ctwin =
+			iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(mvm, vif);
+
+	if (vif->cfg.assoc && vif->bss_conf.dtim_period &&
+	    !force_assoc_off) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+		cmd.client.is_assoc = cpu_to_le32(1);
+
+		if (!mvmvif->authorized &&
+		    fw_has_capa(&mvm->fw->ucode_capa,
+				IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO))
+			cmd.client.data_policy |=
+				cpu_to_le32(COEX_HIGH_PRIORITY_ENABLE);
+
+	} else {
+		cmd.client.is_assoc = cpu_to_le32(0);
+
+		/* Allow beacons to pass through as long as we are not
+		 * associated, or we do not have dtim period information.
+		 */
+		cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_BEACON);
+	}
+
+	cmd.client.assoc_id = cpu_to_le32(vif->cfg.aid);
+
+	if (vif->probe_req_reg && vif->cfg.assoc && vif->p2p)
+		cmd.filter_flags |= cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
+
+	if (vif->bss_conf.he_support && !iwlwifi_mod_params.disable_11ax)
+		cmd.client.data_policy |=
+			iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(mvm, vif);
+
+	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
+}
+
+static int iwl_mvm_mld_mac_ctxt_cmd_listener(struct iwl_mvm *mvm,
+					     struct ieee80211_vif *vif,
+					     u32 action)
+{
+	struct iwl_mac_config_cmd cmd = {};
+
+	WARN_ON(vif->type != NL80211_IFTYPE_MONITOR);
+
+	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
+
+	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_PROMISC |
+				       MAC_FILTER_IN_CONTROL_AND_MGMT |
+				       MAC_CFG_FILTER_ACCEPT_BEACON |
+				       MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
+				       MAC_CFG_FILTER_ACCEPT_GRP);
+
+	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
+}
+
+static int iwl_mvm_mld_mac_ctxt_cmd_ibss(struct iwl_mvm *mvm,
+					 struct ieee80211_vif *vif,
+					 u32 action)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mac_config_cmd cmd = {};
+
+	WARN_ON(vif->type != NL80211_IFTYPE_ADHOC);
+
+	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
+
+	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_ACCEPT_BEACON |
+				       MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
+				       MAC_CFG_FILTER_ACCEPT_GRP);
+
+	/* TODO: Assumes that the beacon id == mac context id */
+	cmd.go_ibss.beacon_template = cpu_to_le32(mvmvif->id);
+
+	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
+}
+
+static int iwl_mvm_mld_mac_ctxt_cmd_p2p_device(struct iwl_mvm *mvm,
+					       struct ieee80211_vif *vif,
+					       u32 action)
+{
+	struct iwl_mac_config_cmd cmd = {};
+
+	WARN_ON(vif->type != NL80211_IFTYPE_P2P_DEVICE);
+
+	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
+
+	cmd.p2p_dev.is_disc_extended =
+		iwl_mac_ctxt_p2p_dev_has_extended_disc(mvm, vif);
+
+	/* Override the filter flags to accept only probe requests */
+	cmd.filter_flags = cpu_to_le32(MAC_CFG_FILTER_ACCEPT_PROBE_REQ);
+
+	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
+}
+
+static int iwl_mvm_mld_mac_ctxt_cmd_ap_go(struct iwl_mvm *mvm,
+					  struct ieee80211_vif *vif,
+					  u32 action)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mac_config_cmd cmd = {};
+
+	WARN_ON(vif->type != NL80211_IFTYPE_AP);
+
+	/* Fill the common data for all mac context types */
+	iwl_mvm_mld_mac_ctxt_cmd_common(mvm, vif, &cmd, action);
+
+	iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(mvm, mvmvif,
+						 &cmd.filter_flags,
+						 MAC_CFG_FILTER_ACCEPT_PROBE_REQ,
+						 MAC_CFG_FILTER_ACCEPT_BEACON);
+
+	/* TODO: Assume that the beacon id == mac context id */
+	cmd.go_ibss.beacon_template = cpu_to_le32(mvmvif->id);
+
+	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
+}
+
+static int iwl_mvm_mld_mac_ctx_send(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    u32 action, bool force_assoc_off)
+{
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		return iwl_mvm_mld_mac_ctxt_cmd_sta(mvm, vif, action,
+						    force_assoc_off);
+	case NL80211_IFTYPE_AP:
+		return iwl_mvm_mld_mac_ctxt_cmd_ap_go(mvm, vif, action);
+	case NL80211_IFTYPE_MONITOR:
+		return iwl_mvm_mld_mac_ctxt_cmd_listener(mvm, vif, action);
+	case NL80211_IFTYPE_P2P_DEVICE:
+		return iwl_mvm_mld_mac_ctxt_cmd_p2p_device(mvm, vif, action);
+	case NL80211_IFTYPE_ADHOC:
+		return iwl_mvm_mld_mac_ctxt_cmd_ibss(mvm, vif, action);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+int iwl_mvm_mld_mac_ctxt_add(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	int ret;
+
+	if (WARN_ON_ONCE(vif->type == NL80211_IFTYPE_NAN))
+		return -EOPNOTSUPP;
+
+	if (WARN_ONCE(mvmvif->uploaded, "Adding active MAC %pM/%d\n",
+		      vif->addr, ieee80211_vif_type_p2p(vif)))
+		return -EIO;
+
+	ret = iwl_mvm_mld_mac_ctx_send(mvm, vif, FW_CTXT_ACTION_ADD,
+				       true);
+	if (ret)
+		return ret;
+
+	/* will only do anything at resume from D3 time */
+	iwl_mvm_set_last_nonqos_seq(mvm, vif);
+
+	mvmvif->uploaded = true;
+	return 0;
+}
+
+int iwl_mvm_mld_mac_ctxt_changed(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 bool force_assoc_off)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (WARN_ON_ONCE(vif->type == NL80211_IFTYPE_NAN))
+		return -EOPNOTSUPP;
+
+	if (WARN_ONCE(!mvmvif->uploaded, "Changing inactive MAC %pM/%d\n",
+		      vif->addr, ieee80211_vif_type_p2p(vif)))
+		return -EIO;
+
+	return iwl_mvm_mld_mac_ctx_send(mvm, vif, FW_CTXT_ACTION_MODIFY,
+					force_assoc_off);
+}
+
+int iwl_mvm_mld_mac_ctxt_remove(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mac_config_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.id_and_color = cpu_to_le32(mvmvif->id),
+	};
+	int ret;
+
+	if (WARN_ON_ONCE(vif->type == NL80211_IFTYPE_NAN))
+		return -EOPNOTSUPP;
+
+	if (WARN_ONCE(!mvmvif->uploaded, "Removing inactive MAC %pM/%d\n",
+		      vif->addr, ieee80211_vif_type_p2p(vif)))
+		return -EIO;
+
+	ret = iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
+	if (ret)
+		return ret;
+
+	mvmvif->uploaded = false;
+
+	return 0;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 301f39d9efe7..72f429537572 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1477,6 +1477,7 @@ void iwl_mvm_hwrate_to_tx_rate_v1(u32 rate_n_flags,
 				  struct ieee80211_tx_rate *r);
 u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx);
 u8 iwl_mvm_mac80211_ac_to_ucode_ac(enum ieee80211_ac_numbers ac);
+bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 
 static inline void iwl_mvm_dump_nic_error_log(struct iwl_mvm *mvm)
 {
@@ -1638,6 +1639,23 @@ u8 iwl_mvm_get_channel_width(struct cfg80211_chan_def *chandef);
 u8 iwl_mvm_get_ctrl_pos(struct cfg80211_chan_def *chandef);
 
 /* MAC (virtual interface) programming */
+
+__le32 iwl_mac_ctxt_p2p_dev_has_extended_disc(struct iwl_mvm *mvm,
+					      struct ieee80211_vif *vif);
+void iwl_mvm_mac_ctxt_cmd_ap_set_filter_flags(struct iwl_mvm *mvm,
+					      struct iwl_mvm_vif *mvmvif,
+					      __le32 *filter_flags,
+					      int accept_probe_req_flag,
+					      int accept_beacon_flag);
+int iwl_mvm_get_mac_type(struct ieee80211_vif *vif);
+__le32 iwl_mvm_mac_ctxt_cmd_p2p_sta_get_oppps_ctwin(struct iwl_mvm *mvm,
+						    struct ieee80211_vif *vif);
+__le32 iwl_mvm_mac_ctxt_cmd_sta_get_twt_policy(struct iwl_mvm *mvm,
+					       struct ieee80211_vif *vif);
+int iwl_mvm_mld_mac_ctxt_add(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
+int iwl_mvm_mld_mac_ctxt_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+				 bool force_assoc_off);
+int iwl_mvm_mld_mac_ctxt_remove(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mac_ctxt_init(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mac_ctxt_add(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 int iwl_mvm_mac_ctxt_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f4e9446d9dc2..69c390ff2745 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -521,6 +521,7 @@ static const struct iwl_hcmd_names iwl_mvm_system_names[] = {
 static const struct iwl_hcmd_names iwl_mvm_mac_conf_names[] = {
 	HCMD_NAME(CHANNEL_SWITCH_TIME_EVENT_CMD),
 	HCMD_NAME(SESSION_PROTECTION_CMD),
+	HCMD_NAME(MAC_CONFIG_CMD),
 	HCMD_NAME(SESSION_PROTECTION_NOTIF),
 	HCMD_NAME(CHANNEL_SWITCH_START_NOTIF),
 };
-- 
2.38.1

