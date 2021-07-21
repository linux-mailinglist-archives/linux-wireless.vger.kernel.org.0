Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A537A3D18ED
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhGUUkM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24942 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhGUUkL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902447; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=KWg9ZuuvvwDV4zhFDhqdO+lo8gc2hESbPLL7uCQJQTM=; b=qwJMsT7Vt/8dNp3bD54vriinaUGScM2Qp9MFdr5qVj0sXa+5QHA01VjrwGI1m/a2GMOF+mfo
 kXTlj1bRplzT/5sVq0NSoZ5kzC36IPCbl+3PsPJdoUDUKibupNfDx+heRnTddIJ8ea7IR9g+
 BDt/or8CoTCRfyeR0uTIb04zRk4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60f88fa9e31d882d18196505 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:20:41
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7FE00C43217; Wed, 21 Jul 2021 21:20:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C2529C433D3;
        Wed, 21 Jul 2021 21:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2529C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 01/12] ath11k: Fix pktlog lite rx events
Date:   Thu, 22 Jul 2021 00:20:18 +0300
Message-Id: <20210721212029.142388-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Fix sending rx_buf_sz to ath11k_dp_tx_htt_rx_filter_setup()
to enable pktlog full or lite mode. Depending on mode update the
trace buffer with log type full/lite.

Pktlog lite is a lighter version of pktlog. This can be used to capture
PPDU stats. These are useful for firmware performance debugging.

pktlog lite dumps are enabled using,
  echo "0x0 1" > ath11k/IPQ8074 hw2.0/mac0/pktlog_filter

Tested On: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01233-QCAHKSWPL_SILICONZ-1 v2

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs.c | 25 +++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/dp.h      |  1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 16 ++++++++++++---
 drivers/net/wireless/ath/ath11k/trace.h   | 11 ++++++----
 4 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 554feaf1ed5c..17f0bbbac7ae 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -902,7 +902,7 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 	struct htt_rx_ring_tlv_filter tlv_filter = {0};
 	u32 rx_filter = 0, ring_id, filter, mode;
 	u8 buf[128] = {0};
-	int i, ret;
+	int i, ret, rx_buf_sz = 0;
 	ssize_t rc;
 
 	mutex_lock(&ar->conf_mutex);
@@ -940,6 +940,17 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 		}
 	}
 
+	/* Clear rx filter set for monitor mode and rx status */
+	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {
+		ring_id = ar->dp.rx_mon_status_refill_ring[i].refill_buf_ring.ring_id;
+		ret = ath11k_dp_tx_htt_rx_filter_setup(ar->ab, ring_id, ar->dp.mac_id,
+						       HAL_RXDMA_MONITOR_STATUS,
+						       rx_buf_sz, &tlv_filter);
+		if (ret) {
+			ath11k_warn(ar->ab, "failed to set rx filter for monitor status ring\n");
+			goto out;
+		}
+	}
 #define HTT_RX_FILTER_TLV_LITE_MODE \
 			(HTT_RX_FILTER_TLV_FLAGS_PPDU_START | \
 			HTT_RX_FILTER_TLV_FLAGS_PPDU_END | \
@@ -955,6 +966,7 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 			    HTT_RX_FILTER_TLV_FLAGS_MPDU_END |
 			    HTT_RX_FILTER_TLV_FLAGS_PACKET_HEADER |
 			    HTT_RX_FILTER_TLV_FLAGS_ATTENTION;
+		rx_buf_sz = DP_RX_BUFFER_SIZE;
 	} else if (mode == ATH11K_PKTLOG_MODE_LITE) {
 		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
 							  HTT_PPDU_STATS_TAG_PKTLOG);
@@ -964,7 +976,12 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 		}
 
 		rx_filter = HTT_RX_FILTER_TLV_LITE_MODE;
+		rx_buf_sz = DP_RX_BUFFER_SIZE_LITE;
 	} else {
+		rx_buf_sz = DP_RX_BUFFER_SIZE;
+		tlv_filter = ath11k_mac_mon_status_filter_default;
+		rx_filter = tlv_filter.rx_filter;
+
 		ret = ath11k_dp_tx_htt_h2t_ppdu_stats_req(ar,
 							  HTT_PPDU_STATS_TAG_DEFAULT);
 		if (ret) {
@@ -988,7 +1005,7 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 		ret = ath11k_dp_tx_htt_rx_filter_setup(ab, ring_id,
 						       ar->dp.mac_id + i,
 						       HAL_RXDMA_MONITOR_STATUS,
-						       DP_RX_BUFFER_SIZE, &tlv_filter);
+						       rx_buf_sz, &tlv_filter);
 
 		if (ret) {
 			ath11k_warn(ab, "failed to set rx filter for monitor status ring\n");
@@ -996,8 +1013,8 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 		}
 	}
 
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "pktlog filter %d mode %s\n",
-		   filter, ((mode == ATH11K_PKTLOG_MODE_FULL) ? "full" : "lite"));
+	ath11k_info(ab, "pktlog mode %s\n",
+		    ((mode == ATH11K_PKTLOG_MODE_FULL) ? "full" : "lite"));
 
 	ar->debug.pktlog_filter = filter;
 	ar->debug.pktlog_mode = mode;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 69b75bc3312f..b2e7621969c5 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -218,6 +218,7 @@ struct ath11k_pdev_dp {
 #define DP_RXDMA_MONITOR_DESC_RING_SIZE	4096
 
 #define DP_RX_BUFFER_SIZE	2048
+#define	DP_RX_BUFFER_SIZE_LITE  1024
 #define DP_RX_BUFFER_ALIGN_SIZE	128
 
 #define DP_RXDMA_BUF_COOKIE_BUF_ID	GENMASK(17, 0)
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index cc53432827e5..9d9af6d65afd 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3080,6 +3080,8 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
 	int num_buffs_reaped = 0;
+	u32 rx_buf_sz;
+	u16 log_type = 0;
 
 	__skb_queue_head_init(&skb_list);
 
@@ -3092,8 +3094,16 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		memset(&ppdu_info, 0, sizeof(ppdu_info));
 		ppdu_info.peer_id = HAL_INVALID_PEERID;
 
-		if (ath11k_debugfs_is_pktlog_rx_stats_enabled(ar))
-			trace_ath11k_htt_rxdesc(ar, skb->data, DP_RX_BUFFER_SIZE);
+		if (ath11k_debugfs_is_pktlog_lite_mode_enabled(ar)) {
+			log_type = ATH11K_PKTLOG_TYPE_LITE_RX;
+			rx_buf_sz = DP_RX_BUFFER_SIZE_LITE;
+		} else if (ath11k_debugfs_is_pktlog_rx_stats_enabled(ar)) {
+			log_type = ATH11K_PKTLOG_TYPE_RX_STATBUF;
+			rx_buf_sz = DP_RX_BUFFER_SIZE;
+		}
+
+		if (log_type)
+			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
 
 		hal_status = ath11k_hal_rx_parse_mon_status(ab, &ppdu_info, skb);
 
@@ -3121,7 +3131,7 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		ath11k_dp_rx_update_peer_stats(arsta, &ppdu_info);
 
 		if (ath11k_debugfs_is_pktlog_peer_valid(ar, peer->addr))
-			trace_ath11k_htt_rxdesc(ar, skb->data, DP_RX_BUFFER_SIZE);
+			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
 
 		spin_unlock_bh(&ab->base_lock);
 		rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath11k/trace.h b/drivers/net/wireless/ath/ath11k/trace.h
index d2d2a3cb0826..25d18e9d5b0b 100644
--- a/drivers/net/wireless/ath/ath11k/trace.h
+++ b/drivers/net/wireless/ath/ath11k/trace.h
@@ -79,14 +79,15 @@ TRACE_EVENT(ath11k_htt_ppdu_stats,
 );
 
 TRACE_EVENT(ath11k_htt_rxdesc,
-	    TP_PROTO(struct ath11k *ar, const void *data, size_t len),
+	    TP_PROTO(struct ath11k *ar, const void *data, size_t log_type, size_t len),
 
-	TP_ARGS(ar, data, len),
+	TP_ARGS(ar, data, log_type, len),
 
 	TP_STRUCT__entry(
 		__string(device, dev_name(ar->ab->dev))
 		__string(driver, dev_driver_string(ar->ab->dev))
 		__field(u16, len)
+		__field(u16, log_type)
 		__dynamic_array(u8, rxdesc, len)
 	),
 
@@ -94,14 +95,16 @@ TRACE_EVENT(ath11k_htt_rxdesc,
 		__assign_str(device, dev_name(ar->ab->dev));
 		__assign_str(driver, dev_driver_string(ar->ab->dev));
 		__entry->len = len;
+		__entry->log_type = log_type;
 		memcpy(__get_dynamic_array(rxdesc), data, len);
 	),
 
 	TP_printk(
-		"%s %s rxdesc len %d",
+		"%s %s rxdesc len %d type %d",
 		__get_str(driver),
 		__get_str(device),
-		__entry->len
+		__entry->len,
+		__entry->log_type
 	 )
 );
 
-- 
2.25.1

