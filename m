Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A36409FAF
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 00:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbhIMWdl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 18:33:41 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:22791 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245145AbhIMWdl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 18:33:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631572344; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=afFpCRWhhRpquIsiXmULrJjJbeU3QLnHMA/D7QNtSJ8=; b=Wflc71IpIsN2yuMKk4zm/qnrXx6FGNcFX8KgfbszcpmZhbtt9JvgavU2obF/eaxjHdKXxBie
 77WEoF4LW1jBHb1vbP+7UUf3hqBVLoSlNd9ILLBKzE1Qmy8KqFPJGsb4mbDRyWOk5pNJ+cX2
 5bfRHfEuZiakH/w3Mct91+G467E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 613fd176ec62f57c9afa0d67 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 22:32:22
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 50593C43619; Mon, 13 Sep 2021 22:32:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 845A2C4338F;
        Mon, 13 Sep 2021 22:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 845A2C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/5] ath11k: Replace HTT_DBG_OUT with scnprintf
Date:   Tue, 14 Sep 2021 01:31:45 +0300
Message-Id: <20210913223148.208026-3-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913223148.208026-1-jouni@codeaurora.org>
References: <20210913223148.208026-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

Get rid of macro HTT_DBG_OUT and replace it with scnprintf().
The macro does not do anything else. Added required new line
characters to scnprintf() for proper display.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01105-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 3370 ++++++++---------
 1 file changed, 1683 insertions(+), 1687 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index f2786ff124c3..efd7f0757df6 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -10,9 +10,6 @@
 #include "debug.h"
 #include "debugfs_htt_stats.h"
 
-#define HTT_DBG_OUT(buf, len, fmt, ...) \
-			scnprintf(buf, len, fmt "\n", ##__VA_ARGS__)
-
 #define HTT_MAX_STRING_LEN 256
 #define HTT_MAX_PRINT_CHAR_PER_ELEM 15
 
@@ -43,17 +40,17 @@ static inline void htt_print_stats_string_tlv(const void *tag_buf,
 
 	tag_len = tag_len >> 2;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_STATS_STRING_TLV:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_STRING_TLV:\n");
 
 	for (i = 0; i < tag_len; i++) {
 		index += scnprintf(&data[index],
-				HTT_MAX_STRING_LEN - index,
-				"%.*s", 4, (char *)&(htt_stats_buf->data[i]));
+				   HTT_MAX_STRING_LEN - index,
+				   "%.*s", 4, (char *)&(htt_stats_buf->data[i]));
 		if (index >= HTT_MAX_STRING_LEN)
 			break;
 	}
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "data = %s\n", data);
+	len += scnprintf(buf + len, buf_len - len, "data = %s\n\n", data);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -71,107 +68,107 @@ static inline void htt_print_tx_pdev_stats_cmn_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_queued = %u",
-			   htt_stats_buf->hw_queued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_reaped = %u",
-			   htt_stats_buf->hw_reaped);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun = %u",
-			   htt_stats_buf->underrun);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_paused = %u",
-			   htt_stats_buf->hw_paused);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_flush = %u",
-			   htt_stats_buf->hw_flush);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_filt = %u",
-			   htt_stats_buf->hw_filt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort = %u",
-			   htt_stats_buf->tx_abort);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_requeued = %u",
-			   htt_stats_buf->mpdu_requeued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_xretry = %u",
-			   htt_stats_buf->tx_xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "data_rc = %u",
-			   htt_stats_buf->data_rc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_dropped_xretry = %u",
-			   htt_stats_buf->mpdu_dropped_xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "illegal_rate_phy_err = %u",
-			   htt_stats_buf->illgl_rate_phy_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cont_xretry = %u",
-			   htt_stats_buf->cont_xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_timeout = %u",
-			   htt_stats_buf->tx_timeout);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_resets = %u",
-			   htt_stats_buf->pdev_resets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_underrun = %u",
-			   htt_stats_buf->phy_underrun);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txop_ovf = %u",
-			   htt_stats_buf->txop_ovf);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_posted = %u",
-			   htt_stats_buf->seq_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_failed_queueing = %u",
-			   htt_stats_buf->seq_failed_queueing);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_completed = %u",
-			   htt_stats_buf->seq_completed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_restarted = %u",
-			   htt_stats_buf->seq_restarted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_seq_posted = %u",
-			   htt_stats_buf->mu_seq_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_switch_hw_paused = %u",
-			   htt_stats_buf->seq_switch_hw_paused);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "next_seq_posted_dsr = %u",
-			   htt_stats_buf->next_seq_posted_dsr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_posted_isr = %u",
-			   htt_stats_buf->seq_posted_isr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "seq_ctrl_cached = %u",
-			   htt_stats_buf->seq_ctrl_cached);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_count_tqm = %u",
-			   htt_stats_buf->mpdu_count_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_count_tqm = %u",
-			   htt_stats_buf->msdu_count_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_removed_tqm = %u",
-			   htt_stats_buf->mpdu_removed_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_removed_tqm = %u",
-			   htt_stats_buf->msdu_removed_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_sw_flush = %u",
-			   htt_stats_buf->mpdus_sw_flush);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_hw_filter = %u",
-			   htt_stats_buf->mpdus_hw_filter);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_truncated = %u",
-			   htt_stats_buf->mpdus_truncated);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_ack_failed = %u",
-			   htt_stats_buf->mpdus_ack_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_expired = %u",
-			   htt_stats_buf->mpdus_expired);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_seq_hw_retry = %u",
-			   htt_stats_buf->mpdus_seq_hw_retry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
-			   htt_stats_buf->ack_tlv_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "coex_abort_mpdu_cnt_valid = %u",
-			   htt_stats_buf->coex_abort_mpdu_cnt_valid);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "coex_abort_mpdu_cnt = %u",
-			   htt_stats_buf->coex_abort_mpdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_total_ppdus_tried_ota = %u",
-			   htt_stats_buf->num_total_ppdus_tried_ota);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_tried_ota = %u",
-			   htt_stats_buf->num_data_ppdus_tried_ota);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_ctrl_mgmt_enqued = %u",
-			   htt_stats_buf->local_ctrl_mgmt_enqued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_ctrl_mgmt_freed = %u",
-			   htt_stats_buf->local_ctrl_mgmt_freed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_data_enqued = %u",
-			   htt_stats_buf->local_data_enqued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_data_freed = %u",
-			   htt_stats_buf->local_data_freed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_tried = %u",
-			   htt_stats_buf->mpdu_tried);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "isr_wait_seq_posted = %u",
-			   htt_stats_buf->isr_wait_seq_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_active_dur_us_low = %u",
-			   htt_stats_buf->tx_active_dur_us_low);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_active_dur_us_high = %u\n",
-			   htt_stats_buf->tx_active_dur_us_high);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "hw_queued = %u\n",
+			 htt_stats_buf->hw_queued);
+	len += scnprintf(buf + len, buf_len - len, "hw_reaped = %u\n",
+			 htt_stats_buf->hw_reaped);
+	len += scnprintf(buf + len, buf_len - len, "underrun = %u\n",
+			 htt_stats_buf->underrun);
+	len += scnprintf(buf + len, buf_len - len, "hw_paused = %u\n",
+			 htt_stats_buf->hw_paused);
+	len += scnprintf(buf + len, buf_len - len, "hw_flush = %u\n",
+			 htt_stats_buf->hw_flush);
+	len += scnprintf(buf + len, buf_len - len, "hw_filt = %u\n",
+			 htt_stats_buf->hw_filt);
+	len += scnprintf(buf + len, buf_len - len, "tx_abort = %u\n",
+			 htt_stats_buf->tx_abort);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_requeued = %u\n",
+			 htt_stats_buf->mpdu_requeued);
+	len += scnprintf(buf + len, buf_len - len, "tx_xretry = %u\n",
+			 htt_stats_buf->tx_xretry);
+	len += scnprintf(buf + len, buf_len - len, "data_rc = %u\n",
+			 htt_stats_buf->data_rc);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_dropped_xretry = %u\n",
+			 htt_stats_buf->mpdu_dropped_xretry);
+	len += scnprintf(buf + len, buf_len - len, "illegal_rate_phy_err = %u\n",
+			 htt_stats_buf->illgl_rate_phy_err);
+	len += scnprintf(buf + len, buf_len - len, "cont_xretry = %u\n",
+			 htt_stats_buf->cont_xretry);
+	len += scnprintf(buf + len, buf_len - len, "tx_timeout = %u\n",
+			 htt_stats_buf->tx_timeout);
+	len += scnprintf(buf + len, buf_len - len, "pdev_resets = %u\n",
+			 htt_stats_buf->pdev_resets);
+	len += scnprintf(buf + len, buf_len - len, "phy_underrun = %u\n",
+			 htt_stats_buf->phy_underrun);
+	len += scnprintf(buf + len, buf_len - len, "txop_ovf = %u\n",
+			 htt_stats_buf->txop_ovf);
+	len += scnprintf(buf + len, buf_len - len, "seq_posted = %u\n",
+			 htt_stats_buf->seq_posted);
+	len += scnprintf(buf + len, buf_len - len, "seq_failed_queueing = %u\n",
+			 htt_stats_buf->seq_failed_queueing);
+	len += scnprintf(buf + len, buf_len - len, "seq_completed = %u\n",
+			 htt_stats_buf->seq_completed);
+	len += scnprintf(buf + len, buf_len - len, "seq_restarted = %u\n",
+			 htt_stats_buf->seq_restarted);
+	len += scnprintf(buf + len, buf_len - len, "mu_seq_posted = %u\n",
+			 htt_stats_buf->mu_seq_posted);
+	len += scnprintf(buf + len, buf_len - len, "seq_switch_hw_paused = %u\n",
+			 htt_stats_buf->seq_switch_hw_paused);
+	len += scnprintf(buf + len, buf_len - len, "next_seq_posted_dsr = %u\n",
+			 htt_stats_buf->next_seq_posted_dsr);
+	len += scnprintf(buf + len, buf_len - len, "seq_posted_isr = %u\n",
+			 htt_stats_buf->seq_posted_isr);
+	len += scnprintf(buf + len, buf_len - len, "seq_ctrl_cached = %u\n",
+			 htt_stats_buf->seq_ctrl_cached);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_count_tqm = %u\n",
+			 htt_stats_buf->mpdu_count_tqm);
+	len += scnprintf(buf + len, buf_len - len, "msdu_count_tqm = %u\n",
+			 htt_stats_buf->msdu_count_tqm);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_removed_tqm = %u\n",
+			 htt_stats_buf->mpdu_removed_tqm);
+	len += scnprintf(buf + len, buf_len - len, "msdu_removed_tqm = %u\n",
+			 htt_stats_buf->msdu_removed_tqm);
+	len += scnprintf(buf + len, buf_len - len, "mpdus_sw_flush = %u\n",
+			 htt_stats_buf->mpdus_sw_flush);
+	len += scnprintf(buf + len, buf_len - len, "mpdus_hw_filter = %u\n",
+			 htt_stats_buf->mpdus_hw_filter);
+	len += scnprintf(buf + len, buf_len - len, "mpdus_truncated = %u\n",
+			 htt_stats_buf->mpdus_truncated);
+	len += scnprintf(buf + len, buf_len - len, "mpdus_ack_failed = %u\n",
+			 htt_stats_buf->mpdus_ack_failed);
+	len += scnprintf(buf + len, buf_len - len, "mpdus_expired = %u\n",
+			 htt_stats_buf->mpdus_expired);
+	len += scnprintf(buf + len, buf_len - len, "mpdus_seq_hw_retry = %u\n",
+			 htt_stats_buf->mpdus_seq_hw_retry);
+	len += scnprintf(buf + len, buf_len - len, "ack_tlv_proc = %u\n",
+			 htt_stats_buf->ack_tlv_proc);
+	len += scnprintf(buf + len, buf_len - len, "coex_abort_mpdu_cnt_valid = %u\n",
+			 htt_stats_buf->coex_abort_mpdu_cnt_valid);
+	len += scnprintf(buf + len, buf_len - len, "coex_abort_mpdu_cnt = %u\n",
+			 htt_stats_buf->coex_abort_mpdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "num_total_ppdus_tried_ota = %u\n",
+			 htt_stats_buf->num_total_ppdus_tried_ota);
+	len += scnprintf(buf + len, buf_len - len, "num_data_ppdus_tried_ota = %u\n",
+			 htt_stats_buf->num_data_ppdus_tried_ota);
+	len += scnprintf(buf + len, buf_len - len, "local_ctrl_mgmt_enqued = %u\n",
+			 htt_stats_buf->local_ctrl_mgmt_enqued);
+	len += scnprintf(buf + len, buf_len - len, "local_ctrl_mgmt_freed = %u\n",
+			 htt_stats_buf->local_ctrl_mgmt_freed);
+	len += scnprintf(buf + len, buf_len - len, "local_data_enqued = %u\n",
+			 htt_stats_buf->local_data_enqued);
+	len += scnprintf(buf + len, buf_len - len, "local_data_freed = %u\n",
+			 htt_stats_buf->local_data_freed);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_tried = %u\n",
+			 htt_stats_buf->mpdu_tried);
+	len += scnprintf(buf + len, buf_len - len, "isr_wait_seq_posted = %u\n",
+			 htt_stats_buf->isr_wait_seq_posted);
+	len += scnprintf(buf + len, buf_len - len, "tx_active_dur_us_low = %u\n",
+			 htt_stats_buf->tx_active_dur_us_low);
+	len += scnprintf(buf + len, buf_len - len, "tx_active_dur_us_high = %u\n\n",
+			 htt_stats_buf->tx_active_dur_us_high);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -193,10 +190,10 @@ htt_print_tx_pdev_stats_urrn_tlv_v(const void *tag_buf,
 	char urrn_stats[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_URRN_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_URRN_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_URRN_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(urrn_stats, htt_stats_buf->urrn_stats, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "urrn_stats = %s\n", urrn_stats);
+	len += scnprintf(buf + len, buf_len - len, "urrn_stats = %s\n\n", urrn_stats);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -218,10 +215,10 @@ htt_print_tx_pdev_stats_flush_tlv_v(const void *tag_buf,
 	char flush_errs[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_FLUSH_REASON_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_FLUSH_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_FLUSH_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(flush_errs, htt_stats_buf->flush_errs, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_errs = %s\n", flush_errs);
+	len += scnprintf(buf + len, buf_len - len, "flush_errs = %s\n\n", flush_errs);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -243,11 +240,11 @@ htt_print_tx_pdev_stats_sifs_tlv_v(const void *tag_buf,
 	char sifs_status[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_SIFS_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_SIFS_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(sifs_status, htt_stats_buf->sifs_status, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_status = %s\n",
-			   sifs_status);
+	len += scnprintf(buf + len, buf_len - len, "sifs_status = %s\n\n",
+			 sifs_status);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -269,10 +266,10 @@ htt_print_tx_pdev_stats_phy_err_tlv_v(const void *tag_buf,
 	char phy_errs[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_PHY_ERR_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_PHY_ERR_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_PHY_ERR_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(phy_errs, htt_stats_buf->phy_errs, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
+	len += scnprintf(buf + len, buf_len - len, "phy_errs = %s\n\n", phy_errs);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -294,12 +291,12 @@ htt_print_tx_pdev_stats_sifs_hist_tlv_v(const void *tag_buf,
 	char sifs_hist_status[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_SIFS_HIST_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_SIFS_HIST_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(sifs_hist_status, htt_stats_buf->sifs_hist_status, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sifs_hist_status = %s\n",
-			   sifs_hist_status);
+	len += scnprintf(buf + len, buf_len - len, "sifs_hist_status = %s\n\n",
+			 sifs_hist_status);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -318,23 +315,23 @@ htt_print_tx_pdev_stats_tx_ppdu_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_TX_PPDU_STATS_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_TX_PPDU_STATS_TLV_V:\n");
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_legacy_su = %u",
-			   htt_stats_buf->num_data_ppdus_legacy_su);
+	len += scnprintf(buf + len, buf_len - len, "num_data_ppdus_legacy_su = %u\n",
+			 htt_stats_buf->num_data_ppdus_legacy_su);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ac_su = %u",
-			   htt_stats_buf->num_data_ppdus_ac_su);
+	len += scnprintf(buf + len, buf_len - len, "num_data_ppdus_ac_su = %u\n",
+			 htt_stats_buf->num_data_ppdus_ac_su);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ax_su = %u",
-			   htt_stats_buf->num_data_ppdus_ax_su);
+	len += scnprintf(buf + len, buf_len - len, "num_data_ppdus_ax_su = %u\n",
+			 htt_stats_buf->num_data_ppdus_ax_su);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ac_su_txbf = %u",
-			   htt_stats_buf->num_data_ppdus_ac_su_txbf);
+	len += scnprintf(buf + len, buf_len - len, "num_data_ppdus_ac_su_txbf = %u\n",
+			 htt_stats_buf->num_data_ppdus_ac_su_txbf);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_data_ppdus_ax_su_txbf = %u\n",
-			   htt_stats_buf->num_data_ppdus_ax_su_txbf);
+	len += scnprintf(buf + len, buf_len - len, "num_data_ppdus_ax_su_txbf = %u\n\n",
+			 htt_stats_buf->num_data_ppdus_ax_su_txbf);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -357,20 +354,20 @@ htt_print_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
 	u32  num_elements = ((tag_len - sizeof(htt_stats_buf->hist_bin_size)) >> 2);
 	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_TRIED_MPDU_CNT_HIST_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u",
-			   htt_stats_buf->hist_bin_size);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_TRIED_MPDU_CNT_HIST_TLV_V:\n");
+	len += scnprintf(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u\n",
+			 htt_stats_buf->hist_bin_size);
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
 		PRINT_ARRAY_TO_BUF(tried_mpdu_cnt_hist,
 				   htt_stats_buf->tried_mpdu_cnt_hist,
 				   num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "tried_mpdu_cnt_hist = %s\n",
-				   tried_mpdu_cnt_hist);
+		len += scnprintf(buf + len, buf_len - len, "tried_mpdu_cnt_hist = %s\n\n",
+				 tried_mpdu_cnt_hist);
 	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER\n");
+		len += scnprintf(buf + len, buf_len - len,
+				 "INSUFFICIENT PRINT BUFFER\n\n");
 	}
 
 	if (len >= buf_len)
@@ -390,14 +387,14 @@ static inline void htt_print_hw_stats_intr_misc_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char hw_intr_name[HTT_STATS_MAX_HW_INTR_NAME_LEN + 1] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_INTR_MISC_TLV:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_INTR_MISC_TLV:\n");
 	memcpy(hw_intr_name, &(htt_stats_buf->hw_intr_name[0]),
 	       HTT_STATS_MAX_HW_INTR_NAME_LEN);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_intr_name = %s ", hw_intr_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mask = %u",
-			   htt_stats_buf->mask);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u\n",
-			   htt_stats_buf->count);
+	len += scnprintf(buf + len, buf_len - len, "hw_intr_name = %s\n", hw_intr_name);
+	len += scnprintf(buf + len, buf_len - len, "mask = %u\n",
+			 htt_stats_buf->mask);
+	len += scnprintf(buf + len, buf_len - len, "count = %u\n\n",
+			 htt_stats_buf->count);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -417,13 +414,13 @@ htt_print_hw_stats_wd_timeout_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char hw_module_name[HTT_STATS_MAX_HW_MODULE_NAME_LEN + 1] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_WD_TIMEOUT_TLV:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_WD_TIMEOUT_TLV:\n");
 	memcpy(hw_module_name, &(htt_stats_buf->hw_module_name[0]),
 	       HTT_STATS_MAX_HW_MODULE_NAME_LEN);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_module_name = %s ",
-			   hw_module_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u",
-			   htt_stats_buf->count);
+	len += scnprintf(buf + len, buf_len - len, "hw_module_name = %s\n",
+			 hw_module_name);
+	len += scnprintf(buf + len, buf_len - len, "count = %u\n",
+			 htt_stats_buf->count);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -441,29 +438,29 @@ static inline void htt_print_hw_stats_pdev_errs_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_PDEV_ERRS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort = %u",
-			   htt_stats_buf->tx_abort);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_abort_fail_count = %u",
-			   htt_stats_buf->tx_abort_fail_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_abort = %u",
-			   htt_stats_buf->rx_abort);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_abort_fail_count = %u",
-			   htt_stats_buf->rx_abort_fail_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "warm_reset = %u",
-			   htt_stats_buf->warm_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cold_reset = %u",
-			   htt_stats_buf->cold_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_flush = %u",
-			   htt_stats_buf->tx_flush);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_glb_reset = %u",
-			   htt_stats_buf->tx_glb_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_txq_reset = %u",
-			   htt_stats_buf->tx_txq_reset);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_timeout_reset = %u\n",
-			   htt_stats_buf->rx_timeout_reset);
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_PDEV_ERRS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "tx_abort = %u\n",
+			 htt_stats_buf->tx_abort);
+	len += scnprintf(buf + len, buf_len - len, "tx_abort_fail_count = %u\n",
+			 htt_stats_buf->tx_abort_fail_count);
+	len += scnprintf(buf + len, buf_len - len, "rx_abort = %u\n",
+			 htt_stats_buf->rx_abort);
+	len += scnprintf(buf + len, buf_len - len, "rx_abort_fail_count = %u\n",
+			 htt_stats_buf->rx_abort_fail_count);
+	len += scnprintf(buf + len, buf_len - len, "warm_reset = %u\n",
+			 htt_stats_buf->warm_reset);
+	len += scnprintf(buf + len, buf_len - len, "cold_reset = %u\n",
+			 htt_stats_buf->cold_reset);
+	len += scnprintf(buf + len, buf_len - len, "tx_flush = %u\n",
+			 htt_stats_buf->tx_flush);
+	len += scnprintf(buf + len, buf_len - len, "tx_glb_reset = %u\n",
+			 htt_stats_buf->tx_glb_reset);
+	len += scnprintf(buf + len, buf_len - len, "tx_txq_reset = %u\n",
+			 htt_stats_buf->tx_txq_reset);
+	len += scnprintf(buf + len, buf_len - len, "rx_timeout_reset = %u\n\n",
+			 htt_stats_buf->rx_timeout_reset);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -481,35 +478,34 @@ static inline void htt_print_msdu_flow_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_MSDU_FLOW_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_update_timestamp = %u",
-			   htt_stats_buf->last_update_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_add_timestamp = %u",
-			   htt_stats_buf->last_add_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_remove_timestamp = %u",
-			   htt_stats_buf->last_remove_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_processed_msdu_count = %u",
-			   htt_stats_buf->total_processed_msdu_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cur_msdu_count_in_flowq = %u",
-			   htt_stats_buf->cur_msdu_count_in_flowq);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_flow_no = %u",
-			   htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xF0000) >>
-			   16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "drop_rule = %u",
-			   (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0x100000) >>
-			   20);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_enqueue_count = %u",
-			   htt_stats_buf->last_cycle_enqueue_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_dequeue_count = %u",
-			   htt_stats_buf->last_cycle_dequeue_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_cycle_drop_count = %u",
-			   htt_stats_buf->last_cycle_drop_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_drop_th = %u\n",
-			   htt_stats_buf->current_drop_th);
+	len += scnprintf(buf + len, buf_len - len, "HTT_MSDU_FLOW_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "last_update_timestamp = %u\n",
+			 htt_stats_buf->last_update_timestamp);
+	len += scnprintf(buf + len, buf_len - len, "last_add_timestamp = %u\n",
+			 htt_stats_buf->last_add_timestamp);
+	len += scnprintf(buf + len, buf_len - len, "last_remove_timestamp = %u\n",
+			 htt_stats_buf->last_remove_timestamp);
+	len += scnprintf(buf + len, buf_len - len, "total_processed_msdu_count = %u\n",
+			 htt_stats_buf->total_processed_msdu_count);
+	len += scnprintf(buf + len, buf_len - len, "cur_msdu_count_in_flowq = %u\n",
+			 htt_stats_buf->cur_msdu_count_in_flowq);
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
+			 htt_stats_buf->sw_peer_id);
+	len += scnprintf(buf + len, buf_len - len, "tx_flow_no = %u\n",
+			 htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
+			 (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0xF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "drop_rule = %u\n",
+			 (htt_stats_buf->tx_flow_no__tid_num__drop_rule & 0x100000) >>
+			 20);
+	len += scnprintf(buf + len, buf_len - len, "last_cycle_enqueue_count = %u\n",
+			 htt_stats_buf->last_cycle_enqueue_count);
+	len += scnprintf(buf + len, buf_len - len, "last_cycle_dequeue_count = %u\n",
+			 htt_stats_buf->last_cycle_dequeue_count);
+	len += scnprintf(buf + len, buf_len - len, "last_cycle_drop_count = %u\n",
+			 htt_stats_buf->last_cycle_drop_count);
+	len += scnprintf(buf + len, buf_len - len, "current_drop_th = %u\n\n",
+			 htt_stats_buf->current_drop_th);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -528,38 +524,38 @@ static inline void htt_print_tx_tid_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TID_STATS_TLV:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TID_STATS_TLV:\n");
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sched_pending = %u",
-			   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ppdu_in_hwq = %u",
-			   (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
-			   0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_flags = 0x%x",
-			   htt_stats_buf->tid_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_queued = %u",
-			   htt_stats_buf->hw_queued);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hw_reaped = %u",
-			   htt_stats_buf->hw_reaped);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdus_hw_filter = %u",
-			   htt_stats_buf->mpdus_hw_filter);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_bytes = %u",
-			   htt_stats_buf->qdepth_bytes);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_msdu = %u",
-			   htt_stats_buf->qdepth_num_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_mpdu = %u",
-			   htt_stats_buf->qdepth_num_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_scheduled_tsmp = %u",
-			   htt_stats_buf->last_scheduled_tsmp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_module_id = %u",
-			   htt_stats_buf->pause_module_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_module_id = %u\n",
-			   htt_stats_buf->block_module_id);
+	len += scnprintf(buf + len, buf_len - len, "tid_name = %s\n", tid_name);
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
+			 htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
+			 (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "num_sched_pending = %u\n",
+			 htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "num_ppdu_in_hwq = %u\n",
+			 (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
+			 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "tid_flags = 0x%x\n",
+			 htt_stats_buf->tid_flags);
+	len += scnprintf(buf + len, buf_len - len, "hw_queued = %u\n",
+			 htt_stats_buf->hw_queued);
+	len += scnprintf(buf + len, buf_len - len, "hw_reaped = %u\n",
+			 htt_stats_buf->hw_reaped);
+	len += scnprintf(buf + len, buf_len - len, "mpdus_hw_filter = %u\n",
+			 htt_stats_buf->mpdus_hw_filter);
+	len += scnprintf(buf + len, buf_len - len, "qdepth_bytes = %u\n",
+			 htt_stats_buf->qdepth_bytes);
+	len += scnprintf(buf + len, buf_len - len, "qdepth_num_msdu = %u\n",
+			 htt_stats_buf->qdepth_num_msdu);
+	len += scnprintf(buf + len, buf_len - len, "qdepth_num_mpdu = %u\n",
+			 htt_stats_buf->qdepth_num_mpdu);
+	len += scnprintf(buf + len, buf_len - len, "last_scheduled_tsmp = %u\n",
+			 htt_stats_buf->last_scheduled_tsmp);
+	len += scnprintf(buf + len, buf_len - len, "pause_module_id = %u\n",
+			 htt_stats_buf->pause_module_id);
+	len += scnprintf(buf + len, buf_len - len, "block_module_id = %u\n\n",
+			 htt_stats_buf->block_module_id);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -578,42 +574,42 @@ static inline void htt_print_tx_tid_stats_v1_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TID_STATS_V1_TLV:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TID_STATS_V1_TLV:\n");
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sched_pending = %u",
-			   htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ppdu_in_hwq = %u",
-			   (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
-			   0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_flags = 0x%x",
-			   htt_stats_buf->tid_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_qdepth_bytes = %u",
-			   htt_stats_buf->max_qdepth_bytes);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_qdepth_n_msdus = %u",
-			   htt_stats_buf->max_qdepth_n_msdus);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rsvd = %u",
-			   htt_stats_buf->rsvd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_bytes = %u",
-			   htt_stats_buf->qdepth_bytes);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_msdu = %u",
-			   htt_stats_buf->qdepth_num_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qdepth_num_mpdu = %u",
-			   htt_stats_buf->qdepth_num_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_scheduled_tsmp = %u",
-			   htt_stats_buf->last_scheduled_tsmp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_module_id = %u",
-			   htt_stats_buf->pause_module_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_module_id = %u",
-			   htt_stats_buf->block_module_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "allow_n_flags = 0x%x",
-			   htt_stats_buf->allow_n_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sendn_frms_allowed = %u\n",
-			   htt_stats_buf->sendn_frms_allowed);
+	len += scnprintf(buf + len, buf_len - len, "tid_name = %s\n", tid_name);
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
+			 htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
+			 (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "num_sched_pending = %u\n",
+			 htt_stats_buf->num_sched_pending__num_ppdu_in_hwq & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "num_ppdu_in_hwq = %u\n",
+			 (htt_stats_buf->num_sched_pending__num_ppdu_in_hwq &
+			 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "tid_flags = 0x%x\n",
+			 htt_stats_buf->tid_flags);
+	len += scnprintf(buf + len, buf_len - len, "max_qdepth_bytes = %u\n",
+			 htt_stats_buf->max_qdepth_bytes);
+	len += scnprintf(buf + len, buf_len - len, "max_qdepth_n_msdus = %u\n",
+			 htt_stats_buf->max_qdepth_n_msdus);
+	len += scnprintf(buf + len, buf_len - len, "rsvd = %u\n",
+			 htt_stats_buf->rsvd);
+	len += scnprintf(buf + len, buf_len - len, "qdepth_bytes = %u\n",
+			 htt_stats_buf->qdepth_bytes);
+	len += scnprintf(buf + len, buf_len - len, "qdepth_num_msdu = %u\n",
+			 htt_stats_buf->qdepth_num_msdu);
+	len += scnprintf(buf + len, buf_len - len, "qdepth_num_mpdu = %u\n",
+			 htt_stats_buf->qdepth_num_mpdu);
+	len += scnprintf(buf + len, buf_len - len, "last_scheduled_tsmp = %u\n",
+			 htt_stats_buf->last_scheduled_tsmp);
+	len += scnprintf(buf + len, buf_len - len, "pause_module_id = %u\n",
+			 htt_stats_buf->pause_module_id);
+	len += scnprintf(buf + len, buf_len - len, "block_module_id = %u\n",
+			 htt_stats_buf->block_module_id);
+	len += scnprintf(buf + len, buf_len - len, "allow_n_flags = 0x%x\n",
+			 htt_stats_buf->allow_n_flags);
+	len += scnprintf(buf + len, buf_len - len, "sendn_frms_allowed = %u\n\n",
+			 htt_stats_buf->sendn_frms_allowed);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -632,21 +628,21 @@ static inline void htt_print_rx_tid_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char tid_name[MAX_HTT_TID_NAME + 1] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_TID_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_num = %u",
-			   (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_TID_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
+			 htt_stats_buf->sw_peer_id__tid_num & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "tid_num = %u\n",
+			 (htt_stats_buf->sw_peer_id__tid_num & 0xFFFF0000) >> 16);
 	memcpy(tid_name, &(htt_stats_buf->tid_name[0]), MAX_HTT_TID_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tid_name = %s ", tid_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_in_reorder = %u",
-			   htt_stats_buf->dup_in_reorder);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_past_outside_window = %u",
-			   htt_stats_buf->dup_past_outside_window);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dup_past_within_window = %u",
-			   htt_stats_buf->dup_past_within_window);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rxdesc_err_decrypt = %u\n",
-			   htt_stats_buf->rxdesc_err_decrypt);
+	len += scnprintf(buf + len, buf_len - len, "tid_name = %s\n", tid_name);
+	len += scnprintf(buf + len, buf_len - len, "dup_in_reorder = %u\n",
+			 htt_stats_buf->dup_in_reorder);
+	len += scnprintf(buf + len, buf_len - len, "dup_past_outside_window = %u\n",
+			 htt_stats_buf->dup_past_outside_window);
+	len += scnprintf(buf + len, buf_len - len, "dup_past_within_window = %u\n",
+			 htt_stats_buf->dup_past_within_window);
+	len += scnprintf(buf + len, buf_len - len, "rxdesc_err_decrypt = %u\n\n",
+			 htt_stats_buf->rxdesc_err_decrypt);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -665,14 +661,14 @@ static inline void htt_print_counter_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char counter_name[HTT_MAX_STRING_LEN] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_COUNTER_TLV:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_COUNTER_TLV:\n");
 
 	PRINT_ARRAY_TO_BUF(counter_name,
 			   htt_stats_buf->counter_name,
 			   HTT_MAX_COUNTER_NAME);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "counter_name = %s ", counter_name);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "count = %u\n",
-			   htt_stats_buf->count);
+	len += scnprintf(buf + len, buf_len - len, "counter_name = %s\n", counter_name);
+	len += scnprintf(buf + len, buf_len - len, "count = %u\n\n",
+			 htt_stats_buf->count);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -690,35 +686,35 @@ static inline void htt_print_peer_stats_cmn_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PEER_STATS_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ppdu_cnt = %u",
-			   htt_stats_buf->ppdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt = %u",
-			   htt_stats_buf->mpdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_cnt = %u",
-			   htt_stats_buf->msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pause_bitmap = %u",
-			   htt_stats_buf->pause_bitmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "block_bitmap = %u",
-			   htt_stats_buf->block_bitmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_rssi = %d",
-			   htt_stats_buf->rssi);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueued_count = %llu",
-			   htt_stats_buf->peer_enqueued_count_low |
-			   ((u64)htt_stats_buf->peer_enqueued_count_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dequeued_count = %llu",
-			   htt_stats_buf->peer_dequeued_count_low |
-			   ((u64)htt_stats_buf->peer_dequeued_count_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dropped_count = %llu",
-			   htt_stats_buf->peer_dropped_count_low |
-			   ((u64)htt_stats_buf->peer_dropped_count_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "transmitted_ppdu_bytes = %llu",
-			   htt_stats_buf->ppdu_transmitted_bytes_low |
-			   ((u64)htt_stats_buf->ppdu_transmitted_bytes_high << 32));
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ttl_removed_count = %u",
-			   htt_stats_buf->peer_ttl_removed_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "inactive_time = %u\n",
-			   htt_stats_buf->inactive_time);
+	len += scnprintf(buf + len, buf_len - len, "HTT_PEER_STATS_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ppdu_cnt = %u\n",
+			 htt_stats_buf->ppdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt = %u\n",
+			 htt_stats_buf->mpdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "msdu_cnt = %u\n",
+			 htt_stats_buf->msdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "pause_bitmap = %u\n",
+			 htt_stats_buf->pause_bitmap);
+	len += scnprintf(buf + len, buf_len - len, "block_bitmap = %u\n",
+			 htt_stats_buf->block_bitmap);
+	len += scnprintf(buf + len, buf_len - len, "last_rssi = %d\n",
+			 htt_stats_buf->rssi);
+	len += scnprintf(buf + len, buf_len - len, "enqueued_count = %llu\n",
+			 htt_stats_buf->peer_enqueued_count_low |
+			 ((u64)htt_stats_buf->peer_enqueued_count_high << 32));
+	len += scnprintf(buf + len, buf_len - len, "dequeued_count = %llu\n",
+			 htt_stats_buf->peer_dequeued_count_low |
+			 ((u64)htt_stats_buf->peer_dequeued_count_high << 32));
+	len += scnprintf(buf + len, buf_len - len, "dropped_count = %llu\n",
+			 htt_stats_buf->peer_dropped_count_low |
+			 ((u64)htt_stats_buf->peer_dropped_count_high << 32));
+	len += scnprintf(buf + len, buf_len - len, "transmitted_ppdu_bytes = %llu\n",
+			 htt_stats_buf->ppdu_transmitted_bytes_low |
+			 ((u64)htt_stats_buf->ppdu_transmitted_bytes_high << 32));
+	len += scnprintf(buf + len, buf_len - len, "ttl_removed_count = %u\n",
+			 htt_stats_buf->peer_ttl_removed_count);
+	len += scnprintf(buf + len, buf_len - len, "inactive_time = %u\n\n",
+			 htt_stats_buf->inactive_time);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -736,29 +732,29 @@ static inline void htt_print_peer_details_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PEER_DETAILS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_type = %u",
-			   htt_stats_buf->peer_type);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sw_peer_id = %u",
-			   htt_stats_buf->sw_peer_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "vdev_id = %u",
-			   htt_stats_buf->vdev_pdev_ast_idx & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
-			   (htt_stats_buf->vdev_pdev_ast_idx & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ast_idx = %u",
-			   (htt_stats_buf->vdev_pdev_ast_idx & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "mac_addr = %02x:%02x:%02x:%02x:%02x:%02x",
-			   htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF,
-			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF00) >> 8,
-			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF0000) >> 16,
-			   (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF000000) >> 24,
-			   (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF),
-			   (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_flags = 0x%x",
-			   htt_stats_buf->peer_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qpeer_flags = 0x%x\n",
-			   htt_stats_buf->qpeer_flags);
+	len += scnprintf(buf + len, buf_len - len, "HTT_PEER_DETAILS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "peer_type = %u\n",
+			 htt_stats_buf->peer_type);
+	len += scnprintf(buf + len, buf_len - len, "sw_peer_id = %u\n",
+			 htt_stats_buf->sw_peer_id);
+	len += scnprintf(buf + len, buf_len - len, "vdev_id = %u\n",
+			 htt_stats_buf->vdev_pdev_ast_idx & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 (htt_stats_buf->vdev_pdev_ast_idx & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "ast_idx = %u\n",
+			 (htt_stats_buf->vdev_pdev_ast_idx & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len,
+			 "mac_addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
+			 htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF,
+			 (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF00) >> 8,
+			 (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF0000) >> 16,
+			 (htt_stats_buf->mac_addr.mac_addr_l32 & 0xFF000000) >> 24,
+			 (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF),
+			 (htt_stats_buf->mac_addr.mac_addr_h16 & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "peer_flags = 0x%x\n",
+			 htt_stats_buf->peer_flags);
+	len += scnprintf(buf + len, buf_len - len, "qpeer_flags = 0x%x\n\n",
+			 htt_stats_buf->qpeer_flags);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -785,64 +781,64 @@ static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
 			goto fail;
 	}
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PEER_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_ldpc = %u",
-			   htt_stats_buf->tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_rssi = %u",
-			   htt_stats_buf->ack_rssi);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PEER_RATE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "tx_ldpc = %u\n",
+			 htt_stats_buf->tx_ldpc);
+	len += scnprintf(buf + len, buf_len - len, "rts_cnt = %u\n",
+			 htt_stats_buf->rts_cnt);
+	len += scnprintf(buf + len, buf_len - len, "ack_rssi = %u\n",
+			 htt_stats_buf->ack_rssi);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mcs,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_su_mcs,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_su_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_su_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mu_mcs,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mu_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_mu_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf,
 			   htt_stats_buf->tx_nss,
 			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf,
 			   htt_stats_buf->tx_bw,
 			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_bw = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_stbc,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_stbc = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_pream,
 			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_pream = %s\n", str_buf);
 
 	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(tx_gi[j],
 				   htt_stats_buf->tx_gi[j],
 				   HTT_TX_PEER_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len, "tx_gi[%u] = %s\n",
+				 j, tx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf,
 			   htt_stats_buf->tx_dcm,
 			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_dcm = %s\n\n", str_buf);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -880,63 +876,63 @@ static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
 			goto fail;
 	}
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PEER_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "nsts = %u",
-			   htt_stats_buf->nsts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ldpc = %u",
-			   htt_stats_buf->rx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_mgmt = %u",
-			   htt_stats_buf->rssi_mgmt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_data = %u",
-			   htt_stats_buf->rssi_data);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_comb = %u",
-			   htt_stats_buf->rssi_comb);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PEER_RATE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "nsts = %u\n",
+			 htt_stats_buf->nsts);
+	len += scnprintf(buf + len, buf_len - len, "rx_ldpc = %u\n",
+			 htt_stats_buf->rx_ldpc);
+	len += scnprintf(buf + len, buf_len - len, "rts_cnt = %u\n",
+			 htt_stats_buf->rts_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rssi_mgmt = %u\n",
+			 htt_stats_buf->rssi_mgmt);
+	len += scnprintf(buf + len, buf_len - len, "rssi_data = %u\n",
+			 htt_stats_buf->rssi_data);
+	len += scnprintf(buf + len, buf_len - len, "rssi_comb = %u\n",
+			 htt_stats_buf->rssi_comb);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_mcs,
 			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_nss,
 			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_dcm,
 			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_dcm = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_stbc,
 			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_stbc = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_bw,
 			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_bw = %s\n", str_buf);
 
 	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
 		PRINT_ARRAY_TO_BUF(rssi_chain[j], htt_stats_buf->rssi_chain[j],
 				   HTT_RX_PEER_STATS_NUM_BW_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
-				   j, rssi_chain[j]);
+		len += scnprintf(buf + len, buf_len - len, "rssi_chain[%u] = %s\n",
+				 j, rssi_chain[j]);
 	}
 
 	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->rx_gi[j],
 				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
-				   j, rx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len, "rx_gi[%u] = %s\n",
+				 j, rx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_pream,
 			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s\n", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_pream = %s\n\n", str_buf);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -962,13 +958,13 @@ htt_print_tx_hwq_mu_mimo_sch_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_SCH_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_posted = %u",
-			   htt_stats_buf->mu_mimo_sch_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_failed = %u",
-			   htt_stats_buf->mu_mimo_sch_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n",
-			   htt_stats_buf->mu_mimo_ppdu_posted);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_SCH_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_sch_posted = %u\n",
+			 htt_stats_buf->mu_mimo_sch_posted);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_sch_failed = %u\n",
+			 htt_stats_buf->mu_mimo_sch_failed);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n\n",
+			 htt_stats_buf->mu_mimo_ppdu_posted);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -987,22 +983,22 @@ htt_print_tx_hwq_mu_mimo_mpdu_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_MU_MIMO_MPDU_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_queued_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_queued_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_tried_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_tried_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_failed_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_failed_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdus_requeued_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdus_requeued_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_err_no_ba_usr = %u",
-			   htt_stats_buf->mu_mimo_err_no_ba_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_mpdu_underrun_usr = %u",
-			   htt_stats_buf->mu_mimo_mpdu_underrun_usr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ampdu_underrun_usr = %u\n",
-			   htt_stats_buf->mu_mimo_ampdu_underrun_usr);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_MU_MIMO_MPDU_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_mpdus_queued_usr = %u\n",
+			 htt_stats_buf->mu_mimo_mpdus_queued_usr);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_mpdus_tried_usr = %u\n",
+			 htt_stats_buf->mu_mimo_mpdus_tried_usr);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_mpdus_failed_usr = %u\n",
+			 htt_stats_buf->mu_mimo_mpdus_failed_usr);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_mpdus_requeued_usr = %u\n",
+			 htt_stats_buf->mu_mimo_mpdus_requeued_usr);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_err_no_ba_usr = %u\n",
+			 htt_stats_buf->mu_mimo_err_no_ba_usr);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_mpdu_underrun_usr = %u\n",
+			 htt_stats_buf->mu_mimo_mpdu_underrun_usr);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_ampdu_underrun_usr = %u\n\n",
+			 htt_stats_buf->mu_mimo_ampdu_underrun_usr);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1021,11 +1017,11 @@ htt_print_tx_hwq_mu_mimo_cmn_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__hwq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwq_id = %u\n",
-			   (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_MU_MIMO_CMN_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__hwq_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "hwq_id = %u\n\n",
+			 (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1044,51 +1040,51 @@ htt_print_tx_hwq_stats_cmn_tlv(const void *tag_buf, struct debug_htt_stats_req *
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
 	/* TODO: HKDBG */
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_STATS_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__hwq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwq_id = %u",
-			   (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "xretry = %u",
-			   htt_stats_buf->xretry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun_cnt = %u",
-			   htt_stats_buf->underrun_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cnt = %u",
-			   htt_stats_buf->flush_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "filt_cnt = %u",
-			   htt_stats_buf->filt_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "null_mpdu_bmap = %u",
-			   htt_stats_buf->null_mpdu_bmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "user_ack_failure = %u",
-			   htt_stats_buf->user_ack_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
-			   htt_stats_buf->ack_tlv_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_id_proc = %u",
-			   htt_stats_buf->sched_id_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "null_mpdu_tx_count = %u",
-			   htt_stats_buf->null_mpdu_tx_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_bmap_not_recvd = %u",
-			   htt_stats_buf->mpdu_bmap_not_recvd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_bar = %u",
-			   htt_stats_buf->num_bar);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts = %u",
-			   htt_stats_buf->rts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cts2self = %u",
-			   htt_stats_buf->cts2self);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_null = %u",
-			   htt_stats_buf->qos_null);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_tried_cnt = %u",
-			   htt_stats_buf->mpdu_tried_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queued_cnt = %u",
-			   htt_stats_buf->mpdu_queued_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_ack_fail_cnt = %u",
-			   htt_stats_buf->mpdu_ack_fail_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_filt_cnt = %u",
-			   htt_stats_buf->mpdu_filt_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "false_mpdu_ack_count = %u",
-			   htt_stats_buf->false_mpdu_ack_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txq_timeout = %u\n",
-			   htt_stats_buf->txq_timeout);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_STATS_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__hwq_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "hwq_id = %u\n",
+			 (htt_stats_buf->mac_id__hwq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "xretry = %u\n",
+			 htt_stats_buf->xretry);
+	len += scnprintf(buf + len, buf_len - len, "underrun_cnt = %u\n",
+			 htt_stats_buf->underrun_cnt);
+	len += scnprintf(buf + len, buf_len - len, "flush_cnt = %u\n",
+			 htt_stats_buf->flush_cnt);
+	len += scnprintf(buf + len, buf_len - len, "filt_cnt = %u\n",
+			 htt_stats_buf->filt_cnt);
+	len += scnprintf(buf + len, buf_len - len, "null_mpdu_bmap = %u\n",
+			 htt_stats_buf->null_mpdu_bmap);
+	len += scnprintf(buf + len, buf_len - len, "user_ack_failure = %u\n",
+			 htt_stats_buf->user_ack_failure);
+	len += scnprintf(buf + len, buf_len - len, "ack_tlv_proc = %u\n",
+			 htt_stats_buf->ack_tlv_proc);
+	len += scnprintf(buf + len, buf_len - len, "sched_id_proc = %u\n",
+			 htt_stats_buf->sched_id_proc);
+	len += scnprintf(buf + len, buf_len - len, "null_mpdu_tx_count = %u\n",
+			 htt_stats_buf->null_mpdu_tx_count);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_bmap_not_recvd = %u\n",
+			 htt_stats_buf->mpdu_bmap_not_recvd);
+	len += scnprintf(buf + len, buf_len - len, "num_bar = %u\n",
+			 htt_stats_buf->num_bar);
+	len += scnprintf(buf + len, buf_len - len, "rts = %u\n",
+			 htt_stats_buf->rts);
+	len += scnprintf(buf + len, buf_len - len, "cts2self = %u\n",
+			 htt_stats_buf->cts2self);
+	len += scnprintf(buf + len, buf_len - len, "qos_null = %u\n",
+			 htt_stats_buf->qos_null);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_tried_cnt = %u\n",
+			 htt_stats_buf->mpdu_tried_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_queued_cnt = %u\n",
+			 htt_stats_buf->mpdu_queued_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_ack_fail_cnt = %u\n",
+			 htt_stats_buf->mpdu_ack_fail_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_filt_cnt = %u\n",
+			 htt_stats_buf->mpdu_filt_cnt);
+	len += scnprintf(buf + len, buf_len - len, "false_mpdu_ack_count = %u\n",
+			 htt_stats_buf->false_mpdu_ack_count);
+	len += scnprintf(buf + len, buf_len - len, "txq_timeout = %u\n\n",
+			 htt_stats_buf->txq_timeout);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1110,15 +1106,15 @@ htt_print_tx_hwq_difs_latency_stats_tlv_v(const void *tag_buf,
 	u16 data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS);
 	char difs_latency_hist[HTT_MAX_STRING_LEN] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_DIFS_LATENCY_STATS_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hist_intvl = %u",
-			htt_stats_buf->hist_intvl);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_DIFS_LATENCY_STATS_TLV_V:\n");
+	len += scnprintf(buf + len, buf_len - len, "hist_intvl = %u\n",
+			 htt_stats_buf->hist_intvl);
 
 	PRINT_ARRAY_TO_BUF(difs_latency_hist, htt_stats_buf->difs_latency_hist,
 			   data_len);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "difs_latency_hist = %s\n",
-			   difs_latency_hist);
+	len += scnprintf(buf + len, buf_len - len, "difs_latency_hist = %s\n\n",
+			 difs_latency_hist);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1142,12 +1138,12 @@ htt_print_tx_hwq_cmd_result_stats_tlv_v(const void *tag_buf,
 
 	data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_RESULT_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_CMD_RESULT_STATS_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_CMD_RESULT_STATS_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(cmd_result, htt_stats_buf->cmd_result, data_len);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_result = %s\n", cmd_result);
+	len += scnprintf(buf + len, buf_len - len, "cmd_result = %s\n\n", cmd_result);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1171,11 +1167,11 @@ htt_print_tx_hwq_cmd_stall_stats_tlv_v(const void *tag_buf,
 
 	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_STALL_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_HWQ_CMD_STALL_STATS_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_CMD_STALL_STATS_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(cmd_stall_status, htt_stats_buf->cmd_stall_status, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmd_stall_status = %s\n",
-			   cmd_stall_status);
+	len += scnprintf(buf + len, buf_len - len, "cmd_stall_status = %s\n\n",
+			 cmd_stall_status);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1199,11 +1195,11 @@ htt_print_tx_hwq_fes_result_stats_tlv_v(const void *tag_buf,
 
 	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_FES_RESULT_STATS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_FES_RESULT_STATS_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_FES_RESULT_STATS_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(fes_result, htt_stats_buf->fes_result, num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fes_result = %s\n", fes_result);
+	len += scnprintf(buf + len, buf_len - len, "fes_result = %s\n\n", fes_result);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1227,21 +1223,21 @@ htt_print_tx_hwq_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
 			    sizeof(htt_stats_buf->hist_bin_size)) >> 2);
 	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_TRIED_MPDU_CNT_HIST_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u",
-			   htt_stats_buf->hist_bin_size);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_TRIED_MPDU_CNT_HIST_TLV_V:\n");
+	len += scnprintf(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u\n",
+			 htt_stats_buf->hist_bin_size);
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
 		PRINT_ARRAY_TO_BUF(tried_mpdu_cnt_hist,
 				   htt_stats_buf->tried_mpdu_cnt_hist,
 				   num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "tried_mpdu_cnt_hist = %s\n",
-				   tried_mpdu_cnt_hist);
+		len += scnprintf(buf + len, buf_len - len,
+				 "tried_mpdu_cnt_hist = %s\n\n",
+				 tried_mpdu_cnt_hist);
 	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER ");
+		len += scnprintf(buf + len, buf_len - len,
+				 "INSUFFICIENT PRINT BUFFER\n");
 	}
 
 	if (len >= buf_len)
@@ -1265,18 +1261,18 @@ htt_print_tx_hwq_txop_used_cnt_hist_tlv_v(const void *tag_buf,
 	u32 num_elements = tag_len >> 2;
 	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_HWQ_TXOP_USED_CNT_HIST_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_HWQ_TXOP_USED_CNT_HIST_TLV_V:\n");
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
 		PRINT_ARRAY_TO_BUF(txop_used_cnt_hist,
 				   htt_stats_buf->txop_used_cnt_hist,
 				   num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "txop_used_cnt_hist = %s\n",
-				   txop_used_cnt_hist);
+		len += scnprintf(buf + len, buf_len - len, "txop_used_cnt_hist = %s\n\n",
+				 txop_used_cnt_hist);
 	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER ");
+		len += scnprintf(buf + len, buf_len - len,
+				 "INSUFFICIENT PRINT BUFFER\n");
 	}
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1300,86 +1296,86 @@ static inline void htt_print_tx_sounding_stats_tlv(const void *tag_buf,
 	const u32 *cbf_160 = htt_stats_buf->cbf_160;
 
 	if (htt_stats_buf->tx_sounding_mode == HTT_TX_AC_SOUNDING_MODE) {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "\nHTT_TX_AC_SOUNDING_STATS_TLV:\n");
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u ",
-				   cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nHTT_TX_AC_SOUNDING_STATS_TLV:\n\n");
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
 
 		for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS; i++) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u ",
-					   i,
-					   htt_stats_buf->sounding[0],
-					   htt_stats_buf->sounding[1],
-					   htt_stats_buf->sounding[2],
-					   htt_stats_buf->sounding[3]);
+			len += scnprintf(buf + len, buf_len - len,
+					 "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u\n",
+					 i,
+					 htt_stats_buf->sounding[0],
+					 htt_stats_buf->sounding[1],
+					 htt_stats_buf->sounding[2],
+					 htt_stats_buf->sounding[3]);
 		}
 	} else if (htt_stats_buf->tx_sounding_mode == HTT_TX_AX_SOUNDING_MODE) {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "\nHTT_TX_AX_SOUNDING_STATS_TLV:\n");
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u ",
-				   cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u",
-				   cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
-				   cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nHTT_TX_AX_SOUNDING_STATS_TLV:\n");
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_20 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_20[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_20[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_40 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_40[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_40[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_80 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_80[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_80[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_cbf_160 = IBF : %u, SU_SIFS : %u, SU_RBO : %u, MU_SIFS : %u, MU_RBO : %u\n",
+				 cbf_160[HTT_IMPLICIT_TXBF_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_SU_SIFS_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_SU_RBO_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_MU_SIFS_STEER_STATS],
+				 cbf_160[HTT_EXPLICIT_TXBF_MU_RBO_STEER_STATS]);
 
 		for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS; i++) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u ",
-					   i,
-					   htt_stats_buf->sounding[0],
-					   htt_stats_buf->sounding[1],
-					   htt_stats_buf->sounding[2],
-					   htt_stats_buf->sounding[3]);
+			len += scnprintf(buf + len, buf_len - len,
+					 "Sounding User %u = 20MHz: %u, 40MHz : %u, 80MHz: %u, 160MHz: %u\n",
+					 i,
+					 htt_stats_buf->sounding[0],
+					 htt_stats_buf->sounding[1],
+					 htt_stats_buf->sounding[2],
+					 htt_stats_buf->sounding[3]);
 		}
 	}
 
@@ -1400,31 +1396,31 @@ htt_print_tx_selfgen_cmn_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "su_bar = %u",
-			   htt_stats_buf->su_bar);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts = %u",
-			   htt_stats_buf->rts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cts2self = %u",
-			   htt_stats_buf->cts2self);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_null = %u",
-			   htt_stats_buf->qos_null);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_1 = %u",
-			   htt_stats_buf->delayed_bar_1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_2 = %u",
-			   htt_stats_buf->delayed_bar_2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_3 = %u",
-			   htt_stats_buf->delayed_bar_3);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_4 = %u",
-			   htt_stats_buf->delayed_bar_4);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_5 = %u",
-			   htt_stats_buf->delayed_bar_5);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_6 = %u",
-			   htt_stats_buf->delayed_bar_6);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "delayed_bar_7 = %u\n",
-			   htt_stats_buf->delayed_bar_7);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_CMN_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "su_bar = %u\n",
+			 htt_stats_buf->su_bar);
+	len += scnprintf(buf + len, buf_len - len, "rts = %u\n",
+			 htt_stats_buf->rts);
+	len += scnprintf(buf + len, buf_len - len, "cts2self = %u\n",
+			 htt_stats_buf->cts2self);
+	len += scnprintf(buf + len, buf_len - len, "qos_null = %u\n",
+			 htt_stats_buf->qos_null);
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_1 = %u\n",
+			 htt_stats_buf->delayed_bar_1);
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_2 = %u\n",
+			 htt_stats_buf->delayed_bar_2);
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_3 = %u\n",
+			 htt_stats_buf->delayed_bar_3);
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_4 = %u\n",
+			 htt_stats_buf->delayed_bar_4);
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_5 = %u\n",
+			 htt_stats_buf->delayed_bar_5);
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_6 = %u\n",
+			 htt_stats_buf->delayed_bar_6);
+	len += scnprintf(buf + len, buf_len - len, "delayed_bar_7 = %u\n\n",
+			 htt_stats_buf->delayed_bar_7);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1443,21 +1439,21 @@ htt_print_tx_selfgen_ac_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndpa = %u",
-			   htt_stats_buf->ac_su_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndp = %u",
-			   htt_stats_buf->ac_su_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndpa = %u",
-			   htt_stats_buf->ac_mu_mimo_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndp = %u",
-			   htt_stats_buf->ac_mu_mimo_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_1 = %u",
-			   htt_stats_buf->ac_mu_mimo_brpoll_1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_2 = %u",
-			   htt_stats_buf->ac_mu_mimo_brpoll_2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brpoll_3 = %u\n",
-			   htt_stats_buf->ac_mu_mimo_brpoll_3);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndpa = %u\n",
+			 htt_stats_buf->ac_su_ndpa);
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndp = %u\n",
+			 htt_stats_buf->ac_su_ndp);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndpa = %u\n",
+			 htt_stats_buf->ac_mu_mimo_ndpa);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndp = %u\n",
+			 htt_stats_buf->ac_mu_mimo_ndp);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brpoll_1 = %u\n",
+			 htt_stats_buf->ac_mu_mimo_brpoll_1);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brpoll_2 = %u\n",
+			 htt_stats_buf->ac_mu_mimo_brpoll_2);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brpoll_3 = %u\n\n",
+			 htt_stats_buf->ac_mu_mimo_brpoll_3);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1476,37 +1472,37 @@ htt_print_tx_selfgen_ax_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndpa = %u",
-			   htt_stats_buf->ax_su_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndp = %u",
-			   htt_stats_buf->ax_su_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndpa = %u",
-			   htt_stats_buf->ax_mu_mimo_ndpa);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndp = %u",
-			   htt_stats_buf->ax_mu_mimo_ndp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_1 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_2 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_3 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_3);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_4 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_4);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_5 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_5);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_6 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_6);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brpoll_7 = %u",
-			   htt_stats_buf->ax_mu_mimo_brpoll_7);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_basic_trigger = %u",
-			   htt_stats_buf->ax_basic_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_bsr_trigger = %u",
-			   htt_stats_buf->ax_bsr_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_bar_trigger = %u",
-			   htt_stats_buf->ax_mu_bar_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_rts_trigger = %u\n",
-			   htt_stats_buf->ax_mu_rts_trigger);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndpa = %u\n",
+			 htt_stats_buf->ax_su_ndpa);
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndp = %u\n",
+			 htt_stats_buf->ax_su_ndp);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndpa = %u\n",
+			 htt_stats_buf->ax_mu_mimo_ndpa);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndp = %u\n",
+			 htt_stats_buf->ax_mu_mimo_ndp);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brpoll_1 = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brpoll_1);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brpoll_2 = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brpoll_2);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brpoll_3 = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brpoll_3);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brpoll_4 = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brpoll_4);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brpoll_5 = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brpoll_5);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brpoll_6 = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brpoll_6);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brpoll_7 = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brpoll_7);
+	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger = %u\n",
+			 htt_stats_buf->ax_basic_trigger);
+	len += scnprintf(buf + len, buf_len - len, "ax_bsr_trigger = %u\n",
+			 htt_stats_buf->ax_bsr_trigger);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_bar_trigger = %u\n",
+			 htt_stats_buf->ax_mu_bar_trigger);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_rts_trigger = %u\n\n",
+			 htt_stats_buf->ax_mu_rts_trigger);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1525,21 +1521,21 @@ htt_print_tx_selfgen_ac_err_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_ERR_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndp_err = %u",
-			   htt_stats_buf->ac_su_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_su_ndpa_err = %u",
-			   htt_stats_buf->ac_su_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndpa_err = %u",
-			   htt_stats_buf->ac_mu_mimo_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_ndp_err = %u",
-			   htt_stats_buf->ac_mu_mimo_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp1_err = %u",
-			   htt_stats_buf->ac_mu_mimo_brp1_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp2_err = %u",
-			   htt_stats_buf->ac_mu_mimo_brp2_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_brp3_err = %u\n",
-			   htt_stats_buf->ac_mu_mimo_brp3_err);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AC_ERR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndp_err = %u\n",
+			 htt_stats_buf->ac_su_ndp_err);
+	len += scnprintf(buf + len, buf_len - len, "ac_su_ndpa_err = %u\n",
+			 htt_stats_buf->ac_su_ndpa_err);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndpa_err = %u\n",
+			 htt_stats_buf->ac_mu_mimo_ndpa_err);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_ndp_err = %u\n",
+			 htt_stats_buf->ac_mu_mimo_ndp_err);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brp1_err = %u\n",
+			 htt_stats_buf->ac_mu_mimo_brp1_err);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brp2_err = %u\n",
+			 htt_stats_buf->ac_mu_mimo_brp2_err);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_brp3_err = %u\n\n",
+			 htt_stats_buf->ac_mu_mimo_brp3_err);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1558,37 +1554,37 @@ htt_print_tx_selfgen_ax_err_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_ERR_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndp_err = %u",
-			   htt_stats_buf->ax_su_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_su_ndpa_err = %u",
-			   htt_stats_buf->ax_su_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndpa_err = %u",
-			   htt_stats_buf->ax_mu_mimo_ndpa_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_ndp_err = %u",
-			   htt_stats_buf->ax_mu_mimo_ndp_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp1_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp1_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp2_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp2_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp3_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp3_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp4_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp4_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp5_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp5_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp6_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp6_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_brp7_err = %u",
-			   htt_stats_buf->ax_mu_mimo_brp7_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_basic_trigger_err = %u",
-			   htt_stats_buf->ax_basic_trigger_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_bsr_trigger_err = %u",
-			   htt_stats_buf->ax_bsr_trigger_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_bar_trigger_err = %u",
-			   htt_stats_buf->ax_mu_bar_trigger_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_rts_trigger_err = %u\n",
-			   htt_stats_buf->ax_mu_rts_trigger_err);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_SELFGEN_AX_ERR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndp_err = %u\n",
+			 htt_stats_buf->ax_su_ndp_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_su_ndpa_err = %u\n",
+			 htt_stats_buf->ax_su_ndpa_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndpa_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_ndpa_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_ndp_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_ndp_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brp1_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brp1_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brp2_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brp2_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brp3_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brp3_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brp4_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brp4_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brp5_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brp5_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brp6_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brp6_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_brp7_err = %u\n",
+			 htt_stats_buf->ax_mu_mimo_brp7_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_basic_trigger_err = %u\n",
+			 htt_stats_buf->ax_basic_trigger_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_bsr_trigger_err = %u\n",
+			 htt_stats_buf->ax_bsr_trigger_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_bar_trigger_err = %u\n",
+			 htt_stats_buf->ax_mu_bar_trigger_err);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_rts_trigger_err = %u\n\n",
+			 htt_stats_buf->ax_mu_rts_trigger_err);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1608,35 +1604,35 @@ htt_print_tx_pdev_mu_mimo_sch_stats_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u8 i;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_MU_MIMO_SCH_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_posted = %u",
-			   htt_stats_buf->mu_mimo_sch_posted);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_sch_failed = %u",
-			   htt_stats_buf->mu_mimo_sch_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n",
-			   htt_stats_buf->mu_mimo_ppdu_posted);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_MU_MIMO_SCH_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_sch_posted = %u\n",
+			 htt_stats_buf->mu_mimo_sch_posted);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_sch_failed = %u\n",
+			 htt_stats_buf->mu_mimo_sch_failed);
+	len += scnprintf(buf + len, buf_len - len, "mu_mimo_ppdu_posted = %u\n\n",
+			 htt_stats_buf->mu_mimo_ppdu_posted);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "11ac MU_MIMO SCH STATS:");
+	len += scnprintf(buf + len, buf_len - len, "11ac MU_MIMO SCH STATS:\n");
 
 	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_mu_mimo_sch_nusers_%u = %u",
-				   i, htt_stats_buf->ac_mu_mimo_sch_nusers[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_mu_mimo_sch_nusers_%u = %u\n",
+				 i, htt_stats_buf->ac_mu_mimo_sch_nusers[i]);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n11ax MU_MIMO SCH STATS:");
+	len += scnprintf(buf + len, buf_len - len, "\n11ax MU_MIMO SCH STATS:\n");
 
 	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_mu_mimo_sch_nusers_%u = %u",
-				   i, htt_stats_buf->ax_mu_mimo_sch_nusers[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_mu_mimo_sch_nusers_%u = %u\n",
+				 i, htt_stats_buf->ax_mu_mimo_sch_nusers[i]);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n11ax OFDMA SCH STATS:");
+	len += scnprintf(buf + len, buf_len - len, "\n11ax OFDMA SCH STATS:\n");
 
 	for (i = 0; i < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_ofdma_sch_nusers_%u = %u",
-				   i, htt_stats_buf->ax_ofdma_sch_nusers[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_ofdma_sch_nusers_%u = %u\n",
+				 i, htt_stats_buf->ax_ofdma_sch_nusers[i]);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1657,114 +1653,114 @@ htt_print_tx_pdev_mu_mimo_mpdu_stats_tlv(const void *tag_buf,
 
 	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_MIMO_AC) {
 		if (!htt_stats_buf->user_index)
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "HTT_TX_PDEV_MU_MIMO_AC_MPDU_STATS:\n");
+			len += scnprintf(buf + len, buf_len - len,
+					 "HTT_TX_PDEV_MU_MIMO_AC_MPDU_STATS:\n");
 
 		if (htt_stats_buf->user_index <
 		    HTT_TX_PDEV_STATS_NUM_AC_MUMIMO_USER_STATS) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_queued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_queued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_tried_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_tried_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_failed_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_failed_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdus_requeued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_requeued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_err_no_ba_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->err_no_ba_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_mpdu_underrun_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdu_underrun_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ac_mu_mimo_ampdu_underrun_usr_%u = %u\n",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->ampdu_underrun_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ac_mu_mimo_mpdus_queued_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_queued_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ac_mu_mimo_mpdus_tried_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_tried_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ac_mu_mimo_mpdus_failed_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_failed_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ac_mu_mimo_mpdus_requeued_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_requeued_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ac_mu_mimo_err_no_ba_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->err_no_ba_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ac_mu_mimo_mpdu_underrun_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdu_underrun_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ac_mu_mimo_ampdu_underrun_usr_%u = %u\n\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->ampdu_underrun_usr);
 		}
 	}
 
 	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_MIMO_AX) {
 		if (!htt_stats_buf->user_index)
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "HTT_TX_PDEV_MU_MIMO_AX_MPDU_STATS:\n");
+			len += scnprintf(buf + len, buf_len - len,
+					 "HTT_TX_PDEV_MU_MIMO_AX_MPDU_STATS:\n");
 
 		if (htt_stats_buf->user_index <
 		    HTT_TX_PDEV_STATS_NUM_AX_MUMIMO_USER_STATS) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_queued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_queued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_tried_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_tried_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_failed_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_failed_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdus_requeued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_requeued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_err_no_ba_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->err_no_ba_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_mpdu_underrun_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdu_underrun_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_mimo_ampdu_underrun_usr_%u = %u\n",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->ampdu_underrun_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_mimo_mpdus_queued_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_queued_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_mimo_mpdus_tried_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_tried_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_mimo_mpdus_failed_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_failed_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_mimo_mpdus_requeued_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_requeued_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_mimo_err_no_ba_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->err_no_ba_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_mimo_mpdu_underrun_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdu_underrun_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_mimo_ampdu_underrun_usr_%u = %u\n\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->ampdu_underrun_usr);
 		}
 	}
 
 	if (htt_stats_buf->tx_sched_mode == HTT_STATS_TX_SCHED_MODE_MU_OFDMA_AX) {
 		if (!htt_stats_buf->user_index)
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "HTT_TX_PDEV_AX_MU_OFDMA_MPDU_STATS:\n");
+			len += scnprintf(buf + len, buf_len - len,
+					 "HTT_TX_PDEV_AX_MU_OFDMA_MPDU_STATS:\n");
 
 		if (htt_stats_buf->user_index < HTT_TX_PDEV_STATS_NUM_OFDMA_USER_STATS) {
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_queued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_queued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_tried_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_tried_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_failed_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_failed_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdus_requeued_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdus_requeued_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_err_no_ba_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->err_no_ba_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_mpdu_underrun_usr_%u = %u",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->mpdu_underrun_usr);
-			len += HTT_DBG_OUT(buf + len, buf_len - len,
-					   "ax_mu_ofdma_ampdu_underrun_usr_%u = %u\n",
-					   htt_stats_buf->user_index,
-					   htt_stats_buf->ampdu_underrun_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_ofdma_mpdus_queued_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_queued_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_ofdma_mpdus_tried_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_tried_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_ofdma_mpdus_failed_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_failed_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_ofdma_mpdus_requeued_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdus_requeued_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_ofdma_err_no_ba_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->err_no_ba_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_ofdma_mpdu_underrun_usr_%u = %u\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->mpdu_underrun_usr);
+			len += scnprintf(buf + len, buf_len - len,
+					 "ax_mu_ofdma_ampdu_underrun_usr_%u = %u\n\n",
+					 htt_stats_buf->user_index,
+					 htt_stats_buf->ampdu_underrun_usr);
 		}
 	}
 
@@ -1788,12 +1784,12 @@ htt_print_sched_txq_cmd_posted_tlv_v(const void *tag_buf,
 	char sched_cmd_posted[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_POSTED_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_POSTED_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(sched_cmd_posted, htt_stats_buf->sched_cmd_posted,
 			   num_elements);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_posted = %s\n",
-			   sched_cmd_posted);
+	len += scnprintf(buf + len, buf_len - len, "sched_cmd_posted = %s\n\n",
+			 sched_cmd_posted);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1815,12 +1811,12 @@ htt_print_sched_txq_cmd_reaped_tlv_v(const void *tag_buf,
 	char sched_cmd_reaped[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_REAPED_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_REAPED_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(sched_cmd_reaped, htt_stats_buf->sched_cmd_reaped,
 			   num_elements);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_reaped = %s\n",
-			   sched_cmd_reaped);
+	len += scnprintf(buf + len, buf_len - len, "sched_cmd_reaped = %s\n\n",
+			 sched_cmd_reaped);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1844,13 +1840,13 @@ htt_print_sched_txq_sched_order_su_tlv_v(const void *tag_buf,
 	u32 sched_order_su_num_entries =
 		min_t(u32, (tag_len >> 2), HTT_TX_PDEV_NUM_SCHED_ORDER_LOG);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(sched_order_su, htt_stats_buf->sched_order_su,
 			   sched_order_su_num_entries);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_order_su = %s\n",
-			   sched_order_su);
+	len += scnprintf(buf + len, buf_len - len, "sched_order_su = %s\n\n",
+			 sched_order_su);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1873,13 +1869,13 @@ htt_print_sched_txq_sched_ineligibility_tlv_v(const void *tag_buf,
 	/* each entry is u32, i.e. 4 bytes */
 	u32 sched_ineligibility_num_entries = tag_len >> 2;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_SCHED_TXQ_SCHED_INELIGIBILITY_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_SCHED_TXQ_SCHED_INELIGIBILITY_V:\n");
 
 	PRINT_ARRAY_TO_BUF(sched_ineligibility, htt_stats_buf->sched_ineligibility,
 			   sched_ineligibility_num_entries);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_ineligibility = %s\n",
-			   sched_ineligibility);
+	len += scnprintf(buf + len, buf_len - len, "sched_ineligibility = %s\n\n",
+			 sched_ineligibility);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1898,54 +1894,54 @@ htt_print_tx_pdev_stats_sched_per_txq_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__txq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txq_id = %u",
-			   (htt_stats_buf->mac_id__txq_id__word & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_policy = %u",
-			   htt_stats_buf->sched_policy);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "last_sched_cmd_posted_timestamp = %u",
-			   htt_stats_buf->last_sched_cmd_posted_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "last_sched_cmd_compl_timestamp = %u",
-			   htt_stats_buf->last_sched_cmd_compl_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_2_tac_lwm_count = %u",
-			   htt_stats_buf->sched_2_tac_lwm_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_2_tac_ring_full = %u",
-			   htt_stats_buf->sched_2_tac_ring_full);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmd_post_failure = %u",
-			   htt_stats_buf->sched_cmd_post_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_active_tids = %u",
-			   htt_stats_buf->num_active_tids);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_ps_schedules = %u",
-			   htt_stats_buf->num_ps_schedules);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_cmds_pending = %u",
-			   htt_stats_buf->sched_cmds_pending);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tid_register = %u",
-			   htt_stats_buf->num_tid_register);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tid_unregister = %u",
-			   htt_stats_buf->num_tid_unregister);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_qstats_queried = %u",
-			   htt_stats_buf->num_qstats_queried);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qstats_update_pending = %u",
-			   htt_stats_buf->qstats_update_pending);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_qstats_query_timestamp = %u",
-			   htt_stats_buf->last_qstats_query_timestamp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tqm_cmdq_full = %u",
-			   htt_stats_buf->num_tqm_cmdq_full);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_de_sched_algo_trigger = %u",
-			   htt_stats_buf->num_de_sched_algo_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_rt_sched_algo_trigger = %u",
-			   htt_stats_buf->num_rt_sched_algo_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tqm_sched_algo_trigger = %u",
-			   htt_stats_buf->num_tqm_sched_algo_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_sched = %u\n",
-			   htt_stats_buf->notify_sched);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dur_based_sendn_term = %u\n",
-			   htt_stats_buf->dur_based_sendn_term);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_PDEV_STATS_SCHED_PER_TXQ_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__txq_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "txq_id = %u\n",
+			 (htt_stats_buf->mac_id__txq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "sched_policy = %u\n",
+			 htt_stats_buf->sched_policy);
+	len += scnprintf(buf + len, buf_len - len,
+			 "last_sched_cmd_posted_timestamp = %u\n",
+			 htt_stats_buf->last_sched_cmd_posted_timestamp);
+	len += scnprintf(buf + len, buf_len - len,
+			 "last_sched_cmd_compl_timestamp = %u\n",
+			 htt_stats_buf->last_sched_cmd_compl_timestamp);
+	len += scnprintf(buf + len, buf_len - len, "sched_2_tac_lwm_count = %u\n",
+			 htt_stats_buf->sched_2_tac_lwm_count);
+	len += scnprintf(buf + len, buf_len - len, "sched_2_tac_ring_full = %u\n",
+			 htt_stats_buf->sched_2_tac_ring_full);
+	len += scnprintf(buf + len, buf_len - len, "sched_cmd_post_failure = %u\n",
+			 htt_stats_buf->sched_cmd_post_failure);
+	len += scnprintf(buf + len, buf_len - len, "num_active_tids = %u\n",
+			 htt_stats_buf->num_active_tids);
+	len += scnprintf(buf + len, buf_len - len, "num_ps_schedules = %u\n",
+			 htt_stats_buf->num_ps_schedules);
+	len += scnprintf(buf + len, buf_len - len, "sched_cmds_pending = %u\n",
+			 htt_stats_buf->sched_cmds_pending);
+	len += scnprintf(buf + len, buf_len - len, "num_tid_register = %u\n",
+			 htt_stats_buf->num_tid_register);
+	len += scnprintf(buf + len, buf_len - len, "num_tid_unregister = %u\n",
+			 htt_stats_buf->num_tid_unregister);
+	len += scnprintf(buf + len, buf_len - len, "num_qstats_queried = %u\n",
+			 htt_stats_buf->num_qstats_queried);
+	len += scnprintf(buf + len, buf_len - len, "qstats_update_pending = %u\n",
+			 htt_stats_buf->qstats_update_pending);
+	len += scnprintf(buf + len, buf_len - len, "last_qstats_query_timestamp = %u\n",
+			 htt_stats_buf->last_qstats_query_timestamp);
+	len += scnprintf(buf + len, buf_len - len, "num_tqm_cmdq_full = %u\n",
+			 htt_stats_buf->num_tqm_cmdq_full);
+	len += scnprintf(buf + len, buf_len - len, "num_de_sched_algo_trigger = %u\n",
+			 htt_stats_buf->num_de_sched_algo_trigger);
+	len += scnprintf(buf + len, buf_len - len, "num_rt_sched_algo_trigger = %u\n",
+			 htt_stats_buf->num_rt_sched_algo_trigger);
+	len += scnprintf(buf + len, buf_len - len, "num_tqm_sched_algo_trigger = %u\n",
+			 htt_stats_buf->num_tqm_sched_algo_trigger);
+	len += scnprintf(buf + len, buf_len - len, "notify_sched = %u\n\n",
+			 htt_stats_buf->notify_sched);
+	len += scnprintf(buf + len, buf_len - len, "dur_based_sendn_term = %u\n\n",
+			 htt_stats_buf->dur_based_sendn_term);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1963,11 +1959,11 @@ static inline void htt_print_stats_tx_sched_cmn_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_STATS_TX_SCHED_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_timestamp = %u\n",
-			   htt_stats_buf->current_timestamp);
+	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_TX_SCHED_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "current_timestamp = %u\n\n",
+			 htt_stats_buf->current_timestamp);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1990,12 +1986,12 @@ htt_print_tx_tqm_gen_mpdu_stats_tlv_v(const void *tag_buf,
 	u16 num_elements = min_t(u16, (tag_len >> 2),
 				 HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_GEN_MPDU_STATS_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_GEN_MPDU_STATS_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(gen_mpdu_end_reason, htt_stats_buf->gen_mpdu_end_reason,
 			   num_elements);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_end_reason = %s\n",
-			   gen_mpdu_end_reason);
+	len += scnprintf(buf + len, buf_len - len, "gen_mpdu_end_reason = %s\n\n",
+			 gen_mpdu_end_reason);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2017,13 +2013,13 @@ htt_print_tx_tqm_list_mpdu_stats_tlv_v(const void *tag_buf,
 	char list_mpdu_end_reason[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_TQM_LIST_MPDU_STATS_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_TQM_LIST_MPDU_STATS_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(list_mpdu_end_reason, htt_stats_buf->list_mpdu_end_reason,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_end_reason = %s\n",
-			   list_mpdu_end_reason);
+	len += scnprintf(buf + len, buf_len - len, "list_mpdu_end_reason = %s\n\n",
+			 list_mpdu_end_reason);
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
 	else
@@ -2045,12 +2041,12 @@ htt_print_tx_tqm_list_mpdu_cnt_tlv_v(const void *tag_buf,
 	u16 num_elems = min_t(u16, (tag_len >> 2),
 			      HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(list_mpdu_cnt_hist, htt_stats_buf->list_mpdu_cnt_hist,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_cnt_hist = %s\n",
-			   list_mpdu_cnt_hist);
+	len += scnprintf(buf + len, buf_len - len, "list_mpdu_cnt_hist = %s\n\n",
+			 list_mpdu_cnt_hist);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2069,69 +2065,69 @@ htt_print_tx_tqm_pdev_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_PDEV_STATS_TLV_V:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_count = %u",
-			   htt_stats_buf->msdu_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_count = %u",
-			   htt_stats_buf->mpdu_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu = %u",
-			   htt_stats_buf->remove_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu = %u",
-			   htt_stats_buf->remove_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_ttl = %u",
-			   htt_stats_buf->remove_msdu_ttl);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_bar = %u",
-			   htt_stats_buf->send_bar);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "bar_sync = %u",
-			   htt_stats_buf->bar_sync);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu = %u",
-			   htt_stats_buf->notify_mpdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sync_cmd = %u",
-			   htt_stats_buf->sync_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "write_cmd = %u",
-			   htt_stats_buf->write_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_trigger = %u",
-			   htt_stats_buf->hwsch_trigger);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_tlv_proc = %u",
-			   htt_stats_buf->ack_tlv_proc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_cmd = %u",
-			   htt_stats_buf->gen_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_list_cmd = %u",
-			   htt_stats_buf->gen_list_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_cmd = %u",
-			   htt_stats_buf->remove_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_tried_cmd = %u",
-			   htt_stats_buf->remove_mpdu_tried_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u",
-			   htt_stats_buf->mpdu_queue_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_head_info_cmd = %u",
-			   htt_stats_buf->mpdu_head_info_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u",
-			   htt_stats_buf->msdu_flow_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_cmd = %u",
-			   htt_stats_buf->remove_msdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_ttl_cmd = %u",
-			   htt_stats_buf->remove_msdu_ttl_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cache_cmd = %u",
-			   htt_stats_buf->flush_cache_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_mpduq_cmd = %u",
-			   htt_stats_buf->update_mpduq_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueue = %u",
-			   htt_stats_buf->enqueue);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueue_notify = %u",
-			   htt_stats_buf->enqueue_notify);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu_at_head = %u",
-			   htt_stats_buf->notify_mpdu_at_head);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "notify_mpdu_state_valid = %u",
-			   htt_stats_buf->notify_mpdu_state_valid);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_udp_notify1 = %u",
-			   htt_stats_buf->sched_udp_notify1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_udp_notify2 = %u",
-			   htt_stats_buf->sched_udp_notify2);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_nonudp_notify1 = %u",
-			   htt_stats_buf->sched_nonudp_notify1);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sched_nonudp_notify2 = %u\n",
-			   htt_stats_buf->sched_nonudp_notify2);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_PDEV_STATS_TLV_V:\n");
+	len += scnprintf(buf + len, buf_len - len, "msdu_count = %u\n",
+			 htt_stats_buf->msdu_count);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_count = %u\n",
+			 htt_stats_buf->mpdu_count);
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu = %u\n",
+			 htt_stats_buf->remove_msdu);
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdu = %u\n",
+			 htt_stats_buf->remove_mpdu);
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu_ttl = %u\n",
+			 htt_stats_buf->remove_msdu_ttl);
+	len += scnprintf(buf + len, buf_len - len, "send_bar = %u\n",
+			 htt_stats_buf->send_bar);
+	len += scnprintf(buf + len, buf_len - len, "bar_sync = %u\n",
+			 htt_stats_buf->bar_sync);
+	len += scnprintf(buf + len, buf_len - len, "notify_mpdu = %u\n",
+			 htt_stats_buf->notify_mpdu);
+	len += scnprintf(buf + len, buf_len - len, "sync_cmd = %u\n",
+			 htt_stats_buf->sync_cmd);
+	len += scnprintf(buf + len, buf_len - len, "write_cmd = %u\n",
+			 htt_stats_buf->write_cmd);
+	len += scnprintf(buf + len, buf_len - len, "hwsch_trigger = %u\n",
+			 htt_stats_buf->hwsch_trigger);
+	len += scnprintf(buf + len, buf_len - len, "ack_tlv_proc = %u\n",
+			 htt_stats_buf->ack_tlv_proc);
+	len += scnprintf(buf + len, buf_len - len, "gen_mpdu_cmd = %u\n",
+			 htt_stats_buf->gen_mpdu_cmd);
+	len += scnprintf(buf + len, buf_len - len, "gen_list_cmd = %u\n",
+			 htt_stats_buf->gen_list_cmd);
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdu_cmd = %u\n",
+			 htt_stats_buf->remove_mpdu_cmd);
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdu_tried_cmd = %u\n",
+			 htt_stats_buf->remove_mpdu_tried_cmd);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u\n",
+			 htt_stats_buf->mpdu_queue_stats_cmd);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_head_info_cmd = %u\n",
+			 htt_stats_buf->mpdu_head_info_cmd);
+	len += scnprintf(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u\n",
+			 htt_stats_buf->msdu_flow_stats_cmd);
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu_cmd = %u\n",
+			 htt_stats_buf->remove_msdu_cmd);
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu_ttl_cmd = %u\n",
+			 htt_stats_buf->remove_msdu_ttl_cmd);
+	len += scnprintf(buf + len, buf_len - len, "flush_cache_cmd = %u\n",
+			 htt_stats_buf->flush_cache_cmd);
+	len += scnprintf(buf + len, buf_len - len, "update_mpduq_cmd = %u\n",
+			 htt_stats_buf->update_mpduq_cmd);
+	len += scnprintf(buf + len, buf_len - len, "enqueue = %u\n",
+			 htt_stats_buf->enqueue);
+	len += scnprintf(buf + len, buf_len - len, "enqueue_notify = %u\n",
+			 htt_stats_buf->enqueue_notify);
+	len += scnprintf(buf + len, buf_len - len, "notify_mpdu_at_head = %u\n",
+			 htt_stats_buf->notify_mpdu_at_head);
+	len += scnprintf(buf + len, buf_len - len, "notify_mpdu_state_valid = %u\n",
+			 htt_stats_buf->notify_mpdu_state_valid);
+	len += scnprintf(buf + len, buf_len - len, "sched_udp_notify1 = %u\n",
+			 htt_stats_buf->sched_udp_notify1);
+	len += scnprintf(buf + len, buf_len - len, "sched_udp_notify2 = %u\n",
+			 htt_stats_buf->sched_udp_notify2);
+	len += scnprintf(buf + len, buf_len - len, "sched_nonudp_notify1 = %u\n",
+			 htt_stats_buf->sched_nonudp_notify1);
+	len += scnprintf(buf + len, buf_len - len, "sched_nonudp_notify2 = %u\n\n",
+			 htt_stats_buf->sched_nonudp_notify2);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2149,23 +2145,23 @@ static inline void htt_print_tx_tqm_cmn_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "max_cmdq_id = %u",
-			   htt_stats_buf->max_cmdq_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "list_mpdu_cnt_hist_intvl = %u",
-			   htt_stats_buf->list_mpdu_cnt_hist_intvl);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "add_msdu = %u",
-			   htt_stats_buf->add_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_empty = %u",
-			   htt_stats_buf->q_empty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_not_empty = %u",
-			   htt_stats_buf->q_not_empty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "drop_notification = %u",
-			   htt_stats_buf->drop_notification);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "desc_threshold = %u\n",
-			   htt_stats_buf->desc_threshold);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_CMN_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "max_cmdq_id = %u\n",
+			 htt_stats_buf->max_cmdq_id);
+	len += scnprintf(buf + len, buf_len - len, "list_mpdu_cnt_hist_intvl = %u\n",
+			 htt_stats_buf->list_mpdu_cnt_hist_intvl);
+	len += scnprintf(buf + len, buf_len - len, "add_msdu = %u\n",
+			 htt_stats_buf->add_msdu);
+	len += scnprintf(buf + len, buf_len - len, "q_empty = %u\n",
+			 htt_stats_buf->q_empty);
+	len += scnprintf(buf + len, buf_len - len, "q_not_empty = %u\n",
+			 htt_stats_buf->q_not_empty);
+	len += scnprintf(buf + len, buf_len - len, "drop_notification = %u\n",
+			 htt_stats_buf->drop_notification);
+	len += scnprintf(buf + len, buf_len - len, "desc_threshold = %u\n\n",
+			 htt_stats_buf->desc_threshold);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2183,13 +2179,13 @@ static inline void htt_print_tx_tqm_error_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_ERROR_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_empty_failure = %u",
-			   htt_stats_buf->q_empty_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "q_not_empty_failure = %u",
-			   htt_stats_buf->q_not_empty_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "add_msdu_failure = %u\n",
-			   htt_stats_buf->add_msdu_failure);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_ERROR_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "q_empty_failure = %u\n",
+			 htt_stats_buf->q_empty_failure);
+	len += scnprintf(buf + len, buf_len - len, "q_not_empty_failure = %u\n",
+			 htt_stats_buf->q_not_empty_failure);
+	len += scnprintf(buf + len, buf_len - len, "add_msdu_failure = %u\n\n",
+			 htt_stats_buf->add_msdu_failure);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2207,33 +2203,33 @@ static inline void htt_print_tx_tqm_cmdq_status_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_TQM_CMDQ_STATUS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__cmdq_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cmdq_id = %u\n",
-			   (htt_stats_buf->mac_id__cmdq_id__word & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sync_cmd = %u",
-			   htt_stats_buf->sync_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "write_cmd = %u",
-			   htt_stats_buf->write_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "gen_mpdu_cmd = %u",
-			   htt_stats_buf->gen_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u",
-			   htt_stats_buf->mpdu_queue_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_head_info_cmd = %u",
-			   htt_stats_buf->mpdu_head_info_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u",
-			   htt_stats_buf->msdu_flow_stats_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_mpdu_cmd = %u",
-			   htt_stats_buf->remove_mpdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "remove_msdu_cmd = %u",
-			   htt_stats_buf->remove_msdu_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flush_cache_cmd = %u",
-			   htt_stats_buf->flush_cache_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_mpduq_cmd = %u",
-			   htt_stats_buf->update_mpduq_cmd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "update_msduq_cmd = %u\n",
-			   htt_stats_buf->update_msduq_cmd);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_CMDQ_STATUS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__cmdq_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "cmdq_id = %u\n\n",
+			 (htt_stats_buf->mac_id__cmdq_id__word & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "sync_cmd = %u\n",
+			 htt_stats_buf->sync_cmd);
+	len += scnprintf(buf + len, buf_len - len, "write_cmd = %u\n",
+			 htt_stats_buf->write_cmd);
+	len += scnprintf(buf + len, buf_len - len, "gen_mpdu_cmd = %u\n",
+			 htt_stats_buf->gen_mpdu_cmd);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_queue_stats_cmd = %u\n",
+			 htt_stats_buf->mpdu_queue_stats_cmd);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_head_info_cmd = %u\n",
+			 htt_stats_buf->mpdu_head_info_cmd);
+	len += scnprintf(buf + len, buf_len - len, "msdu_flow_stats_cmd = %u\n",
+			 htt_stats_buf->msdu_flow_stats_cmd);
+	len += scnprintf(buf + len, buf_len - len, "remove_mpdu_cmd = %u\n",
+			 htt_stats_buf->remove_mpdu_cmd);
+	len += scnprintf(buf + len, buf_len - len, "remove_msdu_cmd = %u\n",
+			 htt_stats_buf->remove_msdu_cmd);
+	len += scnprintf(buf + len, buf_len - len, "flush_cache_cmd = %u\n",
+			 htt_stats_buf->flush_cache_cmd);
+	len += scnprintf(buf + len, buf_len - len, "update_mpduq_cmd = %u\n",
+			 htt_stats_buf->update_mpduq_cmd);
+	len += scnprintf(buf + len, buf_len - len, "update_msduq_cmd = %u\n\n",
+			 htt_stats_buf->update_msduq_cmd);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2252,20 +2248,20 @@ htt_print_tx_de_eapol_packets_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_EAPOL_PACKETS_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m1_packets = %u",
-			   htt_stats_buf->m1_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m2_packets = %u",
-			   htt_stats_buf->m2_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m3_packets = %u",
-			   htt_stats_buf->m3_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "m4_packets = %u",
-			   htt_stats_buf->m4_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "g1_packets = %u",
-			   htt_stats_buf->g1_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "g2_packets = %u\n",
-			   htt_stats_buf->g2_packets);
+	len += scnprintf(buf + len, buf_len - len,
+			   "HTT_TX_DE_EAPOL_PACKETS_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "m1_packets = %u\n",
+			 htt_stats_buf->m1_packets);
+	len += scnprintf(buf + len, buf_len - len, "m2_packets = %u\n",
+			 htt_stats_buf->m2_packets);
+	len += scnprintf(buf + len, buf_len - len, "m3_packets = %u\n",
+			 htt_stats_buf->m3_packets);
+	len += scnprintf(buf + len, buf_len - len, "m4_packets = %u\n",
+			 htt_stats_buf->m4_packets);
+	len += scnprintf(buf + len, buf_len - len, "g1_packets = %u\n",
+			 htt_stats_buf->g1_packets);
+	len += scnprintf(buf + len, buf_len - len, "g2_packets = %u\n\n",
+			 htt_stats_buf->g2_packets);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2284,34 +2280,34 @@ htt_print_tx_de_classify_failed_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_CLASSIFY_FAILED_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ap_bss_peer_not_found = %u",
-			   htt_stats_buf->ap_bss_peer_not_found);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ap_bcast_mcast_no_peer = %u",
-			   htt_stats_buf->ap_bcast_mcast_no_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sta_delete_in_progress = %u",
-			   htt_stats_buf->sta_delete_in_progress);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ibss_no_bss_peer = %u",
-			   htt_stats_buf->ibss_no_bss_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_vdev_type = %u",
-			   htt_stats_buf->invalid_vdev_type);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_ast_peer_entry = %u",
-			   htt_stats_buf->invalid_ast_peer_entry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "peer_entry_invalid = %u",
-			   htt_stats_buf->peer_entry_invalid);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ethertype_not_ip = %u",
-			   htt_stats_buf->ethertype_not_ip);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "eapol_lookup_failed = %u",
-			   htt_stats_buf->eapol_lookup_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qpeer_not_allow_data = %u",
-			   htt_stats_buf->qpeer_not_allow_data);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_tid_override = %u",
-			   htt_stats_buf->fse_tid_override);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ipv6_jumbogram_zero_length = %u",
-			   htt_stats_buf->ipv6_jumbogram_zero_length);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "qos_to_non_qos_in_prog = %u\n",
-			   htt_stats_buf->qos_to_non_qos_in_prog);
+	len += scnprintf(buf + len, buf_len - len,
+			   "HTT_TX_DE_CLASSIFY_FAILED_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "ap_bss_peer_not_found = %u\n",
+			 htt_stats_buf->ap_bss_peer_not_found);
+	len += scnprintf(buf + len, buf_len - len, "ap_bcast_mcast_no_peer = %u\n",
+			 htt_stats_buf->ap_bcast_mcast_no_peer);
+	len += scnprintf(buf + len, buf_len - len, "sta_delete_in_progress = %u\n",
+			 htt_stats_buf->sta_delete_in_progress);
+	len += scnprintf(buf + len, buf_len - len, "ibss_no_bss_peer = %u\n",
+			 htt_stats_buf->ibss_no_bss_peer);
+	len += scnprintf(buf + len, buf_len - len, "invalid_vdev_type = %u\n",
+			 htt_stats_buf->invalid_vdev_type);
+	len += scnprintf(buf + len, buf_len - len, "invalid_ast_peer_entry = %u\n",
+			 htt_stats_buf->invalid_ast_peer_entry);
+	len += scnprintf(buf + len, buf_len - len, "peer_entry_invalid = %u\n",
+			 htt_stats_buf->peer_entry_invalid);
+	len += scnprintf(buf + len, buf_len - len, "ethertype_not_ip = %u\n",
+			 htt_stats_buf->ethertype_not_ip);
+	len += scnprintf(buf + len, buf_len - len, "eapol_lookup_failed = %u\n",
+			 htt_stats_buf->eapol_lookup_failed);
+	len += scnprintf(buf + len, buf_len - len, "qpeer_not_allow_data = %u\n",
+			 htt_stats_buf->qpeer_not_allow_data);
+	len += scnprintf(buf + len, buf_len - len, "fse_tid_override = %u\n",
+			 htt_stats_buf->fse_tid_override);
+	len += scnprintf(buf + len, buf_len - len, "ipv6_jumbogram_zero_length = %u\n",
+			 htt_stats_buf->ipv6_jumbogram_zero_length);
+	len += scnprintf(buf + len, buf_len - len, "qos_to_non_qos_in_prog = %u\n\n",
+			 htt_stats_buf->qos_to_non_qos_in_prog);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2330,73 +2326,73 @@ htt_print_tx_de_classify_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_CLASSIFY_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "arp_packets = %u",
-			   htt_stats_buf->arp_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "igmp_packets = %u",
-			   htt_stats_buf->igmp_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dhcp_packets = %u",
-			   htt_stats_buf->dhcp_packets);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_inspected = %u",
-			   htt_stats_buf->host_inspected);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_included = %u",
-			   htt_stats_buf->htt_included);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_mcs = %u",
-			   htt_stats_buf->htt_valid_mcs);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_nss = %u",
-			   htt_stats_buf->htt_valid_nss);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_preamble_type = %u",
-			   htt_stats_buf->htt_valid_preamble_type);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_chainmask = %u",
-			   htt_stats_buf->htt_valid_chainmask);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_guard_interval = %u",
-			   htt_stats_buf->htt_valid_guard_interval);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_retries = %u",
-			   htt_stats_buf->htt_valid_retries);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_bw_info = %u",
-			   htt_stats_buf->htt_valid_bw_info);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_power = %u",
-			   htt_stats_buf->htt_valid_power);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_key_flags = 0x%x",
-			   htt_stats_buf->htt_valid_key_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_valid_no_encryption = %u",
-			   htt_stats_buf->htt_valid_no_encryption);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_entry_count = %u",
-			   htt_stats_buf->fse_entry_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_be = %u",
-			   htt_stats_buf->fse_priority_be);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_high = %u",
-			   htt_stats_buf->fse_priority_high);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_priority_low = %u",
-			   htt_stats_buf->fse_priority_low);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_be = %u",
-			   htt_stats_buf->fse_traffic_ptrn_be);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_over_sub = %u",
-			   htt_stats_buf->fse_traffic_ptrn_over_sub);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_bursty = %u",
-			   htt_stats_buf->fse_traffic_ptrn_bursty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_interactive = %u",
-			   htt_stats_buf->fse_traffic_ptrn_interactive);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_traffic_ptrn_periodic = %u",
-			   htt_stats_buf->fse_traffic_ptrn_periodic);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_alloc = %u",
-			   htt_stats_buf->fse_hwqueue_alloc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_created = %u",
-			   htt_stats_buf->fse_hwqueue_created);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_hwqueue_send_to_host = %u",
-			   htt_stats_buf->fse_hwqueue_send_to_host);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mcast_entry = %u",
-			   htt_stats_buf->mcast_entry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "bcast_entry = %u",
-			   htt_stats_buf->bcast_entry);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_update_peer_cache = %u",
-			   htt_stats_buf->htt_update_peer_cache);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "htt_learning_frame = %u",
-			   htt_stats_buf->htt_learning_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fse_invalid_peer = %u",
-			   htt_stats_buf->fse_invalid_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mec_notify = %u\n",
-			   htt_stats_buf->mec_notify);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_DE_CLASSIFY_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "arp_packets = %u\n",
+			 htt_stats_buf->arp_packets);
+	len += scnprintf(buf + len, buf_len - len, "igmp_packets = %u\n",
+			 htt_stats_buf->igmp_packets);
+	len += scnprintf(buf + len, buf_len - len, "dhcp_packets = %u\n",
+			 htt_stats_buf->dhcp_packets);
+	len += scnprintf(buf + len, buf_len - len, "host_inspected = %u\n",
+			 htt_stats_buf->host_inspected);
+	len += scnprintf(buf + len, buf_len - len, "htt_included = %u\n",
+			 htt_stats_buf->htt_included);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_mcs = %u\n",
+			 htt_stats_buf->htt_valid_mcs);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_nss = %u\n",
+			 htt_stats_buf->htt_valid_nss);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_preamble_type = %u\n",
+			 htt_stats_buf->htt_valid_preamble_type);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_chainmask = %u\n",
+			 htt_stats_buf->htt_valid_chainmask);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_guard_interval = %u\n",
+			 htt_stats_buf->htt_valid_guard_interval);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_retries = %u\n",
+			 htt_stats_buf->htt_valid_retries);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_bw_info = %u\n",
+			 htt_stats_buf->htt_valid_bw_info);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_power = %u\n",
+			 htt_stats_buf->htt_valid_power);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_key_flags = 0x%x\n",
+			 htt_stats_buf->htt_valid_key_flags);
+	len += scnprintf(buf + len, buf_len - len, "htt_valid_no_encryption = %u\n",
+			 htt_stats_buf->htt_valid_no_encryption);
+	len += scnprintf(buf + len, buf_len - len, "fse_entry_count = %u\n",
+			 htt_stats_buf->fse_entry_count);
+	len += scnprintf(buf + len, buf_len - len, "fse_priority_be = %u\n",
+			 htt_stats_buf->fse_priority_be);
+	len += scnprintf(buf + len, buf_len - len, "fse_priority_high = %u\n",
+			 htt_stats_buf->fse_priority_high);
+	len += scnprintf(buf + len, buf_len - len, "fse_priority_low = %u\n",
+			 htt_stats_buf->fse_priority_low);
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_be = %u\n",
+			 htt_stats_buf->fse_traffic_ptrn_be);
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_over_sub = %u\n",
+			 htt_stats_buf->fse_traffic_ptrn_over_sub);
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_bursty = %u\n",
+			 htt_stats_buf->fse_traffic_ptrn_bursty);
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_interactive = %u\n",
+			 htt_stats_buf->fse_traffic_ptrn_interactive);
+	len += scnprintf(buf + len, buf_len - len, "fse_traffic_ptrn_periodic = %u\n",
+			 htt_stats_buf->fse_traffic_ptrn_periodic);
+	len += scnprintf(buf + len, buf_len - len, "fse_hwqueue_alloc = %u\n",
+			 htt_stats_buf->fse_hwqueue_alloc);
+	len += scnprintf(buf + len, buf_len - len, "fse_hwqueue_created = %u\n",
+			 htt_stats_buf->fse_hwqueue_created);
+	len += scnprintf(buf + len, buf_len - len, "fse_hwqueue_send_to_host = %u\n",
+			 htt_stats_buf->fse_hwqueue_send_to_host);
+	len += scnprintf(buf + len, buf_len - len, "mcast_entry = %u\n",
+			 htt_stats_buf->mcast_entry);
+	len += scnprintf(buf + len, buf_len - len, "bcast_entry = %u\n",
+			 htt_stats_buf->bcast_entry);
+	len += scnprintf(buf + len, buf_len - len, "htt_update_peer_cache = %u\n",
+			 htt_stats_buf->htt_update_peer_cache);
+	len += scnprintf(buf + len, buf_len - len, "htt_learning_frame = %u\n",
+			 htt_stats_buf->htt_learning_frame);
+	len += scnprintf(buf + len, buf_len - len, "fse_invalid_peer = %u\n",
+			 htt_stats_buf->fse_invalid_peer);
+	len += scnprintf(buf + len, buf_len - len, "mec_notify = %u\n\n",
+			 htt_stats_buf->mec_notify);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2415,24 +2411,24 @@ htt_print_tx_de_classify_status_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_CLASSIFY_STATUS_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "eok = %u",
-			   htt_stats_buf->eok);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "classify_done = %u",
-			   htt_stats_buf->classify_done);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "lookup_failed = %u",
-			   htt_stats_buf->lookup_failed);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_dhcp = %u",
-			   htt_stats_buf->send_host_dhcp);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_mcast = %u",
-			   htt_stats_buf->send_host_mcast);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host_unknown_dest = %u",
-			   htt_stats_buf->send_host_unknown_dest);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "send_host = %u",
-			   htt_stats_buf->send_host);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "status_invalid = %u\n",
-			   htt_stats_buf->status_invalid);
+	len += scnprintf(buf + len, buf_len - len,
+			   "HTT_TX_DE_CLASSIFY_STATUS_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "eok = %u\n",
+			 htt_stats_buf->eok);
+	len += scnprintf(buf + len, buf_len - len, "classify_done = %u\n",
+			 htt_stats_buf->classify_done);
+	len += scnprintf(buf + len, buf_len - len, "lookup_failed = %u\n",
+			 htt_stats_buf->lookup_failed);
+	len += scnprintf(buf + len, buf_len - len, "send_host_dhcp = %u\n",
+			 htt_stats_buf->send_host_dhcp);
+	len += scnprintf(buf + len, buf_len - len, "send_host_mcast = %u\n",
+			 htt_stats_buf->send_host_mcast);
+	len += scnprintf(buf + len, buf_len - len, "send_host_unknown_dest = %u\n",
+			 htt_stats_buf->send_host_unknown_dest);
+	len += scnprintf(buf + len, buf_len - len, "send_host = %u\n",
+			 htt_stats_buf->send_host);
+	len += scnprintf(buf + len, buf_len - len, "status_invalid = %u\n\n",
+			 htt_stats_buf->status_invalid);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2451,14 +2447,14 @@ htt_print_tx_de_enqueue_packets_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_ENQUEUE_PACKETS_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "enqueued_pkts = %u",
-			htt_stats_buf->enqueued_pkts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "to_tqm = %u",
-			htt_stats_buf->to_tqm);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "to_tqm_bypass = %u\n",
-			htt_stats_buf->to_tqm_bypass);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_ENQUEUE_PACKETS_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "enqueued_pkts = %u\n",
+			 htt_stats_buf->enqueued_pkts);
+	len += scnprintf(buf + len, buf_len - len, "to_tqm = %u\n",
+			 htt_stats_buf->to_tqm);
+	len += scnprintf(buf + len, buf_len - len, "to_tqm_bypass = %u\n\n",
+			 htt_stats_buf->to_tqm_bypass);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2477,14 +2473,14 @@ htt_print_tx_de_enqueue_discard_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_ENQUEUE_DISCARD_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "discarded_pkts = %u",
-			   htt_stats_buf->discarded_pkts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_frames = %u",
-			   htt_stats_buf->local_frames);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "is_ext_msdu = %u\n",
-			   htt_stats_buf->is_ext_msdu);
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_ENQUEUE_DISCARD_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "discarded_pkts = %u\n",
+			 htt_stats_buf->discarded_pkts);
+	len += scnprintf(buf + len, buf_len - len, "local_frames = %u\n",
+			 htt_stats_buf->local_frames);
+	len += scnprintf(buf + len, buf_len - len, "is_ext_msdu = %u\n\n",
+			 htt_stats_buf->is_ext_msdu);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2502,17 +2498,17 @@ static inline void htt_print_tx_de_compl_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_COMPL_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl_dummy_frame = %u",
-			   htt_stats_buf->tcl_dummy_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_dummy_frame = %u",
-			   htt_stats_buf->tqm_dummy_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_notify_frame = %u",
-			   htt_stats_buf->tqm_notify_frame);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw2wbm_enq = %u",
-			   htt_stats_buf->fw2wbm_enq);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tqm_bypass_frame = %u\n",
-			   htt_stats_buf->tqm_bypass_frame);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_DE_COMPL_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "tcl_dummy_frame = %u\n",
+			 htt_stats_buf->tcl_dummy_frame);
+	len += scnprintf(buf + len, buf_len - len, "tqm_dummy_frame = %u\n",
+			 htt_stats_buf->tqm_dummy_frame);
+	len += scnprintf(buf + len, buf_len - len, "tqm_notify_frame = %u\n",
+			 htt_stats_buf->tqm_notify_frame);
+	len += scnprintf(buf + len, buf_len - len, "fw2wbm_enq = %u\n",
+			 htt_stats_buf->fw2wbm_enq);
+	len += scnprintf(buf + len, buf_len - len, "tqm_bypass_frame = %u\n\n",
+			 htt_stats_buf->tqm_bypass_frame);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2535,19 +2531,19 @@ htt_print_tx_de_fw2wbm_ring_full_hist_tlv(const void *tag_buf,
 	u16  num_elements = tag_len >> 2;
 	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_TX_DE_FW2WBM_RING_FULL_HIST_TLV");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_TX_DE_FW2WBM_RING_FULL_HIST_TLV");
 
 	if (required_buffer_size < HTT_MAX_STRING_LEN) {
 		PRINT_ARRAY_TO_BUF(fw2wbm_ring_full_hist,
 				   htt_stats_buf->fw2wbm_ring_full_hist,
 				   num_elements);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "fw2wbm_ring_full_hist = %s\n",
-				   fw2wbm_ring_full_hist);
+		len += scnprintf(buf + len, buf_len - len,
+				 "fw2wbm_ring_full_hist = %s\n\n",
+				 fw2wbm_ring_full_hist);
 	} else {
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "INSUFFICIENT PRINT BUFFER ");
+		len += scnprintf(buf + len, buf_len - len,
+				 "INSUFFICIENT PRINT BUFFER\n");
 	}
 
 	if (len >= buf_len)
@@ -2566,21 +2562,21 @@ htt_print_tx_de_cmn_stats_tlv(const void *tag_buf, struct debug_htt_stats_req *s
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_DE_CMN_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl2fw_entry_count = %u",
-			   htt_stats_buf->tcl2fw_entry_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "not_to_fw = %u",
-			   htt_stats_buf->not_to_fw);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_pdev_vdev_peer = %u",
-			   htt_stats_buf->invalid_pdev_vdev_peer);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcl_res_invalid_addrx = %u",
-			   htt_stats_buf->tcl_res_invalid_addrx);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm2fw_entry_count = %u",
-			   htt_stats_buf->wbm2fw_entry_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "invalid_pdev = %u\n",
-			   htt_stats_buf->invalid_pdev);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_DE_CMN_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "tcl2fw_entry_count = %u\n",
+			 htt_stats_buf->tcl2fw_entry_count);
+	len += scnprintf(buf + len, buf_len - len, "not_to_fw = %u\n",
+			 htt_stats_buf->not_to_fw);
+	len += scnprintf(buf + len, buf_len - len, "invalid_pdev_vdev_peer = %u\n",
+			 htt_stats_buf->invalid_pdev_vdev_peer);
+	len += scnprintf(buf + len, buf_len - len, "tcl_res_invalid_addrx = %u\n",
+			 htt_stats_buf->tcl_res_invalid_addrx);
+	len += scnprintf(buf + len, buf_len - len, "wbm2fw_entry_count = %u\n",
+			 htt_stats_buf->wbm2fw_entry_count);
+	len += scnprintf(buf + len, buf_len - len, "invalid_pdev = %u\n\n",
+			 htt_stats_buf->invalid_pdev);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2600,49 +2596,49 @@ static inline void htt_print_ring_if_stats_tlv(const void *tag_buf,
 	char low_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
 	char high_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RING_IF_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr = %u",
-			   htt_stats_buf->base_addr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "elem_size = %u",
-			   htt_stats_buf->elem_size);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_elems = %u",
-			   htt_stats_buf->num_elems__prefetch_tail_idx & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "prefetch_tail_idx = %u",
-			   (htt_stats_buf->num_elems__prefetch_tail_idx &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "head_idx = %u",
-			   htt_stats_buf->head_idx__tail_idx & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tail_idx = %u",
-			   (htt_stats_buf->head_idx__tail_idx & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "shadow_head_idx = %u",
-			   htt_stats_buf->shadow_head_idx__shadow_tail_idx & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "shadow_tail_idx = %u",
-			   (htt_stats_buf->shadow_head_idx__shadow_tail_idx &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_tail_incr = %u",
-			   htt_stats_buf->num_tail_incr);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "lwm_thresh = %u",
-			   htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwm_thresh = %u",
-			   (htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "overrun_hit_count = %u",
-			   htt_stats_buf->overrun_hit_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "underrun_hit_count = %u",
-			   htt_stats_buf->underrun_hit_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "prod_blockwait_count = %u",
-			   htt_stats_buf->prod_blockwait_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "cons_blockwait_count = %u",
-			   htt_stats_buf->cons_blockwait_count);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RING_IF_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "base_addr = %u\n",
+			 htt_stats_buf->base_addr);
+	len += scnprintf(buf + len, buf_len - len, "elem_size = %u\n",
+			 htt_stats_buf->elem_size);
+	len += scnprintf(buf + len, buf_len - len, "num_elems = %u\n",
+			 htt_stats_buf->num_elems__prefetch_tail_idx & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "prefetch_tail_idx = %u\n",
+			 (htt_stats_buf->num_elems__prefetch_tail_idx &
+			 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "head_idx = %u\n",
+			 htt_stats_buf->head_idx__tail_idx & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "tail_idx = %u\n",
+			 (htt_stats_buf->head_idx__tail_idx & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "shadow_head_idx = %u\n",
+			 htt_stats_buf->shadow_head_idx__shadow_tail_idx & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "shadow_tail_idx = %u\n",
+			 (htt_stats_buf->shadow_head_idx__shadow_tail_idx &
+			 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "num_tail_incr = %u\n",
+			 htt_stats_buf->num_tail_incr);
+	len += scnprintf(buf + len, buf_len - len, "lwm_thresh = %u\n",
+			 htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "hwm_thresh = %u\n",
+			 (htt_stats_buf->lwm_thresh__hwm_thresh & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "overrun_hit_count = %u\n",
+			 htt_stats_buf->overrun_hit_count);
+	len += scnprintf(buf + len, buf_len - len, "underrun_hit_count = %u\n",
+			 htt_stats_buf->underrun_hit_count);
+	len += scnprintf(buf + len, buf_len - len, "prod_blockwait_count = %u\n",
+			 htt_stats_buf->prod_blockwait_count);
+	len += scnprintf(buf + len, buf_len - len, "cons_blockwait_count = %u\n",
+			 htt_stats_buf->cons_blockwait_count);
 
 	PRINT_ARRAY_TO_BUF(low_wm_hit_count, htt_stats_buf->low_wm_hit_count,
 			   HTT_STATS_LOW_WM_BINS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "low_wm_hit_count = %s ",
-			   low_wm_hit_count);
+	len += scnprintf(buf + len, buf_len - len, "low_wm_hit_count = %s\n",
+			 low_wm_hit_count);
 
 	PRINT_ARRAY_TO_BUF(high_wm_hit_count, htt_stats_buf->high_wm_hit_count,
 			   HTT_STATS_HIGH_WM_BINS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "high_wm_hit_count = %s\n",
-			   high_wm_hit_count);
+	len += scnprintf(buf + len, buf_len - len, "high_wm_hit_count = %s\n\n",
+			 high_wm_hit_count);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2660,11 +2656,11 @@ static inline void htt_print_ring_if_cmn_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RING_IF_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
-			   htt_stats_buf->num_records);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RING_IF_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n\n",
+			 htt_stats_buf->num_records);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2685,13 +2681,13 @@ static inline void htt_print_sfm_client_user_tlv_v(const void *tag_buf,
 	char dwords_used_by_user_n[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = tag_len >> 2;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CLIENT_USER_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CLIENT_USER_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(dwords_used_by_user_n,
 			   htt_stats_buf->dwords_used_by_user_n,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dwords_used_by_user_n = %s\n",
-			   dwords_used_by_user_n);
+	len += scnprintf(buf + len, buf_len - len, "dwords_used_by_user_n = %s\n\n",
+			 dwords_used_by_user_n);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2709,21 +2705,21 @@ static inline void htt_print_sfm_client_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CLIENT_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "client_id = %u",
-			   htt_stats_buf->client_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_min = %u",
-			   htt_stats_buf->buf_min);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_max = %u",
-			   htt_stats_buf->buf_max);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_busy = %u",
-			   htt_stats_buf->buf_busy);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_alloc = %u",
-			   htt_stats_buf->buf_alloc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_avail = %u",
-			   htt_stats_buf->buf_avail);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_users = %u\n",
-			   htt_stats_buf->num_users);
+	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CLIENT_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "client_id = %u\n",
+			 htt_stats_buf->client_id);
+	len += scnprintf(buf + len, buf_len - len, "buf_min = %u\n",
+			 htt_stats_buf->buf_min);
+	len += scnprintf(buf + len, buf_len - len, "buf_max = %u\n",
+			 htt_stats_buf->buf_max);
+	len += scnprintf(buf + len, buf_len - len, "buf_busy = %u\n",
+			 htt_stats_buf->buf_busy);
+	len += scnprintf(buf + len, buf_len - len, "buf_alloc = %u\n",
+			 htt_stats_buf->buf_alloc);
+	len += scnprintf(buf + len, buf_len - len, "buf_avail = %u\n",
+			 htt_stats_buf->buf_avail);
+	len += scnprintf(buf + len, buf_len - len, "num_users = %u\n\n",
+			 htt_stats_buf->num_users);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2741,17 +2737,17 @@ static inline void htt_print_sfm_cmn_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SFM_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "buf_total = %u",
-			   htt_stats_buf->buf_total);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mem_empty = %u",
-			   htt_stats_buf->mem_empty);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "deallocate_bufs = %u",
-			   htt_stats_buf->deallocate_bufs);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
-			   htt_stats_buf->num_records);
+	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "buf_total = %u\n",
+			 htt_stats_buf->buf_total);
+	len += scnprintf(buf + len, buf_len - len, "mem_empty = %u\n",
+			 htt_stats_buf->mem_empty);
+	len += scnprintf(buf + len, buf_len - len, "deallocate_bufs = %u\n",
+			 htt_stats_buf->deallocate_bufs);
+	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n\n",
+			 htt_stats_buf->num_records);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2769,42 +2765,42 @@ static inline void htt_print_sring_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SRING_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ring_id = %u",
-			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "arena = %u",
-			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ep = %u",
-			   (htt_stats_buf->mac_id__ring_id__arena__ep & 0x1000000) >> 24);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr_lsb = 0x%x",
-			   htt_stats_buf->base_addr_lsb);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "base_addr_msb = 0x%x",
-			   htt_stats_buf->base_addr_msb);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ring_size = %u",
-			   htt_stats_buf->ring_size);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "elem_size = %u",
-			   htt_stats_buf->elem_size);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_avail_words = %u",
-			   htt_stats_buf->num_avail_words__num_valid_words & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_valid_words = %u",
-			   (htt_stats_buf->num_avail_words__num_valid_words &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "head_ptr = %u",
-			   htt_stats_buf->head_ptr__tail_ptr & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tail_ptr = %u",
-			   (htt_stats_buf->head_ptr__tail_ptr & 0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "consumer_empty = %u",
-			   htt_stats_buf->consumer_empty__producer_full & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "producer_full = %u",
-			   (htt_stats_buf->consumer_empty__producer_full &
-			   0xFFFF0000) >> 16);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "prefetch_count = %u",
-			   htt_stats_buf->prefetch_count__internal_tail_ptr & 0xFFFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "internal_tail_ptr = %u\n",
-			   (htt_stats_buf->prefetch_count__internal_tail_ptr &
-			   0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "HTT_SRING_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "ring_id = %u\n",
+			 (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "arena = %u\n",
+			 (htt_stats_buf->mac_id__ring_id__arena__ep & 0xFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "ep = %u\n",
+			 (htt_stats_buf->mac_id__ring_id__arena__ep & 0x1000000) >> 24);
+	len += scnprintf(buf + len, buf_len - len, "base_addr_lsb = 0x%x\n",
+			 htt_stats_buf->base_addr_lsb);
+	len += scnprintf(buf + len, buf_len - len, "base_addr_msb = 0x%x\n",
+			 htt_stats_buf->base_addr_msb);
+	len += scnprintf(buf + len, buf_len - len, "ring_size = %u\n",
+			 htt_stats_buf->ring_size);
+	len += scnprintf(buf + len, buf_len - len, "elem_size = %u\n",
+			 htt_stats_buf->elem_size);
+	len += scnprintf(buf + len, buf_len - len, "num_avail_words = %u\n",
+			 htt_stats_buf->num_avail_words__num_valid_words & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "num_valid_words = %u\n",
+			 (htt_stats_buf->num_avail_words__num_valid_words &
+			 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "head_ptr = %u\n",
+			 htt_stats_buf->head_ptr__tail_ptr & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "tail_ptr = %u\n",
+			 (htt_stats_buf->head_ptr__tail_ptr & 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "consumer_empty = %u\n",
+			 htt_stats_buf->consumer_empty__producer_full & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "producer_full = %u\n",
+			 (htt_stats_buf->consumer_empty__producer_full &
+			 0xFFFF0000) >> 16);
+	len += scnprintf(buf + len, buf_len - len, "prefetch_count = %u\n",
+			 htt_stats_buf->prefetch_count__internal_tail_ptr & 0xFFFF);
+	len += scnprintf(buf + len, buf_len - len, "internal_tail_ptr = %u\n\n",
+			 (htt_stats_buf->prefetch_count__internal_tail_ptr &
+			 0xFFFF0000) >> 16);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2822,9 +2818,9 @@ static inline void htt_print_sring_cmn_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_SRING_CMN_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u\n",
-			   htt_stats_buf->num_records);
+	len += scnprintf(buf + len, buf_len - len, "HTT_SRING_CMN_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n\n",
+			 htt_stats_buf->num_records);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2851,156 +2847,156 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 			goto fail;
 	}
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_TX_PDEV_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_ldpc = %u",
-			   htt_stats_buf->tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_ldpc = %u",
-			   htt_stats_buf->ac_mu_mimo_tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_ldpc = %u",
-			   htt_stats_buf->ax_mu_mimo_tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_ldpc = %u",
-			   htt_stats_buf->ofdma_tx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_success = %u",
-			   htt_stats_buf->rts_success);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ack_rssi = %u",
-			   htt_stats_buf->ack_rssi);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "Legacy CCK Rates: 1 Mbps: %u, 2 Mbps: %u, 5.5 Mbps: %u, 11 Mbps: %u",
-			   htt_stats_buf->tx_legacy_cck_rate[0],
-			   htt_stats_buf->tx_legacy_cck_rate[1],
-			   htt_stats_buf->tx_legacy_cck_rate[2],
-			   htt_stats_buf->tx_legacy_cck_rate[3]);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "Legacy OFDM Rates: 6 Mbps: %u, 9 Mbps: %u, 12 Mbps: %u, 18 Mbps: %u\n"
-			   "                   24 Mbps: %u, 36 Mbps: %u, 48 Mbps: %u, 54 Mbps: %u",
-			   htt_stats_buf->tx_legacy_ofdm_rate[0],
-			   htt_stats_buf->tx_legacy_ofdm_rate[1],
-			   htt_stats_buf->tx_legacy_ofdm_rate[2],
-			   htt_stats_buf->tx_legacy_ofdm_rate[3],
-			   htt_stats_buf->tx_legacy_ofdm_rate[4],
-			   htt_stats_buf->tx_legacy_ofdm_rate[5],
-			   htt_stats_buf->tx_legacy_ofdm_rate[6],
-			   htt_stats_buf->tx_legacy_ofdm_rate[7]);
+	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_RATE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "tx_ldpc = %u\n",
+			 htt_stats_buf->tx_ldpc);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_ldpc = %u\n",
+			 htt_stats_buf->ac_mu_mimo_tx_ldpc);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_ldpc = %u\n",
+			 htt_stats_buf->ax_mu_mimo_tx_ldpc);
+	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_ldpc = %u\n",
+			 htt_stats_buf->ofdma_tx_ldpc);
+	len += scnprintf(buf + len, buf_len - len, "rts_cnt = %u\n",
+			 htt_stats_buf->rts_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rts_success = %u\n",
+			 htt_stats_buf->rts_success);
+	len += scnprintf(buf + len, buf_len - len, "ack_rssi = %u\n",
+			 htt_stats_buf->ack_rssi);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "Legacy CCK Rates: 1 Mbps: %u, 2 Mbps: %u, 5.5 Mbps: %u, 11 Mbps: %u\n",
+			 htt_stats_buf->tx_legacy_cck_rate[0],
+			 htt_stats_buf->tx_legacy_cck_rate[1],
+			 htt_stats_buf->tx_legacy_cck_rate[2],
+			 htt_stats_buf->tx_legacy_cck_rate[3]);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "Legacy OFDM Rates: 6 Mbps: %u, 9 Mbps: %u, 12 Mbps: %u, 18 Mbps: %u\n"
+			 "                   24 Mbps: %u, 36 Mbps: %u, 48 Mbps: %u, 54 Mbps: %u\n",
+			 htt_stats_buf->tx_legacy_ofdm_rate[0],
+			 htt_stats_buf->tx_legacy_ofdm_rate[1],
+			 htt_stats_buf->tx_legacy_ofdm_rate[2],
+			 htt_stats_buf->tx_legacy_ofdm_rate[3],
+			 htt_stats_buf->tx_legacy_ofdm_rate[4],
+			 htt_stats_buf->tx_legacy_ofdm_rate[5],
+			 htt_stats_buf->tx_legacy_ofdm_rate[6],
+			 htt_stats_buf->tx_legacy_ofdm_rate[7]);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mcs,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_mcs,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_mcs,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_mcs,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_nss,
 			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_nss,
 			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_nss,
 			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_nss,
 			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_bw,
 			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_bw = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_bw = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_bw,
 			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ac_mu_mimo_tx_bw = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_bw = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_bw,
 			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ax_mu_mimo_tx_bw = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_bw = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_bw,
 			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_bw = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_bw = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_stbc,
 			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_stbc = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_stbc = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_pream,
 			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_pream = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_pream = %s\n", str_buf);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HE LTF: 1x: %u, 2x: %u, 4x: %u",
-			   htt_stats_buf->tx_he_ltf[1],
-			   htt_stats_buf->tx_he_ltf[2],
-			   htt_stats_buf->tx_he_ltf[3]);
+	len += scnprintf(buf + len, buf_len - len, "HE LTF: 1x: %u, 2x: %u, 4x: %u\n",
+			 htt_stats_buf->tx_he_ltf[1],
+			 htt_stats_buf->tx_he_ltf[2],
+			 htt_stats_buf->tx_he_ltf[3]);
 
 	/* SU GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->tx_gi[j],
 				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len, "tx_gi[%u] = %s\n",
+				 j, tx_gi[j]);
 	}
 
 	/* AC MU-MIMO GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ac_mu_mimo_tx_gi[j],
 				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ac_mu_mimo_tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ac_mu_mimo_tx_gi[%u] = %s\n",
+				 j, tx_gi[j]);
 	}
 
 	/* AX MU-MIMO GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ax_mu_mimo_tx_gi[j],
 				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "ax_mu_mimo_tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ax_mu_mimo_tx_gi[%u] = %s\n",
+				 j, tx_gi[j]);
 	}
 
 	/* DL OFDMA GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ofdma_tx_gi[j],
 				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "ofdma_tx_gi[%u] = %s ",
-				   j, tx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len, "ofdma_tx_gi[%u] = %s\n",
+				 j, tx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_dcm,
 			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tx_dcm = %s\n", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "tx_dcm = %s\n\n", str_buf);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3045,202 +3041,202 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 			goto fail;
 	}
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "nsts = %u",
-			   htt_stats_buf->nsts);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ldpc = %u",
-			   htt_stats_buf->rx_ldpc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rts_cnt = %u",
-			   htt_stats_buf->rts_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_mgmt = %u",
-			   htt_stats_buf->rssi_mgmt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_data = %u",
-			   htt_stats_buf->rssi_data);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_comb = %u",
-			   htt_stats_buf->rssi_comb);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_in_dbm = %d",
-			   htt_stats_buf->rssi_in_dbm);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "nsts = %u\n",
+			 htt_stats_buf->nsts);
+	len += scnprintf(buf + len, buf_len - len, "rx_ldpc = %u\n",
+			 htt_stats_buf->rx_ldpc);
+	len += scnprintf(buf + len, buf_len - len, "rts_cnt = %u\n",
+			 htt_stats_buf->rts_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rssi_mgmt = %u\n",
+			 htt_stats_buf->rssi_mgmt);
+	len += scnprintf(buf + len, buf_len - len, "rssi_data = %u\n",
+			 htt_stats_buf->rssi_data);
+	len += scnprintf(buf + len, buf_len - len, "rssi_comb = %u\n",
+			 htt_stats_buf->rssi_comb);
+	len += scnprintf(buf + len, buf_len - len, "rssi_in_dbm = %d\n",
+			 htt_stats_buf->rssi_in_dbm);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_mcs,
 			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_mcs = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_nss,
 			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_dcm,
 			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_dcm = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_dcm = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_stbc,
 			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_stbc = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_stbc = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_bw,
 			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_bw = %s ", str_buf);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_evm_nss_count = %u",
-			htt_stats_buf->nss_count);
+	len += scnprintf(buf + len, buf_len - len, "rx_bw = %s\n", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_evm_nss_count = %u\n",
+			 htt_stats_buf->nss_count);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_evm_pilot_count = %u",
-			htt_stats_buf->pilot_count);
+	len += scnprintf(buf + len, buf_len - len, "rx_evm_pilot_count = %u\n",
+			 htt_stats_buf->pilot_count);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
 		index = 0;
 
 		for (i = 0; i < HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS; i++)
 			index += scnprintf(&rx_pilot_evm_db[j][index],
-					  HTT_MAX_STRING_LEN - index,
-					  " %u:%d,",
-					  i,
-					  htt_stats_buf->rx_pilot_evm_db[j][i]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB[%u] = %s ",
-				   j, rx_pilot_evm_db[j]);
+					   HTT_MAX_STRING_LEN - index,
+					   " %u:%d,",
+					   i,
+					   htt_stats_buf->rx_pilot_evm_db[j][i]);
+		len += scnprintf(buf + len, buf_len - len, "pilot_evm_dB[%u] = %s\n",
+				 j, rx_pilot_evm_db[j]);
 	}
 
 	index = 0;
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
 		index += scnprintf(&str_buf[index],
-				  HTT_MAX_STRING_LEN - index,
-				  " %u:%d,", i, htt_stats_buf->rx_pilot_evm_db_mean[i]);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pilot_evm_dB_mean = %s ", str_buf);
+				   HTT_MAX_STRING_LEN - index,
+				   " %u:%d,", i, htt_stats_buf->rx_pilot_evm_db_mean[i]);
+	len += scnprintf(buf + len, buf_len - len, "pilot_evm_dB_mean = %s\n", str_buf);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
 		PRINT_ARRAY_TO_BUF(rssi_chain[j], htt_stats_buf->rssi_chain[j],
 				   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rssi_chain[%u] = %s ",
-				   j, rssi_chain[j]);
+		len += scnprintf(buf + len, buf_len - len, "rssi_chain[%u] = %s\n",
+				 j, rssi_chain[j]);
 	}
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->rx_gi[j],
 				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_gi[%u] = %s ",
-				   j, rx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len, "rx_gi[%u] = %s\n",
+				 j, rx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_pream,
 			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_pream = %s", str_buf);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_su_ext = %u",
-			   htt_stats_buf->rx_11ax_su_ext);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ac_mumimo = %u",
-			   htt_stats_buf->rx_11ac_mumimo);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_mumimo = %u",
-			   htt_stats_buf->rx_11ax_mumimo);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_ofdma = %u",
-			   htt_stats_buf->rx_11ax_ofdma);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "txbf = %u",
-			   htt_stats_buf->txbf);
+	len += scnprintf(buf + len, buf_len - len, "rx_pream = %s\n", str_buf);
+
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_su_ext = %u\n",
+			 htt_stats_buf->rx_11ax_su_ext);
+	len += scnprintf(buf + len, buf_len - len, "rx_11ac_mumimo = %u\n",
+			 htt_stats_buf->rx_11ac_mumimo);
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_mumimo = %u\n",
+			 htt_stats_buf->rx_11ax_mumimo);
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_ofdma = %u\n",
+			 htt_stats_buf->rx_11ax_ofdma);
+	len += scnprintf(buf + len, buf_len - len, "txbf = %u\n",
+			 htt_stats_buf->txbf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_legacy_cck_rate,
 			   HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_cck_rate = %s ",
-			   str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_legacy_cck_rate = %s\n",
+			 str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_legacy_ofdm_rate,
 			   HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_legacy_ofdm_rate = %s ",
-			   str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_legacy_ofdm_rate = %s\n",
+			 str_buf);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_active_dur_us_low = %u",
-			   htt_stats_buf->rx_active_dur_us_low);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_active_dur_us_high = %u",
-			htt_stats_buf->rx_active_dur_us_high);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_11ax_ul_ofdma = %u",
-			htt_stats_buf->rx_11ax_ul_ofdma);
+	len += scnprintf(buf + len, buf_len - len, "rx_active_dur_us_low = %u\n",
+			 htt_stats_buf->rx_active_dur_us_low);
+	len += scnprintf(buf + len, buf_len - len, "rx_active_dur_us_high = %u\n",
+			 htt_stats_buf->rx_active_dur_us_high);
+	len += scnprintf(buf + len, buf_len - len, "rx_11ax_ul_ofdma = %u\n",
+			 htt_stats_buf->rx_11ax_ul_ofdma);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_mcs,
 			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_mcs = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_mcs = %s\n", str_buf);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
 		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->ul_ofdma_rx_gi[j],
 				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_gi[%u] = %s ",
-				   j, rx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_gi[%u] = %s\n",
+				 j, rx_gi[j]);
 	}
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_nss,
 			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_nss = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_nss = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_bw,
 			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_bw = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_bw = %s\n", str_buf);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u",
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u\n",
 			htt_stats_buf->ul_ofdma_rx_stbc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ul_ofdma_rx_ldpc = %u",
+	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_ldpc = %u\n",
 			htt_stats_buf->ul_ofdma_rx_ldpc);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_non_data_ppdu,
 			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_non_data_ppdu = %s ",
-			   str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_non_data_ppdu = %s\n",
+			 str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_data_ppdu,
 			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_data_ppdu = %s ",
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_data_ppdu = %s\n",
 			   str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_mpdu_ok,
 			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_ok = %s ", str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_mpdu_ok = %s\n", str_buf);
 
 	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_mpdu_fail,
 			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ulofdma_mpdu_fail = %s",
-			   str_buf);
+	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_mpdu_fail = %s\n",
+			 str_buf);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
 		index = 0;
 		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 		for (i = 0; i < HTT_RX_PDEV_MAX_OFDMA_NUM_USER; i++)
 			index += scnprintf(&str_buf[index],
-					  HTT_MAX_STRING_LEN - index,
-					  " %u:%d,",
-					  i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "rx_ul_fd_rssi: nss[%u] = %s", j, str_buf);
+					   HTT_MAX_STRING_LEN - index,
+					   " %u:%d,",
+					   i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_ul_fd_rssi: nss[%u] = %s\n", j, str_buf);
 	}
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "per_chain_rssi_pkt_type = %#x",
-			   htt_stats_buf->per_chain_rssi_pkt_type);
+	len += scnprintf(buf + len, buf_len - len, "per_chain_rssi_pkt_type = %#x\n",
+			 htt_stats_buf->per_chain_rssi_pkt_type);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
 		index = 0;
 		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
 		for (i = 0; i < HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
 			index += scnprintf(&str_buf[index],
-					  HTT_MAX_STRING_LEN - index,
-					  " %u:%d,",
-					  i,
-					  htt_stats_buf->rx_per_chain_rssi_in_dbm[j][i]);
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "rx_per_chain_rssi_in_dbm[%u] = %s ", j, str_buf);
+					   HTT_MAX_STRING_LEN - index,
+					   " %u:%d,",
+					   i,
+					   htt_stats_buf->rx_per_chain_rssi_in_dbm[j][i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_per_chain_rssi_in_dbm[%u] = %s\n", j, str_buf);
 	}
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\n");
+	len += scnprintf(buf + len, buf_len - len, "\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3268,34 +3264,34 @@ static inline void htt_print_rx_soc_fw_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_SOC_FW_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_reo_ring_data_msdu = %u",
-			   htt_stats_buf->fw_reo_ring_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_to_host_data_msdu_bcmc = %u",
-			   htt_stats_buf->fw_to_host_data_msdu_bcmc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_to_host_data_msdu_uc = %u",
-			   htt_stats_buf->fw_to_host_data_msdu_uc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_remote_data_buf_recycle_cnt = %u",
-			   htt_stats_buf->ofld_remote_data_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_remote_free_buf_indication_cnt = %u",
-			   htt_stats_buf->ofld_remote_free_buf_indication_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_buf_to_host_data_msdu_uc = %u",
-			   htt_stats_buf->ofld_buf_to_host_data_msdu_uc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "reo_fw_ring_to_host_data_msdu_uc = %u",
-			   htt_stats_buf->reo_fw_ring_to_host_data_msdu_uc);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_sw_ring_reap = %u",
-			   htt_stats_buf->wbm_sw_ring_reap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_forward_to_host_cnt = %u",
-			   htt_stats_buf->wbm_forward_to_host_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wbm_target_recycle_cnt = %u",
-			   htt_stats_buf->wbm_target_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "target_refill_ring_recycle_cnt = %u",
-			   htt_stats_buf->target_refill_ring_recycle_cnt);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_SOC_FW_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "fw_reo_ring_data_msdu = %u\n",
+			 htt_stats_buf->fw_reo_ring_data_msdu);
+	len += scnprintf(buf + len, buf_len - len, "fw_to_host_data_msdu_bcmc = %u\n",
+			 htt_stats_buf->fw_to_host_data_msdu_bcmc);
+	len += scnprintf(buf + len, buf_len - len, "fw_to_host_data_msdu_uc = %u\n",
+			 htt_stats_buf->fw_to_host_data_msdu_uc);
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_remote_data_buf_recycle_cnt = %u\n",
+			 htt_stats_buf->ofld_remote_data_buf_recycle_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_remote_free_buf_indication_cnt = %u\n",
+			 htt_stats_buf->ofld_remote_free_buf_indication_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_buf_to_host_data_msdu_uc = %u\n",
+			 htt_stats_buf->ofld_buf_to_host_data_msdu_uc);
+	len += scnprintf(buf + len, buf_len - len,
+			 "reo_fw_ring_to_host_data_msdu_uc = %u\n",
+			 htt_stats_buf->reo_fw_ring_to_host_data_msdu_uc);
+	len += scnprintf(buf + len, buf_len - len, "wbm_sw_ring_reap = %u\n",
+			 htt_stats_buf->wbm_sw_ring_reap);
+	len += scnprintf(buf + len, buf_len - len, "wbm_forward_to_host_cnt = %u\n",
+			 htt_stats_buf->wbm_forward_to_host_cnt);
+	len += scnprintf(buf + len, buf_len - len, "wbm_target_recycle_cnt = %u\n",
+			 htt_stats_buf->wbm_target_recycle_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			 "target_refill_ring_recycle_cnt = %u\n",
+			 htt_stats_buf->target_refill_ring_recycle_cnt);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3317,14 +3313,14 @@ htt_print_rx_soc_fw_refill_ring_empty_tlv_v(const void *tag_buf,
 	char refill_ring_empty_cnt[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(refill_ring_empty_cnt,
 			   htt_stats_buf->refill_ring_empty_cnt,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_empty_cnt = %s\n",
-			   refill_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len, "refill_ring_empty_cnt = %s\n\n",
+			 refill_ring_empty_cnt);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3347,14 +3343,14 @@ htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v(const void *tag_buf,
 	char rxdma_err_cnt[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_RXDMA_MAX_ERR_CODE);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(rxdma_err_cnt,
 			   htt_stats_buf->rxdma_err,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rxdma_err = %s\n",
-			   rxdma_err_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rxdma_err = %s\n\n",
+			 rxdma_err_cnt);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3376,14 +3372,14 @@ htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv_v(const void *tag_buf,
 	char reo_err_cnt[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_REO_MAX_ERR_CODE);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(reo_err_cnt,
 			   htt_stats_buf->reo_err,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "reo_err = %s\n",
-			   reo_err_cnt);
+	len += scnprintf(buf + len, buf_len - len, "reo_err = %s\n\n",
+			 reo_err_cnt);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3402,27 +3398,27 @@ htt_print_rx_reo_debug_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_REO_RESOURCE_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sample_id = %u",
-			   htt_stats_buf->sample_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_max = %u",
-			   htt_stats_buf->total_max);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_avg = %u",
-			   htt_stats_buf->total_avg);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_sample = %u",
-			   htt_stats_buf->total_sample);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "non_zeros_avg = %u",
-			   htt_stats_buf->non_zeros_avg);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "non_zeros_sample = %u",
-			   htt_stats_buf->non_zeros_sample);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_max = %u",
-			   htt_stats_buf->last_non_zeros_max);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_min %u",
-			   htt_stats_buf->last_non_zeros_min);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_avg %u",
-			   htt_stats_buf->last_non_zeros_avg);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_non_zeros_sample %u\n",
-			   htt_stats_buf->last_non_zeros_sample);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_REO_RESOURCE_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "sample_id = %u\n",
+			 htt_stats_buf->sample_id);
+	len += scnprintf(buf + len, buf_len - len, "total_max = %u\n",
+			 htt_stats_buf->total_max);
+	len += scnprintf(buf + len, buf_len - len, "total_avg = %u\n",
+			 htt_stats_buf->total_avg);
+	len += scnprintf(buf + len, buf_len - len, "total_sample = %u\n",
+			 htt_stats_buf->total_sample);
+	len += scnprintf(buf + len, buf_len - len, "non_zeros_avg = %u\n",
+			 htt_stats_buf->non_zeros_avg);
+	len += scnprintf(buf + len, buf_len - len, "non_zeros_sample = %u\n",
+			 htt_stats_buf->non_zeros_sample);
+	len += scnprintf(buf + len, buf_len - len, "last_non_zeros_max = %u\n",
+			 htt_stats_buf->last_non_zeros_max);
+	len += scnprintf(buf + len, buf_len - len, "last_non_zeros_min %u\n",
+			 htt_stats_buf->last_non_zeros_min);
+	len += scnprintf(buf + len, buf_len - len, "last_non_zeros_avg %u\n",
+			 htt_stats_buf->last_non_zeros_avg);
+	len += scnprintf(buf + len, buf_len - len, "last_non_zeros_sample %u\n\n",
+			 htt_stats_buf->last_non_zeros_sample);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3444,14 +3440,14 @@ htt_print_rx_soc_fw_refill_ring_num_refill_tlv_v(const void *tag_buf,
 	char refill_ring_num_refill[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(refill_ring_num_refill,
 			   htt_stats_buf->refill_ring_num_refill,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "refill_ring_num_refill = %s\n",
-			   refill_ring_num_refill);
+	len += scnprintf(buf + len, buf_len - len, "refill_ring_num_refill = %s\n\n",
+			 refill_ring_num_refill);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3471,110 +3467,110 @@ static inline void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf,
 	char fw_ring_mgmt_subtype[HTT_MAX_STRING_LEN] = {0};
 	char fw_ring_ctrl_subtype[HTT_MAX_STRING_LEN] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ppdu_recvd = %u",
-			   htt_stats_buf->ppdu_recvd);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt_fcs_ok = %u",
-			   htt_stats_buf->mpdu_cnt_fcs_ok);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mpdu_cnt_fcs_err = %u",
-			   htt_stats_buf->mpdu_cnt_fcs_err);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcp_msdu_cnt = %u",
-			   htt_stats_buf->tcp_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "tcp_ack_msdu_cnt = %u",
-			   htt_stats_buf->tcp_ack_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "udp_msdu_cnt = %u",
-			   htt_stats_buf->udp_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "other_msdu_cnt = %u",
-			   htt_stats_buf->other_msdu_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u",
-			   htt_stats_buf->fw_ring_mpdu_ind);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "ppdu_recvd = %u\n",
+			 htt_stats_buf->ppdu_recvd);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt_fcs_ok = %u\n",
+			 htt_stats_buf->mpdu_cnt_fcs_ok);
+	len += scnprintf(buf + len, buf_len - len, "mpdu_cnt_fcs_err = %u\n",
+			 htt_stats_buf->mpdu_cnt_fcs_err);
+	len += scnprintf(buf + len, buf_len - len, "tcp_msdu_cnt = %u\n",
+			 htt_stats_buf->tcp_msdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "tcp_ack_msdu_cnt = %u\n",
+			 htt_stats_buf->tcp_ack_msdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "udp_msdu_cnt = %u\n",
+			 htt_stats_buf->udp_msdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "other_msdu_cnt = %u\n",
+			 htt_stats_buf->other_msdu_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u\n",
+			 htt_stats_buf->fw_ring_mpdu_ind);
 
 	PRINT_ARRAY_TO_BUF(fw_ring_mgmt_subtype,
 			   htt_stats_buf->fw_ring_mgmt_subtype,
 			   HTT_STATS_SUBTYPE_MAX);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mgmt_subtype = %s ",
-			   fw_ring_mgmt_subtype);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mgmt_subtype = %s\n",
+			 fw_ring_mgmt_subtype);
 
 	PRINT_ARRAY_TO_BUF(fw_ring_ctrl_subtype,
 			   htt_stats_buf->fw_ring_ctrl_subtype,
 			   HTT_STATS_SUBTYPE_MAX);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_ctrl_subtype = %s ",
-			   fw_ring_ctrl_subtype);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u",
-			   htt_stats_buf->fw_ring_mcast_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_bcast_data_msdu = %u",
-			   htt_stats_buf->fw_ring_bcast_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_ucast_data_msdu = %u",
-			   htt_stats_buf->fw_ring_ucast_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_null_data_msdu = %u",
-			   htt_stats_buf->fw_ring_null_data_msdu);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_drop = %u",
-			   htt_stats_buf->fw_ring_mpdu_drop);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "ofld_local_data_ind_cnt = %u",
-			   htt_stats_buf->ofld_local_data_ind_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "ofld_local_data_buf_recycle_cnt = %u",
-			   htt_stats_buf->ofld_local_data_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "drx_local_data_ind_cnt = %u",
-			   htt_stats_buf->drx_local_data_ind_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "drx_local_data_buf_recycle_cnt = %u",
-			   htt_stats_buf->drx_local_data_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_nondata_ind_cnt = %u",
-			   htt_stats_buf->local_nondata_ind_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "local_nondata_buf_recycle_cnt = %u",
-			   htt_stats_buf->local_nondata_buf_recycle_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_status_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->fw_status_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_status_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->fw_status_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_pkt_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->fw_pkt_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_pkt_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->fw_pkt_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_link_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->fw_link_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_link_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->fw_link_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_pkt_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->host_pkt_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "host_pkt_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->host_pkt_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_pkt_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->mon_pkt_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_pkt_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->mon_pkt_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "mon_status_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->mon_status_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_status_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->mon_status_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_desc_buf_ring_refill_cnt = %u",
-			   htt_stats_buf->mon_desc_buf_ring_refill_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_desc_buf_ring_empty_cnt = %u",
-			   htt_stats_buf->mon_desc_buf_ring_empty_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_dest_ring_update_cnt = %u",
-			   htt_stats_buf->mon_dest_ring_update_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mon_dest_ring_full_cnt = %u",
-			   htt_stats_buf->mon_dest_ring_full_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_suspend_cnt = %u",
-			   htt_stats_buf->rx_suspend_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_suspend_fail_cnt = %u",
-			   htt_stats_buf->rx_suspend_fail_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_resume_cnt = %u",
-			   htt_stats_buf->rx_resume_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_resume_fail_cnt = %u",
-			   htt_stats_buf->rx_resume_fail_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ring_switch_cnt = %u",
-			   htt_stats_buf->rx_ring_switch_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_ring_restore_cnt = %u",
-			   htt_stats_buf->rx_ring_restore_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_flush_cnt = %u",
-			   htt_stats_buf->rx_flush_cnt);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "rx_recovery_reset_cnt = %u\n",
-			   htt_stats_buf->rx_recovery_reset_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_ctrl_subtype = %s\n",
+			 fw_ring_ctrl_subtype);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u\n",
+			 htt_stats_buf->fw_ring_mcast_data_msdu);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_bcast_data_msdu = %u\n",
+			 htt_stats_buf->fw_ring_bcast_data_msdu);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_ucast_data_msdu = %u\n",
+			 htt_stats_buf->fw_ring_ucast_data_msdu);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_null_data_msdu = %u\n",
+			 htt_stats_buf->fw_ring_null_data_msdu);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_drop = %u\n",
+			 htt_stats_buf->fw_ring_mpdu_drop);
+	len += scnprintf(buf + len, buf_len - len, "ofld_local_data_ind_cnt = %u\n",
+			 htt_stats_buf->ofld_local_data_ind_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			 "ofld_local_data_buf_recycle_cnt = %u\n",
+			 htt_stats_buf->ofld_local_data_buf_recycle_cnt);
+	len += scnprintf(buf + len, buf_len - len, "drx_local_data_ind_cnt = %u\n",
+			 htt_stats_buf->drx_local_data_ind_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			 "drx_local_data_buf_recycle_cnt = %u\n",
+			 htt_stats_buf->drx_local_data_buf_recycle_cnt);
+	len += scnprintf(buf + len, buf_len - len, "local_nondata_ind_cnt = %u\n",
+			 htt_stats_buf->local_nondata_ind_cnt);
+	len += scnprintf(buf + len, buf_len - len, "local_nondata_buf_recycle_cnt = %u\n",
+			 htt_stats_buf->local_nondata_buf_recycle_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_status_buf_ring_refill_cnt = %u\n",
+			 htt_stats_buf->fw_status_buf_ring_refill_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_status_buf_ring_empty_cnt = %u\n",
+			 htt_stats_buf->fw_status_buf_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_pkt_buf_ring_refill_cnt = %u\n",
+			 htt_stats_buf->fw_pkt_buf_ring_refill_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_pkt_buf_ring_empty_cnt = %u\n",
+			 htt_stats_buf->fw_pkt_buf_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_link_buf_ring_refill_cnt = %u\n",
+			 htt_stats_buf->fw_link_buf_ring_refill_cnt);
+	len += scnprintf(buf + len, buf_len - len, "fw_link_buf_ring_empty_cnt = %u\n",
+			 htt_stats_buf->fw_link_buf_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len, "host_pkt_buf_ring_refill_cnt = %u\n",
+			 htt_stats_buf->host_pkt_buf_ring_refill_cnt);
+	len += scnprintf(buf + len, buf_len - len, "host_pkt_buf_ring_empty_cnt = %u\n",
+			 htt_stats_buf->host_pkt_buf_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mon_pkt_buf_ring_refill_cnt = %u\n",
+			 htt_stats_buf->mon_pkt_buf_ring_refill_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mon_pkt_buf_ring_empty_cnt = %u\n",
+			 htt_stats_buf->mon_pkt_buf_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len,
+			 "mon_status_buf_ring_refill_cnt = %u\n",
+			 htt_stats_buf->mon_status_buf_ring_refill_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mon_status_buf_ring_empty_cnt = %u\n",
+			 htt_stats_buf->mon_status_buf_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mon_desc_buf_ring_refill_cnt = %u\n",
+			 htt_stats_buf->mon_desc_buf_ring_refill_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mon_desc_buf_ring_empty_cnt = %u\n",
+			 htt_stats_buf->mon_desc_buf_ring_empty_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mon_dest_ring_update_cnt = %u\n",
+			 htt_stats_buf->mon_dest_ring_update_cnt);
+	len += scnprintf(buf + len, buf_len - len, "mon_dest_ring_full_cnt = %u\n",
+			 htt_stats_buf->mon_dest_ring_full_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_suspend_cnt = %u\n",
+			 htt_stats_buf->rx_suspend_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_suspend_fail_cnt = %u\n",
+			 htt_stats_buf->rx_suspend_fail_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_resume_cnt = %u\n",
+			 htt_stats_buf->rx_resume_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_resume_fail_cnt = %u\n",
+			 htt_stats_buf->rx_resume_fail_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_ring_switch_cnt = %u\n",
+			 htt_stats_buf->rx_ring_switch_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_ring_restore_cnt = %u\n",
+			 htt_stats_buf->rx_ring_restore_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_flush_cnt = %u\n",
+			 htt_stats_buf->rx_flush_cnt);
+	len += scnprintf(buf + len, buf_len - len, "rx_recovery_reset_cnt = %u\n\n",
+			 htt_stats_buf->rx_recovery_reset_cnt);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3594,14 +3590,14 @@ htt_print_rx_pdev_fw_ring_mpdu_err_tlv_v(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char fw_ring_mpdu_err[HTT_MAX_STRING_LEN] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(fw_ring_mpdu_err,
 			   htt_stats_buf->fw_ring_mpdu_err,
 			   HTT_RX_STATS_RXDMA_MAX_ERR);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_ring_mpdu_err = %s\n",
-			   fw_ring_mpdu_err);
+	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_err = %s\n\n",
+			 fw_ring_mpdu_err);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3623,12 +3619,12 @@ htt_print_rx_pdev_fw_mpdu_drop_tlv_v(const void *tag_buf,
 	char fw_mpdu_drop[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_FW_DROP_REASON_MAX);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_MPDU_DROP_TLV_V:");
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_MPDU_DROP_TLV_V:\n");
 
 	PRINT_ARRAY_TO_BUF(fw_mpdu_drop,
 			   htt_stats_buf->fw_mpdu_drop,
 			   num_elems);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "fw_mpdu_drop = %s\n", fw_mpdu_drop);
+	len += scnprintf(buf + len, buf_len - len, "fw_mpdu_drop = %s\n\n", fw_mpdu_drop);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3648,16 +3644,16 @@ htt_print_rx_pdev_fw_stats_phy_err_tlv(const void *tag_buf,
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	char phy_errs[HTT_MAX_STRING_LEN] = {0};
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_PHY_ERR_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id__word = %u",
-			   htt_stats_buf->mac_id__word);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "total_phy_err_nct = %u",
-			   htt_stats_buf->total_phy_err_cnt);
+	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_PHY_ERR_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id__word = %u\n",
+			 htt_stats_buf->mac_id__word);
+	len += scnprintf(buf + len, buf_len - len, "total_phy_err_nct = %u\n",
+			 htt_stats_buf->total_phy_err_cnt);
 
 	PRINT_ARRAY_TO_BUF(phy_errs,
 			   htt_stats_buf->phy_err,
 			   HTT_STATS_PHY_ERR_MAX);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "phy_errs = %s\n", phy_errs);
+	len += scnprintf(buf + len, buf_len - len, "phy_errs = %s\n\n", phy_errs);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3676,20 +3672,20 @@ htt_print_pdev_cca_stats_hist_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "\nHTT_PDEV_CCA_STATS_HIST_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "chan_num = %u",
-			   htt_stats_buf->chan_num);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_records = %u",
-			   htt_stats_buf->num_records);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "valid_cca_counters_bitmap = 0x%x",
-			   htt_stats_buf->valid_cca_counters_bitmap);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "collection_interval = %u\n",
-			   htt_stats_buf->collection_interval);
-
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)");
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "|  tx_frame|   rx_frame|   rx_clear| my_rx_frame|        cnt| med_rx_idle| med_tx_idle_global|   cca_obss|");
+	len += scnprintf(buf + len, buf_len - len, "\nHTT_PDEV_CCA_STATS_HIST_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "chan_num = %u\n",
+			 htt_stats_buf->chan_num);
+	len += scnprintf(buf + len, buf_len - len, "num_records = %u\n",
+			 htt_stats_buf->num_records);
+	len += scnprintf(buf + len, buf_len - len, "valid_cca_counters_bitmap = 0x%x\n",
+			 htt_stats_buf->valid_cca_counters_bitmap);
+	len += scnprintf(buf + len, buf_len - len, "collection_interval = %u\n\n",
+			 htt_stats_buf->collection_interval);
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_PDEV_STATS_CCA_COUNTERS_TLV:(in usec)\n");
+	len += scnprintf(buf + len, buf_len - len,
+			 "|  tx_frame|   rx_frame|   rx_clear| my_rx_frame|        cnt| med_rx_idle| med_tx_idle_global|   cca_obss|\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3708,16 +3704,16 @@ htt_print_pdev_stats_cca_counters_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "|%10u| %10u| %10u| %11u| %10u| %11u| %18u| %10u|",
-			   htt_stats_buf->tx_frame_usec,
-			   htt_stats_buf->rx_frame_usec,
-			   htt_stats_buf->rx_clear_usec,
-			   htt_stats_buf->my_rx_frame_usec,
-			   htt_stats_buf->usec_cnt,
-			   htt_stats_buf->med_rx_idle_usec,
-			   htt_stats_buf->med_tx_idle_global_usec,
-			   htt_stats_buf->cca_obss_usec);
+	len += scnprintf(buf + len, buf_len - len,
+			 "|%10u| %10u| %10u| %11u| %10u| %11u| %18u| %10u|\n",
+			 htt_stats_buf->tx_frame_usec,
+			 htt_stats_buf->rx_frame_usec,
+			 htt_stats_buf->rx_clear_usec,
+			 htt_stats_buf->my_rx_frame_usec,
+			 htt_stats_buf->usec_cnt,
+			 htt_stats_buf->med_rx_idle_usec,
+			 htt_stats_buf->med_tx_idle_global_usec,
+			 htt_stats_buf->cca_obss_usec);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3735,32 +3731,32 @@ static inline void htt_print_hw_stats_whal_tx_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_HW_STATS_WHAL_TX_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "mac_id = %u",
-			   htt_stats_buf->mac_id__word & 0xFF);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "last_unpause_ppdu_id = %u",
-			   htt_stats_buf->last_unpause_ppdu_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_unpause_wait_tqm_write = %u",
-			   htt_stats_buf->hwsch_unpause_wait_tqm_write);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_dummy_tlv_skipped = %u",
-			   htt_stats_buf->hwsch_dummy_tlv_skipped);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "hwsch_misaligned_offset_received = %u",
-			   htt_stats_buf->hwsch_misaligned_offset_received);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_reset_count = %u",
-			   htt_stats_buf->hwsch_reset_count);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_dev_reset_war = %u",
-			   htt_stats_buf->hwsch_dev_reset_war);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_delayed_pause = %u",
-			   htt_stats_buf->hwsch_delayed_pause);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "hwsch_long_delayed_pause = %u",
-			   htt_stats_buf->hwsch_long_delayed_pause);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_rx_ppdu_no_response = %u",
-			   htt_stats_buf->sch_rx_ppdu_no_response);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_selfgen_response = %u",
-			   htt_stats_buf->sch_selfgen_response);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sch_rx_sifs_resp_trigger= %u\n",
-			   htt_stats_buf->sch_rx_sifs_resp_trigger);
+	len += scnprintf(buf + len, buf_len - len, "HTT_HW_STATS_WHAL_TX_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
+			 htt_stats_buf->mac_id__word & 0xFF);
+	len += scnprintf(buf + len, buf_len - len, "last_unpause_ppdu_id = %u\n",
+			 htt_stats_buf->last_unpause_ppdu_id);
+	len += scnprintf(buf + len, buf_len - len, "hwsch_unpause_wait_tqm_write = %u\n",
+			 htt_stats_buf->hwsch_unpause_wait_tqm_write);
+	len += scnprintf(buf + len, buf_len - len, "hwsch_dummy_tlv_skipped = %u\n",
+			 htt_stats_buf->hwsch_dummy_tlv_skipped);
+	len += scnprintf(buf + len, buf_len - len,
+			 "hwsch_misaligned_offset_received = %u\n",
+			 htt_stats_buf->hwsch_misaligned_offset_received);
+	len += scnprintf(buf + len, buf_len - len, "hwsch_reset_count = %u\n",
+			 htt_stats_buf->hwsch_reset_count);
+	len += scnprintf(buf + len, buf_len - len, "hwsch_dev_reset_war = %u\n",
+			 htt_stats_buf->hwsch_dev_reset_war);
+	len += scnprintf(buf + len, buf_len - len, "hwsch_delayed_pause = %u\n",
+			 htt_stats_buf->hwsch_delayed_pause);
+	len += scnprintf(buf + len, buf_len - len, "hwsch_long_delayed_pause = %u\n",
+			 htt_stats_buf->hwsch_long_delayed_pause);
+	len += scnprintf(buf + len, buf_len - len, "sch_rx_ppdu_no_response = %u\n",
+			 htt_stats_buf->sch_rx_ppdu_no_response);
+	len += scnprintf(buf + len, buf_len - len, "sch_selfgen_response = %u\n",
+			 htt_stats_buf->sch_selfgen_response);
+	len += scnprintf(buf + len, buf_len - len, "sch_rx_sifs_resp_trigger= %u\n\n",
+			 htt_stats_buf->sch_rx_sifs_resp_trigger);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3779,11 +3775,11 @@ htt_print_pdev_stats_twt_sessions_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSIONS_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
-			   htt_stats_buf->pdev_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_sessions = %u\n",
-			   htt_stats_buf->num_sessions);
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSIONS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 htt_stats_buf->pdev_id);
+	len += scnprintf(buf + len, buf_len - len, "num_sessions = %u\n\n",
+			 htt_stats_buf->num_sessions);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3802,27 +3798,27 @@ htt_print_pdev_stats_twt_session_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSION_TLV:");
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "vdev_id = %u",
-			   htt_stats_buf->vdev_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "peer_mac = %02x:%02x:%02x:%02x:%02x:%02x",
-			   htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF,
-			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF00) >> 8,
-			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF0000) >> 16,
-			   (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF000000) >> 24,
-			   (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF),
-			   (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF00) >> 8);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "flow_id_flags = %u",
-			   htt_stats_buf->flow_id_flags);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "dialog_id = %u",
-			   htt_stats_buf->dialog_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wake_dura_us = %u",
-			   htt_stats_buf->wake_dura_us);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "wake_intvl_us = %u",
-			   htt_stats_buf->wake_intvl_us);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "sp_offset_us = %u\n",
-			   htt_stats_buf->sp_offset_us);
+	len += scnprintf(buf + len, buf_len - len, "HTT_PDEV_STATS_TWT_SESSION_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "vdev_id = %u\n",
+			 htt_stats_buf->vdev_id);
+	len += scnprintf(buf + len, buf_len - len,
+			 "peer_mac = %02x:%02x:%02x:%02x:%02x:%02x\n",
+			 htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF,
+			 (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF00) >> 8,
+			 (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF0000) >> 16,
+			 (htt_stats_buf->peer_mac.mac_addr_l32 & 0xFF000000) >> 24,
+			 (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF),
+			 (htt_stats_buf->peer_mac.mac_addr_h16 & 0xFF00) >> 8);
+	len += scnprintf(buf + len, buf_len - len, "flow_id_flags = %u\n",
+			 htt_stats_buf->flow_id_flags);
+	len += scnprintf(buf + len, buf_len - len, "dialog_id = %u\n",
+			 htt_stats_buf->dialog_id);
+	len += scnprintf(buf + len, buf_len - len, "wake_dura_us = %u\n",
+			 htt_stats_buf->wake_dura_us);
+	len += scnprintf(buf + len, buf_len - len, "wake_intvl_us = %u\n",
+			 htt_stats_buf->wake_intvl_us);
+	len += scnprintf(buf + len, buf_len - len, "sp_offset_us = %u\n\n",
+			 htt_stats_buf->sp_offset_us);
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3841,21 +3837,21 @@ htt_print_pdev_obss_pd_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "OBSS Tx success PPDU = %u",
+	len += scnprintf(buf + len, buf_len - len, "OBSS Tx success PPDU = %u\n",
 			   htt_stats_buf->num_obss_tx_ppdu_success);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "OBSS Tx failures PPDU = %u\n",
+	len += scnprintf(buf + len, buf_len - len, "OBSS Tx failures PPDU = %u\n",
 			   htt_stats_buf->num_obss_tx_ppdu_failure);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "Non-SRG Opportunities = %u\n",
+	len += scnprintf(buf + len, buf_len - len, "Non-SRG Opportunities = %u\n",
 			   htt_stats_buf->num_non_srg_opportunities);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "Non-SRG tried PPDU = %u\n",
+	len += scnprintf(buf + len, buf_len - len, "Non-SRG tried PPDU = %u\n",
 			   htt_stats_buf->num_non_srg_ppdu_tried);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "Non-SRG success PPDU = %u\n",
+	len += scnprintf(buf + len, buf_len - len, "Non-SRG success PPDU = %u\n",
 			   htt_stats_buf->num_non_srg_ppdu_success);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "SRG Opportunities = %u\n",
+	len += scnprintf(buf + len, buf_len - len, "SRG Opportunities = %u\n",
 			   htt_stats_buf->num_srg_opportunities);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "SRG tried PPDU = %u\n",
+	len += scnprintf(buf + len, buf_len - len, "SRG tried PPDU = %u\n",
 			   htt_stats_buf->num_srg_ppdu_tried);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "SRG success PPDU = %u\n",
+	len += scnprintf(buf + len, buf_len - len, "SRG success PPDU = %u\n\n",
 			   htt_stats_buf->num_srg_ppdu_success);
 
 	if (len >= buf_len)
@@ -3878,25 +3874,25 @@ static inline void htt_print_backpressure_stats_tlv_v(const u32 *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "pdev_id = %u",
-			   htt_stats_buf->pdev_id);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_head_idx = %u",
-			   htt_stats_buf->current_head_idx);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "current_tail_idx = %u",
-			   htt_stats_buf->current_tail_idx);
-	len += HTT_DBG_OUT(buf + len, buf_len - len, "num_htt_msgs_sent = %u",
-			   htt_stats_buf->num_htt_msgs_sent);
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "backpressure_time_ms = %u",
-			   htt_stats_buf->backpressure_time_ms);
+	len += scnprintf(buf + len, buf_len - len, "pdev_id = %u\n",
+			 htt_stats_buf->pdev_id);
+	len += scnprintf(buf + len, buf_len - len, "current_head_idx = %u\n",
+			 htt_stats_buf->current_head_idx);
+	len += scnprintf(buf + len, buf_len - len, "current_tail_idx = %u\n",
+			 htt_stats_buf->current_tail_idx);
+	len += scnprintf(buf + len, buf_len - len, "num_htt_msgs_sent = %u\n",
+			 htt_stats_buf->num_htt_msgs_sent);
+	len += scnprintf(buf + len, buf_len - len,
+			 "backpressure_time_ms = %u\n",
+			 htt_stats_buf->backpressure_time_ms);
 
 	for (i = 0; i < 5; i++)
-		len += HTT_DBG_OUT(buf + len, buf_len - len,
-				   "backpressure_hist_%u = %u",
-				   i + 1, htt_stats_buf->backpressure_hist[i]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "backpressure_hist_%u = %u\n",
+				 i + 1, htt_stats_buf->backpressure_hist[i]);
 
-	len += HTT_DBG_OUT(buf + len, buf_len - len,
-			   "============================");
+	len += scnprintf(buf + len, buf_len - len,
+			 "============================\n");
 
 	if (len >= buf_len) {
 		buf[buf_len - 1] = 0;
-- 
2.25.1

