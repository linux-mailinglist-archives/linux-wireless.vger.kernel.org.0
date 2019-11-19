Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D5101A3F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 08:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKSHT6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 02:19:58 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:43562
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfKSHT5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 02:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574147996;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=QfWMUb0yyAVE/pQJIGr9kj7ihaPp/0bU19kE5RFsRVY=;
        b=i9C7eYZFMJWv2T56weUvem1SmIwaeWjLwYyeC6B8x2mULjaxvMFkzBIXXPrLVMhC
        Z5+cTJRex6HPn62i/FW2m1uBfpJaS5suH5uubbFSnECLpy1Ml9zpBwusxQGMDUqx4ES
        5wU4WtEzYIaBOQFG6R0SdrELLWaEJV52VXF8sbUs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574147996;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=QfWMUb0yyAVE/pQJIGr9kj7ihaPp/0bU19kE5RFsRVY=;
        b=cljSIdVGtnny1N9m4Pcee/o+/2m4Tz37jUSHJsfiTZigMZDsme5MvxSRzfz9nnKG
        NcAq4WcDHgr4e3boOvEhBdnJG3QOrb6yLLAvoeUtvlQ96LuZ8bcp+NiS6XsWLfIHOBJ
        jDjEGExieWvw572mOvT7Luj7srOUzp3K6dfR1zfE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6699CC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=yyuwang@codeaurora.org
From:   Yu Wang <yyuwang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 1/2] ath10k: add ppdu stats support for QCA6174/QCA9377
Date:   Tue, 19 Nov 2019 07:19:56 +0000
Message-ID: <0101016e82883b59-e52fb973-84a7-4c15-a236-c7a01390087b-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574147982-3956-1-git-send-email-yyuwang@codeaurora.org>
References: <1574147982-3956-1-git-send-email-yyuwang@codeaurora.org>
X-SES-Outgoing: 2019.11.19-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When QCA6174/QCA9377 working in station mode, after connected
to AP, tx bitrate is always '1.0 MBit/s' in output of command
'iw wlan0 link'.

That's because the parameters to calculate the tx bitrate are
not well updated for QCA6174/QCA9377.

To fix this issue:
1. Add processing for HTT_T2H_MSG_TYPE_PPDU_STATS_IND which includes
   the peer tx stats;
2. Map WMI_TLV_SERVICE_PEER_STATS_INFO to WMI_SERVICE_PEER_STATS to
   enable the feature.

Tested with QCA6174 PCIe with firmware WLAN.RM.4.4.1.c3-00031.
Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt.c     |  2 +
 drivers/net/wireless/ath/ath10k/htt.h     | 30 ++++++++++++++
 drivers/net/wireless/ath/ath10k/htt_rx.c  | 65 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  4 ++
 drivers/net/wireless/ath/ath10k/wmi-tlv.h |  3 ++
 5 files changed, 104 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt.c b/drivers/net/wireless/ath/ath10k/htt.c
index 7b75200..c32ab07 100644
--- a/drivers/net/wireless/ath/ath10k/htt.c
+++ b/drivers/net/wireless/ath/ath10k/htt.c
@@ -89,6 +89,8 @@ static const enum htt_t2h_msg_type htt_tlv_t2h_msg_types[] = {
 	[HTT_TLV_T2H_MSG_TYPE_RX_OFLD_PKT_ERR] =
 		HTT_T2H_MSG_TYPE_RX_OFLD_PKT_ERR,
 	[HTT_TLV_T2H_MSG_TYPE_TEST] = HTT_T2H_MSG_TYPE_TEST,
+	[HTT_TLV_T2H_MSG_TYPE_PPDU_STATS_IND] =
+		HTT_T2H_MSG_TYPE_PPDU_STATS_IND,
 };
 
 static const enum htt_t2h_msg_type htt_10_4_t2h_msg_types[] = {
diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 30c0800..e2aae263 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -450,6 +450,13 @@ enum htt_tlv_t2h_msg_type {
 	HTT_TLV_T2H_MSG_TYPE_WDI_IPA_OP_RESPONSE       = 0x14,
 	HTT_TLV_T2H_MSG_TYPE_CHAN_CHANGE               = 0x15,
 	HTT_TLV_T2H_MSG_TYPE_RX_OFLD_PKT_ERR           = 0x16,
+	HTT_TLV_T2H_MSG_TYPE_RATE_REPORT               = 0x17,
+	HTT_TLV_T2H_MSG_TYPE_FLOW_POOL_MAP             = 0x18,
+	HTT_TLV_T2H_MSG_TYPE_FLOW_POOL_UNMAP           = 0x19,
+	HTT_TLV_T2H_MSG_TYPE_SRING_SETUP_DONE          = 0x1a,
+	HTT_TLV_T2H_MSG_TYPE_MAP_FLOW_INFO             = 0x1b,
+	HTT_TLV_T2H_MSG_TYPE_EXT_STATS_CONF            = 0x1c,
+	HTT_TLV_T2H_MSG_TYPE_PPDU_STATS_IND            = 0x1d,
 	HTT_TLV_T2H_MSG_TYPE_TEST,
 	/* keep this last */
 	HTT_TLV_T2H_NUM_MSGS
@@ -519,6 +526,7 @@ enum htt_t2h_msg_type {
 	HTT_T2H_MSG_TYPE_TX_FETCH_CONFIRM,
 	HTT_T2H_MSG_TYPE_TX_MODE_SWITCH_IND,
 	HTT_T2H_MSG_TYPE_PEER_STATS,
+	HTT_T2H_MSG_TYPE_PPDU_STATS_IND,
 	/* keep this last */
 	HTT_T2H_NUM_MSGS
 };
@@ -1750,6 +1758,27 @@ struct htt_peer_tx_stats {
 	u8 payload[0];
 } __packed;
 
+struct htt_tx_ppdu_stats_info {
+	__le32 tlv_hdr;
+	__le32 tx_success_bytes;
+	__le32 tx_retry_bytes;
+	__le32 tx_failed_bytes;
+	u8 tx_ratecode;
+	u8 flags;
+	__le16 peer_id;
+	__le16 tx_success_msdus;
+	__le16 tx_retry_msdus;
+	__le16 tx_failed_msdus;
+	__le16 tx_duration;
+} __packed;
+
+struct htt_ppdu_stats {
+	u8 pad[3];
+	__le32 tlv_hdr;
+	__le32 num_ppdu;
+	struct htt_tx_ppdu_stats_info tx_ppdu_stats[0];
+} __packed;
+
 #define ATH10K_10_2_TX_STATS_OFFSET	136
 #define PEER_STATS_FOR_NO_OF_PPDUS	4
 
@@ -1823,6 +1852,7 @@ struct htt_resp {
 		struct htt_tx_mode_switch_ind tx_mode_switch_ind;
 		struct htt_channel_change chan_change;
 		struct htt_peer_tx_stats peer_tx_stats;
+		struct htt_ppdu_stats ppdu_stats;
 	};
 } __packed;
 
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index d95b63f..cde2d9b 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3723,6 +3723,68 @@ static void ath10k_htt_rx_sec_ind_handler(struct ath10k *ar,
 	spin_unlock_bh(&ar->data_lock);
 }
 
+static void
+ath10k_htt_process_ppdu_stats(struct ath10k *ar, struct sk_buff *skb)
+{
+	struct htt_resp *resp = (struct htt_resp *)skb->data;
+	struct ath10k_per_peer_tx_stats *p_tx_stats = &ar->peer_tx_stats;
+	struct htt_tx_ppdu_stats_info *tx_stats;
+	struct ieee80211_sta *sta;
+	struct ath10k_sta *arsta;
+	struct ath10k_peer *peer;
+	u32 peer_id, i;
+	u8 num_ppdu;
+
+	num_ppdu = resp->ppdu_stats.num_ppdu;
+	tx_stats = &resp->ppdu_stats.tx_ppdu_stats[0];
+	peer_id = __le16_to_cpu(tx_stats->peer_id);
+
+	rcu_read_lock();
+	spin_lock_bh(&ar->data_lock);
+
+	peer = ath10k_peer_find_by_id(ar, peer_id);
+	if (!peer)
+		goto err;
+
+	sta = peer->sta;
+	if (!sta)
+		goto err;
+
+	for (i = 0; i < num_ppdu; i++) {
+		tx_stats = &resp->ppdu_stats.tx_ppdu_stats[i];
+		arsta = (struct ath10k_sta *)sta->drv_priv;
+
+		p_tx_stats->succ_bytes =
+			__le32_to_cpu(tx_stats->tx_success_bytes);
+		p_tx_stats->retry_bytes =
+			__le32_to_cpu(tx_stats->tx_retry_bytes);
+		p_tx_stats->failed_bytes =
+			__le32_to_cpu(tx_stats->tx_failed_bytes);
+		p_tx_stats->ratecode = tx_stats->tx_ratecode;
+		p_tx_stats->flags = tx_stats->flags;
+		p_tx_stats->succ_pkts =
+			__le16_to_cpu(tx_stats->tx_success_msdus);
+		p_tx_stats->retry_pkts =
+			__le16_to_cpu(tx_stats->tx_retry_msdus);
+		p_tx_stats->failed_pkts =
+			__le16_to_cpu(tx_stats->tx_failed_msdus);
+		p_tx_stats->duration =
+			__le16_to_cpu(tx_stats->tx_duration);
+
+		ath10k_update_per_peer_tx_stats(ar, sta, p_tx_stats);
+	}
+
+	spin_unlock_bh(&ar->data_lock);
+	rcu_read_unlock();
+
+	return;
+
+err:
+	spin_unlock_bh(&ar->data_lock);
+	rcu_read_unlock();
+	ath10k_warn(ar, "invalid ppdu stats received\n");
+}
+
 bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
 {
 	struct ath10k_htt *htt = &ar->htt;
@@ -3910,6 +3972,9 @@ bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
 	case HTT_T2H_MSG_TYPE_PEER_STATS:
 		ath10k_htt_fetch_peer_stats(ar, skb);
 		break;
+	case HTT_T2H_MSG_TYPE_PPDU_STATS_IND:
+		ath10k_htt_process_ppdu_stats(ar, skb);
+		break;
 	case HTT_T2H_MSG_TYPE_EN_STATS:
 	default:
 		ath10k_warn(ar, "htt event (%d) not handled\n",
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 69a1ec5..ae12a58 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1849,6 +1849,10 @@ static struct sk_buff *ath10k_wmi_tlv_op_gen_init(struct ath10k *ar)
 	if (test_bit(WMI_SERVICE_TX_DATA_ACK_RSSI, ar->wmi.svc_map))
 		cfg->host_capab |= __cpu_to_le32(WMI_RSRC_CFG_FLAG_TX_ACK_RSSI);
 
+	if (ath10k_peer_stats_enabled(ar))
+		cfg->host_capab |=
+			__cpu_to_le32(WMI_RSRC_CFG_FLAG_TX_PPDU_STATS);
+
 	ath10k_wmi_tlv_put_host_mem_chunks(ar, chunks);
 
 	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi tlv init\n");
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.h b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
index 4972dc1..6635d96 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.h
@@ -16,6 +16,7 @@
 #define WMI_TLV_VDEV_PARAM_UNSUPPORTED 0
 #define WMI_TLV_MGMT_TX_FRAME_MAX_LEN	64
 
+#define WMI_RSRC_CFG_FLAG_TX_PPDU_STATS		BIT(11)
 #define WMI_RSRC_CFG_FLAG_TX_ACK_RSSI		BIT(18)
 
 enum wmi_tlv_grp_id {
@@ -1600,6 +1601,8 @@ wmi_tlv_svc_map(const __le32 *in, unsigned long *out, size_t len)
 	       WMI_SERVICE_MESH_11S, len);
 	SVCMAP(WMI_TLV_SERVICE_SYNC_DELETE_CMDS,
 	       WMI_SERVICE_SYNC_DELETE_CMDS, len);
+	SVCMAP(WMI_TLV_SERVICE_PEER_STATS_INFO,
+	       WMI_SERVICE_PEER_STATS, len);
 }
 
 static inline void
-- 
2.7.4

