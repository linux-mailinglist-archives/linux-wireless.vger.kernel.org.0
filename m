Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590DE95DF1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfHTLza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 07:55:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49306 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTLza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 07:55:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 69D8360E7A; Tue, 20 Aug 2019 11:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566302129;
        bh=i+ZymE+bWnsR3RBv9DekjSe8ie3kbCoz/0LljyLS2bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwOaYPEUrurF6CiHfJoZg5qckSxc22BDv69yZnCZll8Ey1lJI6q1L5cyTVwmHnAx9
         RNt3L8F7qLVGQa0iGLed4Fl8zbJaMy4k7XfCDkpqyafkLq92k2iYUUmy9Ee/8mgVV2
         29Ecu/cO3tORCwyLar+yYk6vLKR/JpY4DQb+hW6U=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C848360DB6;
        Tue, 20 Aug 2019 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566302128;
        bh=i+ZymE+bWnsR3RBv9DekjSe8ie3kbCoz/0LljyLS2bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WRo9I9Fb8ED2Rt6vUxT5x9FL3XS+NMaa4MBGC7+7tFSjOW8bwXxQKam5A41yyDu5H
         16y3S/+v5WMFJA5Pc59E5JdGURZrFcaBdrC/EdeRcM/OkV3b4IHT0iuKi8TXXKUET+
         4EWXXGVn4UP/cN4n0hrU0TaHxGGtkEpsY4bGHudY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C848360DB6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 3/7] ath10k: add workqueue for RX path of sdio
Date:   Tue, 20 Aug 2019 19:55:04 +0800
Message-Id: <1566302108-18219-4-git-send-email-wgong@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The thread of read rx message by sdio bus from firmware is
synchronous, it will cost much time for process the left part
of rx message which includes indicate the rx packet to uppper
net stack. It will reduce the time of read from sdio.

This patch move the indication to a workqueue, it results in
significant performance improvement on RX path.

Tested with QCA6174 SDIO with firmware
WLAN.RMH.4.4.1-00007-QCARMSWP-1.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 117 ++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath10k/sdio.h |  20 ++++++
 2 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index baa6051..f42aca6 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -417,6 +417,67 @@ static int ath10k_sdio_mbox_rx_process_packet(struct ath10k *ar,
 	return 0;
 }
 
+static struct ath10k_sdio_rx_request
+*ath10k_sdio_alloc_rx_req(struct ath10k *ar)
+{
+	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
+	struct ath10k_sdio_rx_request *rx_req;
+
+	spin_lock_bh(&ar_sdio->rx_lock);
+
+	if (list_empty(&ar_sdio->rx_req_freeq)) {
+		rx_req = NULL;
+		ath10k_dbg(ar, ATH10K_DBG_SDIO, "rx_req alloc fail\n");
+		goto out;
+	}
+
+	rx_req = list_first_entry(&ar_sdio->rx_req_freeq,
+				  struct ath10k_sdio_rx_request, list);
+	list_del(&rx_req->list);
+
+out:
+	spin_unlock_bh(&ar_sdio->rx_lock);
+	return rx_req;
+}
+
+static void ath10k_sdio_free_rx_req(struct ath10k *ar,
+				    struct ath10k_sdio_rx_request *rx_req)
+{
+	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
+
+	memset(rx_req, 0, sizeof(*rx_req));
+
+	spin_lock_bh(&ar_sdio->rx_lock);
+	list_add_tail(&rx_req->list, &ar_sdio->rx_req_freeq);
+	spin_unlock_bh(&ar_sdio->rx_lock);
+}
+
+static int ath10k_sdio_prep_async_rx_req(struct ath10k *ar,
+					 struct sk_buff *skb,
+					 struct ath10k_htc_ep *ep)
+{
+	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
+	struct ath10k_sdio_rx_request *rx_req;
+
+	/* Allocate a rx request for the message and queue it on the
+	 * SDIO rx workqueue.
+	 */
+	rx_req = ath10k_sdio_alloc_rx_req(ar);
+	if (!rx_req) {
+		ath10k_warn(ar, "unable to allocate rx request for async request\n");
+		return -ENOMEM;
+	}
+
+	rx_req->skb = skb;
+	rx_req->ep = ep;
+
+	spin_lock_bh(&ar_sdio->wr_async_lock_rx);
+	list_add_tail(&rx_req->list, &ar_sdio->wr_asyncq_rx);
+	spin_unlock_bh(&ar_sdio->wr_async_lock_rx);
+
+	return 0;
+}
+
 static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 					       u32 lookaheads[],
 					       int *n_lookahead)
@@ -470,10 +531,16 @@ static int ath10k_sdio_mbox_rx_process_packets(struct ath10k *ar,
 		if (ret)
 			goto out;
 
-		if (!pkt->trailer_only)
-			ep->ep_ops.ep_rx_complete(ar_sdio->ar, pkt->skb);
-		else
+		if (!pkt->trailer_only) {
+			ret = ath10k_sdio_prep_async_rx_req(ar, pkt->skb, ep);
+			if (ret)
+				kfree_skb(pkt->skb);
+			else
+				queue_work(ar->workqueue_aux,
+					   &ar_sdio->wr_async_work_rx);
+		} else {
 			kfree_skb(pkt->skb);
+		}
 
 		/* The RX complete handler now owns the skb...*/
 		pkt->skb = NULL;
@@ -1322,6 +1389,26 @@ static void __ath10k_sdio_write_async(struct ath10k *ar,
 	ath10k_sdio_free_bus_req(ar, req);
 }
 
+static void ath10k_rx_indication_async_work(struct work_struct *work)
+{
+	struct ath10k_sdio *ar_sdio = container_of(work, struct ath10k_sdio,
+						   wr_async_work_rx);
+	struct ath10k *ar = ar_sdio->ar;
+	struct ath10k_sdio_rx_request *req, *tmp_req;
+
+	spin_lock_bh(&ar_sdio->wr_async_lock_rx);
+
+	list_for_each_entry_safe(req, tmp_req, &ar_sdio->wr_asyncq_rx, list) {
+		list_del(&req->list);
+		spin_unlock_bh(&ar_sdio->wr_async_lock_rx);
+		req->ep->ep_ops.ep_rx_complete(ar, req->skb);
+		ath10k_sdio_free_rx_req(ar, req);
+		spin_lock_bh(&ar_sdio->wr_async_lock_rx);
+	}
+
+	spin_unlock_bh(&ar_sdio->wr_async_lock_rx);
+}
+
 static void ath10k_sdio_write_async_work(struct work_struct *work)
 {
 	struct ath10k_sdio *ar_sdio = container_of(work, struct ath10k_sdio,
@@ -1810,10 +1897,24 @@ static void ath10k_sdio_irq_disable(struct ath10k *ar)
 static void ath10k_sdio_hif_stop(struct ath10k *ar)
 {
 	struct ath10k_sdio_bus_request *req, *tmp_req;
+	struct ath10k_sdio_rx_request *rx_req, *tmp_rx_req;
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
 
 	ath10k_sdio_irq_disable(ar);
 
+	cancel_work_sync(&ar_sdio->wr_async_work_rx);
+
+	spin_lock_bh(&ar_sdio->wr_async_lock_rx);
+
+	/* Free all RX requests that have not been handled */
+	list_for_each_entry_safe(rx_req, tmp_rx_req, &ar_sdio->wr_asyncq_rx, list) {
+		list_del(&rx_req->list);
+		rx_req->ep->ep_ops.ep_rx_complete(ar, rx_req->skb);
+		ath10k_sdio_free_rx_req(ar, rx_req);
+	}
+
+	spin_unlock_bh(&ar_sdio->wr_async_lock_rx);
+
 	cancel_work_sync(&ar_sdio->wr_async_work);
 
 	spin_lock_bh(&ar_sdio->wr_async_lock);
@@ -2092,6 +2193,16 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 	for (i = 0; i < ATH10K_SDIO_BUS_REQUEST_MAX_NUM; i++)
 		ath10k_sdio_free_bus_req(ar, &ar_sdio->bus_req[i]);
 
+	spin_lock_init(&ar_sdio->rx_lock);
+	spin_lock_init(&ar_sdio->wr_async_lock_rx);
+	INIT_LIST_HEAD(&ar_sdio->rx_req_freeq);
+	INIT_LIST_HEAD(&ar_sdio->wr_asyncq_rx);
+
+	INIT_WORK(&ar_sdio->wr_async_work_rx, ath10k_rx_indication_async_work);
+
+	for (i = 0; i < ARRAY_SIZE(ar_sdio->rx_req); i++)
+		ath10k_sdio_free_rx_req(ar, &ar_sdio->rx_req[i]);
+
 	dev_id_base = FIELD_GET(QCA_MANUFACTURER_ID_BASE, id->device);
 	switch (dev_id_base) {
 	case QCA_MANUFACTURER_ID_AR6005_BASE:
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index 3ca76c7..9bb438e 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -38,6 +38,7 @@
 
 #define ATH10K_HIF_MBOX_NUM_MAX                 4
 #define ATH10K_SDIO_BUS_REQUEST_MAX_NUM         64
+#define ATH10K_SDIO_RX_REQUEST_MAX_NUM          1024
 
 #define ATH10K_SDIO_HIF_COMMUNICATION_TIMEOUT_HZ (100 * HZ)
 
@@ -98,6 +99,12 @@
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
 
@@ -187,9 +194,17 @@ struct ath10k_sdio {
 	struct ath10k_sdio_bus_request bus_req[ATH10K_SDIO_BUS_REQUEST_MAX_NUM];
 	/* free list of bus requests */
 	struct list_head bus_req_freeq;
+
 	/* protects access to bus_req_freeq */
 	spinlock_t lock;
 
+	/* available rx requests */
+	struct ath10k_sdio_rx_request rx_req[ATH10K_SDIO_RX_REQUEST_MAX_NUM];
+	/* free list of rx requests */
+	struct list_head rx_req_freeq;
+	/* protects access to rx_req_freeq */
+	spinlock_t rx_lock;
+
 	struct ath10k_sdio_rx_data rx_pkts[ATH10K_SDIO_MAX_RX_MSGS];
 	size_t n_rx_pkts;
 
@@ -209,6 +224,11 @@ struct ath10k_sdio {
 	struct list_head wr_asyncq;
 	/* protects access to wr_asyncq */
 	spinlock_t wr_async_lock;
+
+	struct work_struct wr_async_work_rx;
+	struct list_head wr_asyncq_rx;
+	/* protects access to wr_asyncq_rx */
+	spinlock_t wr_async_lock_rx;
 };
 
 static inline struct ath10k_sdio *ath10k_sdio_priv(struct ath10k *ar)
-- 
1.9.1

