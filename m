Return-Path: <linux-wireless+bounces-37578-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id trhNKw7yJ2pH6AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37578-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:59:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D465F345
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:59:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phiality.com header.s=mail header.b=UktykqRp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37578-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37578-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=phiality.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89615315102F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3BC3F8896;
	Tue,  9 Jun 2026 10:53:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx-832558f3.phiality.com (mx-832558f3.phiality.com [45.146.253.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843883F9F3D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 10:53:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002395; cv=none; b=WAHFGrV4vaFjkpkVEwd2LLwrQakEjsvage9X5tQ5Gcqo960ppdyYBfpknC/4u3+Sqvz3yj0XIyCTRGZLiGtCh49+RaIP8oalEOmnjGl9O9yZOFwZpMMYXNhH7eKqHpamFAQzT14ORNVrn3gQA3JNa7lRyZqFUgQAjwnrsEm8P4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002395; c=relaxed/simple;
	bh=5TO6NkP8j8s8pp1FwyWGBv0JV4kBZKJqH3+7DCVZooE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcHlOK1s9Qc1w4VSoBpmMzCnRSHsyePv14MYUtfJAKadAnSz/IGQccTw52vDyG2n7FHrgW+QBKxOHeaw2nwkhsbnCq/2lQUwLy7GtOgS7KxIt+LamLwrlXqbvVhIxw2Oo5uqJwVvJyPe5wpMxZcbpKrP0iIFOMK2LjSLybz2Xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=phiality.com; spf=pass smtp.mailfrom=phiality.com; dkim=pass (2048-bit key) header.d=phiality.com header.i=@phiality.com header.b=UktykqRp; arc=none smtp.client-ip=45.146.253.46
From: Filip Bakreski <phial@phiality.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phiality.com;
	s=mail; t=1781002386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dioNhcM88oeb4AJmnZe8eaaNKVz9pkcjonCD5vMBKfs=;
	b=UktykqRp32ScryZkpgGhwaKqqG2X2WJYi6KWGnhs0YzxAWQVsCd6wQd77Abt/IzPtb8DW/
	aRYx4XtCtD6v7EdX6yYXUFDrdGmBUizNPjv0j/KT6QPqWblPCglcxrN/Pg2ARbEK8Pq9WS
	igpF9tFhZLTit+yjRUuKn1MV7sdyfBT8BIAUZZsIRcLUE9izjQ4EWX1RC0aB/++UZilNzq
	XV3WjUlcg4MFLRKlGoAqY7dqYTE5nKGDjV/x67Q1rUe662VnttK0MTZy6NVRVqY/0AFLmo
	esj0B58xNu05GInyfEYekY0eZ+u9oVIEKFwiiwQZ9hm5SYx8Jl08HSIs8bjipQ==
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH v3] wifi: mt76: mt76u: use a threaded NAPI for the RX path
Date: Tue,  9 Jun 2026 20:53:01 +1000
Message-ID: <20260609105301.196302-1-phial@phiality.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[phiality.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[phiality.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37578-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[phial@phiality.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[phiality.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phial@phiality.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,phiality.com:dkim,phiality.com:email,phiality.com:mid,phiality.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 232D465F345

The USB RX path delivers frames to the stack via mt76_rx_complete() with
a NULL napi pointer, taking the netif_receive_skb_list() path, so it never
benefits from GRO -- unlike the DMA-based mt76 drivers, which pass a real
napi and use napi_gro_receive(). For bulk TCP traffic this is costly, as
every segment traverses the stack individually.

Service the MT_RXQ_MAIN queue from a threaded NAPI, reusing mt76_dev's
existing napi_dev and napi[] rather than adding new fields. The URB
completion handler schedules the napi; its poll drains the URBs, builds
the skbs, resubmits and delivers them through napi_gro_receive(). The MCU
queue stays on the existing RX worker. This enables GRO and moves RX
processing into its own kernel thread, parallelising the datapath.

On mt7921u at HE-MCS 11 (2x2, 80 MHz; fast.com, multiple streams) this
averages ~588 Mbit/s, versus ~424 Mbit/s when the same napi is instead
driven manually from the RX worker, and ~380 Mbit/s for the unmodified
driver.

Suggested-by: Lorenzo Bianconi <lorenzo@kernel.org>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Filip Bakreski <phial@phiality.com>
---
v3:
- Address review nits: add blank lines for readability and use a priv
  pointer for netdev_priv() like mt76_dma_init() (Lorenzo Bianconi).

v2: https://lore.kernel.org/linux-wireless/20260609003224.132191-1-phial@phiality.com/
v1: https://lore.kernel.org/linux-wireless/20260608044109.31730-1-phial@phiality.com/

 drivers/net/wireless/mediatek/mt76/usb.c | 61 +++++++++++++++++++++---
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index d9638a9b7..77a8e35b1 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -580,7 +580,11 @@ static void mt76u_complete_rx(struct urb *urb)
 
 	q->head = (q->head + 1) % q->ndesc;
 	q->queued++;
-	mt76_worker_schedule(&dev->usb.rx_worker);
+
+	if (q == &dev->q_rx[MT_RXQ_MAIN])
+		napi_schedule(&dev->napi[MT_RXQ_MAIN]);
+	else
+		mt76_worker_schedule(&dev->usb.rx_worker);
 out:
 	spin_unlock_irqrestore(&q->lock, flags);
 }
@@ -618,11 +622,23 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		}
 		mt76u_submit_rx_buf(dev, qid, urb);
 	}
-	if (qid == MT_RXQ_MAIN) {
-		local_bh_disable();
-		mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
-		local_bh_enable();
-	}
+}
+
+/* Threaded NAPI poll for the MAIN RX queue: drain URBs, build skbs, resubmit,
+ * then deliver through napi_gro_receive() and let napi_complete() flush GRO.
+ */
+static int mt76u_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct mt76_dev *dev = mt76_priv(napi->dev);
+
+	rcu_read_lock();
+	mt76u_process_rx_queue(dev, &dev->q_rx[MT_RXQ_MAIN]);
+	mt76_rx_poll_complete(dev, MT_RXQ_MAIN, napi);
+	rcu_read_unlock();
+
+	napi_complete(napi);
+
+	return 0;
 }
 
 static void mt76u_rx_worker(struct mt76_worker *w)
@@ -632,8 +648,13 @@ static void mt76u_rx_worker(struct mt76_worker *w)
 	int i;
 
 	rcu_read_lock();
-	mt76_for_each_q_rx(dev, i)
+	mt76_for_each_q_rx(dev, i) {
+		/* MT_RXQ_MAIN is serviced by the threaded NAPI poll */
+		if (i == MT_RXQ_MAIN)
+			continue;
+
 		mt76u_process_rx_queue(dev, &dev->q_rx[i]);
+	}
 	rcu_read_unlock();
 }
 
@@ -723,6 +744,8 @@ void mt76u_stop_rx(struct mt76_dev *dev)
 	int i;
 
 	mt76_worker_disable(&dev->usb.rx_worker);
+	if (dev->napi_dev)
+		napi_disable(&dev->napi[MT_RXQ_MAIN]);
 
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
@@ -751,6 +774,8 @@ int mt76u_resume_rx(struct mt76_dev *dev)
 	}
 
 	mt76_worker_enable(&dev->usb.rx_worker);
+	if (dev->napi_dev)
+		napi_enable(&dev->napi[MT_RXQ_MAIN]);
 
 	return 0;
 }
@@ -1051,6 +1076,13 @@ void mt76u_queues_deinit(struct mt76_dev *dev)
 	mt76u_stop_rx(dev);
 	mt76u_stop_tx(dev);
 
+	/* mt76u_stop_rx() (above) already napi_disable()d the MAIN queue */
+	if (dev->napi_dev) {
+		netif_napi_del(&dev->napi[MT_RXQ_MAIN]);
+		free_netdev(dev->napi_dev);
+		dev->napi_dev = NULL;
+	}
+
 	mt76u_free_rx(dev);
 	mt76u_free_tx(dev);
 }
@@ -1078,6 +1110,7 @@ int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct mt76_usb *usb = &dev->usb;
+	struct mt76_dev **priv;
 	int err;
 
 	INIT_WORK(&usb->stat_work, mt76u_tx_status_data);
@@ -1115,6 +1148,20 @@ int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
 	sched_set_fifo_low(usb->rx_worker.task);
 	sched_set_fifo_low(usb->status_worker.task);
 
+	/* threaded NAPI on a dummy netdev (reusing mt76_dev's napi_dev/napi[])
+	 * services the MAIN RX queue and gives the RX path GRO
+	 */
+	dev->napi_dev = alloc_netdev_dummy(sizeof(struct mt76_dev *));
+	if (!dev->napi_dev)
+		return -ENOMEM;
+
+	priv = netdev_priv(dev->napi_dev);
+	*priv = dev;
+	strscpy(dev->napi_dev->name, "mt76u-rx", sizeof(dev->napi_dev->name));
+	dev->napi_dev->threaded = 1;
+	netif_napi_add(dev->napi_dev, &dev->napi[MT_RXQ_MAIN], mt76u_napi_poll);
+	napi_enable(&dev->napi[MT_RXQ_MAIN]);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__mt76u_init);

base-commit: 5f6099446d1ddb888e36cdf93b6a0551f05c1267
-- 
2.54.0


