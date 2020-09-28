Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8EC27AAA5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgI1JXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52784 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgI1JXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNa-002KgD-Vf; Mon, 28 Sep 2020 12:23:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:18 +0300
Message-Id: <iwlwifi.20200928121852.70bec6eb8008.I6ea78553801d33f7ed10fcd2e4be4ba781fe469a@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/12] iwlwifi: fw: add default value for iwl_fw_lookup_cmd_ver
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

For new APIs this avoids checking every return if it's
IWL_FW_CMD_VER_UNKNOWN (99) or it's lower than the new API value

Done with spatch:
-iwl_fw_lookup_cmd_ver(E1, E2, E3)
+iwl_fw_lookup_cmd_ver(E1, E2, E3, IWL_FW_CMD_VER_UNKNOWN)

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.c   | 11 +++++++----
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 12 ++++++++----
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  3 ++-
 .../intel/iwlwifi/mvm/ftm-responder.c         |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 19 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |  6 ++++--
 10 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
index a4cbfc8f030f..c2a4e60518bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -57,22 +57,25 @@
 
 #include "img.h"
 
-u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd)
+u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def)
 {
 	const struct iwl_fw_cmd_version *entry;
 	unsigned int i;
 
 	if (!fw->ucode_capa.cmd_versions ||
 	    !fw->ucode_capa.n_cmd_versions)
-		return IWL_FW_CMD_VER_UNKNOWN;
+		return def;
 
 	entry = fw->ucode_capa.cmd_versions;
 	for (i = 0; i < fw->ucode_capa.n_cmd_versions; i++, entry++) {
-		if (entry->group == grp && entry->cmd == cmd)
+		if (entry->group == grp && entry->cmd == cmd) {
+			if (entry->cmd_ver == IWL_FW_CMD_VER_UNKNOWN)
+				return def;
 			return entry->cmd_ver;
+		}
 	}
 
-	return IWL_FW_CMD_VER_UNKNOWN;
+	return def;
 }
 EXPORT_SYMBOL_GPL(iwl_fw_lookup_cmd_ver);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 50672414356a..07d72bcf9c46 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -312,7 +312,7 @@ iwl_get_ucode_image(const struct iwl_fw *fw, enum iwl_ucode_type ucode_type)
 	return &fw->img[ucode_type];
 }
 
-u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd);
+u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
 
 u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
 const char *iwl_fw_lookup_assert_desc(u32 num);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index b373606e1241..f8516c7ca767 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -134,7 +134,8 @@ int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt)
 					      SOC_FLAGS_LTR_APPLY_DELAY_MASK);
 
 	if (iwl_fw_lookup_cmd_ver(fwrt->fw, IWL_ALWAYS_LONG_GROUP,
-				  SCAN_REQ_UMAC) >= 2 &&
+				  SCAN_REQ_UMAC,
+				  IWL_FW_CMD_VER_UNKNOWN) >= 2 &&
 	    fwrt->trans->trans_cfg->low_latency_xtal)
 		cmd.flags |= cpu_to_le32(SOC_CONFIG_CMD_FLAGS_LOW_LATENCY);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 3a1e5ac46ea0..b152f5a6ba0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -781,7 +781,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 
 	if (key_data.use_rsc_tsc) {
 		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-						WOWLAN_TSC_RSC_PARAM);
+						WOWLAN_TSC_RSC_PARAM,
+						IWL_FW_CMD_VER_UNKNOWN);
 		int size;
 
 		if (ver == 4) {
@@ -810,7 +811,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	    !fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_TKIP_MIC_KEYS)) {
 		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-						WOWLAN_TKIP_PARAM);
+						WOWLAN_TKIP_PARAM,
+						IWL_FW_CMD_VER_UNKNOWN);
 		int size;
 
 		if (ver == 2) {
@@ -836,8 +838,10 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 
 	/* configure rekey data only if offloaded rekey is supported (d3) */
 	if (mvmvif->rekey_data.valid) {
-		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-						WOWLAN_KEK_KCK_MATERIAL);
+		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+						IWL_ALWAYS_LONG_GROUP,
+						WOWLAN_KEK_KCK_MATERIAL,
+						IWL_FW_CMD_VER_UNKNOWN);
 		if (WARN_ON(cmd_ver != 2 && cmd_ver != 3 &&
 			    cmd_ver != IWL_FW_CMD_VER_UNKNOWN))
 			return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 5ca45915cf7c..3792a5f51201 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -577,7 +577,8 @@ int iwl_mvm_ftm_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	if (new_api) {
 		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-						   TOF_RANGE_REQ_CMD);
+						   TOF_RANGE_REQ_CMD,
+						   IWL_FW_CMD_VER_UNKNOWN);
 
 		switch (cmd_ver) {
 		case 9:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index 179bd2bb0a82..160f3f934ace 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -143,7 +143,8 @@ iwl_mvm_ftm_responder_cmd(struct iwl_mvm *mvm,
 		.sta_id = mvmvif->bcast_sta.sta_id,
 	};
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
-					   TOF_RESPONDER_CONFIG_CMD);
+					   TOF_RESPONDER_CONFIG_CMD,
+					   IWL_FW_CMD_VER_UNKNOWN);
 	int err;
 
 	lockdep_assert_held(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 06bb8ad84efb..4d4315bc669e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -586,7 +586,8 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 		mvm->fw->default_calib[ucode_type].flow_trigger;
 
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					PHY_CONFIGURATION_CMD);
+					PHY_CONFIGURATION_CMD,
+					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 3) {
 		iwl_mvm_phy_filter_init(mvm, &phy_filters);
 		memcpy(&phy_cfg_cmd.phy_specific_cfg, &phy_filters,
@@ -744,7 +745,8 @@ int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b)
 	u16 len = 0;
 	u32 n_subbands;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   REDUCE_TX_POWER_CMD);
+					   REDUCE_TX_POWER_CMD,
+					   IWL_FW_CMD_VER_UNKNOWN);
 
 	if (cmd_ver == 6) {
 		len = sizeof(cmd.v6);
@@ -787,8 +789,9 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	u16 len;
 	int ret;
 	struct iwl_host_cmd cmd;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-					   PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
+					   GEO_TX_POWER_LIMIT,
+					   IWL_FW_CMD_VER_UNKNOWN);
 
 	/* the ops field is at the same spot for all versions, so set in v1 */
 	geo_tx_cmd.v1.ops =
@@ -833,8 +836,9 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	union iwl_geo_tx_power_profiles_cmd cmd;
 	u16 len;
 	int ret;
-	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-					   PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
+					   GEO_TX_POWER_LIMIT,
+					   IWL_FW_CMD_VER_UNKNOWN);
 
 	/* the table is also at the same position both in v1 and v2 */
 	ret = iwl_sar_geo_init(&mvm->fwrt, &cmd.v1.table[0][0],
@@ -975,7 +979,8 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	}
 
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
-					PER_PLATFORM_ANT_GAIN_CMD);
+					PER_PLATFORM_ANT_GAIN_CMD,
+					IWL_FW_CMD_VER_UNKNOWN);
 	if (cmd_ver == 1) {
 		num_sub_bands = IWL_NUM_SUB_BANDS;
 		gain = mvm->fwrt.ppag_table.v1.gain[0];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 38666a181144..30e5a5b5664e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1315,7 +1315,8 @@ static int iwl_mvm_set_tx_power(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		.common.pwr_restriction = cpu_to_le16(8 * tx_power),
 	};
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-					   REDUCE_TX_POWER_CMD);
+					   REDUCE_TX_POWER_CMD,
+					   IWL_FW_CMD_VER_UNKNOWN);
 
 	if (tx_power == IWL_DEFAULT_MAX_TX_POWER)
 		cmd.common.pwr_restriction = cpu_to_le16(IWL_DEV_MAX_TX_POWER);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 37e490148876..b74978878a8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2150,7 +2150,8 @@ iwl_mvm_set_chan_info_chandef(struct iwl_mvm *mvm,
 static inline int iwl_umac_scan_get_max_profiles(const struct iwl_fw *fw)
 {
 	u8 ver = iwl_fw_lookup_cmd_ver(fw, IWL_ALWAYS_LONG_GROUP,
-				       SCAN_OFFLOAD_UPDATE_PROFILES_CMD);
+				       SCAN_OFFLOAD_UPDATE_PROFILES_CMD,
+				       IWL_FW_CMD_VER_UNKNOWN);
 	return (ver == IWL_FW_CMD_VER_UNKNOWN || ver < 3) ?
 		IWL_SCAN_MAX_PROFILES : IWL_SCAN_MAX_PROFILES_V2;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 51a061b138ba..02e3b70b36dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2229,7 +2229,8 @@ static int iwl_mvm_build_scan_cmd(struct iwl_mvm *mvm,
 	hcmd->id = iwl_cmd_id(SCAN_REQ_UMAC, IWL_ALWAYS_LONG_GROUP, 0);
 
 	scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					 SCAN_REQ_UMAC);
+					 SCAN_REQ_UMAC,
+					 IWL_FW_CMD_VER_UNKNOWN);
 
 	for (i = 0; i < ARRAY_SIZE(iwl_scan_umac_handlers); i++) {
 		const struct iwl_scan_umac_handler *ver_handler =
@@ -2569,7 +2570,8 @@ int iwl_mvm_scan_size(struct iwl_mvm *mvm)
 {
 	int base_size, tail_size;
 	u8 scan_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-					    SCAN_REQ_UMAC);
+					    SCAN_REQ_UMAC,
+					    IWL_FW_CMD_VER_UNKNOWN);
 
 	base_size = iwl_scan_req_umac_get_size(scan_ver);
 	if (base_size)
-- 
2.28.0

