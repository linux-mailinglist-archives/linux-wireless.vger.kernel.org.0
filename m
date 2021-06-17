Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68AB3AAD0E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhFQHLJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47888 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230038AbhFQHLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm93-001XeC-4T; Thu, 17 Jun 2021 10:08:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:44 +0300
Message-Id: <iwlwifi.20210617100544.85656b7684b9.I7a661a0758d070a750d3a91874d1a0f5fab9febc@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617070852.496985-1-luca@coelho.fi>
References: <20210617070852.496985-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/12] iwlwifi: mvm: honour firmware SMPS requests
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The firmware can now request SMPS (due to thermal conditions), add
some code to honour such requests and bubble them up through the
stack, subject to our other SMPS constraints, e.g. from Bluetooth.

Then, if the firmware requests SMPS, then we know that it supports
a small extension to the PHY configuration API where a chain mask
of 0 means "use 1 but pick which one yourself", so in this case we
use that extension.

During firmware restart, we stay in the previous state, and the FW
will send us a notification at startup (only) if the temperature is
below the lower or above the high threshold, to sync the state.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 26 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 39 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 11 ++++++
 4 files changed, 80 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index d299bba3aa54..985b0dc5b52a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -63,6 +63,12 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	RX_NO_DATA_NOTIF = 0xF5,
 
+	/**
+	 * @THERMAL_DUAL_CHAIN_DISABLE_REQ: firmware request for SMPS mode,
+	 *	&struct iwl_thermal_dual_chain_request
+	 */
+	THERMAL_DUAL_CHAIN_REQUEST = 0xF6,
+
 	/**
 	 * @TLC_MNG_UPDATE_NOTIF: &struct iwl_tlc_update_notif
 	 */
@@ -169,4 +175,24 @@ struct iwl_datapath_monitor_notif {
 	u8 reserved[3];
 } __packed; /* MONITOR_NTF_API_S_VER_1 */
 
+/**
+ * enum iwl_thermal_dual_chain_req_events - firmware SMPS request event
+ * @THERMAL_DUAL_CHAIN_REQ_ENABLE: (re-)enable dual-chain operation
+ *	(subject to other constraints)
+ * @THERMAL_DUAL_CHAIN_REQ_DISABLE: disable dual-chain operation
+ *	(static SMPS)
+ */
+enum iwl_thermal_dual_chain_req_events {
+	THERMAL_DUAL_CHAIN_REQ_ENABLE,
+	THERMAL_DUAL_CHAIN_REQ_DISABLE,
+}; /* THERMAL_DUAL_CHAIN_DISABLE_STATE_API_E_VER_1 */
+
+/**
+ * struct iwl_thermal_dual_chain_request - SMPS request
+ * @event: the type of request, see &enum iwl_thermal_dual_chain_req_events
+ */
+struct iwl_thermal_dual_chain_request {
+	__le32 event;
+} __packed; /* THERMAL_DUAL_CHAIN_DISABLE_REQ_NTFY_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 04ba4c6315e9..b0223f1c52f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -198,6 +198,7 @@ enum iwl_mvm_smps_type_request {
 	IWL_MVM_SMPS_REQ_BT_COEX,
 	IWL_MVM_SMPS_REQ_TT,
 	IWL_MVM_SMPS_REQ_PROT,
+	IWL_MVM_SMPS_REQ_FW,
 	NUM_IWL_MVM_SMPS_REQ,
 };
 
@@ -1006,6 +1007,8 @@ struct iwl_mvm {
 	 */
 	bool temperature_test;  /* Debug test temperature is enabled */
 
+	bool fw_static_smps_request;
+
 	unsigned long bt_coex_last_tcm_ts;
 	struct iwl_mvm_tcm tcm;
 
@@ -1852,6 +1855,7 @@ void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				enum ieee80211_smps_mode smps_request);
 bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm,
 				  struct iwl_mvm_phy_ctxt *ctxt);
+void iwl_mvm_apply_fw_smps_request(struct ieee80211_vif *vif);
 
 /* Low latency */
 int iwl_mvm_update_low_latency(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 7b67ee2c70aa..9898e1a72c7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -210,6 +210,39 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	ieee80211_disconnect(vif, true);
 }
 
+void iwl_mvm_apply_fw_smps_request(struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+
+	iwl_mvm_update_smps(mvm, vif, IWL_MVM_SMPS_REQ_FW,
+			    mvm->fw_static_smps_request ?
+				IEEE80211_SMPS_STATIC :
+				IEEE80211_SMPS_AUTOMATIC);
+}
+
+static void iwl_mvm_intf_dual_chain_req(void *data, u8 *mac,
+					struct ieee80211_vif *vif)
+{
+	iwl_mvm_apply_fw_smps_request(vif);
+}
+
+static void iwl_mvm_rx_thermal_dual_chain_req(struct iwl_mvm *mvm,
+					      struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_thermal_dual_chain_request *req = (void *)pkt->data;
+
+	/*
+	 * We could pass it to the iterator data, but also need to remember
+	 * it for new interfaces that are added while in this state.
+	 */
+	mvm->fw_static_smps_request =
+		req->event == cpu_to_le32(THERMAL_DUAL_CHAIN_REQ_DISABLE);
+	ieee80211_iterate_interfaces(mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
+				     iwl_mvm_intf_dual_chain_req, NULL);
+}
+
 /**
  * enum iwl_rx_handler_context context for Rx handler
  * @RX_HANDLER_SYNC : this means that it will be called in the Rx path
@@ -358,6 +391,11 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 	RX_HANDLER_GRP(DATA_PATH_GROUP, MONITOR_NOTIF,
 		       iwl_mvm_rx_monitor_notif, RX_HANDLER_ASYNC_LOCKED,
 		       struct iwl_datapath_monitor_notif),
+
+	RX_HANDLER_GRP(DATA_PATH_GROUP, THERMAL_DUAL_CHAIN_REQUEST,
+		       iwl_mvm_rx_thermal_dual_chain_req,
+		       RX_HANDLER_ASYNC_LOCKED,
+		       struct iwl_thermal_dual_chain_request),
 };
 #undef RX_HANDLER
 #undef RX_HANDLER_GRP
@@ -502,6 +540,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(TLC_MNG_CONFIG_CMD),
 	HCMD_NAME(CHEST_COLLECTOR_FILTER_CONFIG_CMD),
 	HCMD_NAME(MONITOR_NOTIF),
+	HCMD_NAME(THERMAL_DUAL_CHAIN_REQUEST),
 	HCMD_NAME(STA_PM_NOTIF),
 	HCMD_NAME(MU_GROUP_MGMT_NOTIF),
 	HCMD_NAME(RX_QUEUES_NOTIFICATION),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 4ed2338027d1..035336a9e755 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -99,6 +99,17 @@ static void iwl_mvm_phy_ctxt_set_rxchain(struct iwl_mvm *mvm,
 		active_cnt = 2;
 	}
 
+	/*
+	 * If the firmware requested it, then we know that it supports
+	 * getting zero for the values to indicate "use one, but pick
+	 * which one yourself", which means it can dynamically pick one
+	 * that e.g. has better RSSI.
+	 */
+	if (mvm->fw_static_smps_request && active_cnt == 1 && idle_cnt == 1) {
+		idle_cnt = 0;
+		active_cnt = 0;
+	}
+
 	*rxchain_info = cpu_to_le32(iwl_mvm_get_valid_rx_ant(mvm) <<
 					PHY_RX_CHAIN_VALID_POS);
 	*rxchain_info |= cpu_to_le32(idle_cnt << PHY_RX_CHAIN_CNT_POS);
-- 
2.32.0

