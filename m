Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C95B3AAD0D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 09:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFQHLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 03:11:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47882 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230146AbhFQHLG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 03:11:06 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ltm92-001XeC-2m; Thu, 17 Jun 2021 10:08:57 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 17 Jun 2021 10:08:43 +0300
Message-Id: <iwlwifi.20210617100544.123c6b05809d.I992e3d1c6a29850d02eeec01712b5b685b963a87@changeid>
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
Subject: [PATCH 03/12] iwlwifi: mvm: apply RX diversity per PHY context
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

SMPS requests may differ per interfaces due to e.g. Bluetooth
only interfering on 2.4 GHz, so if that's the case we should,
in the case of multiple PHY contexts, still allow RX diversity
on PHY context that have no interfaces with SMPS requests.

Fix the code to pass through the PHY context in question and
skip interfaces with non-matching PHY context while iterating.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +-
 .../net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 15 ++++++----
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 28 ++++++++++++++-----
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3d738243fcee..04ba4c6315e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1850,7 +1850,8 @@ int iwl_mvm_disable_beacon_filter(struct iwl_mvm *mvm,
 void iwl_mvm_update_smps(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 				enum iwl_mvm_smps_type_request req_type,
 				enum ieee80211_smps_mode smps_request);
-bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm);
+bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm,
+				  struct iwl_mvm_phy_ctxt *ctxt);
 
 /* Low latency */
 int iwl_mvm_update_low_latency(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 0fd51f6aa206..4ed2338027d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
@@ -76,6 +76,7 @@ static void iwl_mvm_phy_ctxt_cmd_hdr(struct iwl_mvm_phy_ctxt *ctxt,
 }
 
 static void iwl_mvm_phy_ctxt_set_rxchain(struct iwl_mvm *mvm,
+					 struct iwl_mvm_phy_ctxt *ctxt,
 					 __le32 *rxchain_info,
 					 u8 chains_static,
 					 u8 chains_dynamic)
@@ -93,7 +94,7 @@ static void iwl_mvm_phy_ctxt_set_rxchain(struct iwl_mvm *mvm,
 	 * between the two antennas is sufficiently different to impact
 	 * performance.
 	 */
-	if (active_cnt == 1 && iwl_mvm_rx_diversity_allowed(mvm)) {
+	if (active_cnt == 1 && iwl_mvm_rx_diversity_allowed(mvm, ctxt)) {
 		idle_cnt = 2;
 		active_cnt = 2;
 	}
@@ -113,6 +114,7 @@ static void iwl_mvm_phy_ctxt_set_rxchain(struct iwl_mvm *mvm,
  * Add the phy configuration to the PHY context command
  */
 static void iwl_mvm_phy_ctxt_cmd_data_v1(struct iwl_mvm *mvm,
+					 struct iwl_mvm_phy_ctxt *ctxt,
 					 struct iwl_phy_context_cmd_v1 *cmd,
 					 struct cfg80211_chan_def *chandef,
 					 u8 chains_static, u8 chains_dynamic)
@@ -123,7 +125,7 @@ static void iwl_mvm_phy_ctxt_cmd_data_v1(struct iwl_mvm *mvm,
 	/* Set the channel info data */
 	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
 
-	iwl_mvm_phy_ctxt_set_rxchain(mvm, &tail->rxchain_info,
+	iwl_mvm_phy_ctxt_set_rxchain(mvm, ctxt, &tail->rxchain_info,
 				     chains_static, chains_dynamic);
 
 	tail->txchain_info = cpu_to_le32(iwl_mvm_get_valid_tx_ant(mvm));
@@ -133,6 +135,7 @@ static void iwl_mvm_phy_ctxt_cmd_data_v1(struct iwl_mvm *mvm,
  * Add the phy configuration to the PHY context command
  */
 static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
+				      struct iwl_mvm_phy_ctxt *ctxt,
 				      struct iwl_phy_context_cmd *cmd,
 				      struct cfg80211_chan_def *chandef,
 				      u8 chains_static, u8 chains_dynamic)
@@ -143,7 +146,7 @@ static void iwl_mvm_phy_ctxt_cmd_data(struct iwl_mvm *mvm,
 	/* Set the channel info data */
 	iwl_mvm_set_chan_info_chandef(mvm, &cmd->ci, chandef);
 
-	iwl_mvm_phy_ctxt_set_rxchain(mvm, &cmd->rxchain_info,
+	iwl_mvm_phy_ctxt_set_rxchain(mvm, ctxt, &cmd->rxchain_info,
 				     chains_static, chains_dynamic);
 }
 
@@ -170,7 +173,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 		iwl_mvm_phy_ctxt_cmd_hdr(ctxt, &cmd, action);
 
 		/* Set the command data */
-		iwl_mvm_phy_ctxt_cmd_data(mvm, &cmd, chandef,
+		iwl_mvm_phy_ctxt_cmd_data(mvm, ctxt, &cmd, chandef,
 					  chains_static,
 					  chains_dynamic);
 
@@ -186,7 +189,7 @@ static int iwl_mvm_phy_ctxt_apply(struct iwl_mvm *mvm,
 					 action);
 
 		/* Set the command data */
-		iwl_mvm_phy_ctxt_cmd_data_v1(mvm, &cmd, chandef,
+		iwl_mvm_phy_ctxt_cmd_data_v1(mvm, ctxt, &cmd, chandef,
 					     chains_static,
 					     chains_dynamic);
 		ret = iwl_mvm_send_cmd_pdu(mvm, PHY_CONTEXT_CMD,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index e1e45eca09b5..0e8ad798ab57 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -681,23 +681,37 @@ void iwl_mvm_accu_radio_stats(struct iwl_mvm *mvm)
 	mvm->accu_radio_stats.on_time_scan += mvm->radio_stats.on_time_scan;
 }
 
+struct iwl_mvm_diversity_iter_data {
+	struct iwl_mvm_phy_ctxt *ctxt;
+	bool result;
+};
+
 static void iwl_mvm_diversity_iter(void *_data, u8 *mac,
 				   struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	bool *result = _data;
+	struct iwl_mvm_diversity_iter_data *data = _data;
 	int i;
 
+	if (mvmvif->phy_ctxt != data->ctxt)
+		return;
+
 	for (i = 0; i < NUM_IWL_MVM_SMPS_REQ; i++) {
 		if (mvmvif->smps_requests[i] == IEEE80211_SMPS_STATIC ||
-		    mvmvif->smps_requests[i] == IEEE80211_SMPS_DYNAMIC)
-			*result = false;
+		    mvmvif->smps_requests[i] == IEEE80211_SMPS_DYNAMIC) {
+			data->result = false;
+			break;
+		}
 	}
 }
 
-bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm)
+bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm,
+				  struct iwl_mvm_phy_ctxt *ctxt)
 {
-	bool result = true;
+	struct iwl_mvm_diversity_iter_data data = {
+		.ctxt = ctxt,
+		.result = true,
+	};
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -709,9 +723,9 @@ bool iwl_mvm_rx_diversity_allowed(struct iwl_mvm *mvm)
 
 	ieee80211_iterate_active_interfaces_atomic(
 			mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
-			iwl_mvm_diversity_iter, &result);
+			iwl_mvm_diversity_iter, &data);
 
-	return result;
+	return data.result;
 }
 
 void iwl_mvm_send_low_latency_cmd(struct iwl_mvm *mvm,
-- 
2.32.0

