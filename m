Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47273109AFC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 10:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKZJSa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 04:18:30 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:50790
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbfKZJSa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 04:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574759909;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=X5V8s0Eli1EcgJsp36WqwwwNfr8P8+kw3efGveKQfu0=;
        b=IRFr+/iquEAK6YrAZOcW2OKgwRIdl5UDz5LiAdOM23Ip/aTkitM6BzZgFnr1qCl/
        +oA3A/qS5ylAvVED0StIkJv5xD9NiP7Ly/iWxUsIttDPlEzZkUhXNUgahNsXFZPmhif
        5E0QnoH4NRIcAIztJUB/gXvsj7qZOrkDnvV3dt1c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574759909;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=X5V8s0Eli1EcgJsp36WqwwwNfr8P8+kw3efGveKQfu0=;
        b=FCAcI2qkidJgW01AnYA3Fo7lelAXn3+p0SH2D+F2zbiE5n+KneXJdhXRcm+kZ79O
        mm7lwf9uFIPJV7Z0nRVdNiFF9GX7vycXSxjFGt7//e4qHBH0eQcImHW7psR4FslgzjA
        7YUsK5hWo9vK5sXNkc4UOQcdz4iDEEp840fcPpnE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95B09C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: drop the TX packet which size exceed credit size for sdio
Date:   Tue, 26 Nov 2019 09:18:29 +0000
Message-ID: <0101016ea7014696-55ae954e-6272-4899-bd03-d8012e217b9e-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.11.26-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

sdio chip use DMA buffer to receive TX packet from ath10k, and it has
limitation of each buffer, if the packet size exceed the credit size,
it will trigger error in firmware.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
this patch depens on the patch "ath10k: add htt TX bundle for sdio"
 drivers/net/wireless/ath/ath10k/htc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index 03c358cd16d4..51addcc654a0 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -846,6 +846,11 @@ int ath10k_htc_send_hl(struct ath10k_htc *htc,
 	struct ath10k_htc_ep *ep = &htc->endpoint[eid];
 	struct ath10k *ar = htc->ar;
 
+	if (sizeof(struct ath10k_htc_hdr) + skb->len > ep->tx_credit_size) {
+		ath10k_dbg(ar, ATH10K_DBG_HTC, "tx exceed max len %d\n", skb->len);
+		return -ENOMEM;
+	}
+
 	ath10k_dbg(ar, ATH10K_DBG_HTC, "htc send hl: eid:%d, bundle:%d, tx count:%d, len:%d\n",
 		   eid, ep->bundle_tx, skb_queue_len(&ep->tx_req_head), skb->len);
 
-- 
2.23.0

