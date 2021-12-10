Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3446FD80
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhLJJQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 04:16:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50926 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231529AbhLJJQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 04:16:35 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvbxa-001FED-Ha; Fri, 10 Dec 2021 11:12:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 11:12:44 +0200
Message-Id: <iwlwifi.20211210110539.796ae29c90d9.Icb2f07905bebd9ed4537ca4c453069211ea71799@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210091245.289008-1-luca@coelho.fi>
References: <20211210091245.289008-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/10] iwlwifi: mvm: isolate offload assist (checksum) calculation
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Isolate the entire calculation of the offload_assist field used
for HW checksumming to the iwl_mvm_tx_csum function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 45 +++++++++------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1883d98abb2f..6fb140ffd87c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -42,8 +42,9 @@ iwl_mvm_bar_check_trigger(struct iwl_mvm *mvm, const u8 *addr,
 static u16 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 			   struct ieee80211_hdr *hdr,
 			   struct ieee80211_tx_info *info,
-			   u16 offload_assist)
+			   bool amsdu)
 {
+	u16 offload_assist = 0;
 #if IS_ENABLED(CONFIG_INET)
 	u16 mh_len = ieee80211_hdrlen(hdr->frame_control);
 	u8 protocol = 0;
@@ -106,8 +107,7 @@ static u16 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 	offload_assist |= (4 << TX_CMD_OFFLD_IP_HDR);
 
 	/* Do IPv4 csum for AMSDU only (no IP csum for Ipv6) */
-	if (skb->protocol == htons(ETH_P_IP) &&
-	    (offload_assist & BIT(TX_CMD_OFFLD_AMSDU))) {
+	if (skb->protocol == htons(ETH_P_IP) && amsdu) {
 		ip_hdr(skb)->check = 0;
 		offload_assist |= BIT(TX_CMD_OFFLD_L3_EN);
 	}
@@ -132,6 +132,12 @@ static u16 iwl_mvm_tx_csum(struct iwl_mvm *mvm, struct sk_buff *skb,
 
 out:
 #endif
+	if (amsdu)
+		offload_assist |= BIT(TX_CMD_OFFLD_AMSDU);
+	else if (ieee80211_hdrlen(hdr->frame_control) % 4)
+		/* padding is inserted later in transport */
+		offload_assist |= BIT(TX_CMD_OFFLD_PAD);
+
 	return offload_assist;
 }
 
@@ -146,7 +152,7 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 	__le16 fc = hdr->frame_control;
 	u32 tx_flags = le32_to_cpu(tx_cmd->tx_flags);
 	u32 len = skb->len + FCS_LEN;
-	u16 offload_assist = 0;
+	bool amsdu = false;
 	u8 ac;
 
 	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK) ||
@@ -166,8 +172,7 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 		u8 *qc = ieee80211_get_qos_ctl(hdr);
 		tx_cmd->tid_tspec = qc[0] & 0xf;
 		tx_flags &= ~TX_CMD_FLG_SEQ_CTL;
-		if (*qc & IEEE80211_QOS_CTL_A_MSDU_PRESENT)
-			offload_assist |= BIT(TX_CMD_OFFLD_AMSDU);
+		amsdu = *qc & IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 	} else if (ieee80211_is_back_req(fc)) {
 		struct ieee80211_bar *bar = (void *)skb->data;
 		u16 control = le16_to_cpu(bar->control);
@@ -234,14 +239,8 @@ void iwl_mvm_set_tx_cmd(struct iwl_mvm *mvm, struct sk_buff *skb,
 	tx_cmd->life_time = cpu_to_le32(TX_CMD_LIFE_TIME_INFINITE);
 	tx_cmd->sta_id = sta_id;
 
-	/* padding is inserted later in transport */
-	if (ieee80211_hdrlen(fc) % 4 &&
-	    !(offload_assist & BIT(TX_CMD_OFFLD_AMSDU)))
-		offload_assist |= BIT(TX_CMD_OFFLD_PAD);
-
-	tx_cmd->offload_assist |=
-		cpu_to_le16(iwl_mvm_tx_csum(mvm, skb, hdr, info,
-					    offload_assist));
+	tx_cmd->offload_assist =
+		cpu_to_le16(iwl_mvm_tx_csum(mvm, skb, hdr, info, amsdu));
 }
 
 static u32 iwl_mvm_get_tx_ant(struct iwl_mvm *mvm,
@@ -462,26 +461,20 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	dev_cmd->hdr.cmd = TX_CMD;
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
-		u16 offload_assist = 0;
+		u16 offload_assist;
 		u32 rate_n_flags = 0;
 		u16 flags = 0;
 		struct iwl_mvm_sta *mvmsta = sta ?
 			iwl_mvm_sta_from_mac80211(sta) : NULL;
+		bool amsdu = false;
 
 		if (ieee80211_is_data_qos(hdr->frame_control)) {
 			u8 *qc = ieee80211_get_qos_ctl(hdr);
 
-			if (*qc & IEEE80211_QOS_CTL_A_MSDU_PRESENT)
-				offload_assist |= BIT(TX_CMD_OFFLD_AMSDU);
+			amsdu = *qc & IEEE80211_QOS_CTL_A_MSDU_PRESENT;
 		}
 
-		offload_assist = iwl_mvm_tx_csum(mvm, skb, hdr, info,
-						 offload_assist);
-
-		/* padding is inserted later in transport */
-		if (ieee80211_hdrlen(hdr->frame_control) % 4 &&
-		    !(offload_assist & BIT(TX_CMD_OFFLD_AMSDU)))
-			offload_assist |= BIT(TX_CMD_OFFLD_PAD);
+		offload_assist = iwl_mvm_tx_csum(mvm, skb, hdr, info, amsdu);
 
 		if (!info->control.hw_key)
 			flags |= IWL_TX_FLAGS_ENCRYPT_DIS;
@@ -503,7 +496,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		    IWL_DEVICE_FAMILY_AX210) {
 			struct iwl_tx_cmd_gen3 *cmd = (void *)dev_cmd->payload;
 
-			cmd->offload_assist |= cpu_to_le32(offload_assist);
+			cmd->offload_assist = cpu_to_le32(offload_assist);
 
 			/* Total # bytes to be transmitted */
 			cmd->len = cpu_to_le16((u16)skb->len);
@@ -516,7 +509,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		} else {
 			struct iwl_tx_cmd_gen2 *cmd = (void *)dev_cmd->payload;
 
-			cmd->offload_assist |= cpu_to_le16(offload_assist);
+			cmd->offload_assist = cpu_to_le16(offload_assist);
 
 			/* Total # bytes to be transmitted */
 			cmd->len = cpu_to_le16((u16)skb->len);
-- 
2.34.1

