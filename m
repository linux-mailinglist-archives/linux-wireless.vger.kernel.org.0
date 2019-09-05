Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C660AA3F4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbfIENMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:12:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40926 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732890AbfIENMw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:12:52 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZC-0005yI-Eu; Thu, 05 Sep 2019 16:12:51 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:28 +0300
Message-Id: <20190905131241.23487-6-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 05/18] iwlwifi: Set w-pointer upon resume according to SN
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alex Malamud <alex.malamud@intel.com>

During D3 state, FW may send packets.
As a result, "write" queue pointer will be incremented by FW.
Upon resume from D3, driver should adjust its shadows of "write" and "read"
pointers to the value reported by FW.

1. Keep TID used during wowlan configuration.
2. Upon resume, set driver's "write" and "read" queue pointers
	to the value reported by FW.

Signed-off-by: Alex Malamud <alex.malamud@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     | 13 +++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  9 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       | 14 ++++++++++++++
 6 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 942662eaf523..034c935b5579 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -562,6 +562,8 @@ struct iwl_trans_ops {
 	void (*reclaim)(struct iwl_trans *trans, int queue, int ssn,
 			struct sk_buff_head *skbs);
 
+	void (*set_q_ptrs)(struct iwl_trans *trans, int queue, int ptr);
+
 	bool (*txq_enable)(struct iwl_trans *trans, int queue, u16 ssn,
 			   const struct iwl_trans_txq_scd_cfg *cfg,
 			   unsigned int queue_wdg_timeout);
@@ -999,6 +1001,17 @@ static inline void iwl_trans_reclaim(struct iwl_trans *trans, int queue,
 	trans->ops->reclaim(trans, queue, ssn, skbs);
 }
 
+static inline void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue,
+					int ptr)
+{
+	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
+		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
+		return;
+	}
+
+	trans->ops->set_q_ptrs(trans, queue, ptr);
+}
+
 static inline void iwl_trans_txq_disable(struct iwl_trans *trans, int queue,
 					 bool configure_scd)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 89839a83d8c2..6f7345b121a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -831,6 +831,8 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 
+	mvm->offload_tid = wowlan_config_cmd->offloading_tid;
+
 	if (!unified_image) {
 		ret = iwl_mvm_switch_to_d3(mvm);
 		if (ret)
@@ -1656,6 +1658,13 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 		mvm_ap_sta->tid_data[i].seq_number = seq;
 	}
 
+	if (mvm->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000) {
+		i = mvm->offload_tid;
+		iwl_trans_set_q_ptrs(mvm->trans,
+				     mvm_ap_sta->tid_data[i].txq_id,
+				     mvm_ap_sta->tid_data[i].seq_number >> 4);
+	}
+
 	/* now we have all the data we need, unlock to avoid mac80211 issues */
 	mutex_unlock(&mvm->mutex);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3efcc3a939b8..79bbdf8121cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1001,6 +1001,7 @@ struct iwl_mvm {
 	struct ieee80211_channel **nd_channels;
 	int n_nd_channels;
 	bool net_detect;
+	u8 offload_tid;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	bool d3_wake_sysassert;
 	bool d3_test_active;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 9f5d0fc839fe..6bf2a816e221 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -697,6 +697,7 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 			    struct iwl_rx_cmd_buffer *rxb);
 void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 			    struct sk_buff_head *skbs);
+void iwl_trans_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
 void iwl_pcie_gen2_update_byte_tbl(struct iwl_trans_pcie *trans_pcie,
 				   struct iwl_txq *txq, u16 byte_cnt,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a423c5c6605e..3a4be2ff3d42 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3397,6 +3397,8 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.tx = iwl_trans_pcie_gen2_tx,
 	.reclaim = iwl_trans_pcie_reclaim,
 
+	.set_q_ptrs = iwl_trans_pcie_set_q_ptrs,
+
 	.txq_alloc = iwl_trans_pcie_dyn_txq_alloc,
 	.txq_free = iwl_trans_pcie_dyn_txq_free,
 	.wait_txq_empty = iwl_trans_pcie_wait_txq_empty,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 2f0ba7ef53b8..b25f51b5893c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1234,6 +1234,20 @@ void iwl_trans_pcie_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	spin_unlock_bh(&txq->lock);
 }
 
+/* Set wr_ptr of specific device and txq  */
+void iwl_trans_pcie_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_txq *txq = trans_pcie->txq[txq_id];
+
+	spin_lock_bh(&txq->lock);
+
+	txq->write_ptr = ptr;
+	txq->read_ptr = txq->write_ptr;
+
+	spin_unlock_bh(&txq->lock);
+}
+
 static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 				      const struct iwl_host_cmd *cmd)
 {
-- 
2.23.0.rc1

