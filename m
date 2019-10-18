Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E822DBE47
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504609AbfJRH21 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 03:28:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbfJRH20 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 03:28:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 819C960B6C; Fri, 18 Oct 2019 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571383705;
        bh=/0Sk17rSneeVht9NebtaYYzpS0mTxgRCj/R5+NUnotI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ed3TyrUVUT5e8X5ld5LvJk9OvZe5TyiDxXR1Ph6en+7snzG5HPijORB1yowMNfQkV
         G4qFVUWQ8LpuPYkAzFgOrbDxg8ycSni9iLjIrG6k859/Gc5cfdlQ/Yinh7bexN9qrU
         puOL9GScu2wEAFel4hOUuCIgUbGL1gZ9B04XHGqY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDCF260588;
        Fri, 18 Oct 2019 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571383703;
        bh=/0Sk17rSneeVht9NebtaYYzpS0mTxgRCj/R5+NUnotI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gY+QUWTA6TdzOdr/91FEqx9n9tm7K71xPYooYj2cvfo38I6uayotM/GuZUEdxCL1i
         Er19OMeSU/P1Ojwf88dJhXz0HL2KB7u1e2aNU7g+FzqoYP6yRuWKWBK1k4SrxX6c+C
         PGZcc5CA+baZ79JV5OHBxowoKG9HI0VxlJXdtqPg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDCF260588
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v7 1/3] ath10k: disable TX complete indication of htt for sdio
Date:   Fri, 18 Oct 2019 15:27:48 +0800
Message-Id: <20191018072750.10372-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018072750.10372-1-wgong@codeaurora.org>
References: <20191018072750.10372-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For sdio chip, it is high latency bus, all the TX packet's content will
be tranferred from HOST memory to firmware memory via sdio bus, then it
need much more memory in firmware than low latency bus chip, for low
latency chip, such as PCI-E, it only need to transfer the TX descriptor
via PCI-E bus to firmware memory. For sdio chip, reduce the complexity of
TX logic will help TX efficiency since its memory is limited, and it will
reduce the TX circle's time of each packet and then firmware will have more
memory for TX since TX complete also need memeory.

This patch disable TX complete indication from firmware for htt data
packet, it will not have TX complete indication from firmware to ath10k.
It will cut the cost of bus bandwidth of TX complete and make the TX
logic of firmware simpler, it results in significant performance
improvement on TX path.

Udp TX throughout is 130Mbps without this patch, and it arrives
400Mbps with this patch.

The downside of this patch is the command "iw wlan0 station dump" will
show 0 for "tx retries" and "tx failed" since all tx packet's status
is success.

This patch only effect sdio chip, it will not effect PCI, SNOC etc.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWPZ-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c   |  5 +---
 drivers/net/wireless/ath/ath10k/hif.h    |  9 +++++++
 drivers/net/wireless/ath/ath10k/htc.c    | 10 +++++++
 drivers/net/wireless/ath/ath10k/htc.h    |  3 +++
 drivers/net/wireless/ath/ath10k/htt.c    |  5 ++++
 drivers/net/wireless/ath/ath10k/htt.h    | 13 ++++++++-
 drivers/net/wireless/ath/ath10k/htt_rx.c | 34 +++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/htt_tx.c | 31 +++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h     |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c   | 23 ++++++++++++++++
 drivers/net/wireless/ath/ath10k/sdio.h   |  2 +-
 11 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 36c62d66c19e..ebaaf18f6dc7 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -694,10 +694,7 @@ static int ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
 	if (ret)
 		return ret;
 
-	/* Data transfer is not initiated, when reduced Tx completion
-	 * is used for SDIO. disable it until fixed
-	 */
-	param &= ~HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_SET;
+	param |= HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_SET;
 
 	/* Alternate credit size of 1544 as used by SDIO firmware is
 	 * not big enough for mac80211 / native wifi frames. disable it
diff --git a/drivers/net/wireless/ath/ath10k/hif.h b/drivers/net/wireless/ath/ath10k/hif.h
index 496ee34a4d78..0dd8973d0acf 100644
--- a/drivers/net/wireless/ath/ath10k/hif.h
+++ b/drivers/net/wireless/ath/ath10k/hif.h
@@ -56,6 +56,8 @@ struct ath10k_hif_ops {
 
 	int (*swap_mailbox)(struct ath10k *ar);
 
+	int (*get_htt_tx_complete)(struct ath10k *ar);
+
 	int (*map_service_to_pipe)(struct ath10k *ar, u16 service_id,
 				   u8 *ul_pipe, u8 *dl_pipe);
 
@@ -144,6 +146,13 @@ static inline int ath10k_hif_swap_mailbox(struct ath10k *ar)
 	return 0;
 }
 
+static inline int ath10k_hif_get_htt_tx_complete(struct ath10k *ar)
+{
+	if (ar->hif.ops->get_htt_tx_complete)
+		return ar->hif.ops->get_htt_tx_complete(ar);
+	return 0;
+}
+
 static inline int ath10k_hif_map_service_to_pipe(struct ath10k *ar,
 						 u16 service_id,
 						 u8 *ul_pipe, u8 *dl_pipe)
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 1d4d1a1992fe..4c6cdc24d282 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -660,6 +660,16 @@ int ath10k_htc_wait_target(struct ath10k_htc *htc)
 	return 0;
 }
 
+void ath10k_htc_change_tx_credit_flow(struct ath10k_htc *htc,
+				      enum ath10k_htc_ep_id eid,
+				      bool enable)
+{
+	struct ath10k *ar = htc->ar;
+	struct ath10k_htc_ep *ep = &ar->htc.endpoint[eid];
+
+	ep->tx_credit_flow_enabled = enable;
+}
+
 int ath10k_htc_connect_service(struct ath10k_htc *htc,
 			       struct ath10k_htc_svc_conn_req *conn_req,
 			       struct ath10k_htc_svc_conn_resp *conn_resp)
diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
index f55d3caec61f..d0f37cbdab8b 100644
--- a/drivers/net/wireless/ath/ath10k/htc.h
+++ b/drivers/net/wireless/ath/ath10k/htc.h
@@ -367,6 +367,9 @@ int ath10k_htc_start(struct ath10k_htc *htc);
 int ath10k_htc_connect_service(struct ath10k_htc *htc,
 			       struct ath10k_htc_svc_conn_req  *conn_req,
 			       struct ath10k_htc_svc_conn_resp *conn_resp);
+void ath10k_htc_change_tx_credit_flow(struct ath10k_htc *htc,
+				      enum ath10k_htc_ep_id eid,
+				      bool enable);
 int ath10k_htc_send(struct ath10k_htc *htc, enum ath10k_htc_ep_id eid,
 		    struct sk_buff *packet);
 struct sk_buff *ath10k_htc_alloc_skb(struct ath10k *ar, int size);
diff --git a/drivers/net/wireless/ath/ath10k/htt.c b/drivers/net/wireless/ath/ath10k/htt.c
index 7b75200ceae5..4354bf285ff1 100644
--- a/drivers/net/wireless/ath/ath10k/htt.c
+++ b/drivers/net/wireless/ath/ath10k/htt.c
@@ -10,6 +10,7 @@
 #include "htt.h"
 #include "core.h"
 #include "debug.h"
+#include "hif.h"
 
 static const enum htt_t2h_msg_type htt_main_t2h_msg_types[] = {
 	[HTT_MAIN_T2H_MSG_TYPE_VERSION_CONF] = HTT_T2H_MSG_TYPE_VERSION_CONF,
@@ -153,6 +154,10 @@ int ath10k_htt_connect(struct ath10k_htt *htt)
 
 	htt->eid = conn_resp.eid;
 
+	htt->disable_tx_comp = ath10k_hif_get_htt_tx_complete(htt->ar);
+	if (htt->disable_tx_comp)
+		ath10k_htc_change_tx_credit_flow(&htt->ar->htc, htt->eid, true);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
index 30c080094af1..889bf9fe051a 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -150,9 +150,19 @@ enum htt_data_tx_desc_flags1 {
 	HTT_DATA_TX_DESC_FLAGS1_MORE_IN_BATCH    = 1 << 12,
 	HTT_DATA_TX_DESC_FLAGS1_CKSUM_L3_OFFLOAD = 1 << 13,
 	HTT_DATA_TX_DESC_FLAGS1_CKSUM_L4_OFFLOAD = 1 << 14,
-	HTT_DATA_TX_DESC_FLAGS1_RSVD1            = 1 << 15
+	HTT_DATA_TX_DESC_FLAGS1_TX_COMPLETE      = 1 << 15
 };
 
+#define HTT_TX_CREDIT_DELTA_ABS_M      0xffff0000
+#define HTT_TX_CREDIT_DELTA_ABS_S      16
+#define HTT_TX_CREDIT_DELTA_ABS_GET(word) \
+	    (((word) & HTT_TX_CREDIT_DELTA_ABS_M) >> HTT_TX_CREDIT_DELTA_ABS_S)
+
+#define HTT_TX_CREDIT_SIGN_BIT_M       0x00000100
+#define HTT_TX_CREDIT_SIGN_BIT_S       8
+#define HTT_TX_CREDIT_SIGN_BIT_GET(word) \
+	    (((word) & HTT_TX_CREDIT_SIGN_BIT_M) >> HTT_TX_CREDIT_SIGN_BIT_S)
+
 enum htt_data_tx_ext_tid {
 	HTT_DATA_TX_EXT_TID_NON_QOS_MCAST_BCAST = 16,
 	HTT_DATA_TX_EXT_TID_MGMT                = 17,
@@ -2019,6 +2029,7 @@ struct ath10k_htt {
 	bool tx_mem_allocated;
 	const struct ath10k_htt_tx_ops *tx_ops;
 	const struct ath10k_htt_rx_ops *rx_ops;
+	bool disable_tx_comp;
 };
 
 struct ath10k_htt_tx_ops {
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index 9f0e7b4943ec..17ad6c51e1dd 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -3778,6 +3778,9 @@ bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
 	}
 	case HTT_T2H_MSG_TYPE_MGMT_TX_COMPLETION: {
 		struct htt_tx_done tx_done = {};
+		struct ath10k_htt *htt = &ar->htt;
+		struct ath10k_htc *htc = &ar->htc;
+		struct ath10k_htc_ep *ep = &ar->htc.endpoint[htt->eid];
 		int status = __le32_to_cpu(resp->mgmt_tx_completion.status);
 		int info = __le32_to_cpu(resp->mgmt_tx_completion.info);
 
@@ -3803,6 +3806,12 @@ bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
 			break;
 		}
 
+		if (htt->disable_tx_comp) {
+			spin_lock_bh(&htc->tx_lock);
+			ep->tx_credits++;
+			spin_unlock_bh(&htc->tx_lock);
+		}
+
 		status = ath10k_txrx_tx_unref(htt, &tx_done);
 		if (!status) {
 			spin_lock_bh(&htt->tx_lock);
@@ -3877,8 +3886,31 @@ bool ath10k_htt_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
 		skb_queue_tail(&htt->rx_in_ord_compl_q, skb);
 		return false;
 	}
-	case HTT_T2H_MSG_TYPE_TX_CREDIT_UPDATE_IND:
+	case HTT_T2H_MSG_TYPE_TX_CREDIT_UPDATE_IND: {
+		struct ath10k_htt *htt = &ar->htt;
+		struct ath10k_htc *htc = &ar->htc;
+		struct ath10k_htc_ep *ep = &ar->htc.endpoint[htt->eid];
+		u32 msg_word = __le32_to_cpu(*(__le32 *)resp);
+		int htt_credit_delta;
+
+		htt_credit_delta = HTT_TX_CREDIT_DELTA_ABS_GET(msg_word);
+		if (HTT_TX_CREDIT_SIGN_BIT_GET(msg_word))
+			htt_credit_delta = -htt_credit_delta;
+
+		ath10k_dbg(ar, ATH10K_DBG_HTT,
+			   "credit update: delta:%d\n",
+			   htt_credit_delta);
+
+		if (htt->disable_tx_comp) {
+			spin_lock_bh(&htc->tx_lock);
+			ep->tx_credits += htt_credit_delta;
+			spin_unlock_bh(&htc->tx_lock);
+			ath10k_dbg(ar, ATH10K_DBG_HTT,
+				   "credit total:%d\n",
+				   ep->tx_credits);
+		}
 		break;
+	}
 	case HTT_T2H_MSG_TYPE_CHAN_CHANGE: {
 		u32 phymode = __le32_to_cpu(resp->chan_change.phymode);
 		u32 freq = __le32_to_cpu(resp->chan_change.freq);
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index a182c0944cc7..c6c4b2a4d20f 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -543,7 +543,35 @@ void ath10k_htt_tx_free(struct ath10k_htt *htt)
 
 void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
 {
+	struct ath10k_htt *htt = &ar->htt;
+	struct htt_tx_done tx_done = {0};
+	struct htt_cmd_hdr *htt_hdr;
+	struct htt_data_tx_desc *desc_hdr;
+	u16 flags1;
+
 	dev_kfree_skb_any(skb);
+
+	if (!htt->disable_tx_comp)
+		return;
+
+	htt_hdr = (struct htt_cmd_hdr *)skb->data;
+	if (htt_hdr->msg_type != HTT_H2T_MSG_TYPE_TX_FRM)
+		return;
+
+	desc_hdr = (struct htt_data_tx_desc *)
+		(skb->data + sizeof(*htt_hdr));
+	flags1 = __le16_to_cpu(desc_hdr->flags1);
+
+	ath10k_dbg(ar, ATH10K_DBG_HTT,
+		   "htt tx complete msdu id:%u ,flags1:%x\n",
+		   __le16_to_cpu(desc_hdr->id), flags1);
+
+	if (flags1 & HTT_DATA_TX_DESC_FLAGS1_TX_COMPLETE)
+		return;
+
+	tx_done.status = HTT_TX_COMPL_STATE_ACK;
+	tx_done.msdu_id = __le16_to_cpu(desc_hdr->id);
+	ath10k_txrx_tx_unref(&ar->htt, &tx_done);
 }
 
 void ath10k_htt_hif_tx_complete(struct ath10k *ar, struct sk_buff *skb)
@@ -1269,6 +1297,9 @@ static int ath10k_htt_tx_hl(struct ath10k_htt *htt, enum ath10k_hw_txrx_mode txm
 		flags0 |= SM(ATH10K_HW_TXRX_MGMT,
 			     HTT_DATA_TX_DESC_FLAGS0_PKT_TYPE);
 		flags0 |= HTT_DATA_TX_DESC_FLAGS0_MAC_HDR_PRESENT;
+
+		if (htt->disable_tx_comp)
+			flags1 |= HTT_DATA_TX_DESC_FLAGS1_TX_COMPLETE;
 		break;
 	}
 
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 2ae57c1de7b5..6349665a9b34 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -759,7 +759,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
 #define TARGET_TLV_NUM_TDLS_VDEVS		1
 #define TARGET_TLV_NUM_TIDS			((TARGET_TLV_NUM_PEERS) * 2)
 #define TARGET_TLV_NUM_MSDU_DESC		(1024 + 32)
-#define TARGET_TLV_NUM_MSDU_DESC_HL		64
+#define TARGET_TLV_NUM_MSDU_DESC_HL		1024
 #define TARGET_TLV_NUM_WOW_PATTERNS		22
 #define TARGET_TLV_MGMT_NUM_MSDU_DESC		(50)
 
diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 120200a93bcc..84910446df50 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1674,6 +1674,28 @@ static int ath10k_sdio_hif_swap_mailbox(struct ath10k *ar)
 	return 0;
 }
 
+static int ath10k_sdio_get_htt_tx_complete(struct ath10k *ar)
+{
+	u32 addr, val;
+	int ret;
+
+	addr = host_interest_item_address(HI_ITEM(hi_acs_flags));
+
+	ret = ath10k_sdio_hif_diag_read32(ar, addr, &val);
+	if (ret) {
+		ath10k_warn(ar,
+			    "unable to read hi_acs_flags for htt tx comple : %d\n", ret);
+		return ret;
+	}
+
+	ret = (val & HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_FW_ACK);
+
+	ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio reduce tx complete fw%sack\n",
+		   ret ? " " : " not ");
+
+	return ret;
+}
+
 /* HIF start/stop */
 
 static int ath10k_sdio_hif_start(struct ath10k *ar)
@@ -1943,6 +1965,7 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
 	.start			= ath10k_sdio_hif_start,
 	.stop			= ath10k_sdio_hif_stop,
 	.swap_mailbox		= ath10k_sdio_hif_swap_mailbox,
+	.get_htt_tx_complete	= ath10k_sdio_get_htt_tx_complete,
 	.map_service_to_pipe	= ath10k_sdio_hif_map_service_to_pipe,
 	.get_default_pipe	= ath10k_sdio_hif_get_default_pipe,
 	.send_complete_check	= ath10k_sdio_hif_send_complete_check,
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index b8c7ac0330bd..96a1c8e62257 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -37,7 +37,7 @@
 	(ATH10K_SDIO_MAX_BUFFER_SIZE - sizeof(struct ath10k_htc_hdr))
 
 #define ATH10K_HIF_MBOX_NUM_MAX                 4
-#define ATH10K_SDIO_BUS_REQUEST_MAX_NUM         64
+#define ATH10K_SDIO_BUS_REQUEST_MAX_NUM         1024
 
 #define ATH10K_SDIO_HIF_COMMUNICATION_TIMEOUT_HZ (100 * HZ)
 
-- 
2.23.0

