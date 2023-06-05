Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4887233B7
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 01:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjFEXit (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 19:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjFEXis (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 19:38:48 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0348CD
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 16:38:47 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2CA92B80067
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 23:38:45 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6624513C2B0;
        Mon,  5 Jun 2023 16:38:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6624513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1686008324;
        bh=91GlGhrl0r5GqtGFm1UzBW8mY52sMLHQ8cpqebx7Sv8=;
        h=From:To:Cc:Subject:Date:From;
        b=rhRNpZStxYz6Yuch2oHXcYlrYiwDK5rPVVOhJOpMCkrQ0Fj2sWXoK7rMNVHm+C4A8
         vk/nE0qybrl9bP95BHEsaRa0UIA295SmiNvbml9H8Std/eq5teKq7GaNbw2oFjS79M
         Y4oj06CEDHbsTHfzwJwrfjxwvTKxqMI79O5SHTw4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: iwlwifi: Add ethtool stats for txo frames
Date:   Mon,  5 Jun 2023 16:38:42 -0700
Message-Id: <20230605233842.497070-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1686008325-bxqmXxOFsXyp
X-MDID-O: us5;at1;1686008325;bxqmXxOFsXyp;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Flag skbs that have txo settings applied, and gather
some tx stats specific to those.  Used for more
detailed reporting.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

Based on iwlwifi-backports tree, and on top of my
previous patches to iwlwifi.

 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 10 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 26 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 33 ++++++++++++++++---
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b5703687d990..daf6a0eab682 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -6485,6 +6485,11 @@ static const char iwl_mvm_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"tx_mpdu_fail",  /* frames that failed even after retry */
 	"tx_mpdu_retry", /* number of times frames were retried */
 
+	"txo_tx_mpdu_attempts", /* counting any retries, txo frames */
+	"txo_tx_mpdu_fail",  /* frames that failed even after retry, txo frames */
+	"txo_tx_mpdu_retry", /* number of times frames were retried, txo frames */
+	"txo_tx_mpdu_ok", /* frames that succeeded, perhaps after retry, txo frames */
+
 	"tx_direct_done",
 	"tx_postpone_delay",
 	"tx_postpone_few_bytes",
@@ -6649,6 +6654,11 @@ void iwl_mvm_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->tx_mpdu_fail;
 	data[ei++] = mib->tx_mpdu_retry;
 
+	data[ei++] = mib->txo_tx_mpdu_attempts;
+	data[ei++] = mib->txo_tx_mpdu_fail;
+	data[ei++] = mib->txo_tx_mpdu_retry;
+	data[ei++] = mib->txo_tx_mpdu_ok;
+
 	data[ei++] = mib->tx_status_counts[TX_STATUS_DIRECT_DONE];
 	data[ei++] = mib->tx_status_counts[TX_STATUS_POSTPONE_DELAY];
 	data[ei++] = mib->tx_status_counts[TX_STATUS_POSTPONE_FEW_BYTES];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a0f3075d19ed..d322ee000e0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -579,6 +579,11 @@ struct iwl_mvm_ethtool_stats {
 	u64 tx_mpdu_fail; /* Failed even after retry */
 	u64 tx_mpdu_retry; /* Number of times frames were retried */
 
+	unsigned long txo_tx_mpdu_attempts; /* counting any retries, txo frames */
+	unsigned long txo_tx_mpdu_fail; /* frames that failed even after retry, txo frames */
+	unsigned long txo_tx_mpdu_ok; /* tx frames */
+	unsigned long txo_tx_mpdu_retry; /* number of times frames were retried, txo frames */
+
 	/* maps to iwl_tx_status enum
 	 * (TX_STATUS_INTERNAL_ABORT + 1) gathers all larger values.
 	 */
@@ -902,6 +907,27 @@ struct iwl_time_sync_data {
 	bool active;
 };
 
+/* skb->cb usage for mvm
+ * driver_data[0]: Holds iwl_tx_cb struct.
+ * driver_data[1]: holds pointer to struct iwl_device_tx_cmd (maybe unused?)
+ * driver_data[2]: cb + cb_data_offs, points to mac header page.
+ * driver_data[3]: dev_cmd_offs: cb + cb_data_offs + sizeof(void*),
+ *                 holds pointer to struct iwl_device_tx_cmd.
+ * driver_data[4]: unused
+ */
+
+#define IWL_TX_CB_TXO_USED		BIT(0)
+struct iwl_tx_cb {
+	u8 flags;
+};
+
+static inline struct iwl_tx_cb *iwl_tx_skb_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct iwl_tx_cb) >
+		     sizeof(IEEE80211_SKB_CB(skb)->driver_data[0]));
+	return ((void *)&(IEEE80211_SKB_CB(skb)->driver_data[0]));
+}
+
 struct iwl_txo_data {
 	struct rcu_head rcu_head;
 	u8 txo_active; /* tx overrides are active */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index f14aea39b70e..975df8f082ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -677,6 +677,9 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct iwl_device_tx_cmd *dev_cmd;
 	struct iwl_tx_cmd *tx_cmd;
 	__le16 fc = hdr->frame_control;
+	struct iwl_tx_cb *cb = iwl_tx_skb_cb(skb);
+
+	cb->flags = 0;
 
 	dev_cmd = iwl_trans_alloc_tx_cmd(mvm->trans);
 
@@ -718,6 +721,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 			/* Check td again, un-protected access above was lazy check. */
 			if (td && td->txo_active) {
+				cb->flags |= IWL_TX_CB_TXO_USED;
 				flags |= IWL_TX_FLAGS_CMD_RATE;
 				rate_n_flags = iwl_mvm_get_txo_rate_n_flags(mvm, td);
 			}
@@ -779,11 +783,13 @@ static void iwl_mvm_skb_prepare_status(struct sk_buff *skb,
 				       struct iwl_device_tx_cmd *cmd)
 {
 	struct ieee80211_tx_info *skb_info = IEEE80211_SKB_CB(skb);
+	struct iwl_tx_cb cb = *iwl_tx_skb_cb(skb);
 
 	memset(&skb_info->status, 0, sizeof(skb_info->status));
 	memset(skb_info->driver_data, 0, sizeof(skb_info->driver_data));
 
 	skb_info->driver_data[1] = cmd;
+	*iwl_tx_skb_cb(skb) = cb; /* re-apply this driver info */
 }
 
 static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
@@ -1761,7 +1767,8 @@ static void iwl_mvm_tx_status_check_trigger(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_update_tx_stats(struct iwl_mvm *mvm, struct sk_buff *skb, u32 status)
+static void iwl_mvm_update_tx_stats(struct iwl_mvm *mvm, struct sk_buff *skb, u32 status,
+				    struct iwl_tx_cb *cb)
 {
 	u32 idx = status & TX_STATUS_MSK;
 
@@ -1769,10 +1776,15 @@ static void iwl_mvm_update_tx_stats(struct iwl_mvm *mvm, struct sk_buff *skb, u3
 		idx = TX_STATUS_INTERNAL_ABORT + 1;
 
 	mvm->ethtool_stats.tx_status_counts[idx]++;
-	if (idx == TX_STATUS_SUCCESS)
+	if (idx == TX_STATUS_SUCCESS) {
 		mvm->ethtool_stats.tx_bytes_nic += skb->len;
-	else
+		if (cb->flags & IWL_TX_CB_TXO_USED)
+			mvm->ethtool_stats.txo_tx_mpdu_ok++;
+	} else {
 		mvm->ethtool_stats.tx_mpdu_fail++;
+		if (cb->flags & IWL_TX_CB_TXO_USED)
+			mvm->ethtool_stats.txo_tx_mpdu_fail++;
+	}
 }
 
 /*
@@ -1867,6 +1879,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 		struct ieee80211_hdr *hdr = (void *)skb->data;
 		bool flushed = false;
+		struct iwl_tx_cb cb = *iwl_tx_skb_cb(skb);
 
 		skb_freed++;
 
@@ -1915,6 +1928,10 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 
 		mvm->ethtool_stats.tx_mpdu_attempts += info->status.rates[0].count;
 		mvm->ethtool_stats.tx_mpdu_retry += tx_resp->failure_frame;
+		if (cb.flags & IWL_TX_CB_TXO_USED) {
+			mvm->ethtool_stats.txo_tx_mpdu_attempts += info->status.rates[0].count;
+			mvm->ethtool_stats.txo_tx_mpdu_retry += tx_resp->failure_frame;
+		}
 
 		iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw,
 					    le32_to_cpu(tx_resp->initial_rate),
@@ -1963,7 +1980,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 		info->status.status_driver_data[0] =
 			RS_DRV_DATA_PACK(lq_color, tx_resp->reduced_tpc);
 
-		iwl_mvm_update_tx_stats(mvm, skb, status);
+		iwl_mvm_update_tx_stats(mvm, skb, status, &cb);
 
 #ifdef CONFIG_IWLMVM_TDLS_PEER_CACHE
 		if (info->flags & IEEE80211_TX_STAT_ACK)
@@ -2229,6 +2246,14 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 
 	skb_queue_walk(&reclaimed_skbs, skb) {
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		struct iwl_tx_cb *cb = iwl_tx_skb_cb(skb);
+
+		if (!is_flush) {
+			if (cb->flags & IWL_TX_CB_TXO_USED) {
+				mvm->ethtool_stats.txo_tx_mpdu_attempts++;
+				mvm->ethtool_stats.txo_tx_mpdu_ok++;
+			}
+		}
 
 		iwl_trans_free_tx_cmd(mvm->trans, info->driver_data[1]);
 
-- 
2.40.0

