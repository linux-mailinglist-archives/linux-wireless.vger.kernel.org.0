Return-Path: <linux-wireless+bounces-37544-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mxSwCmVfJ2p+vQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37544-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:33:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF4865B5DE
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 02:33:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phiality.com header.s=mail header.b="Kvf/7l9U";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37544-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37544-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=phiality.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABCF13019BAA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 00:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A842AF1D;
	Tue,  9 Jun 2026 00:32:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx-832558f3.phiality.com (mx-832558f3.phiality.com [45.146.253.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE8E1C862D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 00:32:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965152; cv=none; b=Y0m20UTo97GaQy7/xgjIgot8hO7jiiJAu4iIy37UPKYWhdtE5Ka0xPqwzt18CiVN8E8GHTaXSEsbV/ZEhhVmvN430rzqj6CZjY2IA/xQhuZnB4uKJb4UPvkZV9kxqTqz0p/yYvr1vLbGZL44qDBdJ85u77c0RUoaR+rtB+/RS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965152; c=relaxed/simple;
	bh=+VkamQZWn+1MqAdu/nznLATM+iMllMyJPJBmkn3CCks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RKmeDIK1SXG2C8Chfl2izraO7rcm74zyVt7jC/sA4HXiR2johQ8nlLFBs11919o+W7eT7Yr6mBiF+ZRFgaz6FBqkl/UBUARRMKkBu9AjEL5Z8z79E5RV1AzjK4OJOTFwJ5X4u3Xnl3hi8SiuI1pSCq9h1uDBwRK5zZv75Olb5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=phiality.com; spf=pass smtp.mailfrom=phiality.com; dkim=pass (2048-bit key) header.d=phiality.com header.i=@phiality.com header.b=Kvf/7l9U; arc=none smtp.client-ip=45.146.253.46
From: Filip Bakreski <phial@phiality.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phiality.com;
	s=mail; t=1780965149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EF2hRcIcyptCUl7RETqSysH9DXjxr+BTw5MKTmLBCzM=;
	b=Kvf/7l9UNFNNKD8yCQQR6Tqsq3MFgT0A6P6YTOFu4X54YHey23R1JsDYS9p5mnaL8kcZVa
	kGNnJ83AHbbi5viuJfFgpmpb5P/LM+IaiqxP+Dgh4mUhr1yIC4oAWKB5f2227F4AGR9Kj4
	31RZR9F9ubboT3Yni7J2i6nSxHLf48jbQOz0WfWSzbNzd69TshJRxA/D4NfrTlECcx7PYn
	2uavdaHC4jfiGjdRipSfikGgoE9cNLtz0W/dftMzet/jQnvZAqZRHr/qpPKT8WVkG4ZHmE
	M7ZffuX/aw9YnDT+FFiJqYlbA/qu01qmgVSUFFLB1K/QPe/wTVa43K5q/BZCIQ==
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: mt76u: use a threaded NAPI for the RX path
Date: Tue,  9 Jun 2026 10:32:24 +1000
Message-ID: <20260609003224.132191-1-phial@phiality.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[phiality.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37544-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AF4865B5DE

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
v2:
- Service MT_RXQ_MAIN from a threaded NAPI instead of a NAPI driven
  manually from the RX worker; on mt7921u the threaded variant measured
  ~39% faster (~588 vs ~424 Mbit/s, fast.com) (Lorenzo Bianconi).
- Reuse mt76_dev's existing napi_dev/napi[] instead of adding new fields
  to struct mt76_usb (Lorenzo Bianconi).

v1: https://lore.kernel.org/linux-wireless/20260608044109.31730-1-phial@phiality.com/

 drivers/net/wireless/mediatek/mt76/usb.c | 56 +++++++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index d9638a9b7..aef8f855f 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -580,7 +580,10 @@ static void mt76u_complete_rx(struct urb *urb)
 
 	q->head = (q->head + 1) % q->ndesc;
 	q->queued++;
-	mt76_worker_schedule(&dev->usb.rx_worker);
+	if (q == &dev->q_rx[MT_RXQ_MAIN])
+		napi_schedule(&dev->napi[MT_RXQ_MAIN]);
+	else
+		mt76_worker_schedule(&dev->usb.rx_worker);
 out:
 	spin_unlock_irqrestore(&q->lock, flags);
 }
@@ -618,11 +621,23 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
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
@@ -632,8 +647,12 @@ static void mt76u_rx_worker(struct mt76_worker *w)
 	int i;
 
 	rcu_read_lock();
-	mt76_for_each_q_rx(dev, i)
+	mt76_for_each_q_rx(dev, i) {
+		/* MT_RXQ_MAIN is serviced by the threaded NAPI poll */
+		if (i == MT_RXQ_MAIN)
+			continue;
 		mt76u_process_rx_queue(dev, &dev->q_rx[i]);
+	}
 	rcu_read_unlock();
 }
 
@@ -723,6 +742,8 @@ void mt76u_stop_rx(struct mt76_dev *dev)
 	int i;
 
 	mt76_worker_disable(&dev->usb.rx_worker);
+	if (dev->napi_dev)
+		napi_disable(&dev->napi[MT_RXQ_MAIN]);
 
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
@@ -751,6 +772,8 @@ int mt76u_resume_rx(struct mt76_dev *dev)
 	}
 
 	mt76_worker_enable(&dev->usb.rx_worker);
+	if (dev->napi_dev)
+		napi_enable(&dev->napi[MT_RXQ_MAIN]);
 
 	return 0;
 }
@@ -1051,6 +1074,13 @@ void mt76u_queues_deinit(struct mt76_dev *dev)
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
@@ -1115,6 +1145,18 @@ int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
 	sched_set_fifo_low(usb->rx_worker.task);
 	sched_set_fifo_low(usb->status_worker.task);
 
+	/* threaded NAPI on a dummy netdev (reusing mt76_dev's napi_dev/napi[])
+	 * services the MAIN RX queue and gives the RX path GRO
+	 */
+	dev->napi_dev = alloc_netdev_dummy(sizeof(struct mt76_dev *));
+	if (!dev->napi_dev)
+		return -ENOMEM;
+	*(struct mt76_dev **)netdev_priv(dev->napi_dev) = dev;
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


