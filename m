Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2947A4C02
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbjIRPYd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbjIRPYb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 11:24:31 -0400
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA4A199
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 08:20:44 -0700 (PDT)
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
        by forward205a.mail.yandex.net (Yandex) with ESMTP id C716847884
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 17:39:49 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:1182:0:640:88e4:0])
        by forward103a.mail.yandex.net (Yandex) with ESMTP id 5F28A46C86;
        Mon, 18 Sep 2023 17:39:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Idl4mwFDda60-H7Kc2gh3;
        Mon, 18 Sep 2023 17:39:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
        t=1695047958; bh=jsttuxtXQIlPOiO2R3RX0I/RYnNNzYqUEhVKCdtLPMs=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=oj7/71OdRS2Q7nEA3S703mVBGVHaPbbWLoVSNU2/9blbsk+6/M85x3DWE1JQNHmss
         pmW56pyLvMX+GHiBaeqTGMpN6nhW8Fo9UwUpT117Lt4zzT/c1h5xNiK5UeuYXPqE/4
         FgV9UykvQQWkgRuQIKLUUBoEvH5L/0JLyB9n89Hs=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: ath10k: simplify SDIO async handling
Date:   Mon, 18 Sep 2023 17:37:15 +0300
Message-ID: <20230918143718.78259-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an initial attempt to fix TODO found in SDIO bus support
code. As original comment says, an idea is to store SDIO-specific
'struct ath10k_sdio_bus_request' data within skb control buffer
instead of managing (a relatively large, 1024-items for now) free
list of the aforementioned structures.

Compile tested only so TESTERS WANTED.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath10k/sdio.c | 104 ++++++-------------------
 drivers/net/wireless/ath/ath10k/sdio.h |  14 +---
 2 files changed, 25 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
index 56fbcfb80bf8..996f179206b9 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -1285,40 +1285,6 @@ static int ath10k_sdio_bmi_exchange_msg(struct ath10k *ar,
 
 /* sdio async handling functions */
 
-static struct ath10k_sdio_bus_request
-*ath10k_sdio_alloc_busreq(struct ath10k *ar)
-{
-	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
-	struct ath10k_sdio_bus_request *bus_req;
-
-	spin_lock_bh(&ar_sdio->lock);
-
-	if (list_empty(&ar_sdio->bus_req_freeq)) {
-		bus_req = NULL;
-		goto out;
-	}
-
-	bus_req = list_first_entry(&ar_sdio->bus_req_freeq,
-				   struct ath10k_sdio_bus_request, list);
-	list_del(&bus_req->list);
-
-out:
-	spin_unlock_bh(&ar_sdio->lock);
-	return bus_req;
-}
-
-static void ath10k_sdio_free_bus_req(struct ath10k *ar,
-				     struct ath10k_sdio_bus_request *bus_req)
-{
-	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
-
-	memset(bus_req, 0, sizeof(*bus_req));
-
-	spin_lock_bh(&ar_sdio->lock);
-	list_add_tail(&bus_req->list, &ar_sdio->bus_req_freeq);
-	spin_unlock_bh(&ar_sdio->lock);
-}
-
 static void __ath10k_sdio_write_async(struct ath10k *ar,
 				      struct ath10k_sdio_bus_request *req)
 {
@@ -1338,8 +1304,6 @@ static void __ath10k_sdio_write_async(struct ath10k *ar,
 	} else if (req->comp) {
 		complete(req->comp);
 	}
-
-	ath10k_sdio_free_bus_req(ar, req);
 }
 
 /* To improve throughput use workqueue to deliver packets to HTC layer,
@@ -1457,15 +1421,16 @@ static void ath10k_sdio_write_async_work(struct work_struct *work)
 	struct ath10k_sdio *ar_sdio = container_of(work, struct ath10k_sdio,
 						   wr_async_work);
 	struct ath10k *ar = ar_sdio->ar;
-	struct ath10k_sdio_bus_request *req, *tmp_req;
+	struct ath10k_sdio_bus_request *req;
 	struct ath10k_mbox_info *mbox_info = &ar_sdio->mbox_info;
+	struct sk_buff *skb;
 
 	spin_lock_bh(&ar_sdio->wr_async_lock);
 
-	list_for_each_entry_safe(req, tmp_req, &ar_sdio->wr_asyncq, list) {
-		list_del(&req->list);
+	while ((skb = skb_dequeue(&ar_sdio->async_head))) {
 		spin_unlock_bh(&ar_sdio->wr_async_lock);
 
+		req = (struct ath10k_sdio_bus_request *)(skb->cb);
 		if (req->address >= mbox_info->htc_addr &&
 		    ar_sdio->mbox_state == SDIO_MBOX_SLEEP_STATE) {
 			ath10k_sdio_set_mbox_sleep(ar, false);
@@ -1483,23 +1448,15 @@ static void ath10k_sdio_write_async_work(struct work_struct *work)
 		ath10k_sdio_set_mbox_sleep(ar, true);
 }
 
-static int ath10k_sdio_prep_async_req(struct ath10k *ar, u32 addr,
-				      struct sk_buff *skb,
-				      struct completion *comp,
-				      bool htc_msg, enum ath10k_htc_ep_id eid)
+static void ath10k_sdio_prep_async_req(struct ath10k *ar, u32 addr,
+				       struct sk_buff *skb,
+				       struct completion *comp,
+				       bool htc_msg, enum ath10k_htc_ep_id eid)
 {
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
-	struct ath10k_sdio_bus_request *bus_req;
+	struct ath10k_sdio_bus_request *bus_req = (void *)skb->cb;
 
-	/* Allocate a bus request for the message and queue it on the
-	 * SDIO workqueue.
-	 */
-	bus_req = ath10k_sdio_alloc_busreq(ar);
-	if (!bus_req) {
-		ath10k_warn(ar,
-			    "unable to allocate bus request for async request\n");
-		return -ENOMEM;
-	}
+	BUILD_BUG_ON(sizeof(struct ath10k_sdio_bus_request) > sizeof(skb->cb));
 
 	bus_req->skb = skb;
 	bus_req->eid = eid;
@@ -1508,10 +1465,8 @@ static int ath10k_sdio_prep_async_req(struct ath10k *ar, u32 addr,
 	bus_req->comp = comp;
 
 	spin_lock_bh(&ar_sdio->wr_async_lock);
-	list_add_tail(&bus_req->list, &ar_sdio->wr_asyncq);
+	skb_queue_tail(&ar_sdio->async_head, skb);
 	spin_unlock_bh(&ar_sdio->wr_async_lock);
-
-	return 0;
 }
 
 /* IRQ handler */
@@ -1648,7 +1603,7 @@ static int ath10k_sdio_hif_tx_sg(struct ath10k *ar, u8 pipe_id,
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
 	enum ath10k_htc_ep_id eid;
 	struct sk_buff *skb;
-	int ret, i;
+	int i;
 
 	eid = pipe_id_to_eid(pipe_id);
 
@@ -1664,10 +1619,7 @@ static int ath10k_sdio_hif_tx_sg(struct ath10k *ar, u8 pipe_id,
 		/* Write TX data to the end of the mbox address space */
 		address = ar_sdio->mbox_addr[eid] + ar_sdio->mbox_size[eid] -
 			  skb->len;
-		ret = ath10k_sdio_prep_async_req(ar, address, skb,
-						 NULL, true, eid);
-		if (ret)
-			return ret;
+		ath10k_sdio_prep_async_req(ar, address, skb, NULL, true, eid);
 	}
 
 	queue_work(ar_sdio->workqueue, &ar_sdio->wr_async_work);
@@ -1934,10 +1886,8 @@ static void ath10k_sdio_irq_disable(struct ath10k *ar)
 	mutex_unlock(&irq_data->mtx);
 
 	init_completion(&irqs_disabled_comp);
-	ret = ath10k_sdio_prep_async_req(ar, MBOX_INT_STATUS_ENABLE_ADDRESS,
-					 skb, &irqs_disabled_comp, false, 0);
-	if (ret)
-		goto out;
+	ath10k_sdio_prep_async_req(ar, MBOX_INT_STATUS_ENABLE_ADDRESS,
+				   skb, &irqs_disabled_comp, false, 0);
 
 	queue_work(ar_sdio->workqueue, &ar_sdio->wr_async_work);
 
@@ -1957,14 +1907,13 @@ static void ath10k_sdio_irq_disable(struct ath10k *ar)
 
 	sdio_release_host(ar_sdio->func);
 
-out:
 	kfree_skb(skb);
 }
 
 static void ath10k_sdio_hif_stop(struct ath10k *ar)
 {
-	struct ath10k_sdio_bus_request *req, *tmp_req;
 	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
+	struct ath10k_sdio_bus_request *req;
 	struct sk_buff *skb;
 
 	ath10k_sdio_irq_disable(ar);
@@ -1979,18 +1928,16 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
 	spin_lock_bh(&ar_sdio->wr_async_lock);
 
 	/* Free all bus requests that have not been handled */
-	list_for_each_entry_safe(req, tmp_req, &ar_sdio->wr_asyncq, list) {
+	while ((skb = skb_dequeue(&ar_sdio->async_head))) {
 		struct ath10k_htc_ep *ep;
 
-		list_del(&req->list);
-
+		req = (struct ath10k_sdio_bus_request *)(skb->cb);
 		if (req->htc_msg) {
 			ep = &ar->htc.endpoint[req->eid];
 			ath10k_htc_notify_tx_completion(ep, req->skb);
-		} else if (req->skb) {
-			kfree_skb(req->skb);
+		} else {
+			kfree_skb(skb);
 		}
-		ath10k_sdio_free_bus_req(ar, req);
 	}
 
 	spin_unlock_bh(&ar_sdio->wr_async_lock);
@@ -2514,7 +2461,7 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 	enum ath10k_hw_rev hw_rev;
 	u32 dev_id_base;
 	struct ath10k_bus_params bus_params = {};
-	int ret, i;
+	int ret;
 
 	/* Assumption: All SDIO based chipsets (so far) are QCA6174 based.
 	 * If there will be newer chipsets that does not use the hw reg
@@ -2574,13 +2521,9 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 	ar_sdio->is_disabled = true;
 	ar_sdio->ar = ar;
 
-	spin_lock_init(&ar_sdio->lock);
 	spin_lock_init(&ar_sdio->wr_async_lock);
 	mutex_init(&ar_sdio->irq_data.mtx);
 
-	INIT_LIST_HEAD(&ar_sdio->bus_req_freeq);
-	INIT_LIST_HEAD(&ar_sdio->wr_asyncq);
-
 	INIT_WORK(&ar_sdio->wr_async_work, ath10k_sdio_write_async_work);
 	ar_sdio->workqueue = create_singlethread_workqueue("ath10k_sdio_wq");
 	if (!ar_sdio->workqueue) {
@@ -2588,10 +2531,9 @@ static int ath10k_sdio_probe(struct sdio_func *func,
 		goto err_core_destroy;
 	}
 
-	for (i = 0; i < ATH10K_SDIO_BUS_REQUEST_MAX_NUM; i++)
-		ath10k_sdio_free_bus_req(ar, &ar_sdio->bus_req[i]);
-
 	skb_queue_head_init(&ar_sdio->rx_head);
+	skb_queue_head_init(&ar_sdio->async_head);
+
 	INIT_WORK(&ar_sdio->async_work_rx, ath10k_rx_indication_async_work);
 
 	dev_id_base = (id->device & 0x0F00);
diff --git a/drivers/net/wireless/ath/ath10k/sdio.h b/drivers/net/wireless/ath/ath10k/sdio.h
index b6ac927628b1..02d951581dc7 100644
--- a/drivers/net/wireless/ath/ath10k/sdio.h
+++ b/drivers/net/wireless/ath/ath10k/sdio.h
@@ -29,7 +29,6 @@
 	(ATH10K_SDIO_MAX_BUFFER_SIZE - sizeof(struct ath10k_htc_hdr))
 
 #define ATH10K_HIF_MBOX_NUM_MAX                 4
-#define ATH10K_SDIO_BUS_REQUEST_MAX_NUM         1024
 
 #define ATH10K_SDIO_HIF_COMMUNICATION_TIMEOUT_HZ (100 * HZ)
 
@@ -104,10 +103,8 @@ enum sdio_mbox_state {
 #define ATH10K_CIS_READ_RETRY			10
 #define ATH10K_MIN_SLEEP_INACTIVITY_TIME_MS	50
 
-/* TODO: remove this and use skb->cb instead, much cleaner approach */
+/* Keep this small, see ath10k_sdio_prep_async_req() to check why. */
 struct ath10k_sdio_bus_request {
-	struct list_head list;
-
 	/* sdio address */
 	u32 address;
 
@@ -189,15 +186,8 @@ struct ath10k_sdio {
 	u32 mbox_addr[ATH10K_HTC_EP_COUNT];
 	u32 mbox_size[ATH10K_HTC_EP_COUNT];
 
-	/* available bus requests */
-	struct ath10k_sdio_bus_request bus_req[ATH10K_SDIO_BUS_REQUEST_MAX_NUM];
-	/* free list of bus requests */
-	struct list_head bus_req_freeq;
-
 	struct sk_buff_head rx_head;
-
-	/* protects access to bus_req_freeq */
-	spinlock_t lock;
+	struct sk_buff_head async_head;
 
 	struct ath10k_sdio_rx_data rx_pkts[ATH10K_SDIO_MAX_RX_MSGS];
 	size_t n_rx_pkts;
-- 
2.41.0

