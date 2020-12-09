Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E792D4D01
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbgLIVig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:38:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35930 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388046AbgLIVig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:38:36 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pi-003Drx-QA; Wed, 09 Dec 2020 23:17:11 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:26 +0200
Message-Id: <iwlwifi.20201209231352.6c9fc9fb48d5.I2aaebf90e6fe81860105d049a8d35746fa8d86c2@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 22/47] iwlwifi: remove sw_csum_tx
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This was a hack done to test the data path of devices that
didn't support well CSUM offload in Tx. This is not needed
anymore.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 -
 .../wireless/intel/iwlwifi/mvm/constants.h    |  1 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  7 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  3 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 83 +------------------
 8 files changed, 5 insertions(+), 100 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 11a040e75bf3..8f3774181b97 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -432,7 +432,6 @@ struct iwl_hcmd_arr {
  * @bc_table_dword: set to true if the BC table expects the byte count to be
  *	in DWORD (as opposed to bytes)
  * @scd_set_active: should the transport configure the SCD for HCMD queue
- * @sw_csum_tx: transport should compute the TCP checksum
  * @command_groups: array of command groups, each member is an array of the
  *	commands in the group; for debugging only
  * @command_groups_size: number of command groups, to avoid illegal access
@@ -451,7 +450,6 @@ struct iwl_trans_config {
 	enum iwl_amsdu_size rx_buf_size;
 	bool bc_table_dword;
 	bool scd_set_active;
-	bool sw_csum_tx;
 	const struct iwl_hcmd_arr *command_groups;
 	int command_groups_size;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index b4eeb4be3ac7..7fde457e1183 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -107,7 +107,6 @@
 #define IWL_MVM_RS_RSSI_BASED_INIT_RATE         0
 #define IWL_MVM_RS_80_20_FAR_RANGE_TWEAK	1
 #define IWL_MVM_TOF_IS_RESPONDER		0
-#define IWL_MVM_SW_TX_CSUM_OFFLOAD		0
 #define IWL_MVM_HW_CSUM_DISABLE			0
 #define IWL_MVM_PARSE_NVM			0
 #define IWL_MVM_ADWELL_ENABLE			1
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 76e04abd60bf..0f1d345dfc36 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -754,13 +754,9 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	}
 
 	hw->netdev_features |= mvm->cfg->features;
-	if (!iwl_mvm_is_csum_supported(mvm)) {
+	if (!iwl_mvm_is_csum_supported(mvm))
 		hw->netdev_features &= ~(IWL_TX_CSUM_NETIF_FLAGS |
 					 NETIF_F_RXCSUM);
-		/* We may support SW TX CSUM */
-		if (IWL_MVM_SW_TX_CSUM_OFFLOAD)
-			hw->netdev_features |= IWL_TX_CSUM_NETIF_FLAGS;
-	}
 
 	if (mvm->cfg->vht_mu_mimo_supported)
 		wiphy_ext_feature_set(hw->wiphy,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 70b3b9797c2d..517ca5b8ce66 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -775,8 +775,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	trans_cfg.cb_data_offs = offsetof(struct ieee80211_tx_info,
 					  driver_data[2]);
 
-	trans_cfg.sw_csum_tx = IWL_MVM_SW_TX_CSUM_OFFLOAD;
-
 	/* Set a short watchdog for the command queue */
 	trans_cfg.cmd_q_wdg_timeout =
 		iwl_mvm_get_wd_timeout(mvm, NULL, false, true);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index fe1c538cd718..0ce5850dddc4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -105,11 +105,8 @@ static u16 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 	u16 mh_len = ieee80211_hdrlen(hdr->frame_control);
 	u8 protocol = 0;
 
-	/*
-	 * Do not compute checksum if already computed or if transport will
-	 * compute it
-	 */
-	if (skb->ip_summed != CHECKSUM_PARTIAL || IWL_MVM_SW_TX_CSUM_OFFLOAD)
+	/* Do not compute checksum if already computed */
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		goto out;
 
 	/* We do not expect to be requested to csum stuff we do not support */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index acbf367aea4c..d0a723478cbe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -348,8 +348,6 @@ struct cont_rec {
  * @def_rx_queue - default rx queue number
  * @rx_buf_size: Rx buffer size
  * @scd_set_active: should the transport configure the SCD for HCMD queue
- * @sw_csum_tx: if true, then the transport will compute the csum of the TXed
- *	frame.
  * @rx_page_order: page order for receive buffer size
  * @rx_buf_bytes: RX buffer (RB) size in bytes
  * @reg_lock: protect hw register access
@@ -432,7 +430,6 @@ struct iwl_trans_pcie {
 
 	enum iwl_amsdu_size rx_buf_size;
 	bool scd_set_active;
-	bool sw_csum_tx;
 	bool pcie_dbg_dumped_once;
 	u32 rx_page_order;
 	u32 rx_buf_bytes;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 9551f7a8c4bd..2ed7de7262df 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1934,7 +1934,6 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 
 	trans->txqs.bc_table_dword = trans_cfg->bc_table_dword;
 	trans_pcie->scd_set_active = trans_cfg->scd_set_active;
-	trans_pcie->sw_csum_tx = trans_cfg->sw_csum_tx;
 
 	trans->command_groups = trans_cfg->command_groups;
 	trans->command_groups_size = trans_cfg->command_groups_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 2beaf3c01552..cc8c76aea4e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1497,25 +1497,6 @@ static int iwl_fill_data_tbs(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 #ifdef CONFIG_INET
-static void iwl_compute_pseudo_hdr_csum(void *iph, struct tcphdr *tcph,
-					bool ipv6, unsigned int len)
-{
-	if (ipv6) {
-		struct ipv6hdr *iphv6 = iph;
-
-		tcph->check = ~csum_ipv6_magic(&iphv6->saddr, &iphv6->daddr,
-					       len + tcph->doff * 4,
-					       IPPROTO_TCP, 0);
-	} else {
-		struct iphdr *iphv4 = iph;
-
-		ip_send_check(iphv4);
-		tcph->check = ~csum_tcpudp_magic(iphv4->saddr, iphv4->daddr,
-						 len + tcph->doff * 4,
-						 IPPROTO_TCP, 0);
-	}
-}
-
 static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_txq *txq, u8 hdr_len,
 				   struct iwl_cmd_meta *out_meta,
@@ -1523,8 +1504,6 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 				   u16 tb1_len)
 {
 	struct iwl_tx_cmd *tx_cmd = (void *)dev_cmd->payload;
-	struct iwl_trans_pcie *trans_pcie =
-		IWL_TRANS_GET_PCIE_TRANS(txq->trans);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	unsigned int snap_ip_tcp_hdrlen, ip_hdrlen, total_len, hdr_room;
 	unsigned int mss = skb_shinfo(skb)->gso_size;
@@ -1583,8 +1562,7 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		struct sk_buff *csum_skb = NULL;
 		unsigned int hdr_tb_len;
 		dma_addr_t hdr_tb_phys;
-		struct tcphdr *tcph;
-		u8 *iph, *subf_hdrs_start = hdr_page->pos;
+		u8 *subf_hdrs_start = hdr_page->pos;
 
 		total_len -= data_left;
 
@@ -1606,27 +1584,6 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		 * as MAC header.
 		 */
 		tso_build_hdr(skb, hdr_page->pos, &tso, data_left, !total_len);
-		iph = hdr_page->pos + 8;
-		tcph = (void *)(iph + ip_hdrlen);
-
-		/* For testing on current hardware only */
-		if (trans_pcie->sw_csum_tx) {
-			csum_skb = alloc_skb(data_left + tcp_hdrlen(skb),
-					     GFP_ATOMIC);
-			if (!csum_skb)
-				return -ENOMEM;
-
-			iwl_compute_pseudo_hdr_csum(iph, tcph,
-						    skb->protocol ==
-							htons(ETH_P_IPV6),
-						    data_left);
-
-			skb_put_data(csum_skb, tcph, tcp_hdrlen(skb));
-			skb_reset_transport_header(csum_skb);
-			csum_skb->csum_start =
-				(unsigned char *)tcp_hdr(csum_skb) -
-						 csum_skb->head;
-		}
 
 		hdr_page->pos += snap_ip_tcp_hdrlen;
 
@@ -1653,9 +1610,6 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 						  data_left);
 			dma_addr_t tb_phys;
 
-			if (trans_pcie->sw_csum_tx)
-				skb_put_data(csum_skb, tso.data, size);
-
 			tb_phys = dma_map_single(trans->dev, tso.data,
 						 size, DMA_TO_DEVICE);
 			if (unlikely(dma_mapping_error(trans->dev, tb_phys))) {
@@ -1671,23 +1625,6 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 			data_left -= size;
 			tso_build_data(skb, &tso, size);
 		}
-
-		/* For testing on early hardware only */
-		if (trans_pcie->sw_csum_tx) {
-			__wsum csum;
-
-			csum = skb_checksum(csum_skb,
-					    skb_checksum_start_offset(csum_skb),
-					    csum_skb->len -
-					    skb_checksum_start_offset(csum_skb),
-					    0);
-			dev_kfree_skb(csum_skb);
-			dma_sync_single_for_cpu(trans->dev, hdr_tb_phys,
-						hdr_tb_len, DMA_TO_DEVICE);
-			tcph->check = csum_fold(csum);
-			dma_sync_single_for_device(trans->dev, hdr_tb_phys,
-						   hdr_tb_len, DMA_TO_DEVICE);
-		}
 	}
 
 	/* re -add the WiFi header and IV */
@@ -1712,7 +1649,6 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		      struct iwl_device_tx_cmd *dev_cmd, int txq_id)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct ieee80211_hdr *hdr;
 	struct iwl_tx_cmd *tx_cmd = (struct iwl_tx_cmd *)dev_cmd->payload;
 	struct iwl_cmd_meta *out_meta;
@@ -1733,21 +1669,6 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 		      "TX on unused queue %d\n", txq_id))
 		return -EINVAL;
 
-	if (unlikely(trans_pcie->sw_csum_tx &&
-		     skb->ip_summed == CHECKSUM_PARTIAL)) {
-		int offs = skb_checksum_start_offset(skb);
-		int csum_offs = offs + skb->csum_offset;
-		__wsum csum;
-
-		if (skb_ensure_writable(skb, csum_offs + sizeof(__sum16)))
-			return -1;
-
-		csum = skb_checksum(skb, offs, skb->len - offs, 0);
-		*(__sum16 *)(skb->data + csum_offs) = csum_fold(csum);
-
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-	}
-
 	if (skb_is_nonlinear(skb) &&
 	    skb_shinfo(skb)->nr_frags > IWL_TRANS_MAX_FRAGS(trans) &&
 	    __skb_linearize(skb))
@@ -1822,7 +1743,7 @@ int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
 	amsdu = ieee80211_is_data_qos(fc) &&
 		(*ieee80211_get_qos_ctl(hdr) &
 		 IEEE80211_QOS_CTL_A_MSDU_PRESENT);
-	if (trans_pcie->sw_csum_tx || !amsdu) {
+	if (!amsdu) {
 		tb1_len = ALIGN(len, 4);
 		/* Tell NIC about any 2-byte padding after MAC header */
 		if (tb1_len != len)
-- 
2.29.2

