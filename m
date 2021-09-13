Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28263409FB3
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Sep 2021 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244993AbhIMWds (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 18:33:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47475 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245114AbhIMWdn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 18:33:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631572347; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bzKE3tqyaYk5FiqULmXRxJQJs0xi6I3xo4D4qOErwis=; b=hk4nxRnQ0Rby/Uq6ACXfQj5MDjwNw12QKwPP7IOoWm11anh94aD3e6y11HtGV+QTDCAzwAuW
 DLcyiJsL+VzUDl5Heu2giL+79e2oFHmW7sm8FIzLuE2w+6b/P7e6aMkcaprqM7UJ7eRLF1hY
 vtrXSxVRz73TZ/lSgsOwXZrpzH0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 613fd17abd6681d8ed55c704 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 22:32:26
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E192EC43617; Mon, 13 Sep 2021 22:32:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B0C83C43460;
        Mon, 13 Sep 2021 22:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B0C83C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 3/5] ath11k: Remove htt stats fixed size array usage
Date:   Tue, 14 Sep 2021 01:31:46 +0300
Message-Id: <20210913223148.208026-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913223148.208026-1-jouni@codeaurora.org>
References: <20210913223148.208026-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

To support the HTT Stats DebugFS interface a single large buffer that
contains the stats must be provided to the DebugFS infrastructure.
In the current code, for each class of stats, the stats are first
formatted in a local on-stack buffer, and then the local buffer is
copied to the large DebugFS buffer.

This logic has a problem when, for a given class, the formatted
stats exceed the size of the on-stack buffer. When this occurs the
stats for this class is truncated. In addition, this logic is
inefficient since it introduces an unnecessary memory copy.

To address these issues, update the logic to no longer use a local
on-stack buffer, and instead write the formatted data directly into
the large DebugFS buffer.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01105-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 838 ++++++------------
 1 file changed, 264 insertions(+), 574 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index efd7f0757df6..fb686793929f 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -10,20 +10,28 @@
 #include "debug.h"
 #include "debugfs_htt_stats.h"
 
-#define HTT_MAX_STRING_LEN 256
 #define HTT_MAX_PRINT_CHAR_PER_ELEM 15
 
 #define HTT_TLV_HDR_LEN 4
 
-#define PRINT_ARRAY_TO_BUF(out, arr, len)						\
+#define PRINT_ARRAY_TO_BUF(out, buflen, arr, str, len, newline)				\
 	do {										\
-		int index = 0; u8 i;							\
+		int index = 0; u8 i; const char *str_val = str;				\
+		const char *new_line = newline;						\
+		if (str_val) {								\
+			index += scnprintf((out + buflen),				\
+				 (ATH11K_HTT_STATS_BUF_SIZE - buflen),			\
+				 "%s = ", str_val);					\
+		}									\
 		for (i = 0; i < len; i++) {						\
-			index += scnprintf(out + index, HTT_MAX_STRING_LEN - index,	\
-					  " %u:%u,", i, arr[i]);			\
-			if (index < 0 || index >= HTT_MAX_STRING_LEN)			\
-				break;							\
+			index += scnprintf((out + buflen) + index,			\
+				 (ATH11K_HTT_STATS_BUF_SIZE - buflen) - index,		\
+				 " %u:%u,", i, arr[i]);					\
 		}									\
+		index += scnprintf((out + buflen) + index,				\
+			 (ATH11K_HTT_STATS_BUF_SIZE - buflen) - index,			\
+			  "%s", new_line);						\
+		buflen += index;							\
 	} while (0)
 
 static inline void htt_print_stats_string_tlv(const void *tag_buf,
@@ -35,22 +43,20 @@ static inline void htt_print_stats_string_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u8  i;
-	u16 index = 0;
-	char data[HTT_MAX_STRING_LEN] = {0};
 
 	tag_len = tag_len >> 2;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_STATS_STRING_TLV:\n");
 
+	len += scnprintf(buf + len, buf_len - len,
+			 "data = ");
 	for (i = 0; i < tag_len; i++) {
-		index += scnprintf(&data[index],
-				   HTT_MAX_STRING_LEN - index,
-				   "%.*s", 4, (char *)&(htt_stats_buf->data[i]));
-		if (index >= HTT_MAX_STRING_LEN)
-			break;
+		len += scnprintf(buf + len,
+				 buf_len - len,
+				 "%.*s", 4, (char *)&(htt_stats_buf->data[i]));
 	}
-
-	len += scnprintf(buf + len, buf_len - len, "data = %s\n\n", data);
+	/* New lines are added for better display */
+	len += scnprintf(buf + len, buf_len - len, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -187,13 +193,12 @@ htt_print_tx_pdev_stats_urrn_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char urrn_stats[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_URRN_STATS);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_URRN_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(urrn_stats, htt_stats_buf->urrn_stats, num_elems);
-	len += scnprintf(buf + len, buf_len - len, "urrn_stats = %s\n\n", urrn_stats);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->urrn_stats, "urrn_stats",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -212,13 +217,12 @@ htt_print_tx_pdev_stats_flush_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char flush_errs[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_FLUSH_REASON_STATS);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_FLUSH_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(flush_errs, htt_stats_buf->flush_errs, num_elems);
-	len += scnprintf(buf + len, buf_len - len, "flush_errs = %s\n\n", flush_errs);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->flush_errs, "flush_errs",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -237,14 +241,12 @@ htt_print_tx_pdev_stats_sifs_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sifs_status[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_STATS);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_SIFS_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(sifs_status, htt_stats_buf->sifs_status, num_elems);
-	len += scnprintf(buf + len, buf_len - len, "sifs_status = %s\n\n",
-			 sifs_status);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->sifs_status, "sifs_status",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -263,13 +265,12 @@ htt_print_tx_pdev_stats_phy_err_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char phy_errs[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_PHY_ERR_STATS);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_STATS_PHY_ERR_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(phy_errs, htt_stats_buf->phy_errs, num_elems);
-	len += scnprintf(buf + len, buf_len - len, "phy_errs = %s\n\n", phy_errs);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->phy_errs, "phy_errs",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -288,15 +289,13 @@ htt_print_tx_pdev_stats_sifs_hist_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sifs_hist_status[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_MAX_SIFS_BURST_HIST_STATS);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_PDEV_STATS_SIFS_HIST_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(sifs_hist_status, htt_stats_buf->sifs_hist_status, num_elems);
-	len += scnprintf(buf + len, buf_len - len, "sifs_hist_status = %s\n\n",
-			 sifs_hist_status);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->sifs_hist_status,
+			   "sifs_hist_status", num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -350,25 +349,15 @@ htt_print_tx_pdev_stats_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tried_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
 	u32  num_elements = ((tag_len - sizeof(htt_stats_buf->hist_bin_size)) >> 2);
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_PDEV_STATS_TRIED_MPDU_CNT_HIST_TLV_V:\n");
 	len += scnprintf(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u\n",
 			 htt_stats_buf->hist_bin_size);
 
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		PRINT_ARRAY_TO_BUF(tried_mpdu_cnt_hist,
-				   htt_stats_buf->tried_mpdu_cnt_hist,
-				   num_elements);
-		len += scnprintf(buf + len, buf_len - len, "tried_mpdu_cnt_hist = %s\n\n",
-				 tried_mpdu_cnt_hist);
-	} else {
-		len += scnprintf(buf + len, buf_len - len,
-				 "INSUFFICIENT PRINT BUFFER\n\n");
-	}
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tried_mpdu_cnt_hist,
+			   "tried_mpdu_cnt_hist", num_elements, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -659,14 +648,12 @@ static inline void htt_print_counter_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char counter_name[HTT_MAX_STRING_LEN] = {0};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_COUNTER_TLV:\n");
 
-	PRINT_ARRAY_TO_BUF(counter_name,
-			   htt_stats_buf->counter_name,
-			   HTT_MAX_COUNTER_NAME);
-	len += scnprintf(buf + len, buf_len - len, "counter_name = %s\n", counter_name);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->counter_name,
+			   "counter_name",
+			   HTT_MAX_COUNTER_NAME, "\n");
 	len += scnprintf(buf + len, buf_len - len, "count = %u\n\n",
 			 htt_stats_buf->count);
 
@@ -771,16 +758,8 @@ static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-	char *tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
 	u8 j;
 
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		tx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!tx_gi[j])
-			goto fail;
-	}
-
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PEER_RATE_STATS_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "tx_ldpc = %u\n",
 			 htt_stats_buf->tx_ldpc);
@@ -789,56 +768,30 @@ static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "ack_rssi = %u\n",
 			 htt_stats_buf->ack_rssi);
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mcs,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_su_mcs,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_su_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mu_mcs,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_mu_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf,
-			   htt_stats_buf->tx_nss,
-			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "tx_nss = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf,
-			   htt_stats_buf->tx_bw,
-			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_bw = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_stbc,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_stbc = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_pream,
-			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += scnprintf(buf + len, buf_len - len, "tx_pream = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_mcs, "tx_mcs",
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_su_mcs, "tx_su_mcs",
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_mu_mcs, "tx_mu_mcs",
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_nss, "tx_nss",
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_bw, "tx_bw",
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_stbc, "tx_stbc",
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_pream, "tx_pream",
+			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
 
 	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(tx_gi[j],
-				   htt_stats_buf->tx_gi[j],
-				   HTT_TX_PEER_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "tx_gi[%u] = %s\n",
-				 j, tx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "tx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_gi[j], NULL,
+				   HTT_TX_PEER_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf,
-			   htt_stats_buf->tx_dcm,
-			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_dcm = %s\n\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_dcm, "tx_dcm",
+			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -847,9 +800,6 @@ static inline void htt_print_tx_peer_rate_stats_tlv(const void *tag_buf,
 
 	stats_req->buf_len = len;
 
-fail:
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++)
-		kfree(tx_gi[j]);
 }
 
 static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
@@ -860,21 +810,6 @@ static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u8 j;
-	char *rssi_chain[HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS] = {NULL};
-	char *rx_gi[HTT_RX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
-		rssi_chain[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rssi_chain[j])
-			goto fail;
-	}
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		rx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rx_gi[j])
-			goto fail;
-	}
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PEER_RATE_STATS_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "nsts = %u\n",
@@ -890,49 +825,33 @@ static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "rssi_comb = %u\n",
 			 htt_stats_buf->rssi_comb);
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_mcs,
-			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_nss,
-			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "rx_nss = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_dcm,
-			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_dcm = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_stbc,
-			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_stbc = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_bw,
-			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_bw = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_mcs, "rx_mcs",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_nss, "rx_nss",
+			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_dcm, "rx_dcm",
+			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_stbc, "rx_stbc",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_bw, "rx_bw",
+			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
 
 	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++) {
-		PRINT_ARRAY_TO_BUF(rssi_chain[j], htt_stats_buf->rssi_chain[j],
-				   HTT_RX_PEER_STATS_NUM_BW_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "rssi_chain[%u] = %s\n",
-				 j, rssi_chain[j]);
+		len += scnprintf(buf + len, (buf_len - len),
+				 "rssi_chain[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rssi_chain[j], NULL,
+				   HTT_RX_PEER_STATS_NUM_BW_COUNTERS, "\n");
 	}
 
 	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->rx_gi[j],
-				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "rx_gi[%u] = %s\n",
-				 j, rx_gi[j]);
+		len += scnprintf(buf + len, (buf_len - len),
+				 "rx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_gi[j], NULL,
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_pream,
-			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += scnprintf(buf + len, buf_len - len, "rx_pream = %s\n\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_pream, "rx_pream",
+			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -940,13 +859,6 @@ static inline void htt_print_rx_peer_rate_stats_tlv(const void *tag_buf,
 		buf[len] = 0;
 
 	stats_req->buf_len = len;
-
-fail:
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_SPATIAL_STREAMS; j++)
-		kfree(rssi_chain[j]);
-
-	for (j = 0; j < HTT_RX_PEER_STATS_NUM_GI_COUNTERS; j++)
-		kfree(rx_gi[j]);
 }
 
 static inline void
@@ -1104,17 +1016,14 @@ htt_print_tx_hwq_difs_latency_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u16 data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_DIFS_LATENCY_BINS);
-	char difs_latency_hist[HTT_MAX_STRING_LEN] = {0};
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_HWQ_DIFS_LATENCY_STATS_TLV_V:\n");
 	len += scnprintf(buf + len, buf_len - len, "hist_intvl = %u\n",
 			 htt_stats_buf->hist_intvl);
 
-	PRINT_ARRAY_TO_BUF(difs_latency_hist, htt_stats_buf->difs_latency_hist,
-			   data_len);
-	len += scnprintf(buf + len, buf_len - len, "difs_latency_hist = %s\n\n",
-			 difs_latency_hist);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->difs_latency_hist,
+			   "difs_latency_hist", data_len, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1134,16 +1043,14 @@ htt_print_tx_hwq_cmd_result_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u16 data_len;
-	char cmd_result[HTT_MAX_STRING_LEN] = {0};
 
 	data_len = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_RESULT_STATS);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_HWQ_CMD_RESULT_STATS_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(cmd_result, htt_stats_buf->cmd_result, data_len);
-
-	len += scnprintf(buf + len, buf_len - len, "cmd_result = %s\n\n", cmd_result);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->cmd_result, "cmd_result",
+			   data_len, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1163,15 +1070,13 @@ htt_print_tx_hwq_cmd_stall_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u16 num_elems;
-	char cmd_stall_status[HTT_MAX_STRING_LEN] = {0};
 
 	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_CMD_STALL_STATS);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_HWQ_CMD_STALL_STATS_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(cmd_stall_status, htt_stats_buf->cmd_stall_status, num_elems);
-	len += scnprintf(buf + len, buf_len - len, "cmd_stall_status = %s\n\n",
-			 cmd_stall_status);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->cmd_stall_status,
+			   "cmd_stall_status", num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1191,15 +1096,14 @@ htt_print_tx_hwq_fes_result_stats_tlv_v(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u16 num_elems;
-	char fes_result[HTT_MAX_STRING_LEN] = {0};
 
 	num_elems = min_t(u16, (tag_len >> 2), HTT_TX_HWQ_MAX_FES_RESULT_STATS);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_HWQ_FES_RESULT_STATS_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(fes_result, htt_stats_buf->fes_result, num_elems);
-	len += scnprintf(buf + len, buf_len - len, "fes_result = %s\n\n", fes_result);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->fes_result, "fes_result",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1218,27 +1122,16 @@ htt_print_tx_hwq_tried_mpdu_cnt_hist_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char tried_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
 	u32  num_elements = ((tag_len -
 			    sizeof(htt_stats_buf->hist_bin_size)) >> 2);
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_HWQ_TRIED_MPDU_CNT_HIST_TLV_V:\n");
 	len += scnprintf(buf + len, buf_len - len, "TRIED_MPDU_CNT_HIST_BIN_SIZE : %u\n",
 			 htt_stats_buf->hist_bin_size);
 
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		PRINT_ARRAY_TO_BUF(tried_mpdu_cnt_hist,
-				   htt_stats_buf->tried_mpdu_cnt_hist,
-				   num_elements);
-		len += scnprintf(buf + len, buf_len - len,
-				 "tried_mpdu_cnt_hist = %s\n\n",
-				 tried_mpdu_cnt_hist);
-	} else {
-		len += scnprintf(buf + len, buf_len - len,
-				 "INSUFFICIENT PRINT BUFFER\n");
-	}
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tried_mpdu_cnt_hist,
+			   "tried_mpdu_cnt_hist", num_elements, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1257,23 +1150,14 @@ htt_print_tx_hwq_txop_used_cnt_hist_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char txop_used_cnt_hist[HTT_MAX_STRING_LEN] = {0};
 	u32 num_elements = tag_len >> 2;
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_HWQ_TXOP_USED_CNT_HIST_TLV_V:\n");
 
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		PRINT_ARRAY_TO_BUF(txop_used_cnt_hist,
-				   htt_stats_buf->txop_used_cnt_hist,
-				   num_elements);
-		len += scnprintf(buf + len, buf_len - len, "txop_used_cnt_hist = %s\n\n",
-				 txop_used_cnt_hist);
-	} else {
-		len += scnprintf(buf + len, buf_len - len,
-				 "INSUFFICIENT PRINT BUFFER\n");
-	}
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->txop_used_cnt_hist,
+			   "txop_used_cnt_hist", num_elements, "\n\n");
+
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
 	else
@@ -1781,15 +1665,12 @@ htt_print_sched_txq_cmd_posted_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_cmd_posted[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_POSTED_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(sched_cmd_posted, htt_stats_buf->sched_cmd_posted,
-			   num_elements);
-	len += scnprintf(buf + len, buf_len - len, "sched_cmd_posted = %s\n\n",
-			 sched_cmd_posted);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->sched_cmd_posted,
+			   "sched_cmd_posted", num_elements, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1808,15 +1689,12 @@ htt_print_sched_txq_cmd_reaped_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_cmd_reaped[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elements = min_t(u16, (tag_len >> 2), HTT_TX_PDEV_SCHED_TX_MODE_MAX);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_SCHED_TXQ_CMD_REAPED_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(sched_cmd_reaped, htt_stats_buf->sched_cmd_reaped,
-			   num_elements);
-	len += scnprintf(buf + len, buf_len - len, "sched_cmd_reaped = %s\n\n",
-			 sched_cmd_reaped);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->sched_cmd_reaped,
+			   "sched_cmd_reaped", num_elements, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1835,7 +1713,6 @@ htt_print_sched_txq_sched_order_su_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_order_su[HTT_MAX_STRING_LEN] = {0};
 	/* each entry is u32, i.e. 4 bytes */
 	u32 sched_order_su_num_entries =
 		min_t(u32, (tag_len >> 2), HTT_TX_PDEV_NUM_SCHED_ORDER_LOG);
@@ -1843,10 +1720,8 @@ htt_print_sched_txq_sched_order_su_tlv_v(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_SCHED_TXQ_SCHED_ORDER_SU_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(sched_order_su, htt_stats_buf->sched_order_su,
-			   sched_order_su_num_entries);
-	len += scnprintf(buf + len, buf_len - len, "sched_order_su = %s\n\n",
-			 sched_order_su);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->sched_order_su, "sched_order_su",
+			   sched_order_su_num_entries, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1865,17 +1740,15 @@ htt_print_sched_txq_sched_ineligibility_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char sched_ineligibility[HTT_MAX_STRING_LEN] = {0};
 	/* each entry is u32, i.e. 4 bytes */
 	u32 sched_ineligibility_num_entries = tag_len >> 2;
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_SCHED_TXQ_SCHED_INELIGIBILITY_V:\n");
 
-	PRINT_ARRAY_TO_BUF(sched_ineligibility, htt_stats_buf->sched_ineligibility,
-			   sched_ineligibility_num_entries);
-	len += scnprintf(buf + len, buf_len - len, "sched_ineligibility = %s\n\n",
-			 sched_ineligibility);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->sched_ineligibility,
+			   "sched_ineligibility", sched_ineligibility_num_entries,
+			   "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -1982,16 +1855,13 @@ htt_print_tx_tqm_gen_mpdu_stats_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char gen_mpdu_end_reason[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elements = min_t(u16, (tag_len >> 2),
 				 HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_GEN_MPDU_STATS_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(gen_mpdu_end_reason, htt_stats_buf->gen_mpdu_end_reason,
-			   num_elements);
-	len += scnprintf(buf + len, buf_len - len, "gen_mpdu_end_reason = %s\n\n",
-			 gen_mpdu_end_reason);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->gen_mpdu_end_reason,
+			   "gen_mpdu_end_reason", num_elements, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2010,16 +1880,14 @@ htt_print_tx_tqm_list_mpdu_stats_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char list_mpdu_end_reason[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_TX_TQM_MAX_LIST_MPDU_END_REASON);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_TQM_LIST_MPDU_STATS_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(list_mpdu_end_reason, htt_stats_buf->list_mpdu_end_reason,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "list_mpdu_end_reason = %s\n\n",
-			 list_mpdu_end_reason);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->list_mpdu_end_reason,
+			   "list_mpdu_end_reason", num_elems, "\n\n");
+
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
 	else
@@ -2037,16 +1905,13 @@ htt_print_tx_tqm_list_mpdu_cnt_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char list_mpdu_cnt_hist[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2),
 			      HTT_TX_TQM_MAX_LIST_MPDU_CNT_HISTOGRAM_BINS);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_TQM_LIST_MPDU_CNT_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(list_mpdu_cnt_hist, htt_stats_buf->list_mpdu_cnt_hist,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "list_mpdu_cnt_hist = %s\n\n",
-			 list_mpdu_cnt_hist);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->list_mpdu_cnt_hist,
+			   "list_mpdu_cnt_hist", num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2527,24 +2392,13 @@ htt_print_tx_de_fw2wbm_ring_full_hist_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw2wbm_ring_full_hist[HTT_MAX_STRING_LEN] = {0};
 	u16  num_elements = tag_len >> 2;
-	u32  required_buffer_size = HTT_MAX_PRINT_CHAR_PER_ELEM * num_elements;
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_TX_DE_FW2WBM_RING_FULL_HIST_TLV");
 
-	if (required_buffer_size < HTT_MAX_STRING_LEN) {
-		PRINT_ARRAY_TO_BUF(fw2wbm_ring_full_hist,
-				   htt_stats_buf->fw2wbm_ring_full_hist,
-				   num_elements);
-		len += scnprintf(buf + len, buf_len - len,
-				 "fw2wbm_ring_full_hist = %s\n\n",
-				 fw2wbm_ring_full_hist);
-	} else {
-		len += scnprintf(buf + len, buf_len - len,
-				 "INSUFFICIENT PRINT BUFFER\n");
-	}
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->fw2wbm_ring_full_hist,
+			   "fw2wbm_ring_full_hist", num_elements, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2593,8 +2447,6 @@ static inline void htt_print_ring_if_stats_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char low_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
-	char high_wm_hit_count[HTT_MAX_STRING_LEN] = {0};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RING_IF_STATS_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "base_addr = %u\n",
@@ -2630,15 +2482,10 @@ static inline void htt_print_ring_if_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "cons_blockwait_count = %u\n",
 			 htt_stats_buf->cons_blockwait_count);
 
-	PRINT_ARRAY_TO_BUF(low_wm_hit_count, htt_stats_buf->low_wm_hit_count,
-			   HTT_STATS_LOW_WM_BINS);
-	len += scnprintf(buf + len, buf_len - len, "low_wm_hit_count = %s\n",
-			 low_wm_hit_count);
-
-	PRINT_ARRAY_TO_BUF(high_wm_hit_count, htt_stats_buf->high_wm_hit_count,
-			   HTT_STATS_HIGH_WM_BINS);
-	len += scnprintf(buf + len, buf_len - len, "high_wm_hit_count = %s\n\n",
-			 high_wm_hit_count);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->low_wm_hit_count,
+			   "low_wm_hit_count", HTT_STATS_LOW_WM_BINS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->high_wm_hit_count,
+			   "high_wm_hit_count", HTT_STATS_HIGH_WM_BINS, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2678,16 +2525,12 @@ static inline void htt_print_sfm_client_user_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char dwords_used_by_user_n[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = tag_len >> 2;
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_SFM_CLIENT_USER_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(dwords_used_by_user_n,
-			   htt_stats_buf->dwords_used_by_user_n,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "dwords_used_by_user_n = %s\n\n",
-			 dwords_used_by_user_n);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->dwords_used_by_user_n,
+			   "dwords_used_by_user_n", num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -2838,14 +2681,6 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u8 j;
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-	char *tx_gi[HTT_TX_PEER_STATS_NUM_GI_COUNTERS] = {NULL};
-
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++) {
-		tx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!tx_gi[j])
-			goto fail;
-	}
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_TX_PDEV_RATE_STATS_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
@@ -2884,75 +2719,37 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 			 htt_stats_buf->tx_legacy_ofdm_rate[6],
 			 htt_stats_buf->tx_legacy_ofdm_rate[7]);
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_mcs,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_mcs,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_mcs,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_mcs,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_nss,
-			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "tx_nss = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_nss,
-			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_nss = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_nss,
-			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_nss = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_nss,
-			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_nss = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_bw,
-			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_bw = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ac_mu_mimo_tx_bw,
-			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ac_mu_mimo_tx_bw = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ax_mu_mimo_tx_bw,
-			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ax_mu_mimo_tx_bw = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ofdma_tx_bw,
-			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ofdma_tx_bw = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_stbc,
-			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_stbc = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_pream,
-			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += scnprintf(buf + len, buf_len - len, "tx_pream = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_mcs, "tx_mcs",
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ac_mu_mimo_tx_mcs,
+			   "ac_mu_mimo_tx_mcs", HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ax_mu_mimo_tx_mcs,
+			   "ax_mu_mimo_tx_mcs", HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ofdma_tx_mcs, "ofdma_tx_mcs",
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_nss, "tx_nss",
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ac_mu_mimo_tx_nss,
+			   "ac_mu_mimo_tx_nss",
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ax_mu_mimo_tx_nss,
+			   "ax_mu_mimo_tx_nss",
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ofdma_tx_nss, "ofdma_tx_nss",
+			   HTT_TX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_bw, "tx_bw",
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ac_mu_mimo_tx_bw,
+			   "ac_mu_mimo_tx_bw", HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ax_mu_mimo_tx_bw,
+			   "ax_mu_mimo_tx_bw",
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ofdma_tx_bw, "ofdma_tx_bw",
+			   HTT_TX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_stbc, "tx_stbc",
+			   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_pream, "tx_pream",
+			   HTT_TX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
 
 	len += scnprintf(buf + len, buf_len - len, "HE LTF: 1x: %u, 2x: %u, 4x: %u\n",
 			 htt_stats_buf->tx_he_ltf[1],
@@ -2961,42 +2758,38 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 
 	/* SU GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->tx_gi[j],
-				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "tx_gi[%u] = %s\n",
-				 j, tx_gi[j]);
+		len += scnprintf(buf + len, (buf_len - len),
+				 "tx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_gi[j], NULL,
+				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
 	/* AC MU-MIMO GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ac_mu_mimo_tx_gi[j],
-				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len,
-				 "ac_mu_mimo_tx_gi[%u] = %s\n",
-				 j, tx_gi[j]);
+		len += scnprintf(buf + len, (buf_len - len),
+				 "ac_mu_mimo_tx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ac_mu_mimo_tx_gi[j],
+				   NULL, HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
 	/* AX MU-MIMO GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ax_mu_mimo_tx_gi[j],
-				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len,
-				 "ax_mu_mimo_tx_gi[%u] = %s\n",
-				 j, tx_gi[j]);
+		len += scnprintf(buf + len, (buf_len - len),
+				 "ax_mu_mimo_tx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ax_mu_mimo_tx_gi[j],
+				   NULL, HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
 	/* DL OFDMA GI Stats */
 	for (j = 0; j < HTT_TX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(tx_gi[j], htt_stats_buf->ofdma_tx_gi[j],
-				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "ofdma_tx_gi[%u] = %s\n",
-				 j, tx_gi[j]);
+		len += scnprintf(buf + len, (buf_len - len),
+				 "ofdma_tx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ofdma_tx_gi[j], NULL,
+				   HTT_TX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->tx_dcm,
-			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "tx_dcm = %s\n\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->tx_dcm, "tx_dcm",
+			   HTT_TX_PDEV_STATS_NUM_DCM_COUNTERS, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3004,9 +2797,6 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 		buf[len] = 0;
 
 	stats_req->buf_len = len;
-fail:
-	for (j = 0; j < HTT_TX_PEER_STATS_NUM_GI_COUNTERS; j++)
-		kfree(tx_gi[j]);
 }
 
 static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
@@ -3017,29 +2807,6 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
 	u8 i, j;
-	u16 index = 0;
-	char *rssi_chain[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS] = {NULL};
-	char *rx_gi[HTT_RX_PDEV_STATS_NUM_GI_COUNTERS] = {NULL};
-	char str_buf[HTT_MAX_STRING_LEN] = {0};
-	char *rx_pilot_evm_db[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS] = {NULL};
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		rssi_chain[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rssi_chain[j])
-			goto fail;
-	}
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		rx_gi[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rx_gi[j])
-			goto fail;
-	}
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		rx_pilot_evm_db[j] = kmalloc(HTT_MAX_STRING_LEN, GFP_ATOMIC);
-		if (!rx_pilot_evm_db[j])
-			goto fail;
-	}
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_RATE_STATS_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
@@ -3059,30 +2826,17 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "rssi_in_dbm = %d\n",
 			 htt_stats_buf->rssi_in_dbm);
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_mcs,
-			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_mcs = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_nss,
-			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "rx_nss = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_dcm,
-			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_dcm = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_stbc,
-			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_stbc = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_bw,
-			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "rx_bw = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_mcs, "rx_mcs",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_nss, "rx_nss",
+			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_dcm, "rx_dcm",
+			   HTT_RX_PDEV_STATS_NUM_DCM_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_stbc, "rx_stbc",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_bw, "rx_bw",
+			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
+
 	len += scnprintf(buf + len, buf_len - len, "rx_evm_nss_count = %u\n",
 			 htt_stats_buf->nss_count);
 
@@ -3090,44 +2844,43 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 			 htt_stats_buf->pilot_count);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		index = 0;
 
+		len += scnprintf(buf + len, buf_len - len,
+				 "pilot_evm_db[%u] = ", j);
 		for (i = 0; i < HTT_RX_PDEV_STATS_RXEVM_MAX_PILOTS_PER_NSS; i++)
-			index += scnprintf(&rx_pilot_evm_db[j][index],
-					   HTT_MAX_STRING_LEN - index,
-					   " %u:%d,",
-					   i,
-					   htt_stats_buf->rx_pilot_evm_db[j][i]);
-		len += scnprintf(buf + len, buf_len - len, "pilot_evm_dB[%u] = %s\n",
-				 j, rx_pilot_evm_db[j]);
+			len += scnprintf(buf + len,
+					 buf_len - len,
+					 " %u:%d,",
+					 i,
+					 htt_stats_buf->rx_pilot_evm_db[j][i]);
+		len += scnprintf(buf + len, buf_len - len, "\n");
 	}
 
-	index = 0;
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
+	len += scnprintf(buf + len, buf_len - len,
+			 "pilot_evm_db_mean = ");
 	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; i++)
-		index += scnprintf(&str_buf[index],
-				   HTT_MAX_STRING_LEN - index,
-				   " %u:%d,", i, htt_stats_buf->rx_pilot_evm_db_mean[i]);
-	len += scnprintf(buf + len, buf_len - len, "pilot_evm_dB_mean = %s\n", str_buf);
+		len += scnprintf(buf + len,
+				 buf_len - len,
+				 " %u:%d,", i,
+				 htt_stats_buf->rx_pilot_evm_db_mean[i]);
+	len += scnprintf(buf + len, buf_len - len, "\n");
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		PRINT_ARRAY_TO_BUF(rssi_chain[j], htt_stats_buf->rssi_chain[j],
-				   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "rssi_chain[%u] = %s\n",
-				 j, rssi_chain[j]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "rssi_chain[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rssi_chain[j], NULL,
+				   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
 	}
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->rx_gi[j],
-				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "rx_gi[%u] = %s\n",
-				 j, rx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "rx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_gi[j], NULL,
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_pream,
-			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES);
-	len += scnprintf(buf + len, buf_len - len, "rx_pream = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_pream, "rx_pream",
+			   HTT_RX_PDEV_STATS_NUM_PREAMBLE_TYPES, "\n");
 
 	len += scnprintf(buf + len, buf_len - len, "rx_11ax_su_ext = %u\n",
 			 htt_stats_buf->rx_11ax_su_ext);
@@ -3140,17 +2893,13 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "txbf = %u\n",
 			 htt_stats_buf->txbf);
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_legacy_cck_rate,
-			   HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS);
-	len += scnprintf(buf + len, buf_len - len, "rx_legacy_cck_rate = %s\n",
-			 str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_legacy_cck_rate,
+			   "rx_legacy_cck_rate",
+			   HTT_RX_PDEV_STATS_NUM_LEGACY_CCK_STATS, "\n");
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_legacy_ofdm_rate,
-			   HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS);
-	len += scnprintf(buf + len, buf_len - len, "rx_legacy_ofdm_rate = %s\n",
-			 str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_legacy_ofdm_rate,
+			   "rx_legacy_ofdm_rate",
+			   HTT_RX_PDEV_STATS_NUM_LEGACY_OFDM_STATS, "\n");
 
 	len += scnprintf(buf + len, buf_len - len, "rx_active_dur_us_low = %u\n",
 			 htt_stats_buf->rx_active_dur_us_low);
@@ -3159,82 +2908,66 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "rx_11ax_ul_ofdma = %u\n",
 			 htt_stats_buf->rx_11ax_ul_ofdma);
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_mcs,
-			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_mcs = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ul_ofdma_rx_mcs,
+			   "ul_ofdma_rx_mcs",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
-		PRINT_ARRAY_TO_BUF(rx_gi[j], htt_stats_buf->ul_ofdma_rx_gi[j],
-				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS);
-		len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_gi[%u] = %s\n",
-				 j, rx_gi[j]);
+		len += scnprintf(buf + len, buf_len - len,
+				 "ul_ofdma_rx_gi[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ul_ofdma_rx_gi[j], NULL,
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS, "\n");
 	}
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_nss,
-			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS);
-	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_nss = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ul_ofdma_rx_nss,
+			   "ul_ofdma_rx_nss",
+			   HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS, "\n");
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->ul_ofdma_rx_bw,
-			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS);
-	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_bw = %s\n", str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ul_ofdma_rx_bw, "ul_ofdma_rx_bw",
+			   HTT_RX_PDEV_STATS_NUM_BW_COUNTERS, "\n");
 
 	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_stbc = %u\n",
 			htt_stats_buf->ul_ofdma_rx_stbc);
 	len += scnprintf(buf + len, buf_len - len, "ul_ofdma_rx_ldpc = %u\n",
 			htt_stats_buf->ul_ofdma_rx_ldpc);
 
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_non_data_ppdu,
-			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_non_data_ppdu = %s\n",
-			 str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_data_ppdu,
-			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_data_ppdu = %s\n",
-			   str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_mpdu_ok,
-			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_mpdu_ok = %s\n", str_buf);
-
-	memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-	PRINT_ARRAY_TO_BUF(str_buf, htt_stats_buf->rx_ulofdma_mpdu_fail,
-			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER);
-	len += scnprintf(buf + len, buf_len - len, "rx_ulofdma_mpdu_fail = %s\n",
-			 str_buf);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_ulofdma_non_data_ppdu,
+			   "rx_ulofdma_non_data_ppdu",
+			   HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_ulofdma_data_ppdu,
+			   "rx_ulofdma_data_ppdu", HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_ulofdma_mpdu_ok,
+			   "rx_ulofdma_mpdu_ok", HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_ulofdma_mpdu_fail,
+			   "rx_ulofdma_mpdu_fail", HTT_RX_PDEV_MAX_OFDMA_NUM_USER, "\n");
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		index = 0;
-		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-		for (i = 0; i < HTT_RX_PDEV_MAX_OFDMA_NUM_USER; i++)
-			index += scnprintf(&str_buf[index],
-					   HTT_MAX_STRING_LEN - index,
-					   " %u:%d,",
-					   i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
 		len += scnprintf(buf + len, buf_len - len,
-				 "rx_ul_fd_rssi: nss[%u] = %s\n", j, str_buf);
+				 "rx_ul_fd_rssi: nss[%u] = ", j);
+		for (i = 0; i < HTT_RX_PDEV_MAX_OFDMA_NUM_USER; i++)
+			len += scnprintf(buf + len,
+					 buf_len - len,
+					 " %u:%d,",
+					 i, htt_stats_buf->rx_ul_fd_rssi[j][i]);
+		len += scnprintf(buf + len, buf_len - len, "\n");
 	}
 
 	len += scnprintf(buf + len, buf_len - len, "per_chain_rssi_pkt_type = %#x\n",
 			 htt_stats_buf->per_chain_rssi_pkt_type);
 
 	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
-		index = 0;
-		memset(str_buf, 0x0, HTT_MAX_STRING_LEN);
-		for (i = 0; i < HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
-			index += scnprintf(&str_buf[index],
-					   HTT_MAX_STRING_LEN - index,
-					   " %u:%d,",
-					   i,
-					   htt_stats_buf->rx_per_chain_rssi_in_dbm[j][i]);
 		len += scnprintf(buf + len, buf_len - len,
-				 "rx_per_chain_rssi_in_dbm[%u] = %s\n", j, str_buf);
+				 "rx_per_chain_rssi_in_dbm[%u] = ", j);
+		for (i = 0; i < HTT_RX_PDEV_STATS_NUM_BW_COUNTERS; i++)
+			len += scnprintf(buf + len,
+					 buf_len - len,
+					 " %u:%d,",
+					 i,
+					 htt_stats_buf->rx_per_chain_rssi_in_dbm[j][i]);
+		len += scnprintf(buf + len, buf_len - len, "\n");
 	}
 	len += scnprintf(buf + len, buf_len - len, "\n");
 
@@ -3244,16 +2977,6 @@ static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 		buf[len] = 0;
 
 	stats_req->buf_len = len;
-
-fail:
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
-		kfree(rssi_chain[j]);
-
-	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++)
-		kfree(rx_pilot_evm_db[j]);
-
-	for (i = 0; i < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; i++)
-		kfree(rx_gi[i]);
 }
 
 static inline void htt_print_rx_soc_fw_stats_tlv(const void *tag_buf,
@@ -3310,17 +3033,13 @@ htt_print_rx_soc_fw_refill_ring_empty_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char refill_ring_empty_cnt[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_RX_SOC_FW_REFILL_RING_EMPTY_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(refill_ring_empty_cnt,
-			   htt_stats_buf->refill_ring_empty_cnt,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "refill_ring_empty_cnt = %s\n\n",
-			 refill_ring_empty_cnt);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->refill_ring_empty_cnt,
+			   "refill_ring_empty_cnt", num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3340,17 +3059,13 @@ htt_print_rx_soc_fw_refill_ring_num_rxdma_err_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char rxdma_err_cnt[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_RXDMA_MAX_ERR_CODE);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_RX_SOC_FW_REFILL_RING_NUM_RXDMA_ERR_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(rxdma_err_cnt,
-			   htt_stats_buf->rxdma_err,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "rxdma_err = %s\n\n",
-			 rxdma_err_cnt);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rxdma_err, "rxdma_err",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3369,17 +3084,13 @@ htt_print_rx_soc_fw_refill_ring_num_reo_err_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char reo_err_cnt[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_REO_MAX_ERR_CODE);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_RX_SOC_FW_REFILL_RING_NUM_REO_ERR_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(reo_err_cnt,
-			   htt_stats_buf->reo_err,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "reo_err = %s\n\n",
-			 reo_err_cnt);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->reo_err, "reo_err",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3437,17 +3148,13 @@ htt_print_rx_soc_fw_refill_ring_num_refill_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char refill_ring_num_refill[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_REFILL_MAX_RING);
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_RX_SOC_FW_REFILL_RING_NUM_REFILL_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(refill_ring_num_refill,
-			   htt_stats_buf->refill_ring_num_refill,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "refill_ring_num_refill = %s\n\n",
-			 refill_ring_num_refill);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->refill_ring_num_refill,
+			   "refill_ring_num_refill", num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3464,8 +3171,6 @@ static inline void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw_ring_mgmt_subtype[HTT_MAX_STRING_LEN] = {0};
-	char fw_ring_ctrl_subtype[HTT_MAX_STRING_LEN] = {0};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "mac_id = %u\n",
@@ -3487,17 +3192,12 @@ static inline void htt_print_rx_pdev_fw_stats_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_ind = %u\n",
 			 htt_stats_buf->fw_ring_mpdu_ind);
 
-	PRINT_ARRAY_TO_BUF(fw_ring_mgmt_subtype,
-			   htt_stats_buf->fw_ring_mgmt_subtype,
-			   HTT_STATS_SUBTYPE_MAX);
-	len += scnprintf(buf + len, buf_len - len, "fw_ring_mgmt_subtype = %s\n",
-			 fw_ring_mgmt_subtype);
-
-	PRINT_ARRAY_TO_BUF(fw_ring_ctrl_subtype,
-			   htt_stats_buf->fw_ring_ctrl_subtype,
-			   HTT_STATS_SUBTYPE_MAX);
-	len += scnprintf(buf + len, buf_len - len, "fw_ring_ctrl_subtype = %s\n",
-			 fw_ring_ctrl_subtype);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->fw_ring_mgmt_subtype,
+			   "fw_ring_mgmt_subtype", HTT_STATS_SUBTYPE_MAX, "\n");
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->fw_ring_ctrl_subtype,
+			   "fw_ring_ctrl_subtype", HTT_STATS_SUBTYPE_MAX, "\n");
+
 	len += scnprintf(buf + len, buf_len - len, "fw_ring_mcast_data_msdu = %u\n",
 			 htt_stats_buf->fw_ring_mcast_data_msdu);
 	len += scnprintf(buf + len, buf_len - len, "fw_ring_bcast_data_msdu = %u\n",
@@ -3588,16 +3288,12 @@ htt_print_rx_pdev_fw_ring_mpdu_err_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw_ring_mpdu_err[HTT_MAX_STRING_LEN] = {0};
 
 	len += scnprintf(buf + len, buf_len - len,
 			 "HTT_RX_PDEV_FW_RING_MPDU_ERR_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(fw_ring_mpdu_err,
-			   htt_stats_buf->fw_ring_mpdu_err,
-			   HTT_RX_STATS_RXDMA_MAX_ERR);
-	len += scnprintf(buf + len, buf_len - len, "fw_ring_mpdu_err = %s\n\n",
-			 fw_ring_mpdu_err);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->fw_ring_mpdu_err,
+			   "fw_ring_mpdu_err", HTT_RX_STATS_RXDMA_MAX_ERR, "\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3616,15 +3312,12 @@ htt_print_rx_pdev_fw_mpdu_drop_tlv_v(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char fw_mpdu_drop[HTT_MAX_STRING_LEN] = {0};
 	u16 num_elems = min_t(u16, (tag_len >> 2), HTT_RX_STATS_FW_DROP_REASON_MAX);
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_MPDU_DROP_TLV_V:\n");
 
-	PRINT_ARRAY_TO_BUF(fw_mpdu_drop,
-			   htt_stats_buf->fw_mpdu_drop,
-			   num_elems);
-	len += scnprintf(buf + len, buf_len - len, "fw_mpdu_drop = %s\n\n", fw_mpdu_drop);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->fw_mpdu_drop, "fw_mpdu_drop",
+			   num_elems, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
@@ -3642,7 +3335,6 @@ htt_print_rx_pdev_fw_stats_phy_err_tlv(const void *tag_buf,
 	u8 *buf = stats_req->buf;
 	u32 len = stats_req->buf_len;
 	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
-	char phy_errs[HTT_MAX_STRING_LEN] = {0};
 
 	len += scnprintf(buf + len, buf_len - len, "HTT_RX_PDEV_FW_STATS_PHY_ERR_TLV:\n");
 	len += scnprintf(buf + len, buf_len - len, "mac_id__word = %u\n",
@@ -3650,10 +3342,8 @@ htt_print_rx_pdev_fw_stats_phy_err_tlv(const void *tag_buf,
 	len += scnprintf(buf + len, buf_len - len, "total_phy_err_nct = %u\n",
 			 htt_stats_buf->total_phy_err_cnt);
 
-	PRINT_ARRAY_TO_BUF(phy_errs,
-			   htt_stats_buf->phy_err,
-			   HTT_STATS_PHY_ERR_MAX);
-	len += scnprintf(buf + len, buf_len - len, "phy_errs = %s\n\n", phy_errs);
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->phy_err, "phy_errs",
+			   HTT_STATS_PHY_ERR_MAX, "\n\n");
 
 	if (len >= buf_len)
 		buf[buf_len - 1] = 0;
-- 
2.25.1

