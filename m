Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7C34682FB
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbhLDGjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:42 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50320 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242053AbhLDGjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:41 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOec-0017AH-QJ; Sat, 04 Dec 2021 08:36:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:52 +0200
Message-Id: <iwlwifi.20211204083238.55faa3782bb0.I3f9d0071e680cab513c59b093d0827af99d41c51@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: mvm: support RLC configuration command
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There's an RLC configuration command in the firmware that's
going to replace the chain information in the PHY context.
Add support for this command, while leaving the PHY context
fields unset when we know the RLC command will be used.

Also add support to send only the RLC configuration command
if only the # of chains used on the PHY context changes.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 62 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  7 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  1 +
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 60 +++++++++++++++++-
 4 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 985b0dc5b52a..89236f42c5a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -31,6 +31,11 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	STA_HE_CTXT_CMD = 0x7,
 
+	/**
+	 * @RLC_CONFIG_CMD: &struct iwl_rlc_config_cmd
+	 */
+	RLC_CONFIG_CMD = 0x8,
+
 	/**
 	 * @RFH_QUEUE_CONFIG_CMD: &struct iwl_rfh_queue_config
 	 */
@@ -195,4 +200,61 @@ struct iwl_thermal_dual_chain_request {
 	__le32 event;
 } __packed; /* THERMAL_DUAL_CHAIN_DISABLE_REQ_NTFY_API_S_VER_1 */
 
+enum iwl_rlc_chain_info {
+	IWL_RLC_CHAIN_INFO_DRIVER_FORCE		= BIT(0),
+	IWL_RLC_CHAIN_INFO_VALID		= 0x000e,
+	IWL_RLC_CHAIN_INFO_FORCE		= 0x0070,
+	IWL_RLC_CHAIN_INFO_FORCE_MIMO		= 0x0380,
+	IWL_RLC_CHAIN_INFO_COUNT		= 0x0c00,
+	IWL_RLC_CHAIN_INFO_MIMO_COUNT		= 0x3000,
+};
+
+/**
+ * struct iwl_rlc_properties - RLC properties
+ * @rx_chain_info: RX chain info, &enum iwl_rlc_chain_info
+ * @reserved: reserved
+ */
+struct iwl_rlc_properties {
+	__le32 rx_chain_info;
+	__le32 reserved;
+} __packed; /* RLC_PROPERTIES_S_VER_1 */
+
+enum iwl_sad_mode {
+	IWL_SAD_MODE_ENABLED		= BIT(0),
+	IWL_SAD_MODE_DEFAULT_ANT_MSK	= 0x6,
+	IWL_SAD_MODE_DEFAULT_ANT_FW	= 0x0,
+	IWL_SAD_MODE_DEFAULT_ANT_A	= 0x2,
+	IWL_SAD_MODE_DEFAULT_ANT_B	= 0x4,
+};
+
+/**
+ * struct iwl_sad_properties - SAD properties
+ * @chain_a_sad_mode: chain A SAD mode, &enum iwl_sad_mode
+ * @chain_b_sad_mode: chain B SAD mode, &enum iwl_sad_mode
+ * @mac_id: MAC index
+ * @reserved: reserved
+ */
+struct iwl_sad_properties {
+	__le32 chain_a_sad_mode;
+	__le32 chain_b_sad_mode;
+	__le32 mac_id;
+	__le32 reserved;
+} __packed;
+
+/**
+ * struct iwl_rlc_config_cmd - RLC configuration
+ * @phy_id: PHY index
+ * @rlc: RLC properties, &struct iwl_rlc_properties
+ * @sad: SAD (single antenna diversity) options, &struct iwl_sad_properties
+ * @flags: flags, &enum iwl_rlc_flags
+ * @reserved: reserved
+ */
+struct iwl_rlc_config_cmd {
+	__le32 phy_id;
+	struct iwl_rlc_properties rlc;
+	struct iwl_sad_properties sad;
+	u8 flags;
+	u8 reserved[3];
+} __packed; /* RLC_CONFIG_CMD_API_S_VER_2 */
+
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 64ff2395800c..f7ff7f2e3928 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -94,11 +94,10 @@ struct iwl_mvm_phy_ctxt {
 
 	enum nl80211_chan_width width;
 
-	/*
-	 * TODO: This should probably be removed. Currently here only for rate
-	 * scaling algorithm
-	 */
 	struct ieee80211_channel *channel;
+
+	/* track for RLC config command */
+	u32 center_freq1;
 };
 
 struct iwl_mvm_time_event_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index cd04f24dd7fa..baa1d8c597fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -530,6 +530,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(UPDATE_MU_GROUPS_CMD),
 	HCMD_NAME(TRIGGER_RX_QUEUES_NOTIF_CMD),
 	HCMD_NAME(STA_HE_CTXT_CMD),
+	HCMD_NAME(RLC_CONFIG_CMD),
 	HCMD_NAME(RFH_QUEUE_CONFIG_CMD),
 	HCMD_NAME(TLC_MNG_CONFIG_CMD),
 	HCMD_NAME(CHEST_COLLECTOR_FILTER_CONFIG_CMD),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 035336a9e755..6feb2f664d2c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -157,8 +157,43 @@ static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 	/* Set the channel info data */
 	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
 
-	iwl_mvm_phy_ctxt_set_rxchain(mvm, ctxt, &cmd->rxchain_info,
+	/* we only support RLC command version 2 */
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
+				  RLC_CONFIG_CMD, 0) < 2)
+		iwl_mvm_phy_ctxt_set_rxchain(mvm, ctxt, &cmd->rxchain_info,
+					     chains_static, chains_dynamic);
+}
+
+static int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm,
+				struct iwl_mvm_phy_ctxt *ctxt,
+				u8 chains_static, u8 chains_dynamic)
+{
+	struct iwl_rlc_config_cmd cmd = {
+		.phy_id = cpu_to_le32(ctxt->id),
+	};
+
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
+				  RLC_CONFIG_CMD, 0) < 2)
+		return 0;
+
+	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_DRIVER_FORCE !=
+		     PHY_RX_CHAIN_DRIVER_FORCE_MSK);
+	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_VALID !=
+		     PHY_RX_CHAIN_VALID_MSK);
+	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_FORCE !=
+		     PHY_RX_CHAIN_FORCE_SEL_MSK);
+	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_FORCE_MIMO !=
+		     PHY_RX_CHAIN_FORCE_MIMO_SEL_MSK);
+	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_COUNT != PHY_RX_CHAIN_CNT_MSK);
+	BUILD_BUG_ON(IWL_RLC_CHAIN_INFO_MIMO_COUNT !=
+		     PHY_RX_CHAIN_MIMO_CNT_MSK);
+
+	iwl_mvm_phy_ctxt_set_rxchain(mvm, ctxt, &cmd.rlc.rx_chain_info,
 				     chains_static, chains_dynamic);
+
+	return iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(RLC_CONFIG_CMD,
+						    DATA_PATH_GROUP, 2),
+				    0, sizeof(cmd), &cmd);
 }
 
 /*
@@ -211,9 +246,16 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 	}
 
 
-	if (ret)
+	if (ret) {
 		IWL_ERR(mvm, "PHY ctxt cmd error. ret=%d\n", ret);
-	return ret;
+		return ret;
+	}
+
+	if (action != FW_CTXT_ACTION_REMOVE)
+		return iwl_mvm_phy_send_rlc(mvm, ctxt, chains_static,
+					    chains_dynamic);
+
+	return 0;
 }
 
 /*
@@ -228,6 +270,8 @@ int iwl_mvm_phy_ctxt_add(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 	lockdep_assert_held(&mvm->mutex);
 
 	ctxt->channel = chandef->chan;
+	ctxt->width = chandef->width;
+	ctxt->center_freq1 = chandef->center_freq1;
 
 	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 				      chains_static, chains_dynamic,
@@ -257,6 +301,14 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, DATA_PATH_GROUP,
+				  RLC_CONFIG_CMD, 0) >= 2 &&
+	    ctxt->channel == chandef->chan &&
+	    ctxt->width == chandef->width &&
+	    ctxt->center_freq1 == chandef->center_freq1)
+		return iwl_mvm_phy_send_rlc(mvm, ctxt, chains_static,
+					    chains_dynamic);
+
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT) &&
 	    ctxt->channel->band != chandef->chan->band) {
@@ -275,6 +327,8 @@ int iwl_mvm_phy_ctxt_changed(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 
 	ctxt->channel = chandef->chan;
 	ctxt->width = chandef->width;
+	ctxt->center_freq1 = chandef->center_freq1;
+
 	return iwl_mvm_phy_ctxt_apply(mvm, ctxt, chandef,
 				      chains_static, chains_dynamic,
 				      action);
-- 
2.33.1

