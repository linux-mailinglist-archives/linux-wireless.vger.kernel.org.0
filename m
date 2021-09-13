Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D34409FB2
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 00:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245048AbhIMWdq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 18:33:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24131 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245171AbhIMWdn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 18:33:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631572346; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=984D8EuLl3JlYlqxjUYzryMGzwJi1g1VXjRPJ18QNy4=; b=e6sqo22oM/P9yU2M7PFxo9ZeyHeuOF0A16p5IN9EpRrCt4H2lTS/pLoDVFjvHTJWs5FfcngJ
 p51OFsUcF3aeCvV+49yqWMapwnYKkYnjP0F59FXBa7nl72ZikjGC2jEe3NpMoIFSH4v7AtmD
 4I16I3lwSF6BzYODv1+t18HbowM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 613fd179bd6681d8ed55c3b5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 22:32:25
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79F3BC43619; Mon, 13 Sep 2021 22:32:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E197BC4360D;
        Mon, 13 Sep 2021 22:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E197BC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 4/5] ath11k: Change masking and shifting in htt stats
Date:   Tue, 14 Sep 2021 01:31:47 +0300
Message-Id: <20210913223148.208026-5-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913223148.208026-1-jouni@codeaurora.org>
References: <20210913223148.208026-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

In debugfs_htt_stats.c, masking and shifting is done to get
stats values. Instead use GENMASK and FIELD_GET to improve
code readability and maintenance.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01105-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 318 ++++++++++--------
 .../wireless/ath/ath11k/debugfs_htt_stats.h   |  54 +++
 drivers/net/wireless/ath/ath11k/dp.h          |   7 +
 3 files changed, 243 insertions(+), 136 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index fb686793929f..9efce25a067e 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -75,8 +75,8 @@ static inline void htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_CMN_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "hw_queued = %u\n",
 			 htt_stats_buf->hw_queued);
 	len += scnprintf(buf + len, buf_len - len, "hw_reaped = %u\n",
@@ -428,8 +428,8 @@ static inline void htt_print_hw_stats_pdev_errs_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_PDEV_ERRS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "tx_abort = %u\n",
 			 htt_stats_buf->tx_abort);
 	len += scnprintf(buf + len, buf_len - len, "tx_abort_fail_count = %u\n",
@@ -480,13 +480,15 @@ static inline void htt_print_msdu_flow_stats_tlv(const void *tag_buf,
 			 htt_stats_buf->cur_msdu_count_in_flowq);
 	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
 			 htt_stats_buf->sw_peer_id);
-	len += scnprintf(buf + len, buf_len - len, "tx_flow_no = %u\n",
-			 htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
-			 (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "drop_rule = %u\n",
-			 (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0x100000) >>
-			 20);
+	len += scnprintf(buf + len, buf_len - len, "tx_flow_no = %lu\n",
+			 FIELD_GET(HTT_MSDU_FLOW_STATS_TX_FLOW_NO,
+				   htt_stats_buf->tx_flow_no__tid_num__drop_rule));
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %lu\n",
+			 FIELD_GET(HTT_MSDU_FLOW_STATS_TID_NUM,
+				   htt_stats_buf->tx_flow_no__tid_num__drop_rule));
+	len += scnprintf(buf + len, buf_len - len, "drop_rule = %lu\n",
+			 FIELD_GET(HTT_MSDU_FLOW_STATS_DROP_RULE,
+				   htt_stats_buf->tx_flow_no__tid_num__drop_rule));
 	len += scnprintf(buf + len, buf_len - len, "last_cycle_enqueue_count = %u\n",
 			 htt_stats_buf->last_cycle_enqueue_count);
 	len += scnprintf(buf + len, buf_len - len, "last_cycle_dequeue_count = %u\n",
@@ -516,15 +518,18 @@ static inline void htt_print_tx_tid_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TID_STATS_TLV:\n");
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
 	len += scnprintf(buf + len, buf_len - len, "tid_name = %s\n", tid_name);
-	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
-			 htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
-			 (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "num_sched_pending = %u\n",
-			 htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "num_ppdu_in_hwq = %u\n",
-			 (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
-			 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_SW_PEER_ID,
+				   htt_stats_buf->sw_peer_id__tid_num));
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_TID_NUM,
+				   htt_stats_buf->sw_peer_id__tid_num));
+	len += scnprintf(buf + len, buf_len - len, "num_sched_pending = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_NUM_SCHED_PENDING,
+				   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq));
+	len += scnprintf(buf + len, buf_len - len, "num_ppdu_in_hwq = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_NUM_PPDU_IN_HWQ,
+				   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq));
 	len += scnprintf(buf + len, buf_len - len, "tid_flags = 0x%x\n",
 			 htt_stats_buf->tid_flags);
 	len += scnprintf(buf + len, buf_len - len, "hw_queued = %u\n",
@@ -566,15 +571,18 @@ static inline void htt_print_tx_tid_stats_v1_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TID_STATS_V1_TLV:\n");
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
 	len += scnprintf(buf + len, buf_len - len, "tid_name = %s\n", tid_name);
-	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
-			 htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
-			 (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "num_sched_pending = %u\n",
-			 htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "num_ppdu_in_hwq = %u\n",
-			 (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
-			 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_V1_SW_PEER_ID,
+				   htt_stats_buf->sw_peer_id__tid_num));
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_V1_TID_NUM,
+				   htt_stats_buf->sw_peer_id__tid_num));
+	len += scnprintf(buf + len, buf_len - len, "num_sched_pending = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_V1_NUM_SCHED_PENDING,
+				   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq));
+	len += scnprintf(buf + len, buf_len - len, "num_ppdu_in_hwq = %lu\n",
+			 FIELD_GET(HTT_TX_TID_STATS_V1_NUM_PPDU_IN_HWQ,
+				   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq));
 	len += scnprintf(buf + len, buf_len - len, "tid_flags = 0x%x\n",
 			 htt_stats_buf->tid_flags);
 	len += scnprintf(buf + len, buf_len - len, "max_qdepth_bytes = %u\n",
@@ -618,10 +626,12 @@ static inline void htt_print_rx_tid_stats_tlv(const void *tag_buf,
 	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_TID_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
-			 htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
-			 (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %lu\n",
+			 FIELD_GET(HTT_RX_TID_STATS_SW_PEER_ID,
+				   htt_stats_buf->sw_peer_id__tid_num));
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %lu\n",
+			 FIELD_GET(HTT_RX_TID_STATS_TID_NUM,
+				   htt_stats_buf->sw_peer_id__tid_num));
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
 	len += scnprintf(buf + len, buf_len - len, "tid_name = %s\n", tid_name);
 	len += scnprintf(buf + len, buf_len - len, "dup_in_reorder = %u\n",
@@ -724,20 +734,29 @@ static inline void htt_print_peer_details_tlv(const void *tag_buf,
 			 htt_stats_buf->peer_type);
 	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
 			 htt_stats_buf->sw_peer_id);
-	len += scnprintf(buf + len, buf_len - len, "vdev_id = %u\n",
-			 htt_stats_buf->vdev_pdev_ast_idx & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
-			 (htt_stats_buf->vdev_pdev_ast_idx & 0xFF00) >> 8);
-	len += scnprintf(buf + len, buf_len - len, "ast_idx = %u\n",
-			 (htt_stats_buf->vdev_pdev_ast_idx & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "vdev_id = %lu\n",
+			 FIELD_GET(HTT_PEER_DETAILS_VDEV_ID,
+				   htt_stats_buf->vdev_pdev_ast_idx));
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %lu\n",
+			 FIELD_GET(HTT_PEER_DETAILS_PDEV_ID,
+				   htt_stats_buf->vdev_pdev_ast_idx));
+	len += scnprintf(buf + len, buf_len - len, "ast_idx = %lu\n",
+			 FIELD_GET(HTT_PEER_DETAILS_AST_IDX,
+				   htt_stats_buf->vdev_pdev_ast_idx));
 	len += scnprintf(buf + len, buf_len - len,
-			 "mac_addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
-			 htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF,
-			 (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF00) >> 8,
-			 (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF0000) >> 16,
-			 (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF000000) >> 24,
-			 (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF),
-			 (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF00) >> 8);
+			 "mac_addr = %02lx:%02lx:%02lx:%02lx:%02lx:%02lx\n",
+			 FIELD_GET(HTT_MAC_ADDR_L32_0,
+				   htt_stats_buf->mac_addr.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_L32_1,
+				   htt_stats_buf->mac_addr.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_L32_2,
+				   htt_stats_buf->mac_addr.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_L32_3,
+				   htt_stats_buf->mac_addr.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_H16_0,
+				   htt_stats_buf->mac_addr.mac_addr_h16),
+			 FIELD_GET(HTT_MAC_ADDR_H16_1,
+				   htt_stats_buf->mac_addr.mac_addr_h16));
 	len += scnprintf(buf + len, buf_len - len, "peer_flags = 0x%x\n",
 			 htt_stats_buf->peer_flags);
 	len += scnprintf(buf + len, buf_len - len, "qpeer_flags = 0x%x\n\n",
@@ -799,7 +818,6 @@ static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
 		buf[len] = 0;
 
 	stats_req->buf_len = len;
-
 }
 
 static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
@@ -930,10 +948,12 @@ htt_print_tx_hwq_mu_mimo_cmn_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_CMN_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__hwq_id__word & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "hwq_id = %u\n\n",
-			 (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_TX_HWQ_STATS_MAC_ID,
+				   htt_stats_buf->mac_id__hwq_id__word));
+	len += scnprintf(buf + len, buf_len - len, "hwq_id = %lu\n\n",
+			 FIELD_GET(HTT_TX_HWQ_STATS_HWQ_ID,
+				   htt_stats_buf->mac_id__hwq_id__word));
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -953,10 +973,12 @@ htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, struct debug_htt_stats_req *
 
 	/* TODO: HKDBG */
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_STATS_CMN_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__hwq_id__word & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "hwq_id = %u\n",
-			 (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_TX_HWQ_STATS_MAC_ID,
+				   htt_stats_buf->mac_id__hwq_id__word));
+	len += scnprintf(buf + len, buf_len - len, "hwq_id = %lu\n",
+			 FIELD_GET(HTT_TX_HWQ_STATS_HWQ_ID,
+				   htt_stats_buf->mac_id__hwq_id__word));
 	len += scnprintf(buf + len, buf_len - len, "xretry = %u\n",
 			 htt_stats_buf->xretry);
 	len += scnprintf(buf + len, buf_len - len, "underrun_cnt = %u\n",
@@ -1281,8 +1303,8 @@ htt_print_tx_selfgen_cmn_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_CMN_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "su_bar = %u\n",
 			 htt_stats_buf->su_bar);
 	len += scnprintf(buf + len, buf_len - len, "rts = %u\n",
@@ -1769,10 +1791,12 @@ htt_print_tx_pdev_stats_sched_per_txq_tlv(const void *tag_buf,
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__txq_id__word & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "txq_id = %u\n",
-			 (htt_stats_buf->mac_id__txq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID,
+				   htt_stats_buf->mac_id__txq_id__word));
+	len += scnprintf(buf + len, buf_len - len, "txq_id = %lu\n",
+			 FIELD_GET(HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID,
+				   htt_stats_buf->mac_id__txq_id__word));
 	len += scnprintf(buf + len, buf_len - len, "sched_policy = %u\n",
 			 htt_stats_buf->sched_policy);
 	len += scnprintf(buf + len, buf_len - len,
@@ -1833,8 +1857,8 @@ static inline void htt_print_stats_tx_sched_cmn_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_TX_SCHED_CMN_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "current_timestamp = %u\n\n",
 			 htt_stats_buf->current_timestamp);
 
@@ -2011,8 +2035,8 @@ static inline void htt_print_tx_tqm_cmn_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_CMN_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "max_cmdq_id = %u\n",
 			 htt_stats_buf->max_cmdq_id);
 	len += scnprintf(buf + len, buf_len - len, "list_mpdu_cnt_hist_intvl = %u\n",
@@ -2069,10 +2093,12 @@ static inline void htt_print_tx_tqm_cmdq_status_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_CMDQ_STATUS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__cmdq_id__word & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "cmdq_id = %u\n\n",
-			 (htt_stats_buf->mac_id__cmdq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_TX_TQM_CMDQ_STATUS_MAC_ID,
+				   htt_stats_buf->mac_id__cmdq_id__word));
+	len += scnprintf(buf + len, buf_len - len, "cmdq_id = %lu\n\n",
+			 FIELD_GET(HTT_TX_TQM_CMDQ_STATUS_CMDQ_ID,
+				   htt_stats_buf->mac_id__cmdq_id__word));
 	len += scnprintf(buf + len, buf_len - len, "sync_cmd = %u\n",
 			 htt_stats_buf->sync_cmd);
 	len += scnprintf(buf + len, buf_len - len, "write_cmd = %u\n",
@@ -2417,8 +2443,8 @@ htt_print_tx_de_cmn_stats_tlv(const void *tag_buf, struct debug_htt_stats_req *s
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_DE_CMN_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "tcl2fw_entry_count = %u\n",
 			 htt_stats_buf->tcl2fw_entry_count);
 	len += scnprintf(buf + len, buf_len - len, "not_to_fw = %u\n",
@@ -2453,26 +2479,32 @@ static inline void htt_print_ring_if_stats_tlv(const void *tag_buf,
 			 htt_stats_buf->base_addr);
 	len += scnprintf(buf + len, buf_len - len, "elem_size = %u\n",
 			 htt_stats_buf->elem_size);
-	len += scnprintf(buf + len, buf_len - len, "num_elems = %u\n",
-			 htt_stats_buf->num_elems__prefetch_tail_idx & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "prefetch_tail_idx = %u\n",
-			 (htt_stats_buf->num_elems__prefetch_tail_idx &
-			 0xFFFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "head_idx = %u\n",
-			 htt_stats_buf->head_idx__tail_idx & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "tail_idx = %u\n",
-			 (htt_stats_buf->head_idx__tail_idx & 0xFFFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "shadow_head_idx = %u\n",
-			 htt_stats_buf->shadow_head_idx__shadow_tail_idx & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "shadow_tail_idx = %u\n",
-			 (htt_stats_buf->shadow_head_idx__shadow_tail_idx &
-			 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "num_elems = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_NUM_ELEMS,
+				   htt_stats_buf->num_elems__prefetch_tail_idx));
+	len += scnprintf(buf + len, buf_len - len, "prefetch_tail_idx = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_PREFETCH_TAIL_INDEX,
+				   htt_stats_buf->num_elems__prefetch_tail_idx));
+	len += scnprintf(buf + len, buf_len - len, "head_idx = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_HEAD_IDX,
+				   htt_stats_buf->head_idx__tail_idx));
+	len += scnprintf(buf + len, buf_len - len, "tail_idx = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_TAIL_IDX,
+				   htt_stats_buf->head_idx__tail_idx));
+	len += scnprintf(buf + len, buf_len - len, "shadow_head_idx = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_SHADOW_HEAD_IDX,
+				   htt_stats_buf->shadow_head_idx__shadow_tail_idx));
+	len += scnprintf(buf + len, buf_len - len, "shadow_tail_idx = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_SHADOW_TAIL_IDX,
+				   htt_stats_buf->shadow_head_idx__shadow_tail_idx));
 	len += scnprintf(buf + len, buf_len - len, "num_tail_incr = %u\n",
 			 htt_stats_buf->num_tail_incr);
-	len += scnprintf(buf + len, buf_len - len, "lwm_thresh = %u\n",
-			 htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "hwm_thresh = %u\n",
-			 (htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "lwm_thresh = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_LWM_THRESH,
+				   htt_stats_buf->lwm_thresh__hwm_thresh));
+	len += scnprintf(buf + len, buf_len - len, "hwm_thresh = %lu\n",
+			 FIELD_GET(HTT_RING_IF_STATS_HWM_THRESH,
+				   htt_stats_buf->lwm_thresh__hwm_thresh));
 	len += scnprintf(buf + len, buf_len - len, "overrun_hit_count = %u\n",
 			 htt_stats_buf->overrun_hit_count);
 	len += scnprintf(buf + len, buf_len - len, "underrun_hit_count = %u\n",
@@ -2504,8 +2536,8 @@ static inline void htt_print_ring_if_cmn_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RING_IF_CMN_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n\n",
 			 htt_stats_buf->num_records);
 
@@ -2581,8 +2613,8 @@ static inline void htt_print_sfm_cmn_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CMN_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "buf_total = %u\n",
 			 htt_stats_buf->buf_total);
 	len += scnprintf(buf + len, buf_len - len, "mem_empty = %u\n",
@@ -2609,14 +2641,18 @@ static inline void htt_print_sring_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_SRING_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF);
-	len += scnprintf(buf + len, buf_len - len, "ring_id = %u\n",
-			 (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF00) >> 8);
-	len += scnprintf(buf + len, buf_len - len, "arena = %u\n",
-			 (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "ep = %u\n",
-			 (htt_stats_buf->mac_id__ring_id__arena__ep & 0x1000000) >> 24);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_MAC_ID,
+				   htt_stats_buf->mac_id__ring_id__arena__ep));
+	len += scnprintf(buf + len, buf_len - len, "ring_id = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_RING_ID,
+				   htt_stats_buf->mac_id__ring_id__arena__ep));
+	len += scnprintf(buf + len, buf_len - len, "arena = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_ARENA,
+				   htt_stats_buf->mac_id__ring_id__arena__ep));
+	len += scnprintf(buf + len, buf_len - len, "ep = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_EP,
+				   htt_stats_buf->mac_id__ring_id__arena__ep));
 	len += scnprintf(buf + len, buf_len - len, "base_addr_lsb = 0x%x\n",
 			 htt_stats_buf->base_addr_lsb);
 	len += scnprintf(buf + len, buf_len - len, "base_addr_msb = 0x%x\n",
@@ -2625,25 +2661,30 @@ static inline void htt_print_sring_stats_tlv(const void *tag_buf,
 			 htt_stats_buf->ring_size);
 	len += scnprintf(buf + len, buf_len - len, "elem_size = %u\n",
 			 htt_stats_buf->elem_size);
-	len += scnprintf(buf + len, buf_len - len, "num_avail_words = %u\n",
-			 htt_stats_buf->num_avail_words__num_valid_words & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "num_valid_words = %u\n",
-			 (htt_stats_buf->num_avail_words__num_valid_words &
-			 0xFFFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "head_ptr = %u\n",
-			 htt_stats_buf->head_ptr__tail_ptr & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "tail_ptr = %u\n",
-			 (htt_stats_buf->head_ptr__tail_ptr & 0xFFFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "consumer_empty = %u\n",
-			 htt_stats_buf->consumer_empty__producer_full & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "producer_full = %u\n",
-			 (htt_stats_buf->consumer_empty__producer_full &
-			 0xFFFF0000) >> 16);
-	len += scnprintf(buf + len, buf_len - len, "prefetch_count = %u\n",
-			 htt_stats_buf->prefetch_count__internal_tail_ptr & 0xFFFF);
-	len += scnprintf(buf + len, buf_len - len, "internal_tail_ptr = %u\n\n",
-			 (htt_stats_buf->prefetch_count__internal_tail_ptr &
-			 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "num_avail_words = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_NUM_AVAIL_WORDS,
+				   htt_stats_buf->num_avail_words__num_valid_words));
+	len += scnprintf(buf + len, buf_len - len, "num_valid_words = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_NUM_VALID_WORDS,
+				   htt_stats_buf->num_avail_words__num_valid_words));
+	len += scnprintf(buf + len, buf_len - len, "head_ptr = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_HEAD_PTR,
+				   htt_stats_buf->head_ptr__tail_ptr));
+	len += scnprintf(buf + len, buf_len - len, "tail_ptr = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_TAIL_PTR,
+				   htt_stats_buf->head_ptr__tail_ptr));
+	len += scnprintf(buf + len, buf_len - len, "consumer_empty = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_CONSUMER_EMPTY,
+				   htt_stats_buf->consumer_empty__producer_full));
+	len += scnprintf(buf + len, buf_len - len, "producer_full = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_PRODUCER_FULL,
+				   htt_stats_buf->consumer_empty__producer_full));
+	len += scnprintf(buf + len, buf_len - len, "prefetch_count = %lu\n",
+			 FIELD_GET(HTT_SRING_STATS_PREFETCH_COUNT,
+				   htt_stats_buf->prefetch_count__internal_tail_ptr));
+	len += scnprintf(buf + len, buf_len - len, "internal_tail_ptr = %lu\n\n",
+			 FIELD_GET(HTT_SRING_STATS_INTERNAL_TAIL_PTR,
+				   htt_stats_buf->prefetch_count__internal_tail_ptr));
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2683,8 +2724,8 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 	u8 j;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_RATE_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "tx_ldpc = %u\n",
 			 htt_stats_buf->tx_ldpc);
 	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_ldpc = %u\n",
@@ -2809,8 +2850,8 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 	u8 i, j;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "nsts = %u\n",
 			 htt_stats_buf->nsts);
 	len += scnprintf(buf + len, buf_len - len, "rx_ldpc = %u\n",
@@ -2844,7 +2885,6 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 			 htt_stats_buf->pilot_count);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-
 		len += scnprintf(buf + len, buf_len - len,
 				 "pilot_evm_db[%u] = ", j);
 		for (i = 0; i < HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS; i++)
@@ -3173,8 +3213,8 @@ static inline void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "ppdu_recvd = %u\n",
 			 htt_stats_buf->ppdu_recvd);
 	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt_fcs_ok = %u\n",
@@ -3422,8 +3462,8 @@ static inline void htt_print_hw_stats_whal_tx_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_WHAL_TX_TLV:\n");
-	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
-			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %lu\n",
+			 FIELD_GET(HTT_STATS_MAC_ID, htt_stats_buf->mac_id__word));
 	len += scnprintf(buf + len, buf_len - len, "last_unpause_ppdu_id = %u\n",
 			 htt_stats_buf->last_unpause_ppdu_id);
 	len += scnprintf(buf + len, buf_len - len, "hwsch_unpause_wait_tqm_write = %u\n",
@@ -3492,13 +3532,19 @@ htt_print_pdev_stats_twt_session_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "vdev_id = %u\n",
 			 htt_stats_buf->vdev_id);
 	len += scnprintf(buf + len, buf_len - len,
-			 "peer_mac = %02x:%02x:%02x:%02x:%02x:%02x\n",
-			 htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF,
-			 (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF00) >> 8,
-			 (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF0000) >> 16,
-			 (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF000000) >> 24,
-			 (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF),
-			 (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF00) >> 8);
+			 "peer_mac = %02lx:%02lx:%02lx:%02lx:%02lx:%02lx\n",
+			 FIELD_GET(HTT_MAC_ADDR_L32_0,
+				   htt_stats_buf->peer_mac.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_L32_1,
+				   htt_stats_buf->peer_mac.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_L32_2,
+				   htt_stats_buf->peer_mac.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_L32_3,
+				   htt_stats_buf->peer_mac.mac_addr_l32),
+			 FIELD_GET(HTT_MAC_ADDR_H16_0,
+				   htt_stats_buf->peer_mac.mac_addr_h16),
+			 FIELD_GET(HTT_MAC_ADDR_H16_1,
+				   htt_stats_buf->peer_mac.mac_addr_h16));
 	len += scnprintf(buf + len, buf_len - len, "flow_id_flags = %u\n",
 			 htt_stats_buf->flow_id_flags);
 	len += scnprintf(buf + len, buf_len - len, "dialog_id = %u\n",
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
index d428f52003a4..95ab8505ae5f 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -137,6 +137,8 @@ struct htt_stats_string_tlv {
 	u32 data[0]; /* Can be variable length */
 } __packed;
 
+#define HTT_STATS_MAC_ID	GENMASK(7, 0)
+
 /* == TX PDEV STATS == */
 struct htt_tx_pdev_stats_cmn_tlv {
 	u32 mac_id__word;
@@ -290,6 +292,10 @@ struct htt_hw_stats_whal_tx_tlv {
 };
 
 /* ============ PEER STATS ============ */
+#define	HTT_MSDU_FLOW_STATS_TX_FLOW_NO	GENMASK(15, 0)
+#define	HTT_MSDU_FLOW_STATS_TID_NUM	GENMASK(19, 16)
+#define	HTT_MSDU_FLOW_STATS_DROP_RULE	BIT(20)
+
 struct htt_msdu_flow_stats_tlv {
 	u32 last_update_timestamp;
 	u32 last_add_timestamp;
@@ -306,6 +312,11 @@ struct htt_msdu_flow_stats_tlv {
 
 #define MAX_HTT_TID_NAME 8
 
+#define	HTT_TX_TID_STATS_SW_PEER_ID		GENMASK(15, 0)
+#define	HTT_TX_TID_STATS_TID_NUM		GENMASK(31, 16)
+#define	HTT_TX_TID_STATS_NUM_SCHED_PENDING	GENMASK(7, 0)
+#define	HTT_TX_TID_STATS_NUM_PPDU_IN_HWQ	GENMASK(15, 8)
+
 /* Tidq stats */
 struct htt_tx_tid_stats_tlv {
 	/* Stored as little endian */
@@ -326,6 +337,11 @@ struct htt_tx_tid_stats_tlv {
 	u32 tid_tx_airtime;
 };
 
+#define	HTT_TX_TID_STATS_V1_SW_PEER_ID		GENMASK(15, 0)
+#define	HTT_TX_TID_STATS_V1_TID_NUM		GENMASK(31, 16)
+#define	HTT_TX_TID_STATS_V1_NUM_SCHED_PENDING	GENMASK(7, 0)
+#define	HTT_TX_TID_STATS_V1_NUM_PPDU_IN_HWQ	GENMASK(15, 8)
+
 /* Tidq stats */
 struct htt_tx_tid_stats_v1_tlv {
 	/* Stored as little endian */
@@ -348,6 +364,9 @@ struct htt_tx_tid_stats_v1_tlv {
 	u32 sendn_frms_allowed;
 };
 
+#define	HTT_RX_TID_STATS_SW_PEER_ID	GENMASK(15, 0)
+#define	HTT_RX_TID_STATS_TID_NUM	GENMASK(31, 16)
+
 struct htt_rx_tid_stats_tlv {
 	u32 sw_peer_id__tid_num;
 	u8 tid_name[MAX_HTT_TID_NAME];
@@ -386,6 +405,10 @@ struct htt_peer_stats_cmn_tlv {
 	u32 inactive_time;
 };
 
+#define HTT_PEER_DETAILS_VDEV_ID	GENMASK(7, 0)
+#define HTT_PEER_DETAILS_PDEV_ID	GENMASK(15, 8)
+#define HTT_PEER_DETAILS_AST_IDX	GENMASK(31, 16)
+
 struct htt_peer_details_tlv {
 	u32 peer_type;
 	u32 sw_peer_id;
@@ -510,6 +533,9 @@ struct htt_tx_hwq_mu_mimo_mpdu_stats_tlv {
 	u32 mu_mimo_ampdu_underrun_usr;
 };
 
+#define	HTT_TX_HWQ_STATS_MAC_ID	GENMASK(7, 0)
+#define	HTT_TX_HWQ_STATS_HWQ_ID	GENMASK(15, 8)
+
 struct htt_tx_hwq_mu_mimo_cmn_stats_tlv {
 	u32 mac_id__hwq_id__word;
 };
@@ -789,6 +815,9 @@ struct htt_sched_txq_sched_ineligibility_tlv_v {
 	u32 sched_ineligibility[0];
 };
 
+#define	HTT_TX_PDEV_STATS_SCHED_PER_TXQ_MAC_ID	GENMASK(7, 0)
+#define	HTT_TX_PDEV_STATS_SCHED_PER_TXQ_ID	GENMASK(15, 8)
+
 struct htt_tx_pdev_stats_sched_per_txq_tlv {
 	u32 mac_id__txq_id__word;
 	u32 sched_policy;
@@ -910,6 +939,9 @@ struct htt_tx_tqm_error_stats_tlv {
 };
 
 /* == TQM CMDQ stats == */
+#define	HTT_TX_TQM_CMDQ_STATUS_MAC_ID	GENMASK(7, 0)
+#define	HTT_TX_TQM_CMDQ_STATUS_CMDQ_ID	GENMASK(15, 8)
+
 struct htt_tx_tqm_cmdq_status_tlv {
 	u32 mac_id__cmdq_id__word;
 	u32 sync_cmd;
@@ -1055,6 +1087,15 @@ struct htt_tx_de_cmn_stats_tlv {
 #define HTT_STATS_LOW_WM_BINS      5
 #define HTT_STATS_HIGH_WM_BINS     5
 
+#define HTT_RING_IF_STATS_NUM_ELEMS		GENMASK(15, 0)
+#define	HTT_RING_IF_STATS_PREFETCH_TAIL_INDEX	GENMASK(31, 16)
+#define HTT_RING_IF_STATS_HEAD_IDX		GENMASK(15, 0)
+#define HTT_RING_IF_STATS_TAIL_IDX		GENMASK(31, 16)
+#define HTT_RING_IF_STATS_SHADOW_HEAD_IDX	GENMASK(15, 0)
+#define HTT_RING_IF_STATS_SHADOW_TAIL_IDX	GENMASK(31, 16)
+#define HTT_RING_IF_STATS_LWM_THRESH		GENMASK(15, 0)
+#define HTT_RING_IF_STATS_HWM_THRESH		GENMASK(31, 16)
+
 struct htt_ring_if_stats_tlv {
 	u32 base_addr; /* DWORD aligned base memory address of the ring */
 	u32 elem_size;
@@ -1117,6 +1158,19 @@ struct htt_sfm_cmn_tlv {
 };
 
 /* == SRNG STATS == */
+#define	HTT_SRING_STATS_MAC_ID			GENMASK(7, 0)
+#define HTT_SRING_STATS_RING_ID			GENMASK(15, 8)
+#define HTT_SRING_STATS_ARENA			GENMASK(23, 16)
+#define HTT_SRING_STATS_EP			BIT(24)
+#define HTT_SRING_STATS_NUM_AVAIL_WORDS		GENMASK(15, 0)
+#define HTT_SRING_STATS_NUM_VALID_WORDS		GENMASK(31, 16)
+#define HTT_SRING_STATS_HEAD_PTR		GENMASK(15, 0)
+#define HTT_SRING_STATS_TAIL_PTR		GENMASK(31, 16)
+#define HTT_SRING_STATS_CONSUMER_EMPTY		GENMASK(15, 0)
+#define HTT_SRING_STATS_PRODUCER_FULL		GENMASK(31, 16)
+#define HTT_SRING_STATS_PREFETCH_COUNT		GENMASK(15, 0)
+#define HTT_SRING_STATS_INTERNAL_TAIL_PTR	GENMASK(31, 16)
+
 struct htt_sring_stats_tlv {
 	u32 mac_id__ring_id__arena__ep;
 	u32 base_addr_lsb; /* DWORD aligned base memory address of the ring */
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 522d3a6ce253..36ef85e9515a 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1692,6 +1692,13 @@ struct ath11k_htt_extd_stats_msg {
 	u8 data[0];
 } __packed;
 
+#define	HTT_MAC_ADDR_L32_0	GENMASK(7, 0)
+#define	HTT_MAC_ADDR_L32_1	GENMASK(15, 8)
+#define	HTT_MAC_ADDR_L32_2	GENMASK(23, 16)
+#define	HTT_MAC_ADDR_L32_3	GENMASK(31, 24)
+#define	HTT_MAC_ADDR_H16_0	GENMASK(7, 0)
+#define	HTT_MAC_ADDR_H16_1	GENMASK(15, 8)
+
 struct htt_mac_addr {
 	u32 mac_addr_l32;
 	u32 mac_addr_h16;
-- 
2.25.1

