Return-Path: <linux-wireless+bounces-27410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03FB7DF9E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065D27B85E1
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A61286D56;
	Tue, 16 Sep 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="LpNp+LPR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7C199935
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061863; cv=none; b=LTBxKNimggaKazyrp9j/JYPGkZ7U1o+Uw/Zov2MINY8t0JQEVBknWkJ+ok20YQwZ/9NM/IOQRuhGO9w+oQ735DF7v9FxECtERpLNbT9VVVlp5VndVNFocD0FGziju7kCYI3U3cgCyD8xoys1VZgeszn6XsczPUdLdlO541iHC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061863; c=relaxed/simple;
	bh=BFlRNOFqroYVgxsXw288E+Zn1Ul2wZw1Lr/uSg/Xbv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1Ye6n6pIV0U3i1tbaXw1VwFkmQnEEoA/gEdAkS6V2LjmQ9FfjR02MhcAJW1V96JcaPDOwaSAaA3Ds+LCj/oU+OKW9CP5a8ABRCWAQq28/eHAr70erAA9jIk9KHfjJWCqOGfr8Ujmv8eJ/jY+NK4KwoSZDa3OJtU0hndOF5b8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=LpNp+LPR; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061860; x=1789597860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFlRNOFqroYVgxsXw288E+Zn1Ul2wZw1Lr/uSg/Xbv8=;
  b=LpNp+LPRcAdUKcsIpjIEeQKFRO5s2Ux8TQeK9vkXjqM1ekCkP/izcMuP
   LQnD4sV3cxEz3gFQJYaNdyC+SH5kA0AP4B0MQIZzt8Rqjl5OwjdCe8LPG
   APu+yzGdxDO+Z6UJl7fY7sJyecOwDDM4XDVDLH7Rfo6WZKvEOLtTokzmf
   k=;
X-CSE-ConnectionGUID: Wjt4ztKIR8aIS+m4FoaE7w==
X-CSE-MsgGUID: 7NICP0+5Sl+R6Ci6hxXK2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093945"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093945"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:30:58 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:30:58 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:30:55 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 55/57] wifi: inffmac: add utils.c/h
Date: Wed, 17 Sep 2025 03:48:15 +0530
Message-ID: <20250916221821.4387-61-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE823.infineon.com (172.23.29.54) To
 MUCSE827.infineon.com (172.23.29.20)

Imeplemenation of common utility functions and MACRO definitions which can
be used by other driver source files.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/utils.c | 323 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/utils.h | 254 ++++++++++++++
 2 files changed, 577 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/utils.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/utils.h

diff --git a/drivers/net/wireless/infineon/inffmac/utils.c b/drivers/net/wireless/infineon/inffmac/utils.c
new file mode 100644
index 000000000000..c27864f207bd
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/utils.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: ISC
+
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/netdevice.h>
+#include <linux/module.h>
+
+#include "utils.h"
+
+struct sk_buff *inff_pkt_buf_get_skb(uint len)
+{
+	struct sk_buff *skb;
+
+	skb = dev_alloc_skb(len);
+	if (skb) {
+		skb_put(skb, len);
+		skb->priority = 0;
+	}
+
+	return skb;
+}
+
+/* Free the driver packet. Free the tag if present */
+void inff_pkt_buf_free_skb(struct sk_buff *skb)
+{
+	if (!skb)
+		return;
+
+	WARN_ON(skb->next);
+	dev_kfree_skb_any(skb);
+}
+
+/*
+ * osl multiple-precedence packet queue
+ * hi_prec is always >= the number of the highest non-empty precedence
+ */
+struct sk_buff *inff_pktq_penq(struct pktq *pq, int prec,
+			       struct sk_buff *p)
+{
+	struct sk_buff_head *q;
+
+	if (pktq_full(pq) || pktq_pfull(pq, prec))
+		return NULL;
+
+	q = &pq->q[prec].skblist;
+	skb_queue_tail(q, p);
+	pq->len++;
+
+	if (pq->hi_prec < prec)
+		pq->hi_prec = (u8)prec;
+
+	return p;
+}
+
+struct sk_buff *inff_pktq_penq_head(struct pktq *pq, int prec,
+				    struct sk_buff *p)
+{
+	struct sk_buff_head *q;
+
+	if (pktq_full(pq) || pktq_pfull(pq, prec))
+		return NULL;
+
+	q = &pq->q[prec].skblist;
+	skb_queue_head(q, p);
+	pq->len++;
+
+	if (pq->hi_prec < prec)
+		pq->hi_prec = (u8)prec;
+
+	return p;
+}
+
+struct sk_buff *inff_pktq_pdeq(struct pktq *pq, int prec)
+{
+	struct sk_buff_head *q;
+	struct sk_buff *p;
+
+	q = &pq->q[prec].skblist;
+	p = skb_dequeue(q);
+	if (!p)
+		return NULL;
+
+	pq->len--;
+	return p;
+}
+
+/*
+ * precedence based dequeue with match function. Passing a NULL pointer
+ * for the match function parameter is considered to be a wildcard so
+ * any packet on the queue is returned. In that case it is no different
+ * from inff_pktq_pdeq() above.
+ */
+struct sk_buff *inff_pktq_pdeq_match(struct pktq *pq, int prec,
+				     bool (*match_fn)(struct sk_buff *skb,
+						      void *arg), void *arg)
+{
+	struct sk_buff_head *q;
+	struct sk_buff *p, *next;
+
+	q = &pq->q[prec].skblist;
+	skb_queue_walk_safe(q, p, next) {
+		if (!match_fn || match_fn(p, arg)) {
+			skb_unlink(p, q);
+			pq->len--;
+			return p;
+		}
+	}
+	return NULL;
+}
+
+struct sk_buff *inff_pktq_pdeq_tail(struct pktq *pq, int prec)
+{
+	struct sk_buff_head *q;
+	struct sk_buff *p;
+
+	q = &pq->q[prec].skblist;
+	p = skb_dequeue_tail(q);
+	if (!p)
+		return NULL;
+
+	pq->len--;
+	return p;
+}
+
+void
+inff_pktq_pflush(struct pktq *pq, int prec, bool dir,
+		 bool (*fn)(struct sk_buff *, void *), void *arg)
+{
+	struct sk_buff_head *q;
+	struct sk_buff *p, *next;
+
+	q = &pq->q[prec].skblist;
+	skb_queue_walk_safe(q, p, next) {
+		if (!fn || (*fn) (p, arg)) {
+			skb_unlink(p, q);
+			inff_pkt_buf_free_skb(p);
+			pq->len--;
+		}
+	}
+}
+
+void inff_pktq_flush(struct pktq *pq, bool dir,
+		     bool (*fn)(struct sk_buff *, void *), void *arg)
+{
+	int prec;
+
+	for (prec = 0; prec < pq->num_prec; prec++)
+		inff_pktq_pflush(pq, prec, dir, fn, arg);
+}
+
+void inff_pktq_init(struct pktq *pq, int num_prec, int max_len)
+{
+	int prec;
+
+	/* pq is variable size; only zero out what's requested */
+	memset(pq, 0,
+	       offsetof(struct pktq, q) + (sizeof(struct pktq_prec) * num_prec));
+
+	pq->num_prec = (u16)num_prec;
+
+	pq->max = (u16)max_len;
+
+	for (prec = 0; prec < num_prec; prec++) {
+		pq->q[prec].max = pq->max;
+		skb_queue_head_init(&pq->q[prec].skblist);
+	}
+}
+
+struct sk_buff *inff_pktq_peek_tail(struct pktq *pq, int *prec_out)
+{
+	int prec;
+
+	if (pktq_empty(pq))
+		return NULL;
+
+	for (prec = 0; prec < pq->hi_prec; prec++)
+		if (!skb_queue_empty(&pq->q[prec].skblist))
+			break;
+
+	if (prec_out)
+		*prec_out = prec;
+
+	return skb_peek_tail(&pq->q[prec].skblist);
+}
+
+/* Return sum of lengths of a specific set of precedences */
+int inff_pktq_mlen(struct pktq *pq, uint prec_bmp)
+{
+	int prec, len;
+
+	len = 0;
+
+	for (prec = 0; prec <= pq->hi_prec; prec++)
+		if (prec_bmp & (1 << prec))
+			len += pq->q[prec].skblist.qlen;
+
+	return len;
+}
+
+/* Priority dequeue from a specific set of precedences */
+struct sk_buff *inff_pktq_mdeq(struct pktq *pq, uint prec_bmp,
+			       int *prec_out)
+{
+	struct sk_buff_head *q;
+	struct sk_buff *p;
+	int prec;
+
+	if (pktq_empty(pq))
+		return NULL;
+
+	while ((prec = pq->hi_prec) > 0 &&
+	       skb_queue_empty(&pq->q[prec].skblist))
+		pq->hi_prec--;
+
+	while ((prec_bmp & (1 << prec)) == 0 ||
+	       skb_queue_empty(&pq->q[prec].skblist))
+		if (prec-- == 0)
+			return NULL;
+
+	q = &pq->q[prec].skblist;
+	p = skb_dequeue(q);
+	if (!p)
+		return NULL;
+
+	pq->len--;
+
+	if (prec_out)
+		*prec_out = prec;
+
+	return p;
+}
+
+/* Produce a human-readable string for boardrev */
+char *inff_boardrev_str(u32 brev, char *buf)
+{
+	char c;
+
+	if (brev < 0x100) {
+		snprintf(buf, INFF_BOARDREV_LEN, "%d.%d",
+			 (brev & 0xf0) >> 4, brev & 0xf);
+	} else {
+		c = (brev & 0xf000) == 0x1000 ? 'P' : 'A';
+		snprintf(buf, INFF_BOARDREV_LEN, "%c%03x", c, brev & 0xfff);
+	}
+	return buf;
+}
+
+char *inff_dotrev_str(u32 dotrev, char *buf)
+{
+	u8 dotval[4];
+
+	if (!dotrev) {
+		snprintf(buf, INFF_DOTREV_LEN, "unknown");
+		return buf;
+	}
+	dotval[0] = (dotrev >> 24) & 0xFF;
+	dotval[1] = (dotrev >> 16) & 0xFF;
+	dotval[2] = (dotrev >> 8) & 0xFF;
+	dotval[3] = dotrev & 0xFF;
+
+	if (dotval[3])
+		snprintf(buf, INFF_DOTREV_LEN, "%d.%d.%d.%d", dotval[0],
+			 dotval[1], dotval[2], dotval[3]);
+	else if (dotval[2])
+		snprintf(buf, INFF_DOTREV_LEN, "%d.%d.%d", dotval[0],
+			 dotval[1], dotval[2]);
+	else
+		snprintf(buf, INFF_DOTREV_LEN, "%d.%d", dotval[0],
+			 dotval[1]);
+
+	return buf;
+}
+
+struct sk_buff *__inff_pkt_buf_get_skb(uint len, gfp_t gfp_mask)
+{
+	struct sk_buff *skb;
+
+	skb = __netdev_alloc_skb(NULL, len, gfp_mask);
+	if (skb) {
+		skb_put(skb, len);
+		skb->priority = 0;
+	}
+	return skb;
+}
+
+#if defined(DEBUG)
+/* pretty hex print a pkt buffer chain */
+void inff_prpkt(const char *msg, struct sk_buff *p0)
+{
+	struct sk_buff *p;
+
+	if (msg && (msg[0] != '\0'))
+		pr_debug("%s:\n", msg);
+
+	for (p = p0; p; p = p->next)
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, p->data, p->len);
+}
+
+void inff_dbg_hex_dump(const void *data, size_t size, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	pr_debug("%pV", &vaf);
+
+	va_end(args);
+
+	print_hex_dump_bytes("", DUMP_PREFIX_OFFSET, data, size);
+}
+
+#endif				/* defined(DEBUG) */
diff --git a/drivers/net/wireless/infineon/inffmac/utils.h b/drivers/net/wireless/infineon/inffmac/utils.h
new file mode 100644
index 000000000000..e8cf19d8e0c3
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/utils.h
@@ -0,0 +1,254 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_UTILS_H
+#define	INFF_UTILS_H
+
+#include <linux/skbuff.h>
+
+/*
+ * Spin at most 'us' microseconds while 'exp' is true.
+ * Caller should explicitly test 'exp' when this completes
+ * and take appropriate error action if 'exp' is still true.
+ */
+#define SPINWAIT(exp, us) { \
+	uint countdown = (us) + 9; \
+	while ((exp) && (countdown >= 10)) {\
+		usleep_range(10, 20); \
+		countdown -= 10; \
+	} \
+}
+
+/* Spin at most 'ms' milliseconds with polling interval 'interval' milliseconds
+ * while 'exp' is true. Caller should explicitly test 'exp' when this completes
+ * and take appropriate error action if 'exp' is still true.
+ */
+#define SPINWAIT_MS(exp, ms, interval) { \
+	typeof(interval) interval_ = (interval); \
+	uint countdown = (ms) + (interval_ - 1U); \
+	while ((exp) && (countdown >= interval_)) { \
+		msleep(interval_); \
+		countdown -= interval_; \
+	} \
+}
+
+/* osl multi-precedence packet queue */
+#define PKTQ_LEN_DEFAULT        128	/* Max 128 packets */
+#define PKTQ_MAX_PREC           16	/* Maximum precedence levels */
+
+/* the largest reasonable packet buffer driver uses for ethernet MTU in bytes */
+#define	PKTBUFSZ	2048
+
+#ifndef setbit
+#ifndef NBBY			/* the BSD family defines NBBY */
+#define	NBBY	8		/* 8 bits per byte */
+#endif				/* #ifndef NBBY */
+#define	setbit(a, i)	{ \
+	typeof(i) _i = (i); \
+	(((u8 *)a)[(_i) / NBBY] |= 1 << ((_i) % NBBY)); \
+	}
+#define	clrbit(a, i)	{ \
+	typeof(i) _i = (i); \
+	(((u8 *)a)[(_i) / NBBY] &= ~(1 << ((_i) % NBBY))); \
+	}
+#define	isset(a, i)	{ \
+	typeof(i) _i = (i); \
+	(((const u8 *)a)[(_i) / NBBY] & (1 << ((_i) % NBBY))); \
+	}
+#define	isclr(a, i)	{ \
+	typeof(i) _i = (i); \
+	((((const u8 *)a)[(_i) / NBBY] & (1 << ((_i) % NBBY))) == 0); \
+	}
+#endif				/* setbit */
+
+#define	NBITS(type)	(sizeof(type) * 8)
+#define NBITVAL(nbits)	(1 << (nbits))
+#define MAXBITVAL(nbits)	((1 << (nbits)) - 1)
+#define	NBITMASK(nbits)	MAXBITVAL(nbits)
+#define MAXNBVAL(nbyte)	MAXBITVAL((nbyte) * 8)
+
+/* crc defines */
+#define CRC16_INIT_VALUE 0xffff	/* Initial CRC16 checksum value */
+#define CRC16_GOOD_VALUE 0xf0b8	/* Good final CRC16 checksum value */
+
+/* 18-bytes of Ethernet address buffer length */
+#define ETHER_ADDR_STR_LEN	18
+
+struct pktq_prec {
+	struct sk_buff_head skblist;
+	u16 max;		/* maximum number of queued packets */
+};
+
+/* multi-priority pkt queue */
+struct pktq {
+	u16 num_prec;	/* number of precedences in use */
+	u16 hi_prec;	/* rapid dequeue hint (>= highest non-empty prec) */
+	u16 max;	/* total max packets */
+	u16 len;	/* total number of packets */
+	/*
+	 * q array must be last since # of elements can be either
+	 * PKTQ_MAX_PREC or 1
+	 */
+	struct pktq_prec q[PKTQ_MAX_PREC];
+};
+
+/* operations on a specific precedence in packet queue */
+
+static inline int pktq_plen(struct pktq *pq, int prec)
+{
+	return pq->q[prec].skblist.qlen;
+}
+
+static inline int pktq_pavail(struct pktq *pq, int prec)
+{
+	return pq->q[prec].max - pq->q[prec].skblist.qlen;
+}
+
+static inline bool pktq_pfull(struct pktq *pq, int prec)
+{
+	return pq->q[prec].skblist.qlen >= pq->q[prec].max;
+}
+
+static inline bool pktq_pempty(struct pktq *pq, int prec)
+{
+	return skb_queue_empty(&pq->q[prec].skblist);
+}
+
+static inline struct sk_buff *pktq_ppeek(struct pktq *pq, int prec)
+{
+	return skb_peek(&pq->q[prec].skblist);
+}
+
+static inline struct sk_buff *pktq_ppeek_tail(struct pktq *pq, int prec)
+{
+	return skb_peek_tail(&pq->q[prec].skblist);
+}
+
+struct sk_buff *inff_pktq_penq(struct pktq *pq, int prec, struct sk_buff *p);
+struct sk_buff *inff_pktq_penq_head(struct pktq *pq, int prec,
+				    struct sk_buff *p);
+struct sk_buff *inff_pktq_pdeq(struct pktq *pq, int prec);
+struct sk_buff *inff_pktq_pdeq_tail(struct pktq *pq, int prec);
+struct sk_buff *inff_pktq_pdeq_match(struct pktq *pq, int prec,
+				     bool (*match_fn)(struct sk_buff *p,
+						      void *arg),
+				      void *arg);
+
+/* packet primitives */
+struct sk_buff *inff_pkt_buf_get_skb(uint len);
+void inff_pkt_buf_free_skb(struct sk_buff *skb);
+struct sk_buff *__inff_pkt_buf_get_skb(uint len, gfp_t gfp_mask);
+
+/* Empty the queue at particular precedence level */
+/* callback function fn(pkt, arg) returns true if pkt belongs to if */
+void inff_pktq_pflush(struct pktq *pq, int prec, bool dir,
+		      bool (*fn)(struct sk_buff *, void *), void *arg);
+
+/* operations on a set of precedences in packet queue */
+
+int inff_pktq_mlen(struct pktq *pq, uint prec_bmp);
+struct sk_buff *inff_pktq_mdeq(struct pktq *pq, uint prec_bmp, int *prec_out);
+
+/* operations on packet queue as a whole */
+
+static inline int pktq_len(struct pktq *pq)
+{
+	return (int)pq->len;
+}
+
+static inline int pktq_max(struct pktq *pq)
+{
+	return (int)pq->max;
+}
+
+static inline int pktq_avail(struct pktq *pq)
+{
+	return (int)(pq->max - pq->len);
+}
+
+static inline bool pktq_full(struct pktq *pq)
+{
+	return pq->len >= pq->max;
+}
+
+static inline bool pktq_empty(struct pktq *pq)
+{
+	return pq->len == 0;
+}
+
+void inff_pktq_init(struct pktq *pq, int num_prec, int max_len);
+/* prec_out may be NULL if caller is not interested in return value */
+struct sk_buff *inff_pktq_peek_tail(struct pktq *pq, int *prec_out);
+void inff_pktq_flush(struct pktq *pq, bool dir,
+		     bool (*fn)(struct sk_buff *, void *), void *arg);
+
+/* externs */
+/* ip address */
+struct ipv4_addr;
+
+/*
+ * bitfield macros using masking and shift
+ *
+ * remark: the mask parameter should be a shifted mask.
+ */
+static inline void inff_maskset32(u32 *var, u32 mask, u8 shift, u32 value)
+{
+	value = (value << shift) & mask;
+	*var = (*var & ~mask) | value;
+}
+
+static inline u32 inff_maskget32(u32 var, u32 mask, u8 shift)
+{
+	return (var & mask) >> shift;
+}
+
+static inline void inff_maskset16(u16 *var, u16 mask, u8 shift, u16 value)
+{
+	value = (value << shift) & mask;
+	*var = (*var & ~mask) | value;
+}
+
+static inline u16 inff_maskget16(u16 var, u16 mask, u8 shift)
+{
+	return (var & mask) >> shift;
+}
+
+static inline int inff_work_sched_cpu(int cpu)
+{
+	if (cpu >= 0 && cpu < nr_cpu_ids)
+		return cpu;
+
+	return WORK_CPU_UNBOUND;
+}
+
+/* externs */
+/* format/print */
+#ifdef DEBUG
+void inff_prpkt(const char *msg, struct sk_buff *p0);
+#else
+#define inff_prpkt(a, b)
+#endif				/* DEBUG */
+
+#ifdef DEBUG
+__printf(3, 4)
+void inff_dbg_hex_dump(const void *data, size_t size, const char *fmt, ...);
+#else
+__printf(3, 4)
+static inline
+void inff_dbg_hex_dump(const void *data, size_t size, const char *fmt, ...)
+{
+}
+#endif
+
+#define INFF_BOARDREV_LEN	8
+#define INFF_DOTREV_LEN	16
+
+char *inff_boardrev_str(u32 brev, char *buf);
+char *inff_dotrev_str(u32 dotrev, char *buf);
+
+#endif /* INFF_UTILS_H */
-- 
2.25.1


