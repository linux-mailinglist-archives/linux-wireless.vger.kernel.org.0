Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9B309BC6
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Jan 2021 13:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhAaLy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Jan 2021 06:54:58 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:42914 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231582AbhAaLvU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Jan 2021 06:51:20 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l6AY4-004131-Oa; Sun, 31 Jan 2021 13:05:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 31 Jan 2021 13:05:33 +0200
Message-Id: <iwlwifi.20210131125922.f5b813753bdb.Id58979b678974c3ccf44d8b381c68165ac55a3d3@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131110533.887130-1-luca@coelho.fi>
References: <20210131110533.887130-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: mvm: fix CSA AP side
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Once the all the stations completed the switch, we need
to clear csa_tx_blocked_vif. This was missing. We also
need to re-enable the broadcast / multicast stations.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 31 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 11 ++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 7b0b7d191fc5..c21736f80c29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1634,6 +1634,23 @@ static inline u8 iwl_mvm_nl80211_band_from_rx_msdu(u8 phy_band)
 	}
 }
 
+struct iwl_rx_sta_csa {
+	bool all_sta_unblocked;
+	struct ieee80211_vif *vif;
+};
+
+static void iwl_mvm_rx_get_sta_block_tx(void *data, struct ieee80211_sta *sta)
+{
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_rx_sta_csa *rx_sta_csa = data;
+
+	if (mvmsta->vif != rx_sta_csa->vif)
+		return;
+
+	if (mvmsta->disable_tx)
+		rx_sta_csa->all_sta_unblocked = false;
+}
+
 void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			struct iwl_rx_cmd_buffer *rxb, int queue)
 {
@@ -1863,10 +1880,24 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		if (unlikely(tx_blocked_vif) && tx_blocked_vif == vif) {
 			struct iwl_mvm_vif *mvmvif =
 				iwl_mvm_vif_from_mac80211(tx_blocked_vif);
+			struct iwl_rx_sta_csa rx_sta_csa = {
+				.all_sta_unblocked = true,
+				.vif = tx_blocked_vif,
+			};
 
 			if (mvmvif->csa_target_freq == rx_status->freq)
 				iwl_mvm_sta_modify_disable_tx_ap(mvm, sta,
 								 false);
+			ieee80211_iterate_stations_atomic(mvm->hw,
+							  iwl_mvm_rx_get_sta_block_tx,
+							  &rx_sta_csa);
+
+			if (rx_sta_csa.all_sta_unblocked) {
+				RCU_INIT_POINTER(mvm->csa_tx_blocked_vif, NULL);
+				/* Unblock BCAST / MCAST station */
+				iwl_mvm_modify_all_sta_disable_tx(mvm, mvmvif, false);
+				cancel_delayed_work_sync(&mvm->cs_tx_unblock_dwork);
+			}
 		}
 
 		rs_update_last_rssi(mvm, mvmsta, rx_status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 2050cb4a0d18..4a8a15dbb1a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2015, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2015, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -3811,7 +3811,7 @@ static void iwl_mvm_int_sta_modify_disable_tx(struct iwl_mvm *mvm,
 	};
 	int ret;
 
-	ret = iwl_mvm_send_cmd_pdu(mvm, ADD_STA, 0,
+	ret = iwl_mvm_send_cmd_pdu(mvm, ADD_STA, CMD_ASYNC,
 				   iwl_mvm_add_sta_cmd_size(mvm), &cmd);
 	if (ret)
 		IWL_ERR(mvm, "Failed to send ADD_STA command (%d)\n", ret);
@@ -3825,12 +3825,11 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvm_sta;
 	int i;
 
-	lockdep_assert_held(&mvm->mutex);
+	rcu_read_lock();
 
 	/* Block/unblock all the stations of the given mvmvif */
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
-		sta = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
-						lockdep_is_held(&mvm->mutex));
+		sta = rcu_dereference(mvm->fw_id_to_mac_id[i]);
 		if (IS_ERR_OR_NULL(sta))
 			continue;
 
@@ -3842,6 +3841,8 @@ void iwl_mvm_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 		iwl_mvm_sta_modify_disable_tx_ap(mvm, sta, disable);
 	}
 
+	rcu_read_unlock();
+
 	if (!fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_STA_TYPE))
 		return;
 
-- 
2.29.2

