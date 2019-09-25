Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11186BDAA1
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbfIYJLL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 05:11:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54644 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfIYJK5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 05:10:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4851F611FA; Wed, 25 Sep 2019 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569402652;
        bh=28HjTg107xudXWilP3f2TOc5WYDSsZ6Rmykw7iVlDPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jorIhOxZaKDA0MH+G1vEM98l42BK/Im7HQ/VQ1kFg/0P9tcM9fGfH3Wt6zDaGJIiV
         VW98bF1kQOWlrKK8m6Yh8SMVOkneuJB6uUM9Rzh6QHkW0SjvoHMvnvEObChyUtd+FD
         ApEGq1abMcYUPOqT4MVxXg/XjDJYdJw/1GJjRHLs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15A01611BF;
        Wed, 25 Sep 2019 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569402651;
        bh=28HjTg107xudXWilP3f2TOc5WYDSsZ6Rmykw7iVlDPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYEFjpaoK9Ba/iJHXZOrlSVJZMYMqqDwViS/7YKe7yCfU59hLlGiwAkA/irQ8lFpy
         gmpwRA6ZRiFRmf2tv2M+Zeff1Ss61c9i+u1pQHRHqUQ/kz6TudW9MUHqTbivE9SUse
         e9cx7lZ8Snqz4x4JP5HNH4S/F0iTK+BRDOrQh2HI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15A01611BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
Date:   Wed, 25 Sep 2019 17:10:39 +0800
Message-Id: <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For RX, it has two parts, one is to read data from sdio, another
is to indicate the packets to upper stack. Recently it has only
one thread to do all RX things, it results that it is sequential
for RX and low throughout, change RX to parallel for the two parts
will increase throughout.

This patch move the indication to a workqueue, it results in
significant performance improvement on RX path.

Udp rx throughout is 200Mbps without this patch, and it arrives
400Mbps with this patch.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00017-QCARMSWPZ-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 35 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath10k/sdio.h | 11 +++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index a510101..ff02833 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -419,6 +419,7 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 	struct ath10k_htc *htc = &ar->htc;
 	struct ath10k_sdio_rx_data *pkt;
 	struct ath10k_htc_ep *ep;
+	struct ath10k_skb_cb *cb;
 	enum ath10k_htc_ep_id id;
 	int ret, i, *n_lookahead_local;
 	u32 *lookaheads_local;
@@ -464,10 +465,16 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 		if (ret)
 			goto out;
 
-		if (!pkt->trailer_only)
-			ep->ep_ops.ep_rx_complete(ar_sdio->ar, pkt->skb);
-		else
+		if (!pkt->trailer_only) {
+			cb = ATH10K_SKB_CB(pkt->skb);
+			cb->eid = id;
+
+			skb_queue_tail(&ar_sdio->rx_head, pkt->skb);
+			queue_work(ar->workqueue_aux,
+				   &ar_sdio->async_work_rx);
+		} else {
 			kfree_skb(pkt->skb);
+		}
 
 		/* The RX complete handler now owns the skb...*/
 		pkt->skb = NULL;
@@ -1317,6 +1324,25 @@ static void __ath10k_sdio_write_async(struct ath10k *ar,
 	ath10k_sdio_free_bus_req(ar, req);
 }
 
+static void ath10k_rx_indication_async_work(struct work_struct *work)
+{
+	struct ath10k_sdio *ar_sdio = container_of(work, struct ath10k_sdio,
+						   async_work_rx);
+	struct ath10k *ar = ar_sdio->ar;
+	struct ath10k_htc_ep *ep;
+	struct ath10k_skb_cb *cb;
+	struct sk_buff *skb;
+
+	while (true) {
+		skb = skb_dequeue(&ar_sdio->rx_head);
+		if (!skb)
+			break;
+		cb = ATH10K_SKB_CB(skb);
+		ep = &ar->htc.endpoint[cb->eid];
+		ep->ep_ops.ep_rx_complete(ar, skb);
+	}
+}
+
 static void ath10k_sdio_write_async_work(struct work_struct *work)
 {
 	struct ath10k_sdio *ar_sdio = container_of(work, struct ath10k_sdio,
@@ -2087,6 +2113,9 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 	for (i = 0; i < ATH10K_SDIO_BUS_REQUEST_MAX_NUM; i++)
 		ath10k_sdio_free_bus_req(ar, &ar_sdio->bus_req[i]);
 
+	skb_queue_head_init(&ar_sdio->rx_head);
+	INIT_WORK(&ar_sdio->async_work_rx, ath10k_rx_indication_async_work);
+
 	dev_id_base = FIELD_GET(QCA_MANUFACTURER_ID_BASE, id->device);
 	switch (dev_id_base) {
 	case QCA_MANUFACTURER_ID_AR6005_BASE:
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index 00bd4ca..8aa0dbc 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -98,6 +98,12 @@
 #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_OFF 0xFFFEFFFF
 #define ATH10K_FIFO_TIMEOUT_AND_CHIP_CONTROL_DISABLE_SLEEP_ON 0x10000
 
+struct ath10k_sdio_rx_request {
+	struct list_head list;
+	struct sk_buff *skb;
+	struct ath10k_htc_ep *ep;
+};
+
 struct ath10k_sdio_bus_request {
 	struct list_head list;
 
@@ -187,6 +193,9 @@ struct ath10k_sdio {
 	struct ath10k_sdio_bus_request bus_req[ATH10K_SDIO_BUS_REQUEST_MAX_NUM];
 	/* free list of bus requests */
 	struct list_head bus_req_freeq;
+
+	struct sk_buff_head rx_head;
+
 	/* protects access to bus_req_freeq */
 	spinlock_t lock;
 
@@ -213,6 +222,8 @@ struct ath10k_sdio {
 	struct list_head wr_asyncq;
 	/* protects access to wr_asyncq */
 	spinlock_t wr_async_lock;
+
+	struct work_struct async_work_rx;
 };
 
 static inline struct ath10k_sdio *ath10k_sdio_priv(struct ath10k *ar)
-- 
1.9.1

