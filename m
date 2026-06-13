Return-Path: <linux-wireless+bounces-37775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7meJOADeLWoilwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEAA67FF4F
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37775-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37775-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C513300B3F2
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F06B342509;
	Sat, 13 Jun 2026 22:47:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E693290AF
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:47:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390841; cv=none; b=slIDrXXIiPRTz9f3pYb3sCM0q0otZHB2iqMDA0EaXfn9ho6dj/HQHd4ET8MeI20Iizs5A8tBrh3YI1oAjDD+mGH4I0EL8NZnDYFfNutqAlUqK9SAHL5vtwLSBo7LCu2ac5DMF+nNqKj0ia5soXz6/MZGk1YyRieYP99gp9boHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390841; c=relaxed/simple;
	bh=3zuNkaap7WALltlhFycvxeIdz2oxk/cfN37foopCS8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3Bm6ZpwO1yunGTbdng9gDjs8HnrKJpy8i4GVO3pdCzwKjLgfeYBvJSQN4QQ5XJ4DHaHfkQOtfslgmptl5/n/JoTZ7TLAtHAPR7IHyWINYWHBmtgz/SOj4BkbFYieQrexoTtWaEcNU4M1XPrNBlnNB38pO/ECaIL6fFG2X2m5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-13810b63a1aso5089083c88.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390839; x=1781995639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rh/2Eq507HykjFUSyM79lweTsoPJN45Ln2Hf87GqCWg=;
        b=XAv6R77uckJUtrutEBfUKDUQEogciNvF5g7brhaTtm6YGxlDsfJkgcwvqT2LrLtn8s
         G90p/wSB3q9NqL0htIJ2O/L6+3DrE3bX/bt9BjPuQ7hI0QJ6jsImohQIB1V4oI3s4wsl
         It44lsGboweZC0QJYHAWPZLUwGiECMs25iHIGXoltcn7vMql1xvjAztJGveslhjFj06f
         VIgWwprgXlnqoJbfO4PUbNtZZOvWDF8T73EWqinElikG5+MXK2T3MlNWjLpfj6tZCxfM
         8u1oaLkZx3N1V3MG2uTiy9hNEMNal8h9QGYgJag+600Iyk4U5SBaUGapYpTQ5guheY1E
         b4BQ==
X-Gm-Message-State: AOJu0Yzl68zYARrJ1ikNlol/NXQLNx3JPf6kIwUI37AHWOPmwG+Wp43k
	uYxhw8rXavDXQDOxOxfLbPGWk57z+GA3j0i4sGEKpEmDNQPjIqN1P2U9
X-Gm-Gg: Acq92OGn7w2g1U4YP+HyanKNgQLmzdyME5R3HBZOk/8nkP/NOq1JkhPcILuOePbjk+F
	K95jzrHyL8Ft2VrVWASkY1Z106LHRhWPpWxRGc6WxVWIM/VZQqLs4M7d3AiTe8tiHJ/u1IHf0Pu
	+HGM98F0poExvtyW3sogNojgK898ywv0Q8RSpldTMnBFXoVscdPhOqubdFEMcR85c/jGPJPZPq9
	MUTxCpvNBlAyYslMXbkdzriNnIyQgTUaOlvOIRev0hdOocMHDnhVtgqXhOvr7roy2pp3hNUvqIM
	8rjIWmiX9HcUGR3qWGi621ckjwVLu3ElHHYjHtqhjxkJUAgRi8wfWzhWyb/NC66SNUYNq0O+ESS
	p9IFEbSbS1OC1rB+Qu5UQ7NoYl69+U0SGqgKlI57fG96DZi7qXFZLzLPuTDuCjUQg1aFLc8PlrD
	OcMWfjG5hI21CL/hEgFB1b6rPgQV7eEBEYjLn+VbUEw5HSvlNmjxxHHEAz2IDfBDHLIawI0S50t
	P448lcfa2V3VEOK489yywl0GRipwv3XODfRrm3M+bOA9d85HqA=
X-Received: by 2002:a05:7022:f82:b0:12d:d972:b96e with SMTP id a92af1059eb24-1384bba8b3amr3914654c88.20.1781390839035;
        Sat, 13 Jun 2026 15:47:19 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm6345380c88.14.2026.06.13.15.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:47:18 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4/5] wifi: mt76: usb: add debugfs aggregation stats
Date: Sat, 13 Jun 2026 17:46:54 -0500
Message-ID: <20260613224655.2405686-5-sean.wang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:sean.wang@mediatek.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37775-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DEAA67FF4F

From: Sean Wang <sean.wang@mediatek.com>

Add USB debugfs counters for RX/TX URBs, packets, bytes and recent RX
aggregation frame counts.

These stats make it easier to verify whether USB RX aggregation are working
as expected, and to debug throughput issues without adding
temporary driver logs.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 35 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h    | 12 ++++++
 drivers/net/wireless/mediatek/mt76/usb.c     | 39 ++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index a5ac6ca86735..b3f1bc3cd69b 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -88,6 +88,38 @@ static int mt76_rx_queues_read(struct seq_file *s, void *data)
 	return 0;
 }
 
+static int mt76_usb_stats_read(struct seq_file *s, void *data)
+{
+	struct mt76_dev *dev = dev_get_drvdata(s->private);
+	struct mt76_usb *usb = &dev->usb;
+	u64 seq;
+	int i, n;
+
+	seq_printf(s, "rx_aggr\t%d\n", usb->rx_aggr.enable);
+	seq_printf(s, "sg_en\t%d\n", usb->sg_en);
+	seq_printf(s, "tx_urbs\t%lld\n", atomic64_read(&usb->stats.tx_urbs));
+	seq_printf(s, "tx_packets\t%lld\n",
+		   atomic64_read(&usb->stats.tx_packets));
+	seq_printf(s, "tx_bytes\t%lld\n", atomic64_read(&usb->stats.tx_bytes));
+	seq_printf(s, "rx_urbs\t%lld\n", atomic64_read(&usb->stats.rx_urbs));
+	seq_printf(s, "rx_packets\t%lld\n",
+		   atomic64_read(&usb->stats.rx_packets));
+	seq_printf(s, "rx_bytes\t%lld\n", atomic64_read(&usb->stats.rx_bytes));
+
+	seq = atomic64_read(&usb->stats.rx_aggr_seq);
+	seq_puts(s, "rx_aggr_nframes");
+	n = min_t(u64, seq, MT_USB_AGGR_STATS_LEN);
+	for (i = 0; i < n; i++) {
+		u64 idx = seq - n + i;
+		u64 slot = idx % MT_USB_AGGR_STATS_LEN;
+
+		seq_printf(s, " %u", READ_ONCE(usb->stats.rx_aggr_nframes[slot]));
+	}
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
 void mt76_seq_puts_array(struct seq_file *file, const char *str,
 			 s8 *val, int len)
 {
@@ -120,6 +152,9 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 		debugfs_create_blob("otp", 0400, dir, &dev->otp);
 	debugfs_create_devm_seqfile(dev->dev, "rx-queues", dir,
 				    mt76_rx_queues_read);
+	if (mt76_is_usb(dev))
+		debugfs_create_devm_seqfile(dev->dev, "usb-stats", dir,
+					    mt76_usb_stats_read);
 
 	return dir;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 125c97dc1f28..c11a463ae092 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -664,6 +664,7 @@ struct mt76u_rx_entry {
 #define MT_RX_SG_MAX_SIZE	4
 #define MT_NUM_TX_ENTRIES	256
 #define MT_NUM_RX_ENTRIES	128
+#define MT_USB_AGGR_STATS_LEN	128
 #define MCU_RESP_URB_SIZE	1024
 struct mt76_usb {
 	struct mutex usb_ctrl_mtx;
@@ -687,6 +688,17 @@ struct mt76_usb {
 		int buf_size;
 	} rx_aggr;
 
+	struct {
+		atomic64_t tx_urbs;
+		atomic64_t tx_packets;
+		atomic64_t tx_bytes;
+		atomic64_t rx_urbs;
+		atomic64_t rx_packets;
+		atomic64_t rx_bytes;
+		atomic64_t rx_aggr_seq;
+		u8 rx_aggr_nframes[MT_USB_AGGR_STATS_LEN];
+	} stats;
+
 	struct mt76u_mcu {
 		u8 *data;
 		/* multiple reads */
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index cbdd663fbb25..10ad2b024985 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -15,6 +15,36 @@ static bool disable_usb_sg;
 module_param_named(disable_usb_sg, disable_usb_sg, bool, 0644);
 MODULE_PARM_DESC(disable_usb_sg, "Disable usb scatter-gather support");
 
+static void mt76u_tx_stats_add(struct mt76_dev *dev, struct urb *urb,
+			       unsigned int packets)
+{
+	atomic64_inc(&dev->usb.stats.tx_urbs);
+	atomic64_add(packets, &dev->usb.stats.tx_packets);
+	atomic64_add(urb->transfer_buffer_length, &dev->usb.stats.tx_bytes);
+}
+
+static void mt76u_rx_urb_stats_add(struct mt76_dev *dev, struct urb *urb)
+{
+	atomic64_inc(&dev->usb.stats.rx_urbs);
+	atomic64_add(urb->actual_length, &dev->usb.stats.rx_bytes);
+}
+
+static void mt76u_rx_packet_stats_add(struct mt76_dev *dev,
+				      unsigned int packets)
+{
+	atomic64_add(packets, &dev->usb.stats.rx_packets);
+}
+
+static void mt76u_rx_aggr_stats_add(struct mt76_dev *dev, unsigned int packets)
+{
+	u64 idx, slot;
+
+	idx = atomic64_inc_return(&dev->usb.stats.rx_aggr_seq) - 1;
+	slot = idx % MT_USB_AGGR_STATS_LEN;
+	WRITE_ONCE(dev->usb.stats.rx_aggr_nframes[slot],
+		   min_t(unsigned int, packets, U8_MAX));
+}
+
 int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
 			   u16 val, u16 offset, void *buf, size_t len)
 {
@@ -634,6 +664,10 @@ static int mt76u_process_rx_agg_entry(struct mt76_dev *dev, struct urb *urb)
 	mt76_put_page_pool_buf(urb->transfer_buffer, false);
 	urb->transfer_buffer = NULL;
 
+	if (nframes)
+		mt76u_rx_packet_stats_add(dev, nframes);
+	mt76u_rx_aggr_stats_add(dev, nframes);
+
 	return max(nframes, 1);
 }
 
@@ -681,6 +715,7 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
 
 	skb_mark_for_recycle(skb);
 	dev->drv->rx_skb(dev, MT_RXQ_MAIN, skb, NULL);
+	mt76u_rx_packet_stats_add(dev, 1);
 
 	return nsgs;
 }
@@ -714,6 +749,9 @@ static void mt76u_complete_rx(struct urb *urb)
 		break;
 	}
 
+	if (!urb->status)
+		mt76u_rx_urb_stats_add(dev, urb);
+
 	spin_lock_irqsave(&q->lock, flags);
 	idx = e - q->entry;
 	pending = q->ndesc - q->queued;
@@ -1083,6 +1121,7 @@ static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 					err);
 			break;
 		}
+		mt76u_tx_stats_add(dev, urb, 1);
 		q->first = (q->first + 1) % q->ndesc;
 	}
 }
-- 
2.43.0


