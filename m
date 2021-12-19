Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5607847A05E
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 12:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhLSL2r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 06:28:47 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51430 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235635AbhLSL2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 06:28:46 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1myuMu-001O73-JM; Sun, 19 Dec 2021 13:28:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 13:28:29 +0200
Message-Id: <iwlwifi.20211219132536.c0f44c98b36d.I75a688f3ac80cbe824c459ece4bb67843b9fce76@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219112836.132859-1-luca@coelho.fi>
References: <20211219112836.132859-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: mvm: support Bz TX checksum offload
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Support TX checksum offload for Bz devices, where we have full
checksum offload (NETIF_F_HW_CSUM) and the hardware doesn't
need to parse the IP headers or anything.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 11 ++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 65 ++++++++++++++++---
 6 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 511195a2058e..330ef04ca51a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -252,7 +252,7 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 	.dccm2_len = IWL_22000_DCCM2_LEN,				\
 	.smem_offset = IWL_22000_SMEM_OFFSET,				\
 	.smem_len = IWL_22000_SMEM_LEN,					\
-	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,		\
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,	\
 	.apmg_not_supported = true,					\
 	.trans.mq_rx_supported = true,					\
 	.vht_mu_mimo_supported = true,					\
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 4a74c0ea0f31..e73cc7380a26 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -177,6 +177,17 @@ enum iwl_tx_offload_assist_flags_pos {
 #define IWL_TX_CMD_OFFLD_MH_MASK	0x1f
 #define IWL_TX_CMD_OFFLD_IP_HDR_MASK	0x3f
 
+enum iwl_tx_offload_assist_bz {
+	IWL_TX_CMD_OFFLD_BZ_RESULT_OFFS		= 0x000003ff,
+	IWL_TX_CMD_OFFLD_BZ_START_OFFS		= 0x001ff800,
+	IWL_TX_CMD_OFFLD_BZ_MH_LEN		= 0x07c00000,
+	IWL_TX_CMD_OFFLD_BZ_MH_PAD		= 0x08000000,
+	IWL_TX_CMD_OFFLD_BZ_AMSDU		= 0x10000000,
+	IWL_TX_CMD_OFFLD_BZ_ZERO2ONES		= 0x20000000,
+	IWL_TX_CMD_OFFLD_BZ_ENABLE_CSUM		= 0x40000000,
+	IWL_TX_CMD_OFFLD_BZ_PARTIAL_CSUM	= 0x80000000,
+};
+
 /* TODO: complete documentation for try_cnt and btkill_cnt */
 /**
  * struct iwl_tx_cmd - TX command struct to FW
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 95be04ba9390..e122b8b4e1fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -84,7 +84,10 @@ enum iwl_nvm_type {
 #define IWL_DEFAULT_MAX_TX_POWER 22
 #define IWL_TX_CSUM_NETIF_FLAGS (NETIF_F_IPV6_CSUM | NETIF_F_IP_CSUM |\
 				 NETIF_F_TSO | NETIF_F_TSO6)
-#define IWL_CSUM_NETIF_FLAGS_MASK (IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM)
+#define IWL_TX_CSUM_NETIF_FLAGS_BZ (NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6)
+#define IWL_CSUM_NETIF_FLAGS_MASK (IWL_TX_CSUM_NETIF_FLAGS | \
+				   IWL_TX_CSUM_NETIF_FLAGS_BZ | \
+				   NETIF_F_RXCSUM)
 
 /* Antenna presence definitions */
 #define	ANT_NONE	0x0
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 761a9b62ac22..efda37645fd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5523,6 +5523,10 @@ static bool iwl_mvm_mac_can_aggregate(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		return iwl_mvm_tx_csum_bz(mvm, head, true) ==
+		       iwl_mvm_tx_csum_bz(mvm, skb, true);
+
 	/* For now don't aggregate IPv6 in AMSDU */
 	if (skb->protocol != htons(ETH_P_IP))
 		return false;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1393e5de2e9a..3d010afc69bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1518,6 +1518,7 @@ void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq);
 unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 				    struct ieee80211_sta *sta,
 				    unsigned int tid);
+u32 iwl_mvm_tx_csum_bz(struct iwl_mvm *mvm, struct sk_buff *skb, bool amsdu);
 
 #ifdef CONFIG_IWLWIFI_DEBUG
 const char *iwl_mvm_get_tx_fail_reason(u32 status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6fb140ffd87c..ac4812e3db03 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -39,11 +39,10 @@ iwl_mvm_bar_check_trigger(struct iwl_mvm *mvm, const u8 *addr,
 #define OPT_HDR(type, skb, off) \
 	(type *)(skb_network_header(skb) + (off))
 
-static u16 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
-			   struct ieee80211_hdr *hdr,
-			   struct ieee80211_tx_info *info,
-			   bool amsdu)
+static u16 iwl_mvm_tx_csum_pre_bz(struct iwl_mvm *mvm, struct sk_buff *skb,
+				  struct ieee80211_tx_info *info, bool amsdu)
 {
+	struct ieee80211_hdr *hdr = (void *)skb->data;
 	u16 offload_assist = 0;
 #if IS_ENABLED(CONFIG_INET)
 	u16 mh_len = ieee80211_hdrlen(hdr->frame_control);
@@ -141,6 +140,54 @@ static u16 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 	return offload_assist;
 }
 
+u32 iwl_mvm_tx_csum_bz(struct iwl_mvm *mvm, struct sk_buff *skb, bool amsdu)
+{
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+	u32 offload_assist = IWL_TX_CMD_OFFLD_BZ_PARTIAL_CSUM;
+	unsigned int hdrlen = ieee80211_hdrlen(hdr->frame_control);
+	unsigned int csum_start = skb_checksum_start_offset(skb);
+
+	offload_assist |= u32_encode_bits(hdrlen / 2,
+					  IWL_TX_CMD_OFFLD_BZ_MH_LEN);
+	if (amsdu)
+		offload_assist |= IWL_TX_CMD_OFFLD_BZ_AMSDU;
+	else if (hdrlen % 4)
+		/* padding is inserted later in transport */
+		offload_assist |= IWL_TX_CMD_OFFLD_BZ_MH_PAD;
+
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return offload_assist;
+
+	offload_assist |= IWL_TX_CMD_OFFLD_BZ_ENABLE_CSUM |
+			  IWL_TX_CMD_OFFLD_BZ_ZERO2ONES;
+
+	/*
+	 * mac80211 will always calculate checksum in software for
+	 * non-fast-xmit, and so we can only do offloaded checksum
+	 * for fast-xmit frames. In this case, we always have the
+	 * RFC 1042 header present. skb_checksum_start_offset()
+	 * returns the offset from the beginning, but the hardware
+	 * needs it from after the header & SNAP header.
+	 */
+	csum_start -= hdrlen + 8;
+
+	offload_assist |= u32_encode_bits(csum_start,
+					  IWL_TX_CMD_OFFLD_BZ_START_OFFS);
+	offload_assist |= u32_encode_bits(csum_start + skb->csum_offset,
+					  IWL_TX_CMD_OFFLD_BZ_RESULT_OFFS);
+
+	return offload_assist;
+}
+
+static u32 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
+			   struct ieee80211_tx_info *info,
+			   bool amsdu)
+{
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_BZ)
+		return iwl_mvm_tx_csum_pre_bz(mvm, skb, info, amsdu);
+	return iwl_mvm_tx_csum_bz(mvm, skb, amsdu);
+}
+
 /*
  * Sets most of the Tx cmd's fields
  */
@@ -240,7 +287,7 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 	tx_cmd->sta_id = sta_id;
 
 	tx_cmd->offload_assist =
-		cpu_to_le16(iwl_mvm_tx_csum(mvm, skb, hdr, info, amsdu));
+		cpu_to_le16(iwl_mvm_tx_csum_pre_bz(mvm, skb, info, amsdu));
 }
 
 static u32 iwl_mvm_get_tx_ant(struct iwl_mvm *mvm,
@@ -461,7 +508,6 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	dev_cmd->hdr.cmd = TX_CMD;
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
-		u16 offload_assist;
 		u32 rate_n_flags = 0;
 		u16 flags = 0;
 		struct iwl_mvm_sta *mvmsta = sta ?
@@ -474,8 +520,6 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			amsdu = *qc & IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 		}
 
-		offload_assist = iwl_mvm_tx_csum(mvm, skb, hdr, info, amsdu);
-
 		if (!info->control.hw_key)
 			flags |= IWL_TX_FLAGS_ENCRYPT_DIS;
 
@@ -495,6 +539,8 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		if (mvm->trans->trans_cfg->device_family >=
 		    IWL_DEVICE_FAMILY_AX210) {
 			struct iwl_tx_cmd_gen3 *cmd = (void *)dev_cmd->payload;
+			u32 offload_assist = iwl_mvm_tx_csum(mvm, skb,
+							     info, amsdu);
 
 			cmd->offload_assist = cpu_to_le32(offload_assist);
 
@@ -508,6 +554,9 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			cmd->rate_n_flags = cpu_to_le32(rate_n_flags);
 		} else {
 			struct iwl_tx_cmd_gen2 *cmd = (void *)dev_cmd->payload;
+			u16 offload_assist = iwl_mvm_tx_csum_pre_bz(mvm, skb,
+								    info,
+								    amsdu);
 
 			cmd->offload_assist = cpu_to_le16(offload_assist);
 
-- 
2.34.1

