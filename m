Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1C409FAE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 00:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbhIMWdf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 18:33:35 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:22791 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbhIMWdc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 18:33:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631572334; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0O8uBM/e7467t2lIGRFB+MNcl8ezCnUT9jJyMJAXSzU=; b=MGDfSvLJHOptwx6R01nF18jbRvnLWieTLWZ/vnb00eOwKzmUaqMDsL3Cb0nRjUvBsbm4UsGs
 fimdUMyCxUSRQiSaZPRFXW60Yx3rEn+G60RH+Ni8Hf0liFYBzHvwArVeXGD/R/ZW+4NsMMnO
 CYUGqyHuWBYr6lDxo3fBfH3K1nA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 613fd16c648642cc1c625d1a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 22:32:12
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10C9CC43460; Mon, 13 Sep 2021 22:32:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FEB5C4360D;
        Mon, 13 Sep 2021 22:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7FEB5C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/5] ath11k: Rename macro ARRAY_TO_STRING to PRINT_ARRAY_TO_BUF
Date:   Tue, 14 Sep 2021 01:31:44 +0300
Message-Id: <20210913223148.208026-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913223148.208026-1-jouni@codeaurora.org>
References: <20210913223148.208026-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

Renaming of macro is done to describe the macro functionality
better as the macro functionality is modified in next patch-sets.
No functional changes are done.

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 378 +++++++++---------
 1 file changed, 189 insertions(+), 189 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 9e0c90da99d3..f2786ff124c3 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -18,7 +18,7 @@
 
 #define HTT_TLV_HDR_LEN 4
 
-#define ARRAY_TO_STRING(out, arr, len)							\
+#define PRINT_ARRAY_TO_BUF(out, arr, len)						\
 	do {										\
 		int index = 0; u8 i;							\
 		for (i = 0; i < len; i++) {						\
@@ -195,7 +195,7 @@ htt_print_tx_pdev_stats_urrn_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_URRN_TLV_V:");
 
-	ARRAY_TO_STRING(urrn_stats, htt_stats_buf->urrn_stats, num_elems);
+	PRINT_ARRAY_TO_BUF(urrn_stats, htt_stats_buf->urrn_stats, num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "urrn_stats = %s\n", urrn_stats);
 
 	if (len >= buf_len)
@@ -220,7 +220,7 @@ htt_print_tx_pdev_stats_flush_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_FLUSH_TLV_V:");
 
-	ARRAY_TO_STRING(flush_errs, htt_stats_buf->flush_errs, num_elems);
+	PRINT_ARRAY_TO_BUF(flush_errs, htt_stats_buf->flush_errs, num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_errs = %s\n", flush_errs);
 
 	if (len >= buf_len)
@@ -245,7 +245,7 @@ htt_print_tx_pdev_stats_sifs_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_SIFS_TLV_V:");
 
-	ARRAY_TO_STRING(sifs_status, htt_stats_buf->sifs_status, num_elems);
+	PRINT_ARRAY_TO_BUF(sifs_status, htt_stats_buf->sifs_status, num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_status = %s\n",
 			   sifs_status);
 
@@ -271,7 +271,7 @@ htt_print_tx_pdev_stats_phy_err_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_PHY_ERR_TLV_V:");
 
-	ARRAY_TO_STRING(phy_errs, htt_stats_buf->phy_errs, num_elems);
+	PRINT_ARRAY_TO_BUF(phy_errs, htt_stats_buf->phy_errs, num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
 
 	if (len >= buf_len)
@@ -297,7 +297,7 @@ htt_print_tx_pdev_stats_sifs_hist_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_TX_PDEV_STATS_SIFS_HIST_TLV_V:");
 
-	ARRAY_TO_STRING(sifs_hist_status, htt_stats_buf->sifs_hist_status, num_elems);
+	PRINT_ARRAY_TO_BUF(sifs_hist_status, htt_stats_buf->sifs_hist_status, num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_hist_status = %s\n",
 			   sifs_hist_status);
 
@@ -363,9 +363,9 @@ htt_print_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
 			   htt_stats_buf->hist_bin_size);
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(tried_mpdu_cnt_hist,
-				htt_stats_buf->tried_mpdu_cnt_hist,
-				num_elements);
+		PRINT_ARRAY_TO_BUF(tried_mpdu_cnt_hist,
+				   htt_stats_buf->tried_mpdu_cnt_hist,
+				   num_elements);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "tried_mpdu_cnt_hist = %s\n",
 				   tried_mpdu_cnt_hist);
 	} else {
@@ -667,9 +667,9 @@ static inline void htt_print_counter_tlv(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_COUNTER_TLV:");
 
-	ARRAY_TO_STRING(counter_name,
-			htt_stats_buf->counter_name,
-			HTT_MAX_COUNTER_NAME);
+	PRINT_ARRAY_TO_BUF(counter_name,
+			   htt_stats_buf->counter_name,
+			   HTT_MAX_COUNTER_NAME);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "counter_name = %s ", counter_name);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u\n",
 			   htt_stats_buf->count);
@@ -794,54 +794,54 @@ static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
 			   htt_stats_buf->ack_rssi);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mcs,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_su_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_su_mcs,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_su_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mu_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mu_mcs,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mu_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf,
-			htt_stats_buf->tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf,
+			   htt_stats_buf->tx_nss,
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf,
-			htt_stats_buf->tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf,
+			   htt_stats_buf->tx_bw,
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_stbc,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_stbc,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_pream,
-			HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_pream,
+			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
 
 	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j],
-				htt_stats_buf->tx_gi[j],
-				HTT_TX_PEER_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(tx_gi[j],
+				   htt_stats_buf->tx_gi[j],
+				   HTT_TX_PEER_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
-				j, tx_gi[j]);
+				   j, tx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf,
-			htt_stats_buf->tx_dcm,
-			HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf,
+			   htt_stats_buf->tx_dcm,
+			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
 
 	if (len >= buf_len)
@@ -895,47 +895,47 @@ static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
 			   htt_stats_buf->rssi_comb);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_mcs,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_mcs,
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_nss,
-			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_nss,
+			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_dcm,
-			HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_dcm,
+			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_stbc,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_stbc,
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_bw,
-			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_bw,
+			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
 
 	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
-		ARRAY_TO_STRING(rssi_chain[j], htt_stats_buf->rssi_chain[j],
-				HTT_RX_PEER_STATS_NUM_BW_COUNTERS);
+		PRINT_ARRAY_TO_BUF(rssi_chain[j], htt_stats_buf->rssi_chain[j],
+				   HTT_RX_PEER_STATS_NUM_BW_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
 				   j, rssi_chain[j]);
 	}
 
 	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->rx_gi[j],
-				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->rx_gi[j],
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
-				j, rx_gi[j]);
+				   j, rx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_pream,
-			HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_pream,
+			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s\n", str_buf);
 
 	if (len >= buf_len)
@@ -1115,10 +1115,10 @@ htt_print_tx_hwq_difs_latency_stats_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "hist_intvl = %u",
 			htt_stats_buf->hist_intvl);
 
-	ARRAY_TO_STRING(difs_latency_hist, htt_stats_buf->difs_latency_hist,
-			data_len);
+	PRINT_ARRAY_TO_BUF(difs_latency_hist, htt_stats_buf->difs_latency_hist,
+			   data_len);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "difs_latency_hist = %s\n",
-			difs_latency_hist);
+			   difs_latency_hist);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1145,7 +1145,7 @@ htt_print_tx_hwq_cmd_result_stats_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_TX_HWQ_CMD_RESULT_STATS_TLV_V:");
 
-	ARRAY_TO_STRING(cmd_result, htt_stats_buf->cmd_result, data_len);
+	PRINT_ARRAY_TO_BUF(cmd_result, htt_stats_buf->cmd_result, data_len);
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_result = %s\n", cmd_result);
 
@@ -1173,7 +1173,7 @@ htt_print_tx_hwq_cmd_stall_stats_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_CMD_STALL_STATS_TLV_V:");
 
-	ARRAY_TO_STRING(cmd_stall_status, htt_stats_buf->cmd_stall_status, num_elems);
+	PRINT_ARRAY_TO_BUF(cmd_stall_status, htt_stats_buf->cmd_stall_status, num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_stall_status = %s\n",
 			   cmd_stall_status);
 
@@ -1202,7 +1202,7 @@ htt_print_tx_hwq_fes_result_stats_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_TX_HWQ_FES_RESULT_STATS_TLV_V:");
 
-	ARRAY_TO_STRING(fes_result, htt_stats_buf->fes_result, num_elems);
+	PRINT_ARRAY_TO_BUF(fes_result, htt_stats_buf->fes_result, num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "fes_result = %s\n", fes_result);
 
 	if (len >= buf_len)
@@ -1233,9 +1233,9 @@ htt_print_tx_hwq_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
 			   htt_stats_buf->hist_bin_size);
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(tried_mpdu_cnt_hist,
-				htt_stats_buf->tried_mpdu_cnt_hist,
-				num_elements);
+		PRINT_ARRAY_TO_BUF(tried_mpdu_cnt_hist,
+				   htt_stats_buf->tried_mpdu_cnt_hist,
+				   num_elements);
 		len += HTT_DBG_OUT(buf + len, buf_len - len,
 				   "tried_mpdu_cnt_hist = %s\n",
 				   tried_mpdu_cnt_hist);
@@ -1269,9 +1269,9 @@ htt_print_tx_hwq_txop_used_cnt_hist_tlv_v(const void *tag_buf,
 			   "HTT_TX_HWQ_TXOP_USED_CNT_HIST_TLV_V:");
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(txop_used_cnt_hist,
-				htt_stats_buf->txop_used_cnt_hist,
-				num_elements);
+		PRINT_ARRAY_TO_BUF(txop_used_cnt_hist,
+				   htt_stats_buf->txop_used_cnt_hist,
+				   num_elements);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "txop_used_cnt_hist = %s\n",
 				   txop_used_cnt_hist);
 	} else {
@@ -1790,8 +1790,8 @@ htt_print_sched_txq_cmd_posted_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_POSTED_TLV_V:");
 
-	ARRAY_TO_STRING(sched_cmd_posted, htt_stats_buf->sched_cmd_posted,
-			num_elements);
+	PRINT_ARRAY_TO_BUF(sched_cmd_posted, htt_stats_buf->sched_cmd_posted,
+			   num_elements);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_posted = %s\n",
 			   sched_cmd_posted);
 
@@ -1817,8 +1817,8 @@ htt_print_sched_txq_cmd_reaped_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_REAPED_TLV_V:");
 
-	ARRAY_TO_STRING(sched_cmd_reaped, htt_stats_buf->sched_cmd_reaped,
-			num_elements);
+	PRINT_ARRAY_TO_BUF(sched_cmd_reaped, htt_stats_buf->sched_cmd_reaped,
+			   num_elements);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_reaped = %s\n",
 			   sched_cmd_reaped);
 
@@ -1847,8 +1847,8 @@ htt_print_sched_txq_sched_order_su_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV_V:");
 
-	ARRAY_TO_STRING(sched_order_su, htt_stats_buf->sched_order_su,
-			sched_order_su_num_entries);
+	PRINT_ARRAY_TO_BUF(sched_order_su, htt_stats_buf->sched_order_su,
+			   sched_order_su_num_entries);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_order_su = %s\n",
 			   sched_order_su);
 
@@ -1876,8 +1876,8 @@ htt_print_sched_txq_sched_ineligibility_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_SCHED_TXQ_SCHED_INELIGIBILITY_V:");
 
-	ARRAY_TO_STRING(sched_ineligibility, htt_stats_buf->sched_ineligibility,
-			sched_ineligibility_num_entries);
+	PRINT_ARRAY_TO_BUF(sched_ineligibility, htt_stats_buf->sched_ineligibility,
+			   sched_ineligibility_num_entries);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_ineligibility = %s\n",
 			   sched_ineligibility);
 
@@ -1992,8 +1992,8 @@ htt_print_tx_tqm_gen_mpdu_stats_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_GEN_MPDU_STATS_TLV_V:");
 
-	ARRAY_TO_STRING(gen_mpdu_end_reason, htt_stats_buf->gen_mpdu_end_reason,
-			num_elements);
+	PRINT_ARRAY_TO_BUF(gen_mpdu_end_reason, htt_stats_buf->gen_mpdu_end_reason,
+			   num_elements);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_end_reason = %s\n",
 			   gen_mpdu_end_reason);
 
@@ -2020,8 +2020,8 @@ htt_print_tx_tqm_list_mpdu_stats_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_TX_TQM_LIST_MPDU_STATS_TLV_V:");
 
-	ARRAY_TO_STRING(list_mpdu_end_reason, htt_stats_buf->list_mpdu_end_reason,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(list_mpdu_end_reason, htt_stats_buf->list_mpdu_end_reason,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_end_reason = %s\n",
 			   list_mpdu_end_reason);
 	if (len >= buf_len)
@@ -2047,8 +2047,8 @@ htt_print_tx_tqm_list_mpdu_cnt_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:");
 
-	ARRAY_TO_STRING(list_mpdu_cnt_hist, htt_stats_buf->list_mpdu_cnt_hist,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(list_mpdu_cnt_hist, htt_stats_buf->list_mpdu_cnt_hist,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_cnt_hist = %s\n",
 			   list_mpdu_cnt_hist);
 
@@ -2539,9 +2539,9 @@ htt_print_tx_de_fw2wbm_ring_full_hist_tlv(const void *tag_buf,
 			   "HTT_TX_DE_FW2WBM_RING_FULL_HIST_TLV");
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		ARRAY_TO_STRING(fw2wbm_ring_full_hist,
-				htt_stats_buf->fw2wbm_ring_full_hist,
-				num_elements);
+		PRINT_ARRAY_TO_BUF(fw2wbm_ring_full_hist,
+				   htt_stats_buf->fw2wbm_ring_full_hist,
+				   num_elements);
 		len += HTT_DBG_OUT(buf + len, buf_len - len,
 				   "fw2wbm_ring_full_hist = %s\n",
 				   fw2wbm_ring_full_hist);
@@ -2634,13 +2634,13 @@ static inline void htt_print_ring_if_stats_tlv(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "cons_blockwait_count = %u",
 			   htt_stats_buf->cons_blockwait_count);
 
-	ARRAY_TO_STRING(low_wm_hit_count, htt_stats_buf->low_wm_hit_count,
-			HTT_STATS_LOW_WM_BINS);
+	PRINT_ARRAY_TO_BUF(low_wm_hit_count, htt_stats_buf->low_wm_hit_count,
+			   HTT_STATS_LOW_WM_BINS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "low_wm_hit_count = %s ",
 			   low_wm_hit_count);
 
-	ARRAY_TO_STRING(high_wm_hit_count, htt_stats_buf->high_wm_hit_count,
-			HTT_STATS_HIGH_WM_BINS);
+	PRINT_ARRAY_TO_BUF(high_wm_hit_count, htt_stats_buf->high_wm_hit_count,
+			   HTT_STATS_HIGH_WM_BINS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "high_wm_hit_count = %s\n",
 			   high_wm_hit_count);
 
@@ -2687,9 +2687,9 @@ static inline void htt_print_sfm_client_user_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CLIENT_USER_TLV_V:");
 
-	ARRAY_TO_STRING(dwords_used_by_user_n,
-			htt_stats_buf->dwords_used_by_user_n,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(dwords_used_by_user_n,
+			   htt_stats_buf->dwords_used_by_user_n,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "dwords_used_by_user_n = %s\n",
 			   dwords_used_by_user_n);
 
@@ -2889,73 +2889,73 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 			   htt_stats_buf->tx_legacy_ofdm_rate[7]);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mcs,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_mcs,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_mcs,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_mcs,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_mcs,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_nss,
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_nss,
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_nss,
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_nss,
-			HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_nss,
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_bw,
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ac_mu_mimo_tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_bw,
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_bw = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ax_mu_mimo_tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_bw,
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_bw = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ofdma_tx_bw,
-			HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_bw,
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_bw = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_stbc,
-			HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_stbc,
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_pream,
-			HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_pream,
+			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HE LTF: 1x: %u, 2x: %u, 4x: %u",
@@ -2965,16 +2965,16 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 
 	/* SU GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->tx_gi[j],
+				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
 				   j, tx_gi[j]);
 	}
 
 	/* AC MU-MIMO GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ac_mu_mimo_tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ac_mu_mimo_tx_gi[j],
+				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len,
 				   "ac_mu_mimo_tx_gi[%u] = %s ",
 				   j, tx_gi[j]);
@@ -2982,8 +2982,8 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 
 	/* AX MU-MIMO GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ax_mu_mimo_tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ax_mu_mimo_tx_gi[j],
+				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len,
 				   "ax_mu_mimo_tx_gi[%u] = %s ",
 				   j, tx_gi[j]);
@@ -2991,15 +2991,15 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 
 	/* DL OFDMA GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(tx_gi[j], htt_stats_buf->ofdma_tx_gi[j],
-				HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ofdma_tx_gi[j],
+				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_gi[%u] = %s ",
 				   j, tx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->tx_dcm,
-			HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_dcm,
+			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
 
 	if (len >= buf_len)
@@ -3064,28 +3064,28 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 			   htt_stats_buf->rssi_in_dbm);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_mcs,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_mcs,
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_nss,
-			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_nss,
+			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_dcm,
-			HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_dcm,
+			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_stbc,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_stbc,
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_bw,
-			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_bw,
+			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_evm_nss_count = %u",
 			htt_stats_buf->nss_count);
@@ -3115,22 +3115,22 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB_mean = %s ", str_buf);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		ARRAY_TO_STRING(rssi_chain[j], htt_stats_buf->rssi_chain[j],
-				HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+		PRINT_ARRAY_TO_BUF(rssi_chain[j], htt_stats_buf->rssi_chain[j],
+				   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
 				   j, rssi_chain[j]);
 	}
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->rx_gi[j],
-				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->rx_gi[j],
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
 				   j, rx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_pream,
-			HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_pream,
+			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s", str_buf);
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_su_ext = %u",
@@ -3145,14 +3145,14 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 			   htt_stats_buf->txbf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_legacy_cck_rate,
-			HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_legacy_cck_rate,
+			   HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_cck_rate = %s ",
 			   str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_legacy_ofdm_rate,
-			HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_legacy_ofdm_rate,
+			   HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_ofdm_rate = %s ",
 			   str_buf);
 
@@ -3164,25 +3164,25 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 			htt_stats_buf->rx_11ax_ul_ofdma);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_mcs,
-			HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_mcs,
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_mcs = %s ", str_buf);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		ARRAY_TO_STRING(rx_gi[j], htt_stats_buf->ul_ofdma_rx_gi[j],
-				HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
+		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->ul_ofdma_rx_gi[j],
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
 		len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_gi[%u] = %s ",
 				   j, rx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_nss,
-			HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_nss,
+			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_nss = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->ul_ofdma_rx_bw,
-			HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_bw,
+			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_bw = %s ", str_buf);
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u",
@@ -3191,25 +3191,25 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 			htt_stats_buf->ul_ofdma_rx_ldpc);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_non_data_ppdu,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_non_data_ppdu,
+			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_non_data_ppdu = %s ",
 			   str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_data_ppdu,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_data_ppdu,
+			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_data_ppdu = %s ",
 			   str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_mpdu_ok,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_mpdu_ok,
+			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_ok = %s ", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	ARRAY_TO_STRING(str_buf, htt_stats_buf->rx_ulofdma_mpdu_fail,
-			HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
+	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_mpdu_fail,
+			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_fail = %s",
 			   str_buf);
 
@@ -3320,9 +3320,9 @@ htt_print_rx_soc_fw_refill_ring_empty_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV_V:");
 
-	ARRAY_TO_STRING(refill_ring_empty_cnt,
-			htt_stats_buf->refill_ring_empty_cnt,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(refill_ring_empty_cnt,
+			   htt_stats_buf->refill_ring_empty_cnt,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_empty_cnt = %s\n",
 			   refill_ring_empty_cnt);
 
@@ -3350,9 +3350,9 @@ htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV_V:");
 
-	ARRAY_TO_STRING(rxdma_err_cnt,
-			htt_stats_buf->rxdma_err,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(rxdma_err_cnt,
+			   htt_stats_buf->rxdma_err,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "rxdma_err = %s\n",
 			   rxdma_err_cnt);
 
@@ -3379,9 +3379,9 @@ htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV_V:");
 
-	ARRAY_TO_STRING(reo_err_cnt,
-			htt_stats_buf->reo_err,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(reo_err_cnt,
+			   htt_stats_buf->reo_err,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "reo_err = %s\n",
 			   reo_err_cnt);
 
@@ -3447,9 +3447,9 @@ htt_print_rx_soc_fw_refill_ring_num_refill_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV_V:");
 
-	ARRAY_TO_STRING(refill_ring_num_refill,
-			htt_stats_buf->refill_ring_num_refill,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(refill_ring_num_refill,
+			   htt_stats_buf->refill_ring_num_refill,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_num_refill = %s\n",
 			   refill_ring_num_refill);
 
@@ -3491,15 +3491,15 @@ static inline void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u",
 			   htt_stats_buf->fw_ring_mpdu_ind);
 
-	ARRAY_TO_STRING(fw_ring_mgmt_subtype,
-			htt_stats_buf->fw_ring_mgmt_subtype,
-			HTT_STATS_SUBTYPE_MAX);
+	PRINT_ARRAY_TO_BUF(fw_ring_mgmt_subtype,
+			   htt_stats_buf->fw_ring_mgmt_subtype,
+			   HTT_STATS_SUBTYPE_MAX);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mgmt_subtype = %s ",
 			   fw_ring_mgmt_subtype);
 
-	ARRAY_TO_STRING(fw_ring_ctrl_subtype,
-			htt_stats_buf->fw_ring_ctrl_subtype,
-			HTT_STATS_SUBTYPE_MAX);
+	PRINT_ARRAY_TO_BUF(fw_ring_ctrl_subtype,
+			   htt_stats_buf->fw_ring_ctrl_subtype,
+			   HTT_STATS_SUBTYPE_MAX);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_ctrl_subtype = %s ",
 			   fw_ring_ctrl_subtype);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u",
@@ -3597,9 +3597,9 @@ htt_print_rx_pdev_fw_ring_mpdu_err_tlv_v(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len,
 			   "HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV_V:");
 
-	ARRAY_TO_STRING(fw_ring_mpdu_err,
-			htt_stats_buf->fw_ring_mpdu_err,
-			HTT_RX_STATS_RXDMA_MAX_ERR);
+	PRINT_ARRAY_TO_BUF(fw_ring_mpdu_err,
+			   htt_stats_buf->fw_ring_mpdu_err,
+			   HTT_RX_STATS_RXDMA_MAX_ERR);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_err = %s\n",
 			   fw_ring_mpdu_err);
 
@@ -3625,9 +3625,9 @@ htt_print_rx_pdev_fw_mpdu_drop_tlv_v(const void *tag_buf,
 
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_MPDU_DROP_TLV_V:");
 
-	ARRAY_TO_STRING(fw_mpdu_drop,
-			htt_stats_buf->fw_mpdu_drop,
-			num_elems);
+	PRINT_ARRAY_TO_BUF(fw_mpdu_drop,
+			   htt_stats_buf->fw_mpdu_drop,
+			   num_elems);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_mpdu_drop = %s\n", fw_mpdu_drop);
 
 	if (len >= buf_len)
@@ -3654,9 +3654,9 @@ htt_print_rx_pdev_fw_stats_phy_err_tlv(const void *tag_buf,
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_phy_err_nct = %u",
 			   htt_stats_buf->total_phy_err_cnt);
 
-	ARRAY_TO_STRING(phy_errs,
-			htt_stats_buf->phy_err,
-			HTT_STATS_PHY_ERR_MAX);
+	PRINT_ARRAY_TO_BUF(phy_errs,
+			   htt_stats_buf->phy_err,
+			   HTT_STATS_PHY_ERR_MAX);
 	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
 
 	if (len >= buf_len)
-- 
2.25.1

