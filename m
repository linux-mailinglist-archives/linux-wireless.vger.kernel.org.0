Return-Path: <linux-wireless+bounces-37774-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sjYHCfzdLWoglwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37774-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B13167FF47
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jun 2026 00:47:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37774-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37774-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2ED83301372A
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jun 2026 22:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311E2032D;
	Sat, 13 Jun 2026 22:47:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA43914F0
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 22:47:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390837; cv=none; b=d2mw4MKqYffRrD7t51+ggXAmtpMS58npm3LEYTCnDwQsR4mNibNEytqmh5ETLneuu+q+Sc/X3k7xESEPGUgbGV+8V3XIkl7PTIjxJx9MRMADHPKdcVQX5dnj1JoF5TLpvyMWS1WvOXRDlfUlfHLn43taXm6l/N0vK/3FOx1vDbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390837; c=relaxed/simple;
	bh=LqgwrH+Tf+ESzscOPlN8TrTJ5oSPVWgiZXt259E2WD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FgPY0ORwIFrpz3Y8j/m8PT6YqMOU3oJjcm0WT5L+9d9xMdW58bFmGb0845Bwshea3mniujFQ2QQCxDtGdjHgbuU1LMv8tHwpkMfKBrn/aR6LJLUepiWVs1881oZGjiuu9E1i/DihxYnBU8JhT1IW+vO9JtZDGnBSLIsNVZWx07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.52
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1370417c01cso2717812c88.1
        for <linux-wireless@vger.kernel.org>; Sat, 13 Jun 2026 15:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390836; x=1781995636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=321hUeIgZZu6R1Mtyh4MWYy/Mrv5RJd99Cf5mZJVDl8=;
        b=D8PdX+7/35npJle1FiAfPxTO0pHRgeEKR+GRCw48ULTn366PClkgDpA6tsr4Wc3lyw
         0FTKalb7IicZIDv9ApG995CkPYjpDZFgr8KDyDdkGmK4QU6rWEKe69tKHEe2QBekik3s
         GTtPGmya8Yrc6il4OEuFtFCsckC7l3nx3oApbQXNWaJy9oX9nK59gcK1/V8/O6iPwDOP
         piJWC6yIKl8yx4cFQgP+5CpyyEoyS+cz5+d4ekenc8NbWGGJ4+mIruWJTNx71bWM5TG0
         5q1sI/JimeHBytifWMkI/QnLkwCfSl3XYn1EaO+XFAQm0uDtpzsH9Dkh6mapzLpzSia6
         rmHg==
X-Gm-Message-State: AOJu0Yy9MZLK5taMJ3u88jownmwdhVHN2pfRtk0nsEiFzgvkBkvo8+/F
	hvr+7/Rs9ROL68Rltvg5q/hzegTnCGoCkmLvEebD0W2M9y8qEFJe0Ybs
X-Gm-Gg: Acq92OHnyXmfATzbZTPVKXyChsFsuImFj5yXHmVmQLwqQRBbn1kfcUr6ySmMp44m2sb
	pTELU8samaFwwAFInPvzvdTM2tmq2KID3wmbKzQnE2tZKZDpB1nJUsC60Qjx86+UhsYziyEuOi9
	CT5gKVQPt0XXCj0Ixr3bXtxpK8HAR+6THaFEhYiAmrOjJn5K3ObuCVeJNLm+z5KQeGcOuAhfe6m
	aS50OL5XZcmS1AJdTd6dC82dPjgYTUIAiKWH8ZzHguy6Oo1VwVk7tWO9pZ7iJ3gV3beqsuiA8Bx
	18I+fwS3Ix8vfQRVh5HAsqTgQWNmzPyllfoTOYH5uCdK8QvwAC3k6cWQN0j9DYdbxKacGRZDO5J
	gLqr+1YKbmol7/T4lg2vRL6giVBKcoaD1xdTTzvqy2Ghl5xY9tmdj3zis03Y8rOuRp9g5jcQK/Z
	imzMrfArPizCKl7W9SdLgjDagl2dmLK8XNTMGj3QwJ8Lx+5fwvM3dbH1YW92ostxSCMO2OPl5zo
	qnk3BBuKeEnij+kYXzakYto1D2lyQoBm5kGwrd4
X-Received: by 2002:a05:7022:fa03:b0:138:508b:93ca with SMTP id a92af1059eb24-138508b957emr2715475c88.18.1781390835542;
        Sat, 13 Jun 2026 15:47:15 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.. (114-34-228-194.hinet-ip.hinet.net. [114.34.228.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm6345380c88.14.2026.06.13.15.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 15:47:15 -0700 (PDT)
From: Sean Wang <sean.wang@kernel.org>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 3/5] wifi: mt76: usb: add optional RX aggregation support
Date: Sat, 13 Jun 2026 17:46:53 -0500
Message-ID: <20260613224655.2405686-4-sean.wang@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-37774-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 8B13167FF47

From: Sean Wang <sean.wang@mediatek.com>

Add common USB RX aggregation support and let drivers opt in by programming
the UDMA RX aggregation limit and timeout.

RX aggregation allows the device to pack multiple RX packets into one USB
transfer, reducing URB completion rate, USB interrupt/IO overhead, and host
RX scheduling pressure. This is especially useful at high throughput, where
per-packet USB RX handling can become a CPU bottleneck.

Keep it disabled by default so existing USB drivers keep the current RX
behavior unless they explicitly enable aggregation.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  21 ++-
 .../net/wireless/mediatek/mt76/mt7925/usb.c   |  12 ++
 .../net/wireless/mediatek/mt76/mt792x_usb.c   |  23 +++-
 drivers/net/wireless/mediatek/mt76/usb.c      | 124 +++++++++++++++++-
 4 files changed, 169 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 81740aa7df71..125c97dc1f28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -680,6 +680,13 @@ struct mt76_usb {
 	void (*ctrl_timeout)(struct mt76_dev *dev, int err);
 	bool sg_en;
 
+	struct {
+		bool enable;
+		int align;
+		int padding;
+		int buf_size;
+	} rx_aggr;
+
 	struct mt76u_mcu {
 		u8 *data;
 		/* multiple reads */
@@ -1857,6 +1864,17 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
 
+static inline int
+mt76u_rx_aggr_buf_size(int max_mpdu, int aggr_limit, int aggr_pkt_limit,
+		       int padding)
+{
+	int aggr_size;
+
+	aggr_size = min(aggr_limit, aggr_pkt_limit * (max_mpdu + padding));
+
+	return PAGE_ALIGN(max_mpdu + aggr_size);
+}
+
 void mt76_ethtool_page_pool_stats(struct mt76_dev *dev, u64 *data, int *index);
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 			 struct mt76_sta_stats *stats, bool eht);
@@ -1882,7 +1900,8 @@ void mt76u_stop_tx(struct mt76_dev *dev);
 void mt76u_stop_rx(struct mt76_dev *dev);
 int mt76u_resume_rx(struct mt76_dev *dev);
 void mt76u_queues_deinit(struct mt76_dev *dev);
-
+void mt76u_enable_rx_aggr(struct mt76_dev *dev, int align, int padding,
+			  int buf_size);
 int mt76s_init(struct mt76_dev *dev, struct sdio_func *func,
 	       const struct mt76_bus_ops *bus_ops);
 int mt76s_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index 49ad4fe9eb1b..a0bfe6f09ae4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -3,12 +3,24 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sizes.h>
 #include <linux/usb.h>
 
 #include "mt7925.h"
 #include "mcu.h"
 #include "mac.h"
 
+#define MT7927_USB_RX_AGGR_ALIGN	16
+#define MT7927_USB_RX_AGGR_PADDING	12
+#define MT7927_USB_RX_AGGR_LIMIT	SZ_32K
+#define MT7927_USB_RX_AGGR_PKT_LIMIT	30
+#define MT7927_USB_RX_MAX_MPDU		(13 * SZ_1K)
+#define MT7927_USB_RX_AGGR_BUF_SIZE \
+	mt76u_rx_aggr_buf_size(MT7927_USB_RX_MAX_MPDU, \
+			       MT7927_USB_RX_AGGR_LIMIT, \
+			       MT7927_USB_RX_AGGR_PKT_LIMIT, \
+			       MT7927_USB_RX_AGGR_PADDING)
+
 static const struct usb_device_id mt7925u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x6639, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
index 6280bc4bf78d..769e828e9449 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
@@ -13,6 +13,9 @@
 
 #define MT792X_USB_TX_TIMEOUT_LIMIT	50000
 #define MT792X_USB_UDMA_IDLE_TIMEOUT	1000
+#define MT792X_USB_RX_AGG_LIMIT		32
+#define MT792X_USB_RX_AGG_TIMEOUT	100
+#define MT792X_USB_RX_AGG_PKT_LIMIT	30
 
 static int mt792xu_read32(struct mt76_dev *dev, u32 addr, void *buf)
 {
@@ -403,9 +406,23 @@ int mt792xu_dma_init(struct mt792x_dev *dev, bool resume)
 		 FIELD_PREP(MT_WL_TX_TMOUT_LMT,
 			    MT792X_USB_TX_TIMEOUT_LIMIT));
 	mt76_set(dev, MT_UDMA_WLCFG_0, MT_WL_TX_TMOUT_FUNC_EN);
-	mt76_clear(dev, MT_UDMA_WLCFG_0,
-		   MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT);
-	mt76_clear(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT);
+
+	if (dev->mt76.usb.rx_aggr.enable) {
+		mt76_set(dev, MT_UDMA_WLCFG_0, MT_WL_RX_AGG_EN);
+		mt76_rmw(dev, MT_UDMA_WLCFG_0,
+			 MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT,
+			 FIELD_PREP(MT_WL_RX_AGG_TO,
+				    MT792X_USB_RX_AGG_TIMEOUT) |
+			 FIELD_PREP(MT_WL_RX_AGG_LMT,
+				    MT792X_USB_RX_AGG_LIMIT));
+		mt76_rmw(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT,
+			 FIELD_PREP(MT_WL_RX_AGG_PKT_LMT,
+				    MT792X_USB_RX_AGG_PKT_LIMIT));
+	} else {
+		mt76_clear(dev, MT_UDMA_WLCFG_0, MT_WL_RX_AGG_EN |
+			   MT_WL_RX_AGG_TO | MT_WL_RX_AGG_LMT);
+		mt76_clear(dev, MT_UDMA_WLCFG_1, MT_WL_RX_AGG_PKT_LMT);
+	}
 
 	if (resume)
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index cab36630c978..cbdd663fbb25 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -371,6 +371,14 @@ mt76u_refill_rx(struct mt76_dev *dev, struct mt76_queue *q,
 		return mt76u_fill_rx_sg(dev, q, urb, nsgs);
 
 	urb->transfer_buffer_length = q->buf_size;
+	if (qid == MT_RXQ_MAIN && dev->usb.rx_aggr.enable) {
+		if (!urb->transfer_buffer)
+			urb->transfer_buffer =
+				mt76_get_page_pool_buf(q, &offset, q->buf_size);
+
+		return urb->transfer_buffer ? 0 : -ENOMEM;
+	}
+
 	urb->transfer_buffer = mt76_get_page_pool_buf(q, &offset, q->buf_size);
 
 	return urb->transfer_buffer ? 0 : -ENOMEM;
@@ -538,18 +546,113 @@ mt76u_build_rx_skb(struct mt76_dev *dev, void *data,
 	return skb;
 }
 
+static struct sk_buff *
+mt76u_build_rx_skb_aggr(struct mt76_dev *dev, void *data, int data_len,
+			int buf_len)
+{
+	int head_room, drv_flags = dev->drv->drv_flags;
+	int len = min_t(int, data_len, MT_SKB_HEAD_LEN);
+	struct sk_buff *skb;
+
+	if (data_len <= 0)
+		return NULL;
+
+	head_room = drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	data += head_room;
+	skb_put_data(skb, data, len);
+	if (data_len > len) {
+		struct page *page;
+
+		data += len;
+		page = virt_to_head_page(data);
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				page, data - page_address(page),
+				data_len - len, buf_len);
+		get_page(page);
+	}
+
+	return skb;
+}
+
+static int mt76u_process_rx_agg_entry(struct mt76_dev *dev, struct urb *urb)
+{
+	int offset = 0, head_room, drv_flags = dev->drv->drv_flags;
+	int align = dev->usb.rx_aggr.align ?: 4;
+	int padding = dev->usb.rx_aggr.padding ?: 4;
+	u8 *data = urb->transfer_buffer;
+	int min_len;
+	int nframes = 0;
+
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state) ||
+	    test_bit(MT76_REMOVED, &dev->phy.state))
+		return 0;
+
+	head_room = drv_flags & MT_DRV_RX_DMA_HDR ? 0 : MT_DMA_HDR_LEN;
+	min_len = head_room + MT_RX_RXWI_LEN;
+
+	while (urb->actual_length - offset >= min_len) {
+		struct sk_buff *skb;
+		int len, frame_len, agg_len;
+
+		len = mt76u_get_rx_entry_len(dev, data + offset,
+					     urb->actual_length - offset);
+		if (len < 0) {
+			dev_warn_ratelimited(dev->dev,
+					     "invalid USB RX aggregate at offset %d\n",
+					     offset);
+			break;
+		}
+
+		frame_len = head_room + len;
+		if (frame_len > urb->actual_length - offset) {
+			dev_warn_ratelimited(dev->dev,
+					     "truncated USB RX aggregate at offset %d\n",
+					     offset);
+			break;
+		}
+
+		agg_len = ALIGN(frame_len, align) + padding;
+		if (dev->drv->rx_check &&
+		    !dev->drv->rx_check(dev, data + offset + head_room, len))
+			goto next;
+
+		skb = mt76u_build_rx_skb_aggr(dev, data + offset, len,
+					      agg_len);
+		if (skb) {
+			dev->drv->rx_skb(dev, MT_RXQ_MAIN, skb, NULL);
+			nframes++;
+		}
+
+next:
+		offset += agg_len;
+	}
+
+	mt76_put_page_pool_buf(urb->transfer_buffer, false);
+	urb->transfer_buffer = NULL;
+
+	return max(nframes, 1);
+}
+
 static int
 mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb,
-		       int buf_size)
+		       enum mt76_rxq_id qid, int buf_size)
 {
 	u8 *data = urb->num_sgs ? sg_virt(&urb->sg[0]) : urb->transfer_buffer;
 	int data_len = urb->num_sgs ? urb->sg[0].length : urb->actual_length;
 	int len, nsgs = 1, head_room, drv_flags = dev->drv->drv_flags;
 	struct sk_buff *skb;
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state) ||
+	    test_bit(MT76_REMOVED, &dev->phy.state))
 		return 0;
 
+	if (qid == MT_RXQ_MAIN && dev->usb.rx_aggr.enable && !urb->num_sgs)
+		return mt76u_process_rx_agg_entry(dev, urb);
+
 	len = mt76u_get_rx_entry_len(dev, data, urb->actual_length);
 	if (len < 0)
 		return 0;
@@ -594,6 +697,9 @@ static void mt76u_complete_rx(struct urb *urb)
 
 	trace_rx_urb(dev, urb);
 
+	if (test_bit(MT76_REMOVED, &dev->phy.state))
+		return;
+
 	switch (urb->status) {
 	case -ECONNRESET:
 	case -ESHUTDOWN:
@@ -658,12 +764,14 @@ mt76u_process_rx_queue(struct mt76_dev *dev, struct mt76_queue *q)
 		if (!urb)
 			break;
 
-		count = mt76u_process_rx_entry(dev, urb, q->buf_size);
+		count = mt76u_process_rx_entry(dev, urb, qid, q->buf_size);
 		if (count > 0) {
 			err = mt76u_refill_rx(dev, q, urb, count);
 			if (err < 0)
 				break;
 		}
+		if (test_bit(MT76_REMOVED, &dev->phy.state))
+			break;
 		mt76u_submit_rx_buf(dev, qid, urb);
 	}
 }
@@ -729,10 +837,6 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 	struct mt76_queue *q = &dev->q_rx[qid];
 	int i, err;
 
-	err = mt76_create_page_pool(dev, q);
-	if (err)
-		return err;
-
 	spin_lock_init(&q->lock);
 	q->entry = devm_kcalloc(dev->dev,
 				MT_NUM_RX_ENTRIES, sizeof(*q->entry),
@@ -742,6 +846,12 @@ mt76u_alloc_rx_queue(struct mt76_dev *dev, enum mt76_rxq_id qid)
 
 	q->ndesc = MT_NUM_RX_ENTRIES;
 	q->buf_size = PAGE_SIZE;
+	if (qid == MT_RXQ_MAIN && dev->usb.rx_aggr.enable)
+		q->buf_size = dev->usb.rx_aggr.buf_size ?: PAGE_SIZE;
+
+	err = mt76_create_page_pool(dev, q);
+	if (err)
+		return err;
 
 	for (i = 0; i < q->ndesc; i++) {
 		err = mt76u_rx_urb_alloc(dev, q, &q->entry[i]);
-- 
2.43.0


