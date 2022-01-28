Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6807849FACC
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348914AbiA1Neo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37850 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348902AbiA1Neo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:44 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROi-0002DK-AX;
        Fri, 28 Jan 2022 15:34:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:25 +0200
Message-Id: <iwlwifi.20220128153014.c4ac213cef5c.I6fd9a4fcbcf16ef3a3ae20a2b08ee54ebe06f96f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/13] iwlwifi: make iwl_fw_lookup_cmd_ver() take a cmd_id
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Instead of taking the group/command separately, make the function
take a combined command ID. In many cases, this allows us to pass
an existing command ID (e.g. cmd.id), or introduce a new variable
for it, so that we don't use the command ID twice.

This way, we can also use LONG_GROUP implicitly, so we don't need
to spell that out for many commands.

Apart from mvm.h, fw/img.{c,h} changes and some copyright and
indentation updates, this was done with spatch:

    @@
    identifier cmd;
    expression fw, G, C, def;
    @@
     struct iwl_host_cmd cmd = {
      .id = WIDE_ID(G, C),
    ...
     };
    ...
    -iwl_fw_lookup_cmd_ver(fw, G, C, def)
    +iwl_fw_lookup_cmd_ver(fw, cmd.id, def)

    @@
    identifier cmd;
    expression fw, C, def;
    @@
     struct iwl_host_cmd cmd = {
      .id = C,
    ...
     };
    ...
    -iwl_fw_lookup_cmd_ver(fw, \(IWL_ALWAYS_LONG_GROUP\|LONG_GROUP\), C, def)
    +iwl_fw_lookup_cmd_ver(fw, cmd.id, def)

    @@
    identifier func;
    expression fw, G, C, mvm, flags, cmd, size, def;
    type rettype;
    @@
    rettype func(...)
    {
    +u32 cmd_id = WIDE_ID(G, C);
    ...
    -iwl_fw_lookup_cmd_ver(fw, G, C, def)
    +iwl_fw_lookup_cmd_ver(fw, cmd_id, def)
    ...
    -iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(G, C), flags, cmd, size)
    +iwl_mvm_send_cmd_pdu(mvm, cmd_id, flags, cmd, size)
    ...
    }

    @@
    identifier func;
    expression fw, G, C, mvm, flags, cmd, size, def;
    type rettype;
    @@
    rettype func(...)
    {
    +u32 cmd_id = C;
    ...
    -iwl_fw_lookup_cmd_ver(fw, \(IWL_ALWAYS_LONG_GROUP\|LONG_GROUP\), C, def)
    +iwl_fw_lookup_cmd_ver(fw, cmd_id, def)
    ...
    -iwl_mvm_send_cmd_pdu(mvm, C, flags, cmd, size)
    +iwl_mvm_send_cmd_pdu(mvm, cmd_id, flags, cmd, size)
    ...
    }

    @@
    expression fw, C, def;
    @@
    -iwl_fw_lookup_cmd_ver(fw, \(IWL_ALWAYS_LONG_GROUP\|LONG_GROUP\), C, def)
    +iwl_fw_lookup_cmd_ver(fw, C, def)

    @@
    expression fw, C, G, def;
    @@
    -iwl_fw_lookup_cmd_ver(fw, G, C, def)
    +iwl_fw_lookup_cmd_ver(fw, WIDE_ID(G, C), def)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |  7 ++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 19 +++----
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  8 +--
 .../intel/iwlwifi/mvm/ftm-responder.c         | 18 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 54 ++++++++-----------
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 13 ++---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 18 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 .../wireless/intel/iwlwifi/mvm/offloading.c   |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 12 ++---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 11 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 22 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  6 +--
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  3 +-
 19 files changed, 88 insertions(+), 125 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
index 530674a35eeb..b7deca05a953 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -2,13 +2,16 @@
 /*
  * Copyright(c) 2019 - 2021 Intel Corporation
  */
-
+#include <fw/api/commands.h>
 #include "img.h"
 
-u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def)
+u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u32 cmd_id, u8 def)
 {
 	const struct iwl_fw_cmd_version *entry;
 	unsigned int i;
+	/* prior to LONG_GROUP, we never used this CMD version API */
+	u8 grp = iwl_cmd_groupid(cmd_id) ?: LONG_GROUP;
+	u8 cmd = iwl_cmd_opcode(cmd_id);
 
 	if (!fw->ucode_capa.cmd_versions ||
 	    !fw->ucode_capa.n_cmd_versions)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index fa7b1780064c..89869edb23e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -275,7 +275,7 @@ iwl_get_ucode_image(const struct iwl_fw *fw, enum iwl_ucode_type ucode_type)
 	return &fw->img[ucode_type];
 }
 
-u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
+u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u32 cmd_id, u8 def);
 
 u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
 const char *iwl_fw_lookup_assert_desc(u32 num);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index a914f77aae30..135bd48bfe9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -87,8 +87,7 @@ int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt)
 		cmd.flags |= le32_encode_bits(fwrt->trans->trans_cfg->ltr_delay,
 					      SOC_FLAGS_LTR_APPLY_DELAY_MASK);
 
-	if (iwl_fw_lookup_cmd_ver(fwrt->fw, IWL_ALWAYS_LONG_GROUP,
-				  SCAN_REQ_UMAC,
+	if (iwl_fw_lookup_cmd_ver(fwrt->fw, SCAN_REQ_UMAC,
 				  IWL_FW_CMD_VER_UNKNOWN) >= 2 &&
 	    fwrt->trans->trans_cfg->low_latency_xtal)
 		cmd.flags |= cpu_to_le32(SOC_CONFIG_CMD_FLAGS_LOW_LATENCY);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index b400867e94f0..a46365a5a9a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -453,8 +453,7 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					WOWLAN_TSC_RSC_PARAM,
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_TSC_RSC_PARAM,
 					IWL_FW_CMD_VER_UNKNOWN);
 	int ret;
 
@@ -672,8 +671,7 @@ static int iwl_mvm_send_patterns(struct iwl_mvm *mvm,
 		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
 	};
 	int i, err;
-	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					WOWLAN_PATTERNS,
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd.id,
 					IWL_FW_CMD_VER_UNKNOWN);
 
 	if (!wowlan->n_patterns)
@@ -921,8 +919,7 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 	wowlan_config_cmd->flags = ENABLE_L3_FILTERING |
 		ENABLE_NBNS_FILTERING | ENABLE_DHCP_FILTERING;
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-				  WOWLAN_CONFIGURATION, 0) < 6) {
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_CONFIGURATION, 0) < 6) {
 		/* Query the last used seqno and set it */
 		int ret = iwl_mvm_get_last_nonqos_seq(mvm, vif);
 
@@ -1017,8 +1014,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 
 	if (!fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_TKIP_MIC_KEYS)) {
-		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-						WOWLAN_TKIP_PARAM,
+		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_TKIP_PARAM,
 						IWL_FW_CMD_VER_UNKNOWN);
 		struct wowlan_key_tkip_data tkip_data = {};
 		int size;
@@ -1058,7 +1054,6 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		};
 
 		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-						IWL_ALWAYS_LONG_GROUP,
 						WOWLAN_KEK_KCK_MATERIAL,
 						IWL_FW_CMD_VER_UNKNOWN);
 		if (WARN_ON(cmd_ver != 2 && cmd_ver != 3 && cmd_ver != 4 &&
@@ -2074,8 +2069,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 	};
 	int ret, len;
 	u8 notif_ver;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   WOWLAN_GET_STATUSES,
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd.id,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
 	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN)
@@ -2182,8 +2176,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 static struct iwl_wowlan_status_data *
 iwl_mvm_get_wakeup_status(struct iwl_mvm *mvm, u8 sta_id)
 {
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   OFFLOADS_QUERY_CMD,
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, OFFLOADS_QUERY_CMD,
 					   IWL_FW_CMD_VER_UNKNOWN);
 	__le32 station_id = cpu_to_le32(sta_id);
 	u32 cmd_size = cmd_ver != IWL_FW_CMD_VER_UNKNOWN ? sizeof(station_id) : 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 5c1a89969c8c..430044bc4755 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -346,8 +346,8 @@ iwl_mvm_ftm_target_chandef_v2(struct iwl_mvm *mvm,
 		*format_bw |= IWL_LOCATION_BW_80MHZ << LOCATION_BW_POS;
 		break;
 	case NL80211_CHAN_WIDTH_160:
-		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-						TOF_RANGE_REQ_CMD,
+		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+						WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 						IWL_FW_CMD_VER_UNKNOWN);
 
 		if (cmd_ver >= 13) {
@@ -877,8 +877,8 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return -EBUSY;
 
 	if (new_api) {
-		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-						   TOF_RANGE_REQ_CMD,
+		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+						   WIDE_ID(LOCATION_GROUP, TOF_RANGE_REQ_CMD),
 						   IWL_FW_CMD_VER_UNKNOWN);
 
 		switch (cmd_ver) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 0b5f80f73c5d..9729680476fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -106,6 +106,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 			  struct ieee80211_vif *vif,
 			  struct cfg80211_chan_def *chandef)
 {
+	u32 cmd_id = WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_CONFIG_CMD);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	/*
 	 * The command structure is the same for versions 6, 7 and 8 (only the
@@ -120,8 +121,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 				    IWL_TOF_RESPONDER_CMD_VALID_STA_ID),
 		.sta_id = mvmvif->bcast_sta.sta_id,
 	};
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-					   TOF_RESPONDER_CONFIG_CMD, 6);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id, 6);
 	int err;
 	int cmd_size;
 
@@ -161,9 +161,7 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 
 	memcpy(cmd.bssid, vif->addr, ETH_ALEN);
 
-	return iwl_mvm_send_cmd_pdu(mvm,
-				    WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_CONFIG_CMD),
-				    0, cmd_size, &cmd);
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, cmd_size, &cmd);
 }
 
 static int
@@ -276,8 +274,9 @@ iwl_mvm_ftm_responder_dyn_cfg_cmd(struct iwl_mvm *mvm,
 				  struct ieee80211_ftm_responder_params *params)
 {
 	int ret;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-					   TOF_RESPONDER_DYN_CONFIG_CMD, 2);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_DYN_CONFIG_CMD),
+					   2);
 
 	switch (cmd_ver) {
 	case 2:
@@ -318,8 +317,9 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 		.addr = addr,
 		.hltk = hltk,
 	};
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-					   TOF_RESPONDER_DYN_CONFIG_CMD, 2);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					   WIDE_ID(LOCATION_GROUP, TOF_RESPONDER_DYN_CONFIG_CMD),
+					   2);
 
 	lockdep_assert_held(&mvm->mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 61741f07dd7f..dde979b34533 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -546,8 +546,7 @@ static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
 		return 0;
 	}
 
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, REGULATORY_AND_NVM_GROUP,
-					SAR_OFFSET_MAPPING_TABLE_CMD,
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd.id,
 					IWL_FW_CMD_VER_UNKNOWN);
 
 	if (cmd_ver != 2) {
@@ -572,6 +571,7 @@ static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
 
 static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 {
+	u32 cmd_id = PHY_CONFIGURATION_CMD;
 	struct iwl_phy_cfg_cmd_v3 phy_cfg_cmd;
 	enum iwl_ucode_type ucode_type = mvm->fwrt.cur_fw_img;
 	struct iwl_phy_specific_cfg phy_filters = {};
@@ -603,8 +603,7 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	phy_cfg_cmd.calib_control.flow_trigger =
 		mvm->fw->default_calib[ucode_type].flow_trigger;
 
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					PHY_CONFIGURATION_CMD,
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 3) {
 		iwl_mvm_phy_filter_init(mvm, &phy_filters);
@@ -616,8 +615,7 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 		       phy_cfg_cmd.phy_cfg);
 	cmd_size = (cmd_ver == 3) ? sizeof(struct iwl_phy_cfg_cmd_v3) :
 				    sizeof(struct iwl_phy_cfg_cmd_v1);
-	return iwl_mvm_send_cmd_pdu(mvm, PHY_CONFIGURATION_CMD, 0,
-				    cmd_size, &phy_cfg_cmd);
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, cmd_size, &phy_cfg_cmd);
 }
 
 int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm)
@@ -760,6 +758,7 @@ static int iwl_mvm_config_ltr(struct iwl_mvm *mvm)
 #ifdef CONFIG_ACPI
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 {
+	u32 cmd_id = REDUCE_TX_POWER_CMD;
 	struct iwl_dev_tx_power_cmd cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_CHAINS),
 	};
@@ -767,8 +766,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	int ret;
 	u16 len = 0;
 	u32 n_subbands;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   REDUCE_TX_POWER_CMD,
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
 	if (cmd_ver == 6) {
@@ -805,7 +803,7 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	iwl_mei_set_power_limit(per_chain);
 
 	IWL_DEBUG_RADIO(mvm, "Sending REDUCE_TX_POWER_CMD per chain\n");
-	return iwl_mvm_send_cmd_pdu(mvm, REDUCE_TX_POWER_CMD, 0, len, &cmd);
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
@@ -819,8 +817,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 		.flags = CMD_WANT_SKB,
 		.data = { &geo_tx_cmd },
 	};
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
-					   PER_CHAIN_LIMIT_OFFSET_CMD,
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd.id,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
 	/* the ops field is at the same spot for all versions, so set in v1 */
@@ -862,14 +859,14 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 
 static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 {
+	u32 cmd_id = WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD);
 	union iwl_geo_tx_power_profiles_cmd cmd;
 	u16 len;
 	u32 n_bands;
 	u32 n_profiles;
 	u32 sk = 0;
 	int ret;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
-					   PER_CHAIN_LIMIT_OFFSET_CMD,
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
 	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v1, ops) !=
@@ -947,10 +944,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 			    IWL_UCODE_TLV_API_SAR_TABLE_VER))
 		cmd.v2.table_revision = cpu_to_le32(sk);
 
-	return iwl_mvm_send_cmd_pdu(mvm,
-				    WIDE_ID(PHY_OPS_GROUP,
-					    PER_CHAIN_LIMIT_OFFSET_CMD),
-				    0, len, &cmd);
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
 static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
@@ -1069,8 +1063,8 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	 * use v1 to access it.
 	 */
 	cmd.v1.flags = cpu_to_le32(mvm->fwrt.ppag_flags);
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
-					PER_PLATFORM_ANT_GAIN_CMD,
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					WIDE_ID(PHY_OPS_GROUP, PER_PLATFORM_ANT_GAIN_CMD),
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 1) {
 		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
@@ -1204,6 +1198,7 @@ static bool iwl_mvm_add_to_tas_block_list(__le32 *list, __le32 *le_size, unsigne
 
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
+	u32 cmd_id = WIDE_ID(REGULATORY_AND_NVM_GROUP, TAS_CONFIG);
 	int ret;
 	union iwl_tas_config_cmd cmd = {};
 	int cmd_size, fw_ver;
@@ -1216,8 +1211,8 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		return;
 	}
 
-	fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, REGULATORY_AND_NVM_GROUP,
-				       TAS_CONFIG, IWL_FW_CMD_VER_UNKNOWN);
+	fw_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
+				       IWL_FW_CMD_VER_UNKNOWN);
 
 	ret = iwl_acpi_get_tas(&mvm->fwrt, &cmd, fw_ver);
 	if (ret < 0) {
@@ -1251,9 +1246,7 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 		sizeof(struct iwl_tas_config_cmd_v2) :
 		sizeof(struct iwl_tas_config_cmd_v3);
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(REGULATORY_AND_NVM_GROUP,
-						TAS_CONFIG),
-				   0, cmd_size, &cmd);
+	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, cmd_size, &cmd);
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
@@ -1320,8 +1313,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	    cmd.chan_state_active_bitmap) {
 		size_t cmd_size;
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-						   REGULATORY_AND_NVM_GROUP,
-						   LARI_CONFIG_CHANGE, 1);
+						   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+							   LARI_CONFIG_CHANGE),
+						   1);
 		if (cmd_ver == 5)
 			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v5);
 		else if (cmd_ver == 4)
@@ -1644,9 +1638,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	 * internal aux station for all aux activities that don't
 	 * requires a dedicated data queue.
 	 */
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-				  ADD_STA,
-				  0) < 12) {
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
 		 /*
 		  * In old version the aux station uses mac id like other
 		  * station and not lmac id
@@ -1803,9 +1795,7 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm)
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++)
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[i], NULL);
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-				  ADD_STA,
-				  0) < 12) {
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
 		/*
 		 * Add auxiliary station for scanning.
 		 * Newer versions of this command implies that the fw uses
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index bcce3c1c5feb..5aa4520b70ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -821,10 +821,7 @@ u8 iwl_mvm_mac_ctxt_get_lowest_rate(struct ieee80211_tx_info *info,
 u16 iwl_mvm_mac_ctxt_get_beacon_flags(const struct iwl_fw *fw, u8 rate_idx)
 {
 	u16 flags = iwl_mvm_mac80211_idx_to_hwrate(fw, rate_idx);
-	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw,
-						 LONG_GROUP,
-						 BEACON_TEMPLATE_CMD,
-						 0) > 10;
+	bool is_new_rate = iwl_fw_lookup_cmd_ver(fw, BEACON_TEMPLATE_CMD, 0) > 10;
 
 	if (rate_idx <= IWL_FIRST_CCK_RATE)
 		flags |= is_new_rate ? IWL_MAC_BEACON_CCK
@@ -960,8 +957,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	WARN_ON(channel == 0);
 	if (cfg80211_channel_is_psc(ctx->def.chan) &&
 	    !IWL_MVM_DISABLE_AP_FILS) {
-		flags |= iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					       BEACON_TEMPLATE_CMD,
+		flags |= iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD,
 					       0) > 10 ?
 			IWL_MAC_BEACON_FILS :
 			IWL_MAC_BEACON_FILS_V1;
@@ -1458,8 +1454,9 @@ void iwl_mvm_rx_stored_beacon_notif(struct iwl_mvm *mvm,
 	struct sk_buff *skb;
 	u8 *data;
 	u32 size = le32_to_cpu(sb->byte_count);
-	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, PROT_OFFLOAD_GROUP,
-					STORED_BEACON_NTF, 0);
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					WIDE_ID(PROT_OFFLOAD_GROUP, STORED_BEACON_NTF),
+					0);
 
 	if (size == 0)
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 0e06454c1404..c1dfc4702b5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -627,8 +627,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 			IWL_UCODE_TLV_CAPA_WFA_TPC_REP_IE_SUPPORT))
 		hw->wiphy->features |= NL80211_FEATURE_WFA_TPC_IE_IN_PROBES;
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-				  WOWLAN_KEK_KCK_MATERIAL,
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WOWLAN_KEK_KCK_MATERIAL,
 				  IWL_FW_CMD_VER_UNKNOWN) == 3)
 		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK;
 
@@ -641,9 +640,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	}
 
 	if (iwl_mvm_is_oce_supported(mvm)) {
-		u8 scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-						    IWL_ALWAYS_LONG_GROUP,
-						    SCAN_REQ_UMAC, 0);
+		u8 scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, SCAN_REQ_UMAC, 0);
 
 		wiphy_ext_feature_set(hw->wiphy,
 			NL80211_EXT_FEATURE_ACCEPT_BCAST_PROBE_RESP);
@@ -1233,7 +1230,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 
 	/* async_handlers_wk is now blocked */
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP, ADD_STA, 0) < 12)
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12)
 		iwl_mvm_rm_aux_sta(mvm);
 
 	iwl_mvm_stop_device(mvm);
@@ -1325,6 +1322,7 @@ static struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm)
 static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				s16 tx_power)
 {
+	u32 cmd_id = REDUCE_TX_POWER_CMD;
 	int len;
 	struct iwl_dev_tx_power_cmd cmd = {
 		.common.set_mode = cpu_to_le32(IWL_TX_POWER_MODE_SET_MAC),
@@ -1332,8 +1330,7 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			cpu_to_le32(iwl_mvm_vif_from_mac80211(vif)->id),
 		.common.pwr_restriction = cpu_to_le16(8 * tx_power),
 	};
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   REDUCE_TX_POWER_CMD,
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
 	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
@@ -1353,7 +1350,7 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	/* all structs have the same common part, add it */
 	len += sizeof(cmd.common);
 
-	return iwl_mvm_send_cmd_pdu(mvm, REDUCE_TX_POWER_CMD, 0, len, &cmd);
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
 static int iwl_mvm_post_channel_switch(struct ieee80211_hw *hw,
@@ -4050,8 +4047,7 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		if (fw_has_capa(&mvm->fw->ucode_capa,
 				IWL_UCODE_TLV_CAPA_HOTSPOT_SUPPORT)) {
 			/* Use aux roc framework (HS20) */
-			if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-						  ADD_STA, 0) >= 12) {
+			if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12) {
 				u32 lmac_id;
 
 				lmac_id = iwl_mvm_get_lmac_id(mvm->fw,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 8a0e17adcb56..250effb8ed87 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2174,8 +2174,7 @@ iwl_mvm_set_chan_info_chandef(struct iwl_mvm *mvm,
 
 static inline int iwl_umac_scan_get_max_profiles(const struct iwl_fw *fw)
 {
-	u8 ver = iwl_fw_lookup_cmd_ver(fw, IWL_ALWAYS_LONG_GROUP,
-				       SCAN_OFFLOAD_UPDATE_PROFILES_CMD,
+	u8 ver = iwl_fw_lookup_cmd_ver(fw, SCAN_OFFLOAD_UPDATE_PROFILES_CMD,
 				       IWL_FW_CMD_VER_UNKNOWN);
 	return (ver == IWL_FW_CMD_VER_UNKNOWN || ver < 3) ?
 		IWL_SCAN_MAX_PROFILES : IWL_SCAN_MAX_PROFILES_V2;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
index 41880517e8bb..c7dabc6b3765 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/offloading.c
@@ -47,8 +47,7 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 	struct iwl_proto_offload_cmd_common *common;
 	u32 enabled = 0, size;
 	u32 capa_flags = mvm->fw->ucode_capa.flags;
-	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					PROT_OFFLOAD_CONFIG_CMD, 0);
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, hcmd.id, 0);
 
 #if IS_ENABLED(CONFIG_IPV6)
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 9af40b0fa37a..24d86ca15850 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -158,8 +158,7 @@ static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
 
 	/* we only support RLC command version 2 */
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
-				  RLC_CONFIG_CMD, 0) < 2)
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP, RLC_CONFIG_CMD), 0) < 2)
 		iwl_mvm_phy_ctxt_set_rxchain(mvm, ctxt, &cmd->rxchain_info,
 					     chains_static, chains_dynamic);
 }
@@ -172,8 +171,7 @@ static int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm,
 		.phy_id = cpu_to_le32(ctxt->id),
 	};
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
-				  RLC_CONFIG_CMD, 0) < 2)
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP, RLC_CONFIG_CMD), 0) < 2)
 		return 0;
 
 	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_DRIVER_FORCE !=
@@ -209,8 +207,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 				  u32 action)
 {
 	int ret;
-	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					PHY_CONTEXT_CMD, 1);
+	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1);
 
 	if (ver == 3 || ver == 4) {
 		struct iwl_phy_context_cmd cmd = {};
@@ -301,8 +298,7 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
-				  RLC_CONFIG_CMD, 0) >= 2 &&
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, WIDE_ID(DATA_PATH_GROUP, RLC_CONFIG_CMD), 0) >= 2 &&
 	    ctxt->channel == chandef->chan &&
 	    ctxt->width == chandef->width &&
 	    ctxt->center_freq1 == chandef->center_freq1)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index be42490d3ad5..0611874aa24b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -449,8 +449,10 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	 */
 	sta->max_amsdu_len = max_amsdu_len;
 
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
-					TLC_MNG_CONFIG_CMD, 0);
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					WIDE_ID(DATA_PATH_GROUP,
+						TLC_MNG_CONFIG_CMD),
+					0);
 	if (cmd_ver == 4) {
 		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC,
 					   sizeof(cfg_cmd), &cfg_cmd);
@@ -474,8 +476,9 @@ void rs_fw_rate_init(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		u16 cmd_size = sizeof(cfg_cmd_v3);
 
 		/* In old versions of the API the struct is 4 bytes smaller */
-		if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
-					  TLC_MNG_CONFIG_CMD, 0) < 3)
+		if (iwl_fw_lookup_cmd_ver(mvm->fw,
+					  WIDE_ID(DATA_PATH_GROUP,
+						  TLC_MNG_CONFIG_CMD), 0) < 3)
 			cmd_size -= 4;
 
 		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, CMD_ASYNC, cmd_size,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index c0b7e451def1..ce7afca36bbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -651,9 +651,7 @@ static void iwl_mvm_scan_fill_tx_cmd(struct iwl_mvm *mvm,
 							   NL80211_BAND_2GHZ,
 							   no_cck);
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-				  ADD_STA,
-				  0) < 12) {
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
 		tx_cmd[0].sta_id = mvm->aux_sta.sta_id;
 		tx_cmd[1].sta_id = mvm->aux_sta.sta_id;
 
@@ -1090,8 +1088,7 @@ static void iwl_mvm_fill_scan_config_v1(struct iwl_mvm *mvm, void *config,
 	memcpy(&cfg->mac_addr, &mvm->addresses[0].addr, ETH_ALEN);
 
 	/* This function should not be called when using ADD_STA ver >=12 */
-	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   ADD_STA, 0) >= 12);
+	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12);
 
 	cfg->bcast_sta_id = mvm->aux_sta.sta_id;
 	cfg->channel_flags = channel_flags;
@@ -1142,8 +1139,7 @@ static void iwl_mvm_fill_scan_config_v2(struct iwl_mvm *mvm, void *config,
 	memcpy(&cfg->mac_addr, &mvm->addresses[0].addr, ETH_ALEN);
 
 	/* This function should not be called when using ADD_STA ver >=12 */
-	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   ADD_STA, 0) >= 12);
+	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12);
 
 	cfg->bcast_sta_id = mvm->aux_sta.sta_id;
 	cfg->channel_flags = channel_flags;
@@ -1258,11 +1254,9 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 
 	memset(&cfg, 0, sizeof(cfg));
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-				  ADD_STA, 0) < 12) {
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
 		cfg.bcast_sta_id = mvm->aux_sta.sta_id;
-	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					 SCAN_CFG_CMD, 0) < 5) {
+	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, SCAN_CFG_CMD, 0) < 5) {
 		/*
 		 * Fw doesn't use this sta anymore. Deprecated on SCAN_CFG_CMD
 		 * version 5.
@@ -2590,8 +2584,7 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 
 	hcmd->id = WIDE_ID(IWL_ALWAYS_LONG_GROUP, SCAN_REQ_UMAC);
 
-	scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					 SCAN_REQ_UMAC,
+	scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, SCAN_REQ_UMAC,
 					 IWL_FW_CMD_VER_UNKNOWN);
 
 	for (i = 0; i < ARRAY_SIZE(iwl_scan_umac_handlers); i++) {
@@ -2977,8 +2970,7 @@ static int iwl_scan_req_umac_get_size(u8 scan_ver)
 int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 {
 	int base_size, tail_size;
-	u8 scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					    SCAN_REQ_UMAC,
+	u8 scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, SCAN_REQ_UMAC,
 					    IWL_FW_CMD_VER_UNKNOWN);
 
 	base_size = iwl_scan_req_umac_get_size(scan_ver);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 6ced0c084ab9..1e08b7ffb79a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1516,8 +1516,7 @@ static int iwl_mvm_add_int_sta_common(struct iwl_mvm *mvm,
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.sta_id = sta->sta_id;
 
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP, ADD_STA,
-				  0) >= 12 &&
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12 &&
 	    sta->type == IWL_STA_AUX_ACTIVITY)
 		cmd.mac_id_n_color = cpu_to_le32(mac_id);
 	else
@@ -3238,8 +3237,7 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	int i, size;
 	bool new_api = fw_has_api(&mvm->fw->ucode_capa,
 				  IWL_UCODE_TLV_API_TKIP_MIC_KEYS);
-	int api_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					    ADD_STA_KEY,
+	int api_ver = iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA_KEY,
 					    new_api ? 2 : 1);
 
 	if (sta_id == IWL_MVM_INVALID_STA)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 49260a5f774b..6edf2b79db43 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -97,8 +97,7 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 		/* In newer version of this command an aux station is added only
 		 * in cases of dedicated tx queue and need to be removed in end
 		 * of use */
-		if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					  ADD_STA, 0) >= 12)
+		if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) >= 12)
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 398390c59344..9409ef7aee83 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2019-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2016 Intel Deutschland GmbH
  */
@@ -240,8 +240,8 @@ int iwl_mvm_get_temp(struct iwl_mvm *mvm, s32 *temp)
 	 * a response. For older versions we send the command and wait for a
 	 * notification (no command TLV for previous versions).
 	 */
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
-					CMD_DTS_MEASUREMENT_TRIGGER_WIDE,
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+					WIDE_ID(PHY_OPS_GROUP, CMD_DTS_MEASUREMENT_TRIGGER_WIDE),
 					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 1)
 		return iwl_mvm_send_temp_cmd(mvm, true, temp);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6fa2c12f7955..13dfabdf464a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -351,7 +351,7 @@ static u32 iwl_mvm_get_tx_rate(struct iwl_mvm *mvm,
 	is_cck = (rate_idx >= IWL_FIRST_CCK_RATE) && (rate_idx <= IWL_LAST_CCK_RATE);
 
 	/* Set CCK or OFDM flag */
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP, TX_CMD, 0) > 8) {
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, TX_CMD, 0) > 8) {
 		if (!is_cck)
 			rate_flags |= RATE_MCS_LEGACY_OFDM_MSK;
 		else
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 1affdafb07fc..2bb207ce5557 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -169,8 +169,7 @@ int iwl_mvm_legacy_rate_to_mac80211_idx(u32 rate_n_flags,
 
 u8 iwl_mvm_mac80211_idx_to_hwrate(const struct iwl_fw *fw, int rate_idx)
 {
-	if (iwl_fw_lookup_cmd_ver(fw, LONG_GROUP,
-				  TX_CMD, 0) > 8)
+	if (iwl_fw_lookup_cmd_ver(fw, TX_CMD, 0) > 8)
 		/* In the new rate legacy rates are indexed:
 		 * 0 - 3 for CCK and 0 - 7 for OFDM.
 		 */
-- 
2.34.1

