Return-Path: <linux-wireless+bounces-37472-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2vrkMuxJJmqpUQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37472-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 06:49:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C10F652A46
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 06:49:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=phiality.com header.s=mail header.b=qu63RjVM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37472-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37472-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=phiality.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F25EF300D30B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 04:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F22EB5A6;
	Mon,  8 Jun 2026 04:49:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx-832558f3.phiality.com (mx-832558f3.phiality.com [45.146.253.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1502771B
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 04:49:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894186; cv=none; b=SWIAzU7sX92c5NTuHtJePbWS4jA9mO+X+8ph6uGD+nb5xIiuTsoc0vssNkmCVKQEYwT37WsJIg/e9WmHx3J3V9y7pKkKgSS902YvAd8+QmtjNBDGDnpLFURAq0Jcugcy9Dm1/EfhL43EFb+c8mLAzRKVYJB6fTZiahjkKB3S0lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894186; c=relaxed/simple;
	bh=bUtqkvcnxPEJGCyF3E8cbZ0viuoQRDzSx+0GqbThWxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7CbJZlO/ba2xELlSk11DarHS+fsmIFgoM9j99lUm0dqVdEPJAFKFPTZHlGmeGZUir7gRyiWVIEXsisk8TG9RnxD/A+PlTW8YwT0DB6bcNc2rkETiUK1R4GXh1galFKMWg3uB0/EmWB+K6cLH3nLXSuMNBM6gw0SLjPRUfNylwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=phiality.com; spf=pass smtp.mailfrom=phiality.com; dkim=pass (2048-bit key) header.d=phiality.com header.i=@phiality.com header.b=qu63RjVM; arc=none smtp.client-ip=45.146.253.46
From: Filip Bakreski <phial@phiality.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phiality.com;
	s=mail; t=1780893742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Iy8yUFtW4y8274BEW7dWJfpXx1/gVh8wBDX9SZzONOs=;
	b=qu63RjVM7A4asiFjsy2Y7qxymleX4eZvt5GKdopYdArDasE+4VGgR+aHKI+JtHxXoRTMMb
	9aynmPQYy0qgNa648JynVNOTamnjMXUJj/inCvpO7oW4NMGCupePMQAQbG1jdAc1+9kRyc
	PWukpBcFHkIch8AE3OZOsiK+wSlkPu1A4CFa84Y0y5R5drBITbanIG5VVseda8bHmDU9nX
	JEjyl34UIojkJ7wKAPCqjV7SJv41SGRRm5U/6Z23N4xzgFTgLnRg6flmpq73D2AXa7xmZy
	nP/F3GaBxGNkcq7I6laBNRs64kq124voJvOZlvA+wlALpVWEMetNSl2xxp7EIQ==
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt76u: use GRO on the USB RX path
Date: Mon,  8 Jun 2026 14:41:09 +1000
Message-ID: <20260608044109.31730-1-phial@phiality.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[phiality.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37472-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[phial@phiality.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,phiality.com:mid,phiality.com:dkim,phiality.com:from_mime,phiality.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C10F652A46

The USB RX path delivers frames to the stack via mt76_rx_complete() with
a NULL napi pointer, which takes the netif_receive_skb_list() path and
therefore never benefits from GRO. The DMA-based mt76 drivers pass a real
napi and get napi_gro_receive(); the USB path does not. For bulk TCP
traffic this is costly, as every segment traverses the network stack
individually instead of being coalesced.

Add a small container NAPI on a dummy netdev that the RX worker drives
manually: napi_schedule_prep() marks it scheduled, frames are delivered
through napi_gro_receive(), and napi_complete_done() flushes the coalesced
list. The poll handler is never invoked by the core.

On mt7921u at HE-MCS 11 (2x2, 80 MHz) this raises single-stream TCP
download throughput from ~383 to ~475 Mbit/s (~+24%), averaged over six
interleaved A/B measurements. The gain only applies while the link is not
RF-limited, as expected for a host-side optimisation.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Filip Bakreski <phial@phiality.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  4 +++
 drivers/net/wireless/mediatek/mt76/usb.c  | 36 ++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 07955555f..f5e52c1f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -668,6 +668,10 @@ struct mt76_usb {
 	struct mt76_worker status_worker;
 	struct mt76_worker rx_worker;
 
+	/* container NAPI used only to batch GRO for the RX worker */
+	struct net_device *napi_dev;
+	struct napi_struct napi;
+
 	struct work_struct stat_work;
 
 	u8 out_ep[__MT_EP_OUT_MAX];
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index d9638a9b7..f9c48140c 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -619,12 +619,31 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		mt76u_submit_rx_buf(dev, qid, urb);
 	}
 	if (qid == MT_RXQ_MAIN) {
+		struct napi_struct *napi = &dev->usb.napi;
+
 		local_bh_disable();
-		mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
+		/* Drive a container NAPI so the RX path can use
+		 * napi_gro_receive(): napi_schedule_prep() marks it SCHED and
+		 * napi_complete_done() flushes the coalesced GRO list. The poll
+		 * handler is never actually invoked by the core.
+		 */
+		if (dev->usb.napi_dev && napi_schedule_prep(napi)) {
+			mt76_rx_poll_complete(dev, MT_RXQ_MAIN, napi);
+			napi_complete_done(napi, 1);
+		} else {
+			mt76_rx_poll_complete(dev, MT_RXQ_MAIN, NULL);
+		}
 		local_bh_enable();
 	}
 }
 
+/* Never invoked by the core: the RX worker drives GRO via the napi manually. */
+static int mt76u_napi_poll(struct napi_struct *napi, int budget)
+{
+	napi_complete(napi);
+	return 0;
+}
+
 static void mt76u_rx_worker(struct mt76_worker *w)
 {
 	struct mt76_usb *usb = container_of(w, struct mt76_usb, rx_worker);
@@ -1051,6 +1070,13 @@ void mt76u_queues_deinit(struct mt76_dev *dev)
 	mt76u_stop_rx(dev);
 	mt76u_stop_tx(dev);
 
+	if (dev->usb.napi_dev) {
+		napi_disable(&dev->usb.napi);
+		netif_napi_del(&dev->usb.napi);
+		free_netdev(dev->usb.napi_dev);
+		dev->usb.napi_dev = NULL;
+	}
+
 	mt76u_free_rx(dev);
 	mt76u_free_tx(dev);
 }
@@ -1115,6 +1141,14 @@ int __mt76u_init(struct mt76_dev *dev, struct usb_interface *intf,
 	sched_set_fifo_low(usb->rx_worker.task);
 	sched_set_fifo_low(usb->status_worker.task);
 
+	/* container netdev + NAPI used only to enable GRO on the RX path */
+	usb->napi_dev = alloc_netdev_dummy(0);
+	if (!usb->napi_dev)
+		return -ENOMEM;
+	strscpy(usb->napi_dev->name, "mt76u-rx", sizeof(usb->napi_dev->name));
+	netif_napi_add(usb->napi_dev, &usb->napi, mt76u_napi_poll);
+	napi_enable(&usb->napi);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__mt76u_init);

base-commit: 5f6099446d1ddb888e36cdf93b6a0551f05c1267
-- 
2.54.0


