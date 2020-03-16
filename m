Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3A81867E5
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2020 10:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgCPJ3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Mar 2020 05:29:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37498 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730356AbgCPJ3s (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Mar 2020 05:29:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584350987; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Lsq8V0H3Vmfrb9LCKmRWPHRvl6qaZXlN6bQOkA1cwEE=; b=SmhzKnE4FBWlAit2jwKDkJAY8IC6M8/Tt4AAYar0WXmpzO7djQ6zunWMWtXV7NMT9MA89+s2
 G5ALm+Uwmi5YUuj7L28OWrdD0FUm4+0O8FNW01eqRCS9lwSXuO3jXU2F0l2YBQfSK9DPpMdX
 ++kovPDhZZk7WUfB7ArMt96M54I=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6f46fc.7fcbb746c5a8-smtp-out-n02;
 Mon, 16 Mar 2020 09:29:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 374ECC433BA; Mon, 16 Mar 2020 09:29:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from checstp253621-lin.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B146AC433CB;
        Mon, 16 Mar 2020 09:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B146AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=srirrama@codeaurora.org
From:   Sriram R <srirrama@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Sriram R <srirrama@codeaurora.org>,
        Vikas Patel <vikpatel@codeaurora.org>
Subject: [PATCH v3] ath11k: Supporting RX ring backpressure HTT event and stats handling
Date:   Mon, 16 Mar 2020 14:58:40 +0530
Message-Id: <1584350920-20688-1-git-send-email-srirrama@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The Firmware sends HTT event to host whenever there is a
backpressure on RX rings, Handling such event and dumping
info on the console under the "ATH11K_DBG_DP_HTT"  debug level.

Fetching RX ring backpressure histogram from FW via htt_stats debugfs.

 #echo "24" > /sys/kernel/debug/ath11k/ipq8074/macX/htt_stats_type
 #cat /sys/kernel/debug/ath11k/ipq8074/macX/htt_stats

Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
Signed-off-by: Sriram R <srirrama@codeaurora.org>
---
v3: Rebased on top of master
 drivers/net/wireless/ath/ath11k/debug.h           |  2 ++
 drivers/net/wireless/ath/ath11k/debug_htt_stats.c | 44 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/debug_htt_stats.h | 28 +++++++++++++++
 drivers/net/wireless/ath/ath11k/dp.h              |  8 +++++
 drivers/net/wireless/ath/ath11k/dp_rx.c           | 26 ++++++++++++++
 5 files changed, 108 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 427d3ac..97e7306 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -53,6 +53,8 @@ enum ath11k_dbg_htt_ext_stats_type {
 	ATH11K_DBG_HTT_EXT_STATS_TWT_SESSIONS               =  20,
 	ATH11K_DBG_HTT_EXT_STATS_REO_RESOURCE_STATS         =  21,
 	ATH11K_DBG_HTT_EXT_STATS_TX_SOUNDING_INFO           =  22,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	    =  23,
+	ATH11K_DBG_HTT_EXT_STATS_RING_BACKPRESSURE_STATS    =  24,
 
 	/* keep this last */
 	ATH11K_DBG_HTT_NUM_EXT_STATS,
diff --git a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
index f44dec8..5db0c27 100644
--- a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
@@ -3854,6 +3854,47 @@ htt_print_pdev_obss_pd_stats_tlv_v(const void *tag_buf,
 	stats_req->buf_len = len;
 }
 
+static inline void htt_print_backpressure_stats_tlv_v(const u32 *tag_buf,
+						      u8 *data)
+{
+	struct debug_htt_stats_req *stats_req =
+			(struct debug_htt_stats_req *)data;
+	struct htt_ring_backpressure_stats_tlv *htt_stats_buf =
+			(struct htt_ring_backpressure_stats_tlv *)tag_buf;
+	int i;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
+			   htt_stats_buf->pdev_id);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_head_idx = %u",
+			   htt_stats_buf->current_head_idx);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_tail_idx = %u",
+			   htt_stats_buf->current_tail_idx);
+	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_htt_msgs_sent = %u",
+			   htt_stats_buf->num_htt_msgs_sent);
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "backpressure_time_ms = %u",
+			   htt_stats_buf->backpressure_time_ms);
+
+	for (i = 0; i < 5; i++)
+		len += HTT_DBG_OUT(buf + len, buf_len - len,
+				   "backpressure_hist_%u = %u",
+				   i + 1, htt_stats_buf->backpressure_hist[i]);
+
+	len += HTT_DBG_OUT(buf + len, buf_len - len,
+			   "============================");
+
+	if (len >= buf_len) {
+		buf[buf_len - 1] = 0;
+		stats_req->buf_len = buf_len - 1;
+	} else {
+		buf[len] = 0;
+		stats_req->buf_len = len;
+	}
+}
+
 static inline void htt_htt_stats_debug_dump(const u32 *tag_buf,
 					    struct debug_htt_stats_req *stats_req)
 {
@@ -4246,6 +4287,9 @@ static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
 	case HTT_STATS_PDEV_OBSS_PD_TAG:
 		htt_print_pdev_obss_pd_stats_tlv_v(tag_buf, stats_req);
 		break;
+	case HTT_STATS_RING_BACKPRESSURE_STATS_TAG:
+		htt_print_backpressure_stats_tlv_v(tag_buf, user_data);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/debug_htt_stats.h b/drivers/net/wireless/ath/ath11k/debug_htt_stats.h
index 4bdb62d..23a6baa 100644
--- a/drivers/net/wireless/ath/ath11k/debug_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debug_htt_stats.h
@@ -100,6 +100,8 @@ enum htt_tlv_tag_t {
 	HTT_STATS_SCHED_TXQ_SCHED_ORDER_SU_TAG              = 86,
 	HTT_STATS_SCHED_TXQ_SCHED_INELIGIBILITY_TAG         = 87,
 	HTT_STATS_PDEV_OBSS_PD_TAG                          = 88,
+	HTT_STATS_HW_WAR_TAG				    = 89,
+	HTT_STATS_RING_BACKPRESSURE_STATS_TAG		    = 90,
 
 	HTT_STATS_MAX_TAG,
 };
@@ -1659,4 +1661,30 @@ struct htt_pdev_obss_pd_stats_tlv {
 };
 
 void ath11k_debug_htt_stats_init(struct ath11k *ar);
+
+struct htt_ring_backpressure_stats_tlv {
+	u32 pdev_id;
+	u32 current_head_idx;
+	u32 current_tail_idx;
+	u32 num_htt_msgs_sent;
+	/* Time in milliseconds for which the ring has been in
+	 * its current backpressure condition
+	 */
+	u32 backpressure_time_ms;
+	/* backpressure_hist - histogram showing how many times
+	 * different degrees of backpressure duration occurred:
+	 * Index 0 indicates the number of times ring was
+	 * continuously in backpressure state for 100 - 200ms.
+	 * Index 1 indicates the number of times ring was
+	 * continuously in backpressure state for 200 - 300ms.
+	 * Index 2 indicates the number of times ring was
+	 * continuously in backpressure state for 300 - 400ms.
+	 * Index 3 indicates the number of times ring was
+	 * continuously in backpressure state for 400 - 500ms.
+	 * Index 4 indicates the number of times ring was
+	 * continuously in backpressure state beyond 500ms.
+	 */
+	u32 backpressure_hist[5];
+};
+
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index f9b66de..551f9c9 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -936,6 +936,7 @@ enum htt_t2h_msg_type {
 	HTT_T2H_MSG_TYPE_PEER_UNMAP	= 0x1f,
 	HTT_T2H_MSG_TYPE_PPDU_STATS_IND = 0x1d,
 	HTT_T2H_MSG_TYPE_EXT_STATS_CONF = 0x1c,
+	HTT_T2H_MSG_TYPE_BKPRESSURE_EVENT_IND = 0x24,
 };
 
 #define HTT_TARGET_VERSION_MAJOR 3
@@ -984,6 +985,13 @@ struct htt_resp_msg {
 	};
 } __packed;
 
+#define HTT_BACKPRESSURE_EVENT_PDEV_ID_M GENMASK(15, 8)
+#define HTT_BACKPRESSURE_EVENT_RING_TYPE_M GENMASK(23, 16)
+#define HTT_BACKPRESSURE_EVENT_RING_ID_M GENMASK(31, 24)
+
+#define HTT_BACKPRESSURE_EVENT_HP_M GENMASK(15, 0)
+#define HTT_BACKPRESSURE_EVENT_TP_M GENMASK(31, 16)
+
 /* ppdu stats
  *
  * @details
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index aba2dca..fbb67c9 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1494,6 +1494,29 @@ static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
 	trace_ath11k_htt_pktlog(ar, data->payload, hdr->size);
 }
 
+static void ath11k_htt_backpressure_event_handler(struct ath11k_base *ab,
+						  struct sk_buff *skb)
+{
+	u32 *data = (u32 *)skb->data;
+	u8 pdev_id, ring_type, ring_id;
+	u16 hp, tp;
+	u32 backpressure_time;
+
+	pdev_id = FIELD_GET(HTT_BACKPRESSURE_EVENT_PDEV_ID_M, *data);
+	ring_type = FIELD_GET(HTT_BACKPRESSURE_EVENT_RING_TYPE_M, *data);
+	ring_id = FIELD_GET(HTT_BACKPRESSURE_EVENT_RING_ID_M, *data);
+	++data;
+
+	hp = FIELD_GET(HTT_BACKPRESSURE_EVENT_HP_M, *data);
+	tp = FIELD_GET(HTT_BACKPRESSURE_EVENT_TP_M, *data);
+	++data;
+
+	backpressure_time = *data;
+
+	ath11k_dbg(ab, ATH11K_DBG_DP_HTT, "htt backpressure event, pdev %d, ring type %d,ring id %d, hp %d tp %d, backpressure time %d\n",
+		   pdev_id, ring_type, ring_id, hp, tp, backpressure_time);
+}
+
 void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 				       struct sk_buff *skb)
 {
@@ -1543,6 +1566,9 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 	case HTT_T2H_MSG_TYPE_PKTLOG:
 		ath11k_htt_pktlog(ab, skb);
 		break;
+	case HTT_T2H_MSG_TYPE_BKPRESSURE_EVENT_IND:
+		ath11k_htt_backpressure_event_handler(ab, skb);
+		break;
 	default:
 		ath11k_warn(ab, "htt event %d not handled\n", type);
 		break;
-- 
2.7.4
