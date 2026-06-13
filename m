Return-Path: <linux-wireless+bounces-37773-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U68IO/fdLWoflwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37773-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8367FF44
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37773-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37773-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 475C0301BA73
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D12032D;
	Sat, 13 Jun 2026 22:47:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CF3290AF
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:47:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390834; cv=none; b=ZP2BCDLp51KUDuIKhji9rtSqSqgEqhv6JEdTQZKVvpH2wC8JXptHcrxh/3TnJeU6eW5eaj+jrrnhHlIdMRztRtuZxWtnYkPaSw6XT1CHF3gW2XOigraI8l31zJE60QJIulPnWTTErI4xHovdtGFp7Fa7x/c3qIfm3sH/UKhSQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390834; c=relaxed/simple;
	bh=ZP2RYxJVwTI4aErWcPFPPLFzdyS+fhM+HBHIFf2+0NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nf7w4dc4iqwtbI9ueEkOGl50nj8Om7lomzPTkwg8R2QNXDqr4qXKBFFD5msQ7WIQhROQZ6dFDdodjjIcjrXHbxtqmp75pdX0yaO2v1UhfwKsxea4RmBDgC4WKYcmZ4boK9aTwolXzfkse03nOepwL10Le6XMT7nrOKza8LJ2xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.48
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1390f75d8bbso1725006c88.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390833; x=1781995633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dvt+/gI/3HJJNOdlepGPAqH24aZUV8l0eiSTSZ6kD30=;
        b=Ok2zuMCoKR97JmvhmbtaWpX5YMuy0ANmK1z2Dvyd39/H3gvyMxoy6AdO6gUFx1FiZ8
         3qLIiWkvaNpzKRXXrWeno45YX1iH2MzXbLmYxrZ/O7ljhAPtu1QTxrLC7ueu/gkt7ddp
         ZUYjP/oo1sLIQeGyo+QBXh3JfOmsKc1XyYH/8T7W9+jY2nBoGYiudEb7dAffw5qeWXwM
         VSrC4glAM5EQnYxUhZbBOpnp1DmBxvuCSwGszhWL394KRo8V3QzEYFhYGSgwnn/CYHQM
         Y81mx35ANZsUYEh0p3lOstXrZTJLKPsGOTZ6yD/dtENrESt4FyaabEfUS9sBCO9yt/Bv
         20xA==
X-Gm-Message-State: AOJu0YwWJcGRHBqWCt9gxLZrblrPH2TDMP1tjtlfuFY46nUOOJmjhi5y
	lb1h/mM+v567fy1UTs6Us9JSmSYUe3GSyyNFVM2gt8X1tWcvL4IrzK0m
X-Gm-Gg: Acq92OHhfUAiZeWdTXb8/B1Be2oC6bNumMH9kWCYPE8l7OkqO0Quv59xjqifQXEb+cP
	oGz+iB/A0r29o+bWQ+QU4abaGeryKiXdr37UDOD+IJZVBgrTEPHNZ873mrOykRSeFO/vkWFEiU1
	QBf5CCS+oKAecCR5NdGEUsLdyUOK4UUom/V0zOx5ktlnUF53scx5LTEndcKDQOvGZSvLeDfEjr8
	mP3nXXQn/BL5ozOexlvFacPtG7MrCehVFei64GgDkBW65VT+Yln6Y7+hQ0mKdCRahpZaX7yDltA
	PkvrkqD1jS65oDxVi1hto+fQOG4u31QY2BEJa23d3fsFOagv+IacvOi8rV+qmpsZF+5t+c7ZgMo
	hjVrHoZTk4Ho+qa0qfd3mqGWr5O2EaYy2W9y7lBlprbKjl2ims8cdWX73z4PaWlvny98rktzb4s
	yugzzu3dIuns+S8yZc//4uzlPNkesRB7BGfrCxGzJU8+Wy9S14ZTJewuyLwQ2xGQZvarNiRtgnV
	nXmzM1yavEMZtzlTo6kzVwE/80+njoAMH98Hrw2GCI8pHV0X6E=
X-Received: by 2002:a05:7022:4a4:b0:138:4023:8c1 with SMTP id a92af1059eb24-1384bb34465mr3561333c88.11.1781390832584;
        Sat, 13 Jun 2026 15:47:12 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm6345380c88.14.2026.06.13.15.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:47:12 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 2/5] wifi: mt76: usb: support out-of-order RX URB completion
Date: Sat, 13 Jun 2026 17:46:52 -0500
Message-ID: <20260613224655.2405686-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613224655.2405686-1-sean.wang@kernel.org>
References: <20260613224655.2405686-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37773-lists,linux-wireless=lfdr.de];
	FORGED_SENDER(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57B8367FF44

From: Sean Wang <sean.wang@mediatek.com>

Keep per-URB RX queue context and complete entries by their real queue
position instead of assuming the completed URB is always at q->head.

USB RX URBs can complete out of order, and advancing q->head too early
can corrupt RX queue accounting and process buffers in the wrong order.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  5 ++
 drivers/net/wireless/mediatek/mt76/usb.c  | 77 ++++++++++++++++-------
 2 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 122e77a5f2f4..81740aa7df71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -655,6 +655,11 @@ struct mt76_mcu {
 	wait_queue_head_t wait;
 };
 
+struct mt76u_rx_entry {
+	struct mt76_queue_entry *e;
+	struct mt76_queue *q;
+};
+
 #define MT_TX_SG_MAX_SIZE	8
 #define MT_RX_SG_MAX_SIZE	4
 #define MT_NUM_TX_ENTRIES	256
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index ce68e1d0c786..cab36630c978 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -397,11 +397,25 @@ mt76u_urb_alloc(struct mt76_dev *dev, struct mt76_queue_entry *e,
 	return 0;
 }
 
+static void mt76u_urb_free(struct urb *urb)
+{
+	int i;
+
+	for (i = 0; i < urb->num_sgs; i++)
+		mt76_put_page_pool_buf(sg_virt(&urb->sg[i]), false);
+
+	if (urb->transfer_buffer)
+		mt76_put_page_pool_buf(urb->transfer_buffer, false);
+
+	usb_free_urb(urb);
+}
+
 static int
 mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue *q,
 		   struct mt76_queue_entry *e)
 {
 	enum mt76_rxq_id qid = q - &dev->q_rx[MT_RXQ_MAIN];
+	struct mt76u_rx_entry *rxe;
 	int err, sg_size;
 
 	sg_size = qid == MT_RXQ_MAIN ? MT_RX_SG_MAX_SIZE : 0;
@@ -409,20 +423,25 @@ mt76u_rx_urb_alloc(struct mt76_dev *dev, struct mt76_queue *q,
 	if (err)
 		return err;
 
-	return mt76u_refill_rx(dev, q, e->urb, sg_size);
-}
-
-static void mt76u_urb_free(struct urb *urb)
-{
-	int i;
+	rxe = kzalloc_obj(*rxe, GFP_KERNEL);
+	if (!rxe) {
+		usb_free_urb(e->urb);
+		e->urb = NULL;
+		return -ENOMEM;
+	}
 
-	for (i = 0; i < urb->num_sgs; i++)
-		mt76_put_page_pool_buf(sg_virt(&urb->sg[i]), false);
+	rxe->e = e;
+	rxe->q = q;
+	e->urb->context = rxe;
 
-	if (urb->transfer_buffer)
-		mt76_put_page_pool_buf(urb->transfer_buffer, false);
+	err = mt76u_refill_rx(dev, q, e->urb, sg_size);
+	if (err) {
+		kfree(rxe);
+		mt76u_urb_free(e->urb);
+		e->urb = NULL;
+	}
 
-	usb_free_urb(urb);
+	return err;
 }
 
 static void
@@ -566,8 +585,12 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
 static void mt76u_complete_rx(struct urb *urb)
 {
 	struct mt76_dev *dev = dev_get_drvdata(&urb->dev->dev);
-	struct mt76_queue *q = urb->context;
+	struct mt76u_rx_entry *rxe = urb->context;
+	struct mt76_queue_entry *e = rxe->e;
+	unsigned int idx, pending, pos;
+	struct mt76_queue *q = rxe->q;
 	unsigned long flags;
+	bool wake = false;
 
 	trace_rx_urb(dev, urb);
 
@@ -586,18 +609,28 @@ static void mt76u_complete_rx(struct urb *urb)
 	}
 
 	spin_lock_irqsave(&q->lock, flags);
-	if (WARN_ONCE(q->entry[q->head].urb != urb, "rx urb mismatch"))
+	idx = e - q->entry;
+	pending = q->ndesc - q->queued;
+	pos = (idx + q->ndesc - q->head) % q->ndesc;
+	if (WARN_ONCE(idx >= q->ndesc || pos >= pending, "rx urb mismatch"))
 		goto out;
 
-	q->head = (q->head + 1) % q->ndesc;
-	q->queued++;
-
-	if (q == &dev->q_rx[MT_RXQ_MAIN])
-		napi_schedule(&dev->napi[MT_RXQ_MAIN]);
-	else
-		mt76_worker_schedule(&dev->usb.rx_worker);
+	e->done = true;
+	while (q->entry[q->head].done) {
+		q->entry[q->head].done = false;
+		q->head = (q->head + 1) % q->ndesc;
+		q->queued++;
+		wake = true;
+	}
 out:
 	spin_unlock_irqrestore(&q->lock, flags);
+
+	if (wake) {
+		if (q == &dev->q_rx[MT_RXQ_MAIN])
+			napi_schedule(&dev->napi[MT_RXQ_MAIN]);
+		else
+			mt76_worker_schedule(&dev->usb.rx_worker);
+	}
 }
 
 static int
@@ -607,7 +640,7 @@ mt76u_submit_rx_buf(struct mt76_dev *dev, enum mt76_rxq_id qid,
 	int ep = qid == MT_RXQ_MAIN ? MT_EP_IN_PKT_RX : MT_EP_IN_CMD_RESP;
 
 	mt76u_fill_bulk_urb(dev, USB_DIR_IN, ep, urb,
-			    mt76u_complete_rx, &dev->q_rx[qid]);
+			    mt76u_complete_rx, urb->context);
 	trace_submit_urb(dev, urb);
 
 	return usb_submit_urb(urb, GFP_ATOMIC);
@@ -678,6 +711,7 @@ mt76u_submit_rx_buffers(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 	spin_lock_irqsave(&q->lock, flags);
 	for (i = 0; i < q->ndesc; i++) {
+		q->entry[i].done = false;
 		err = mt76u_submit_rx_buf(dev, qid, q->entry[i].urb);
 		if (err < 0)
 			break;
@@ -733,6 +767,7 @@ mt76u_free_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!q->entry[i].urb)
 			continue;
 
+		kfree(q->entry[i].urb->context);
 		mt76u_urb_free(q->entry[i].urb);
 		q->entry[i].urb = NULL;
 	}
-- 
2.43.0


