Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD41526BC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 08:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgBEHQZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 02:16:25 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:54810 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgBEHQZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 02:16:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580886984; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oEibU5IqrW/VSVySG903o9KMYMihm++jSvuEESHQfTs=; b=i3iSxZZuWdlR+oPn8Ski2PXdrKTvW6WTObriU56aykKRLyQUgCCAU8xS2n35P7o3QWTPM6JR
 N3d6Ez6CjVCHEP/U75vEDsp3E9Ie0/vHHQY10e+yTyz6uI+Ckah2XKYjojR+0VD8TTCppHZJ
 uWtKICwZVZTdfSTClotgcjWSXKg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3a6bc2.7f2e3bc433e8-smtp-out-n03;
 Wed, 05 Feb 2020 07:16:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59EFCC43383; Wed,  5 Feb 2020 07:16:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE2AFC433CB;
        Wed,  5 Feb 2020 07:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE2AFC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath11k: fix parsing PPDU_CTRL type in pktlog
Date:   Wed,  5 Feb 2020 12:45:59 +0530
Message-Id: <1580886959-8436-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PPDU_CTRL type is missing in current pktlog dumps.
PPDU_CTRL is sent on CE5 with len 2560 bytes, current
driver ignores the payload len greter than 2048.
PPDU_CTRL of 2560 bytes is sent in two fragments of len 2028
and 532 bytes, but firmware reports pkt header has length as 2560
for both of the fragments.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.h | 13 ++++++++++---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 12 ++----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index aef33f83c9b1..12332eeabc10 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -65,12 +65,19 @@ struct debug_htt_stats_req {
 	u8 buf[0];
 };
 
-#define ATH11K_HTT_STATS_BUF_SIZE (1024 * 512)
+struct ath_pktlog_hdr {
+	u16 flags;
+	u16 missed_cnt;
+	u16 log_type;
+	u16 size;
+	u32 timestamp;
+	u32 type_specific_data;
+	u8 payload[0];
+};
 
+#define ATH11K_HTT_STATS_BUF_SIZE (1024 * 512)
 #define ATH11K_FW_STATS_BUF_SIZE (1024 * 1024)
 
-#define ATH11K_HTT_PKTLOG_MAX_SIZE 2048
-
 enum ath11k_pktlog_filter {
 	ATH11K_PKTLOG_RX		= 0x000000001,
 	ATH11K_PKTLOG_TX		= 0x000000002,
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index ae4bfa5fe3b8..4e4bffd57b3f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1282,18 +1282,10 @@ static int ath11k_htt_pull_ppdu_stats(struct ath11k_base *ab,
 static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct htt_pktlog_msg *data = (struct htt_pktlog_msg *)skb->data;
+	struct ath_pktlog_hdr *hdr = (struct ath_pktlog_hdr *)data;
 	struct ath11k *ar;
-	u32 len;
 	u8 pdev_id;
 
-	len = FIELD_GET(HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE, data->hdr);
-	if (len > ATH11K_HTT_PKTLOG_MAX_SIZE) {
-		ath11k_warn(ab, "htt pktlog buffer size %d, expected < %d\n",
-			    len,
-			    ATH11K_HTT_PKTLOG_MAX_SIZE);
-		return;
-	}
-
 	pdev_id = FIELD_GET(HTT_T2H_PPDU_STATS_INFO_PDEV_ID, data->hdr);
 	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_id);
 	if (!ar) {
@@ -1301,7 +1293,7 @@ static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
 		return;
 	}
 
-	trace_ath11k_htt_pktlog(ar, data->payload, len);
+	trace_ath11k_htt_pktlog(ar, data->payload, hdr->size);
 }
 
 void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
-- 
1.9.1
