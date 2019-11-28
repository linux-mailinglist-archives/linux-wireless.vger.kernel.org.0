Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF10D10C6B3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 11:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfK1Kaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 05:30:52 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:46054
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbfK1Kaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 05:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574937050;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=J35ast3l3+9RFv8epzEreFkmqkHHUcJO1o3Uh1z/1s4=;
        b=CFGWsVOoRr2nbzz3RU827xHums2CjnT5LbWrhY6HWI8cp/uA67Er9Omwe4X647dd
        A+30j7IXYN5clM7hzCKfla1ZxoA+eo1eUgfgzQwxGpSs5qmMe+N+Hg5anSb//5iU1YE
        iKpI/tCZoFULMmQ7F58E0o4gi21P+98HAawPR91I=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574937050;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=J35ast3l3+9RFv8epzEreFkmqkHHUcJO1o3Uh1z/1s4=;
        b=YrHm2ENW+h4f+c9cPDH0p2JPu5vNAdEtU4EIaH34ilrcAGHE4pC303A6TyPAUgVt
        bBMAMUdndPi5gu1uUstr38D41oBHMQMJrzyKceZ3dmUtQ17bFSe6JaqO6mxdMI9HjDT
        sbs7zp/YqjmFe/Ayl7X9E6eJJfOgkZpI9qQkQQ5c=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76643C447A6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v8 1/4] ath10k: disable TX complete indication of htt for sdio
Date:   Thu, 28 Nov 2019 10:30:50 +0000
Message-ID: <0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128103030.6429-1-wgong@codeaurora.org>
References: <20191128103030.6429-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.28-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
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
 10 files changed, 128 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 4f76ba5d78a9..5a49edfdf9e6 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -695,10 +695,7 @@ static int ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
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
index d95b63f133ab..049861f38e95 100644
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
index 35a362329a4f..2661c6893ca5 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -762,7 +762,7 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
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
-- 
2.23.0

