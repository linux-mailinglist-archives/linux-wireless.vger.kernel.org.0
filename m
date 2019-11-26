Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED6E109CBB
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfKZLE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:58 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:43416
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727897AbfKZLE5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766297;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=wBg1Ji6WBfKCb+qV9IDWZbp7IfN7TOLqYYCkbAlsn1E=;
        b=KiZo/u1/vl+gJmyTUKPmrBWgsiaI5Q5n/+uD++/5htvWDAcDZl8/ufSl9Cqkmb7/
        FUcDl9eZdLelFNkzSHSxsgBB+T83KQvHudjdpB6dCLmaoHHJA6eoj6JIQHoLez3IXEF
        i4D/fnqiZZutBeVvMjGVsGTlPBCOlBYQ8QqngJ9E=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766297;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=wBg1Ji6WBfKCb+qV9IDWZbp7IfN7TOLqYYCkbAlsn1E=;
        b=IOcgm9F1Zg98I++3ytkvBtdbRIxr0S92FfPIUwyVrV9foNTKN0B0DRJwc8zoWAAk
        qgZKLAp5++uwXlT5k5AxHqHZxMMZflcCKI3emJLYj86IFhe/mHzmRA1u5OAqVRHdN2r
        1/XdPEeBfUurR4Vt3NI6zP3royyTuru+3I2nROyA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20E7AC447BB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 08/10] ath11k: Fix skb_panic observed during msdu coalescing
Date:   Tue, 26 Nov 2019 11:04:57 +0000
Message-ID: <0101016ea762c08d-ddb7bea1-4346-4a6d-891a-7b2265e50606-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sriram R <srirrama@codeaurora.org>

skb_panic is hit during msdu coalescing whenever
enough tailroom is not allocated based on the remaining
msdu length which is spread across in different rx buffers.

Compute the extra length for resizing the skb based on
the total msdu length and the msdu length of the first buffer.

Signed-off-by: Sriram R <srirrama@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 321a2bb657e8..acad74658e64 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1344,15 +1344,22 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 {
 	struct sk_buff *skb;
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(first);
+	int buf_first_hdr_len, buf_first_len;
 	struct hal_rx_desc *ldesc;
 	int space_extra;
 	int rem_len;
 	int buf_len;
 
-	if (WARN_ON_ONCE(msdu_len <= (DP_RX_BUFFER_SIZE -
-			 (HAL_RX_DESC_SIZE + l3pad_bytes)))) {
-		skb_put(first, HAL_RX_DESC_SIZE + l3pad_bytes + msdu_len);
-		skb_pull(first, HAL_RX_DESC_SIZE + l3pad_bytes);
+	/* As the msdu is spread across multiple rx buffers,
+	 * find the offset to the start of msdu for computing
+	 * the length of the msdu in the first buffer.
+	 */
+	buf_first_hdr_len = HAL_RX_DESC_SIZE + l3pad_bytes;
+	buf_first_len = DP_RX_BUFFER_SIZE - buf_first_hdr_len;
+
+	if (WARN_ON_ONCE(msdu_len <= buf_first_len)) {
+		skb_put(first, buf_first_hdr_len + msdu_len);
+		skb_pull(first, buf_first_hdr_len);
 		return 0;
 	}
 
@@ -1365,9 +1372,9 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 	 * in the first buf is of length DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE.
 	 */
 	skb_put(first, DP_RX_BUFFER_SIZE);
-	skb_pull(first, HAL_RX_DESC_SIZE + l3pad_bytes);
+	skb_pull(first, buf_first_hdr_len);
 
-	space_extra = msdu_len - (DP_RX_BUFFER_SIZE + skb_tailroom(first));
+	space_extra = msdu_len - (buf_first_len + skb_tailroom(first));
 	if (space_extra > 0 &&
 	    (pskb_expand_head(first, 0, space_extra, GFP_ATOMIC) < 0)) {
 		/* Free up all buffers of the MSDU */
@@ -1387,8 +1394,7 @@ static int ath11k_dp_rx_msdu_coalesce(struct ath11k *ar,
 	 */
 	ath11k_dp_rx_desc_end_tlv_copy(rxcb->rx_desc, ldesc);
 
-	rem_len = msdu_len -
-		  (DP_RX_BUFFER_SIZE - HAL_RX_DESC_SIZE - l3pad_bytes);
+	rem_len = msdu_len - buf_first_len;
 	while ((skb = __skb_dequeue(msdu_list)) != NULL && rem_len > 0) {
 		rxcb = ATH11K_SKB_RXCB(skb);
 		if (rxcb->is_continuation)
-- 
2.7.4

