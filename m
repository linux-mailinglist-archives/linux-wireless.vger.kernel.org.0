Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D330EB4B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 04:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhBDD5a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Feb 2021 22:57:30 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:23533 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhBDD5A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Feb 2021 22:57:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612411000; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=L06AwncjbZKouGfESXAlAQvZPGJw8fwyW/N1MJfhov4=; b=cJM3z+g5mwmkd8Z4j1/KcR7aXHUKei/o1VWd4SY7SakQkoMXxH6iO8q1PnLynF1xiB7sN15u
 +sgOeEkyoAcYuWIKI0vzMukqgPV4uDfvCvI29KwxUJdBsOHirN2g77AjA/Jf1uyxB0TMX32t
 /q7ljlVR7206fOOPS5kFmr9mLCg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 601b705c4c7254588af8dc2e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Feb 2021 03:56:12
 GMT
Sender: periyasa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9767AC43461; Thu,  4 Feb 2021 03:56:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 342E9C433CA;
        Thu,  4 Feb 2021 03:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 342E9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH v2] ath11k: Update tx descriptor search index properly
Date:   Thu,  4 Feb 2021 09:26:00 +0530
Message-Id: <1612410960-9120-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tx descriptor search index field should be updated with hw peer id
and not by AST Hash as per the HW/FW recommendation. Incorrect search
index causes throughput degradation in all scenario for all the
platforms. so updated the search index field with hw peer id, which
is a common change applicable for all the platforms. Also no need of these
configuration for non station type. seen 10% throughput increase in WDS
traffic with this change.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 v2:
  - updated the commit message with more details

 drivers/net/wireless/ath/ath11k/core.h   | 1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c  | 8 ++++++--
 drivers/net/wireless/ath/ath11k/dp_tx.c  | 1 +
 drivers/net/wireless/ath/ath11k/hal_tx.c | 2 ++
 drivers/net/wireless/ath/ath11k/hal_tx.h | 1 +
 drivers/net/wireless/ath/ath11k/peer.c   | 9 +++++++--
 drivers/net/wireless/ath/ath11k/peer.h   | 3 ++-
 7 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9db375b..8d29845 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -200,6 +200,7 @@ struct ath11k_vif {
 	u32 beacon_interval;
 	u32 dtim_period;
 	u16 ast_hash;
+	u16 ast_idx;
 	u16 tcl_metadata;
 	u8 hal_addr_search_flags;
 	u8 search_type;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 42328a0..2d90b80 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1652,6 +1652,7 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 	u8 mac_addr[ETH_ALEN];
 	u16 peer_mac_h16;
 	u16 ast_hash;
+	u16 hw_peer_id;
 
 	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "dp_htt rx msg type :0x%0x\n", type);
 
@@ -1672,7 +1673,7 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 					 resp->peer_map_ev.info1);
 		ath11k_dp_get_mac_addr(resp->peer_map_ev.mac_addr_l32,
 				       peer_mac_h16, mac_addr);
-		ath11k_peer_map_event(ab, vdev_id, peer_id, mac_addr, 0);
+		ath11k_peer_map_event(ab, vdev_id, peer_id, mac_addr, 0, 0);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_MAP2:
 		vdev_id = FIELD_GET(HTT_T2H_PEER_MAP_INFO_VDEV_ID,
@@ -1685,7 +1686,10 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 				       peer_mac_h16, mac_addr);
 		ast_hash = FIELD_GET(HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL,
 				     resp->peer_map_ev.info2);
-		ath11k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash);
+		hw_peer_id = FIELD_GET(HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID,
+				       resp->peer_map_ev.info1);
+		ath11k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
+				      hw_peer_id);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_UNMAP:
 	case HTT_T2H_MSG_TYPE_PEER_UNMAP2:
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 6a3fcea..1a0b9be 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -165,6 +165,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 	ti.pkt_offset = 0;
 	ti.lmac_id = ar->lmac_id;
 	ti.bss_ast_hash = arvif->ast_hash;
+	ti.bss_ast_idx = arvif->ast_idx;
 	ti.dscp_tid_tbl_idx = 0;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL &&
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index a755aa8..569e790 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -71,6 +71,8 @@ void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
 	tcl_cmd->info3 = FIELD_PREP(HAL_TCL_DATA_CMD_INFO3_DSCP_TID_TABLE_IDX,
 				    ti->dscp_tid_tbl_idx) |
 			 FIELD_PREP(HAL_TCL_DATA_CMD_INFO3_SEARCH_INDEX,
+				    ti->bss_ast_idx) |
+			 FIELD_PREP(HAL_TCL_DATA_CMD_INFO3_CACHE_SET_NUM,
 				    ti->bss_ast_hash);
 	tcl_cmd->info4 = 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index d4760a2..c291e59 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -29,6 +29,7 @@ struct hal_tx_info {
 	u32 flags1; /* %HAL_TCL_DATA_CMD_INFO2_ */
 	u16 addr_search_flags; /* %HAL_TCL_DATA_CMD_INFO0_ADDR(X/Y)_ */
 	u16 bss_ast_hash;
+	u16 bss_ast_idx;
 	u8 tid;
 	u8 search_type; /* %HAL_TX_ADDR_SEARCH_ */
 	u8 lmac_id;
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index b69e7eb..f49abefa 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -118,7 +118,7 @@ void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id)
 }
 
 void ath11k_peer_map_event(struct ath11k_base *ab, u8 vdev_id, u16 peer_id,
-			   u8 *mac_addr, u16 ast_hash)
+			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id)
 {
 	struct ath11k_peer *peer;
 
@@ -132,6 +132,7 @@ void ath11k_peer_map_event(struct ath11k_base *ab, u8 vdev_id, u16 peer_id,
 		peer->vdev_id = vdev_id;
 		peer->peer_id = peer_id;
 		peer->ast_hash = ast_hash;
+		peer->hw_peer_id = hw_peer_id;
 		ether_addr_copy(peer->addr, mac_addr);
 		list_add(&peer->list, &ab->peers);
 		wake_up(&ab->peer_mapping_wq);
@@ -309,7 +310,11 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 
 	peer->pdev_idx = ar->pdev_idx;
 	peer->sta = sta;
-	arvif->ast_hash = peer->ast_hash;
+
+	if (arvif->vif->type == NL80211_IFTYPE_STATION) {
+		arvif->ast_hash = peer->ast_hash;
+		arvif->ast_idx = peer->hw_peer_id;
+	}
 
 	peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
 	peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 8553ed0..619db00 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -14,6 +14,7 @@ struct ath11k_peer {
 	int peer_id;
 	u16 ast_hash;
 	u8 pdev_idx;
+	u16 hw_peer_id;
 
 	/* protected by ab->data_lock */
 	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
@@ -31,7 +32,7 @@ struct ath11k_peer {
 
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
 void ath11k_peer_map_event(struct ath11k_base *ab, u8 vdev_id, u16 peer_id,
-			   u8 *mac_addr, u16 ast_hash);
+			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
 struct ath11k_peer *ath11k_peer_find(struct ath11k_base *ab, int vdev_id,
 				     const u8 *addr);
 struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
-- 
2.7.4

