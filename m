Return-Path: <linux-wireless+bounces-32263-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA0PMbIcoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32263-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 278AB1B2AB7
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D68831D87AD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868E34889F;
	Fri, 27 Feb 2026 04:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="bXPVlcEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6734DCF2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165661; cv=none; b=CbjIwtk35TDgoBNvQGBGY3wwq1W3GYotr9yd0KYZl59y8IRJJtcDXvc0mSwvZOevY1ujZ5c4CLwi1JsARiZLc0ct+2DL5EAN4iJpx31xiRSKaoi5dqR3jRLdqql1KFK5TO7JVZqdSq5V71glN2x4v2DMDRUVnRoisOmKq7lrmY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165661; c=relaxed/simple;
	bh=qw34Kp5YI1tGbvIqugk9A9lrXRzMXtRWcEhEq65BTcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbygiC38PMDfBi4zEhlYLmgg7yQdpP/ACGNFgYE2WDrdtGgl2NWwavFf0U/3Es+yGJc8Lo4PkrWXe3S9cPTVC3cPLNNfT23EGGZLAOQw1gdWs6DY7bgRXw/IKBhH1tAh2bp1Z/PO9Qq3266tUp65a4f7MddYAOmsxMcCxpc/0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=bXPVlcEs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6e3e4e7388so603512a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165659; x=1772770459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYBnNtF1ihxMJDq6a+iNE3OyoNcMd9lSpU7divWw5uA=;
        b=bXPVlcEsWSLftDF0yPT6lKZqX5fLaQt61oKXYDfeX+8CUxkzZ8L2+ij8I/tOJ0QY2B
         CWan8q86WFGUW5/XeB5YnaUEd74xTsOO1YcYlFcQd/zN7Vip6DU10PbtA4C3AtzETGn0
         8jWNqvA9qUJRuyqO/h3GQFoVjQ5EscyKJHEc7XiNocp6r4LHD7F9wFl31oZK79IPkiuH
         WlA2/BN960qJpkm5qc7g9kfBmr6cgfi3N0DLMHDl1WFyPISrWv3G0MgQ2F3Il7zeQ4n0
         /JtavCL4Vw+22CL9pjiT+55Hw2EtaOSd5O4BVFTQ6sEL4bW++jzpvc0Uyo3VivSFKvpo
         VBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165659; x=1772770459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TYBnNtF1ihxMJDq6a+iNE3OyoNcMd9lSpU7divWw5uA=;
        b=HCHuE3WJxdn9FgsRjn/Ubd6vX8BTthycyDkSCtKCX5G2+U54DYNv19UNO9ULWNB4wq
         pemITj5CLxAchVB5IBXdb0Im79Qh8tdbusNLd8lppz56TEX8gC2/XPWi2T2RzQdXjArA
         +UcQ7xqpn/UZsPpQlF4QuExbNfIQHgeuRgmdpsbLW6t4xay1FN+0+AlF4V8u7hbw8yNv
         Egpw4yTtfuUE+IFbP82NVPozZRa0xP6o/GpbF62pbyTNyZbXMdN4L8K67F31LwtdMU+h
         uHHCpBfP3QnEzDgCgUH6XEjzB2n8S8NmYCzZnqMeV0/stGDdzF+M2iz525hznzzZ/Gci
         MeKg==
X-Forwarded-Encrypted: i=1; AJvYcCVM384TLijKx+yZdhdkn5a4XnecqD1FCUcVi4mXwIy8m82zY6Qq+SB6O3gw0Owi0aFz+Sd7fTX4mypTMllmHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwBOfHaGprAxxO510dlk74koDNwAqS4Kv25cBoMvoLg7ASvTa
	4dck6Kei8T9YzXXueTd22kpcKXYKEIBPUmlsvJdJyrSmFk33rNc+iuIdVrB1dyOlsbY=
X-Gm-Gg: ATEYQzzMJG25uBHKR9Dr9K33PVOpzrtFhqzRIHWCHR3x0KMz20kCrH9sAYiXB7HWV0v
	4e9TlbEgQ7N5VoU4f0L1pk8W694FubIrn3eXT5KK3L+VjAfN5vZT4bv149tx0TekPfQ88fxv3mA
	QgnojXLsCmod4XGzz8GM8QERLBlrsyUo9YZIdAy7gKF+yIxrImJS4bZn1sJp3bFP0PU1LlAzFav
	Gapz4fiE59Gjttu2bPGkEoPmVDQdJS/iXVLL2yBaiG/LbDxNaGIfRY+qGh+H/LclUrkHKgfidKs
	jLA6qYfakT6XUyxv74gkAvcxcNmhUbImnlFwmFyYYpt+7vfS8WPnT3ji6TDshYbGNo5spkcNu61
	F9q0PQphsvn7ePHHRFb3X5I6SyriQw22DSghHAC4bPN0NGii3q37411KoyvdARhOkCwgK0EVH+O
	5tNjUnnv/FcH0XQtlenFJAUZJ8S7DDppYYXdUO/oPk3N4ogN2B4i43zdJnKX40mo30jcclrpZ5t
	FCzR+PlFkoSVaxDFJADp8mwmKvXZ68=
X-Received: by 2002:a17:903:1786:b0:2a9:47ff:101c with SMTP id d9443c01a7336-2ae2e4bb027mr16051575ad.46.1772165658613;
        Thu, 26 Feb 2026 20:14:18 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:18 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 24/35] wifi: mm81x: add skbq.c
Date: Fri, 27 Feb 2026 15:10:34 +1100
Message-ID: <20260227041108.66508-25-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32263-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim,hdr.channel:url,iter.mm:url]
X-Rspamd-Queue-Id: 278AB1B2AB7
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/skbq.c | 1056 ++++++++++++++++++
 1 file changed, 1056 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/skbq.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/skbq.c b/drivers/net/wireless/morsemicro/mm81x/skbq.c
new file mode 100644
index 000000000000..c70eebf4cffd
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/skbq.c
@@ -0,0 +1,1056 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/ktime.h>
+#include <linux/skbuff.h>
+#include <linux/jiffies.h>
+#include "hif.h"
+#include "debug.h"
+#include "skbq.h"
+#include "mac.h"
+#include "command.h"
+#include "bus.h"
+
+/* Returns number of bytes needed to word align */
+#define BYTES_NEEDED_TO_WORD_ALIGN(bytes) \
+	((bytes) & 0x3 ? (4 - ((bytes) & 0x3)) : 0)
+
+/* Rounds down to the nearest word boundary */
+#define ROUND_DOWN_TO_WORD(bytes)                                  \
+	(BYTES_NEEDED_TO_WORD_ALIGN(bytes) ?                       \
+		 bytes - (4 - BYTES_NEEDED_TO_WORD_ALIGN(bytes)) : \
+		 bytes)
+
+#define MM81X_SKBQ_MAX_TXQ_LEN 32
+#define MM81X_SKBQ_TX_QUEUED_LIFETIME_MS 1000
+#define MM81X_SKBQ_TX_STATUS_LIFETIME_MS (15 * 1000)
+
+/* Returns padding needed to align x up to a 4-byte boundary */
+#define MM81X_PAD4(x) (((x) & 0x3) ? (4 - ((x) & 0x3)) : 0)
+
+struct mm81x_tx_status_priv {
+	/*
+	 * Time (jiffies) at which this packet has spent too long the pending
+	 * queue, waiting for status notification from the firmware, and
+	 * should be considered lost.
+	 */
+	unsigned long tx_status_expiry;
+};
+
+static inline struct mm81x_tx_status_priv *
+__mm81x_skbq_tx_status_priv(struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
+
+	BUILD_BUG_ON(sizeof(struct mm81x_tx_status_priv) >
+		     sizeof(tx_info->status.status_driver_data));
+	return (struct mm81x_tx_status_priv *)&tx_info->status
+		.status_driver_data[0];
+}
+
+static inline bool
+__mm81x_skbq_has_pending_tx_skb_timed_out(struct sk_buff *skb)
+{
+	struct mm81x_tx_status_priv *info = __mm81x_skbq_tx_status_priv(skb);
+
+	/* If our timestamp value is in the past then we have timed out. */
+	return time_is_before_jiffies(info->tx_status_expiry);
+}
+
+static inline u32 __mm81x_skbq_size(const struct mm81x_skbq *mq)
+{
+	return mq->skbq_size;
+}
+
+static inline u32 __mm81x_skbq_space(const struct mm81x_skbq *mq)
+{
+	return MM81X_SKBQ_SIZE - __mm81x_skbq_size(mq);
+}
+
+static inline bool __mm81x_skbq_over_threshold(struct mm81x_skbq *mq)
+{
+	return skb_queue_len(&mq->skbq) >= MM81X_SKBQ_MAX_TXQ_LEN;
+}
+
+static inline bool __mm81x_skbq_under_threshold(struct mm81x_skbq *mq)
+{
+	return skb_queue_len(&mq->skbq) < (MM81X_SKBQ_MAX_TXQ_LEN - 2);
+}
+
+static void __mm81x_skbq_unlink(struct mm81x_skbq *mq,
+				struct sk_buff_head *queue, struct sk_buff *skb)
+{
+	if (queue == &mq->skbq) {
+		WARN_ON(skb->len > mq->skbq_size);
+		mq->skbq_size -= min(skb->len, mq->skbq_size);
+	}
+
+	__skb_unlink(skb, queue);
+}
+
+static int __mm81x_skbq_put(struct mm81x_skbq *mq, struct sk_buff_head *queue,
+			    struct sk_buff *skb, bool queue_at_head,
+			    struct sk_buff *queue_before)
+{
+	/* Limit the size of the Tx queue, but not the pending queue */
+	if (queue == &mq->skbq) {
+		if (skb->len > __mm81x_skbq_space(mq))
+			return -ENOMEM;
+
+		mq->skbq_size += skb->len;
+	}
+
+	if (queue_before)
+		__skb_queue_before(queue, queue_before, skb);
+	else if (queue_at_head)
+		__skb_queue_head(queue, skb);
+	else
+		__skb_queue_tail(queue, skb);
+
+	return 0;
+}
+
+static void __mm81x_skbq_pkt_id(struct mm81x_skbq *mq, struct sk_buff *skb)
+{
+	struct mm81x_skb_hdr *hdr = (struct mm81x_skb_hdr *)skb->data;
+
+	hdr->tx_info.pkt_id = cpu_to_le32(mq->pkt_seq++);
+}
+
+static struct mm81x_skbq *
+__mm81x_skbq_tx_status_to_skbq(struct mm81x *mm,
+			       const struct mm81x_skb_tx_status *tx_sts)
+{
+	int aci;
+	struct mm81x_skbq *mq = NULL;
+
+	switch (tx_sts->channel) {
+	case MM81X_SKB_CHAN_DATA:
+	case MM81X_SKB_CHAN_DATA_NOACK:
+		aci = dot11_tid_to_ac(tx_sts->tid);
+		mq = mm81x_hif_get_tx_data_queue(mm, aci);
+		break;
+	case MM81X_SKB_CHAN_MGMT:
+		mq = mm81x_hif_get_tx_mgmt_queue(mm);
+		break;
+	case MM81X_SKB_CHAN_BEACON:
+		mq = mm81x_hif_get_tx_beacon_queue(mm);
+		break;
+	default:
+		mm81x_err(mm, "unexpected channel on reported tx status [%d]",
+			  tx_sts->channel);
+	}
+
+	return mq;
+}
+
+void mm81x_skbq_pull_hdr_post_tx(struct sk_buff *skb)
+{
+	skb_pull(skb, sizeof(struct mm81x_skb_hdr) +
+			      ((struct mm81x_skb_hdr *)skb->data)->offset);
+}
+
+static void mm81x_skbq_insert_pending(struct mm81x_skbq *mq,
+				      struct sk_buff *skb, __le32 insertion_id)
+{
+	struct sk_buff *pfirst, *pnext;
+	struct mm81x_skb_hdr *mhdr;
+	struct sk_buff *tail = skb_peek_tail(&mq->skbq);
+
+	__mm81x_skbq_unlink(mq, &mq->pending, skb);
+
+	if (!tail) {
+		__mm81x_skbq_put(mq, &mq->skbq, skb, false, NULL);
+		return;
+	}
+
+	/* Check if it should just be inserted on to the end */
+	mhdr = (struct mm81x_skb_hdr *)tail->data;
+	WARN_ON(insertion_id == mhdr->tx_info.pkt_id);
+	if (le32_to_cpu(insertion_id) >= le32_to_cpu(mhdr->tx_info.pkt_id)) {
+		__mm81x_skbq_put(mq, &mq->skbq, skb, false, NULL);
+		return;
+	}
+
+	/* Otherwise, re-insert to correct spot in skbq */
+	skb_queue_walk_safe(&mq->skbq, pfirst, pnext) {
+		mhdr = (struct mm81x_skb_hdr *)pfirst->data;
+
+		WARN_ON(insertion_id == mhdr->tx_info.pkt_id);
+		if (le32_to_cpu(insertion_id) <=
+		    le32_to_cpu(mhdr->tx_info.pkt_id)) {
+			__mm81x_skbq_put(mq, &mq->skbq, skb, false, pfirst);
+			return;
+		}
+	}
+
+	WARN_ON_ONCE(1);
+}
+
+static void mm81x_skbq_sta_eosp(struct mm81x *mm, struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = txi->control.vif;
+
+	mm81x_skbq_pull_hdr_post_tx(skb);
+
+	/*
+	 * If this frame is the last frame in a PS-Poll or u-APSD SP,
+	 * then mac80211 must be informed that the SP is now over.
+	 */
+	if (txi->flags & IEEE80211_TX_STATUS_EOSP) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		struct ieee80211_sta *sta;
+
+		scoped_guard(rcu) {
+			sta = ieee80211_find_sta(vif, hdr->addr1);
+			if (sta)
+				ieee80211_sta_eosp(sta);
+		}
+	}
+}
+
+static void __mm81x_skbq_drop_pending_skb(struct mm81x_skbq *mq,
+					  struct sk_buff *skb)
+{
+	__mm81x_skbq_unlink(mq, &mq->pending, skb);
+	mm81x_skbq_sta_eosp(mq->mm, skb);
+	ieee80211_free_txskb(mq->mm->hw, skb);
+}
+
+static bool mm81x_tx_h_is_ps_filtered(struct mm81x_skbq *mq,
+				      struct sk_buff *skb,
+				      struct mm81x_skb_tx_status *tx_sts)
+{
+	struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = txi->control.vif;
+
+	WARN_ON_ONCE(!(le32_to_cpu(tx_sts->flags) &
+		       MM81X_TX_STATUS_FLAGS_PS_FILTERED));
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		__mm81x_skbq_drop_pending_skb(mq, skb);
+		return true;
+	}
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		mm81x_skbq_insert_pending(mq, skb, tx_sts->pkt_id);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Get a pending frame by its ID. This will also drop frames with
+ * older packet ids that are in the list
+ */
+static struct sk_buff *__mm81x_skbq_get_pending_by_id(struct mm81x *mm,
+						      struct mm81x_skbq *mq,
+						      u32 pkt_id)
+{
+	struct sk_buff *pfirst, *pnext;
+	struct sk_buff *ret = NULL;
+
+	/* Move sent packets to pending list waiting for feedback */
+	skb_queue_walk_safe(&mq->pending, pfirst, pnext) {
+		struct mm81x_skb_hdr *hdr =
+			(struct mm81x_skb_hdr *)pfirst->data;
+
+		if (le32_to_cpu(hdr->tx_info.pkt_id) == pkt_id) {
+			ret = pfirst;
+			break;
+
+		} else if (le32_to_cpu(hdr->tx_info.pkt_id) < pkt_id &&
+			   __mm81x_skbq_has_pending_tx_skb_timed_out(pfirst)) {
+			__mm81x_skbq_drop_pending_skb(mq, pfirst);
+		}
+	}
+
+	return ret;
+}
+
+static void mm81x_skbq_tx_status_process(struct mm81x *mm, struct sk_buff *skb)
+{
+	int i;
+	struct mm81x_skb_tx_status *tx_sts =
+		(struct mm81x_skb_tx_status *)skb->data;
+	int count = skb->len / sizeof(*tx_sts);
+
+	for (i = 0; i < count; tx_sts++, i++) {
+		struct sk_buff *tx_skb;
+		struct mm81x_skbq *mq =
+			__mm81x_skbq_tx_status_to_skbq(mm, tx_sts);
+		bool is_ps_filtered = (le32_to_cpu(tx_sts->flags) &
+				       MM81X_TX_STATUS_FLAGS_PS_FILTERED);
+
+		if (!mq)
+			continue;
+
+		spin_lock_bh(&mq->lock);
+		tx_skb = __mm81x_skbq_get_pending_by_id(
+			mm, mq, le32_to_cpu(tx_sts->pkt_id));
+		if (!tx_skb) {
+			mm81x_dbg(
+				mm, MM81X_DBG_ANY,
+				"No pending pkt match found [pktid:%d chan:%d]",
+				tx_sts->pkt_id, tx_sts->channel);
+			spin_unlock_bh(&mq->lock);
+			continue;
+		}
+
+		if (le32_to_cpu(tx_sts->flags) & MM81X_TX_STATUS_PAGE_INVALID) {
+			__mm81x_skbq_drop_pending_skb(mq, tx_skb);
+			spin_unlock_bh(&mq->lock);
+			continue;
+		}
+
+		if (le32_to_cpu(tx_sts->flags) &
+		    MM81X_TX_STATUS_DUTY_CYCLE_CANT_SEND) {
+			__mm81x_skbq_drop_pending_skb(mq, tx_skb);
+			spin_unlock_bh(&mq->lock);
+			continue;
+		}
+
+		if (is_ps_filtered &&
+		    mm81x_tx_h_is_ps_filtered(mq, tx_skb, tx_sts)) {
+			/* Has been consumed by mm81x_tx_h_is_ps_filtered */
+			spin_unlock_bh(&mq->lock);
+			continue;
+		}
+
+		mm81x_skbq_pull_hdr_post_tx(tx_skb);
+		mm81x_skbq_skb_finish(mq, tx_skb, tx_sts);
+		spin_unlock_bh(&mq->lock);
+	}
+
+	if (mm->ps.enable && !mm->ps.suspended &&
+	    (mm81x_hif_get_tx_buffered_count(mm) == 0)) {
+		/* Evaluate ps, check if it was gated on a pending tx status */
+		queue_delayed_work(mm->chip_wq, &mm->ps.delayed_eval_work, 0);
+	}
+}
+
+static void mm81x_skbq_dispatch_work(struct work_struct *dispatch_work)
+{
+	struct mm81x_skbq *mq =
+		container_of(dispatch_work, struct mm81x_skbq, dispatch_work);
+	struct mm81x *mm = mq->mm;
+	struct mm81x_skb_hdr *hdr;
+	struct sk_buff_head skbq;
+	struct sk_buff *pfirst, *pnext;
+	u8 channel;
+
+	__skb_queue_head_init(&skbq);
+
+	mm81x_skbq_deq_num_skb(mq, &skbq, mm81x_skbq_count(mq));
+
+	skb_queue_walk_safe(&skbq, pfirst, pnext) {
+		__skb_unlink(pfirst, &skbq);
+		/* Header endianness has already be adjusted */
+		hdr = (struct mm81x_skb_hdr *)pfirst->data;
+		channel = hdr->channel;
+		/* Remove mm81x header and padding */
+		__skb_pull(pfirst, sizeof(*hdr) + hdr->offset);
+
+		switch (channel) {
+		case MM81X_SKB_CHAN_COMMAND:
+			mm81x_cmd_resp_process(mm, pfirst);
+			break;
+		case MM81X_SKB_CHAN_TX_STATUS:
+			mm81x_skbq_tx_status_process(mm, pfirst);
+			dev_kfree_skb_any(pfirst);
+			break;
+		default:
+			mm81x_mac_rx_skb(mm, pfirst, &hdr->rx_status);
+			break;
+		}
+	}
+
+	if (mm81x_skbq_count(mq))
+		queue_work(mm->net_wq, &mq->dispatch_work);
+}
+
+int mm81x_skbq_put(struct mm81x_skbq *mq, struct sk_buff *skb)
+{
+	int ret;
+
+	spin_lock_bh(&mq->lock);
+	ret = __mm81x_skbq_put(mq, &mq->skbq, skb, false, NULL);
+	spin_unlock_bh(&mq->lock);
+	return ret;
+}
+
+static void mm81x_skbq_set_queued_tx_skb_expiry(struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
+
+	if (ieee80211_is_probe_req(hdr->frame_control) ||
+	    ieee80211_is_probe_resp(hdr->frame_control) ||
+	    ieee80211_is_auth(hdr->frame_control)) {
+		txi->control.enqueue_time = (u32)jiffies;
+	} else {
+		txi->control.enqueue_time = 0;
+	}
+}
+
+static bool mm81x_skbq_has_queued_tx_skb_expired(struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
+
+	if (txi->control.enqueue_time > 0) {
+		u32 expiry_time =
+			txi->control.enqueue_time +
+			msecs_to_jiffies(MM81X_SKBQ_TX_QUEUED_LIFETIME_MS);
+
+		return (s32)((u32)jiffies - expiry_time) > 0;
+	}
+
+	return false;
+}
+
+/*
+ * Drop selected frames (those with an expiry time set) that could not
+ * be sent within a reasonable timeframe due to congestion. These would
+ * only be rejected or ignored by the peer, so are only contributing to
+ * the problem.
+ */
+void mm81x_skbq_purge_aged(struct mm81x *mm, struct mm81x_skbq *mq)
+{
+	int dropped = 0;
+	struct sk_buff *pfirst;
+	struct sk_buff *pnext;
+
+	spin_lock_bh(&mq->lock);
+	skb_queue_walk_safe(&mq->skbq, pfirst, pnext) {
+		if (!mm81x_skbq_has_queued_tx_skb_expired(pfirst))
+			break;
+		__mm81x_skbq_unlink(mq, &mq->skbq, pfirst);
+		ieee80211_free_txskb(mm->hw, pfirst);
+		dropped++;
+	}
+
+	spin_unlock_bh(&mq->lock);
+}
+
+void mm81x_skbq_purge(struct mm81x_skbq *mq, struct sk_buff_head *skbq)
+{
+	struct sk_buff *skb;
+
+	spin_lock_bh(&mq->lock);
+	while ((skb = __skb_dequeue(skbq)))
+		dev_kfree_skb_any(skb);
+	spin_unlock_bh(&mq->lock);
+}
+
+void mm81x_skbq_enq(struct mm81x_skbq *mq, struct sk_buff_head *skbq)
+{
+	int size;
+	struct sk_buff *pfirst, *pnext;
+
+	spin_lock_bh(&mq->lock);
+	size = __mm81x_skbq_space(mq);
+	skb_queue_walk_safe(skbq, pfirst, pnext) {
+		if (pfirst->len > size)
+			break;
+		__skb_unlink(pfirst, skbq);
+		__mm81x_skbq_put(mq, &mq->skbq, pfirst, false, NULL);
+		size -= pfirst->len;
+	}
+
+	spin_unlock_bh(&mq->lock);
+}
+
+int mm81x_skbq_deq_num_skb(struct mm81x_skbq *mq, struct sk_buff_head *skbq,
+			   int num_skb)
+{
+	int count = 0;
+	struct sk_buff *pfirst, *pnext;
+
+	spin_lock_bh(&mq->lock);
+	skb_queue_walk_safe(&mq->skbq, pfirst, pnext) {
+		if (count >= num_skb)
+			break;
+		__mm81x_skbq_unlink(mq, &mq->skbq, pfirst);
+		__skb_queue_tail(skbq, pfirst);
+		++count;
+	}
+
+	spin_unlock_bh(&mq->lock);
+	return count;
+}
+
+void mm81x_skbq_enq_prepend(struct mm81x_skbq *mq, struct sk_buff_head *skbq)
+{
+	int size;
+	struct sk_buff *pfirst, *pnext;
+
+	spin_lock_bh(&mq->lock);
+	size = __mm81x_skbq_space(mq);
+
+	/*
+	 * We are doing a reverse walk here to ensure the order remains the
+	 * same. This means the last member of the queue goes in, on top of
+	 * the queue first and gets pushed down as more members get added to
+	 * the top of the queue.
+	 */
+	skb_queue_reverse_walk_safe(skbq, pfirst, pnext)
+	{
+		if (pfirst->len > size)
+			break;
+		__skb_unlink(pfirst, skbq);
+		__mm81x_skbq_put(mq, &mq->skbq, pfirst, true, NULL);
+		size -= pfirst->len;
+	}
+
+	spin_unlock_bh(&mq->lock);
+}
+
+static void mm81x_skbq_stop_tx_queues(struct mm81x *mm)
+{
+	int queue;
+
+	if (!mm->started)
+		return;
+	for (queue = IEEE80211_AC_VO; queue <= IEEE80211_AC_BK; queue++)
+		ieee80211_stop_queue(mm->hw, queue);
+
+	set_bit(MM81X_STATE_DATA_QS_STOPPED, &mm->state_flags);
+}
+
+/* Wake all Tx queues if all queues are below threshold */
+void mm81x_skbq_may_wake_tx_queues(struct mm81x *mm)
+{
+	int queue;
+	struct mm81x_skbq *qs;
+	int num_qs;
+	bool could_wake;
+
+	if (!mm->started)
+		return;
+
+	could_wake = true;
+	mm81x_hif_skbq_get_tx_qs(mm, &qs, &num_qs);
+	for (queue = 0; queue < num_qs; queue++) {
+		struct mm81x_skbq *mq = &qs[queue];
+
+		if (!could_wake)
+			break;
+
+		spin_lock_bh(&mq->lock);
+		could_wake &= (__mm81x_skbq_under_threshold(mq));
+		spin_unlock_bh(&mq->lock);
+	}
+
+	if (!could_wake)
+		return;
+
+	for (queue = IEEE80211_AC_VO; queue <= IEEE80211_AC_BK; queue++)
+		ieee80211_wake_queue(mm->hw, queue);
+
+	clear_bit(MM81X_STATE_DATA_QS_STOPPED, &mm->state_flags);
+}
+
+static int mm81x_skbq_tx(struct mm81x_skbq *mq, struct sk_buff *skb, u8 channel)
+{
+	int rc;
+	bool mq_over_threshold;
+	struct mm81x *mm = mq->mm;
+
+	spin_lock_bh(&mq->lock);
+	rc = __mm81x_skbq_put(mq, &mq->skbq, skb, false, NULL);
+	if (rc) {
+		mm81x_err(mm, "skb put chan %d failed (%d)", channel, rc);
+		if (channel == MM81X_SKB_CHAN_DATA) {
+			u16 queue = skb_get_queue_mapping(skb);
+
+			mm81x_err(mm, "skb put queue %d status %d", queue,
+				  ieee80211_queue_stopped(mm->hw, queue));
+		}
+	}
+
+	/* Fill packet ID in TX info */
+	__mm81x_skbq_pkt_id(mq, skb);
+
+	mq_over_threshold = __mm81x_skbq_over_threshold(mq);
+	spin_unlock_bh(&mq->lock);
+
+	/* For data packets stop queues */
+	if (channel == MM81X_SKB_CHAN_DATA && mq_over_threshold)
+		mm81x_skbq_stop_tx_queues(mm);
+
+	switch (channel) {
+	case MM81X_SKB_CHAN_DATA:
+	case MM81X_SKB_CHAN_DATA_NOACK:
+		if (mm81x_is_data_tx_allowed(mm)) {
+			set_bit(MM81X_HIF_EVT_TX_DATA_PEND,
+				&mm->hif.event_flags);
+			queue_work(mm->chip_wq, &mm->hif_work);
+		}
+		break;
+	case MM81X_SKB_CHAN_MGMT:
+		set_bit(MM81X_HIF_EVT_TX_MGMT_PEND, &mm->hif.event_flags);
+		queue_work(mm->chip_wq, &mm->hif_work);
+		break;
+	case MM81X_SKB_CHAN_BEACON:
+		set_bit(MM81X_HIF_EVT_TX_BEACON_PEND, &mm->hif.event_flags);
+		queue_work(mm->chip_wq, &mm->hif_work);
+		break;
+	case MM81X_SKB_CHAN_COMMAND:
+		set_bit(MM81X_HIF_EVT_TX_COMMAND_PEND, &mm->hif.event_flags);
+		queue_work(mm->chip_wq, &mm->hif_work);
+		break;
+	default:
+		mm81x_err(mm, "Invalid skb channel: %d", channel);
+		break;
+	}
+
+	return rc;
+}
+
+static inline void __mm81x_skbq_tx_move_to_pending(struct mm81x_skbq *mq,
+						   struct sk_buff *skb)
+{
+	struct mm81x_tx_status_priv *pend_info =
+		__mm81x_skbq_tx_status_priv(skb);
+
+	pend_info->tx_status_expiry =
+		jiffies + msecs_to_jiffies(MM81X_SKBQ_TX_STATUS_LIFETIME_MS);
+	__mm81x_skbq_put(mq, &mq->pending, skb, false, NULL);
+}
+
+void mm81x_skbq_tx_complete(struct mm81x_skbq *mq, struct sk_buff_head *skbq)
+{
+	bool skb_awaits_tx_status = false;
+	struct mm81x *mm = mq->mm;
+	struct sk_buff *pfirst, *pnext;
+	struct sk_buff *peek = skb_peek(skbq);
+	struct mm81x_skb_hdr *hdr;
+	const bool fw_reports_bcn_tx_status =
+		mm->firmware_flags &
+		MM81X_FW_FLAGS_REPORTS_TX_BEACON_COMPLETION;
+
+	if (!peek)
+		return;
+
+	/* Move sent packets to pending list waiting for feedback */
+	spin_lock_bh(&mq->lock);
+	skb_queue_walk_safe(skbq, pfirst, pnext) {
+		__skb_unlink(pfirst, skbq);
+		hdr = (struct mm81x_skb_hdr *)pfirst->data;
+		/*
+		 * If firmware doesn't give status on beacons just free
+		 * them, otherwise queue and wait for response.
+		 */
+		switch (hdr->channel) {
+		case MM81X_SKB_CHAN_BEACON:
+			if (fw_reports_bcn_tx_status) {
+				__mm81x_skbq_tx_move_to_pending(mq, pfirst);
+				skb_awaits_tx_status = true;
+				break;
+			}
+			/*
+			 * If the FW doesn't give statuses on beacon's,
+			 * then mark them as done.
+			 */
+			mm81x_skbq_pull_hdr_post_tx(pfirst);
+			dev_kfree_skb_any(pfirst);
+			break;
+		default:
+			if (le32_to_cpu(hdr->tx_info.flags) &
+			    MM81X_TX_STATUS_FLAGS_NO_REPORT) {
+				dev_kfree_skb_any(pfirst);
+			} else {
+				/*
+				 * skb has been given to the chip. Store the
+				 * time and queue the skb onto the pending
+				 * queue while we wait for the tx_status.
+				 */
+				__mm81x_skbq_tx_move_to_pending(mq, pfirst);
+				skb_awaits_tx_status = true;
+			}
+			break;
+		}
+	}
+	spin_unlock_bh(&mq->lock);
+
+	if (skb_awaits_tx_status) {
+		spin_lock_bh(&mm->stale_status.lock);
+		mod_timer(&mm->stale_status.timer,
+			  jiffies + msecs_to_jiffies(
+					    MM81X_SKBQ_TX_STATUS_LIFETIME_MS));
+		spin_unlock_bh(&mm->stale_status.lock);
+	}
+}
+
+/* Returns the first skb in the pending list. */
+struct sk_buff *mm81x_skbq_tx_pending(struct mm81x_skbq *mq)
+{
+	struct sk_buff *pfirst;
+
+	spin_lock_bh(&mq->lock);
+	pfirst = skb_peek(&mq->pending);
+	spin_unlock_bh(&mq->lock);
+	return pfirst;
+}
+
+int mm81x_skbq_check_for_stale_tx(struct mm81x *mm, struct mm81x_skbq *mq)
+{
+	int flushed = 0;
+	struct sk_buff *pfirst;
+	struct sk_buff *pnext;
+
+	if (!skb_queue_len(&mq->pending))
+		return 0;
+
+	/* Move sent packets to pending list waiting for feedback */
+	spin_lock_bh(&mq->lock);
+	skb_queue_walk_safe(&mq->pending, pfirst, pnext) {
+		struct mm81x_skb_hdr *hdr =
+			(struct mm81x_skb_hdr *)pfirst->data;
+
+		if (__mm81x_skbq_has_pending_tx_skb_timed_out(pfirst)) {
+			mm81x_dbg(mm, MM81X_DBG_ANY,
+				  "TX skb timed out [id:%d,chan:%d]",
+				  hdr->tx_info.pkt_id, hdr->channel);
+
+			__mm81x_skbq_drop_pending_skb(mq, pfirst);
+			flushed++;
+		}
+	}
+
+	spin_unlock_bh(&mq->lock);
+	return flushed;
+}
+
+/* Remove commands from pending (or skbq if not sent) */
+static void __skbq_cmd_finish(struct mm81x_skbq *mq, struct sk_buff *skb)
+{
+	struct mm81x *mm = mq->mm;
+
+	if (skb_queue_len(&mq->pending)) {
+		__mm81x_skbq_unlink(mq, &mq->pending, skb);
+		dev_kfree_skb(skb);
+	} else if (skb_queue_len(&mq->skbq)) {
+		/* Command was probably timed out before being sent */
+		mm81x_dbg(mm, MM81X_DBG_SKBQ,
+			  "Command pending queue empty. Removing from SKBQ.");
+		__mm81x_skbq_unlink(mq, &mq->skbq, skb);
+		dev_kfree_skb(skb);
+	} else {
+		mm81x_dbg(mm, MM81X_DBG_SKBQ, "Command Q not found");
+	}
+}
+
+struct mm81x_update_sta_iter_data {
+	struct mm81x *mm;
+	struct sk_buff *skb;
+	struct mm81x_skb_tx_status *tx_sts;
+	int tx_attempts;
+	bool updated;
+};
+
+static void mm81x_tx_h_update_sta_iter(void *data, u8 *mac,
+				       struct ieee80211_vif *vif)
+{
+	struct mm81x_update_sta_iter_data *iter = data;
+	struct ieee80211_hdr *hdr;
+	struct ieee80211_sta *sta;
+
+	if (iter->updated || !iter->skb || !iter->skb->data)
+		return;
+
+	hdr = (struct ieee80211_hdr *)iter->skb->data;
+
+	/*
+	 * Note that each iteration via
+	 * ieee80211_iterate_active_interfaces_atomic is under an RCU critical
+	 * section so there is no need for a local critical section within here
+	 * when looking up the station.
+	 */
+	sta = ieee80211_find_sta(vif, hdr->addr1);
+	if (!sta)
+		return;
+
+	mm81x_rc_sta_feedback_rates(iter->mm, iter->skb, sta, iter->tx_sts,
+				    iter->tx_attempts);
+	mm81x_tx_h_check_aggr(sta, iter->skb);
+
+	/*
+	 * In situations with multiple virtual interfaces, finish iteration
+	 * once we have found our STA to prevent further iteration.
+	 */
+	iter->updated = true;
+}
+
+/* TX status/Response received remove packet from pending TX finish */
+static void __skbq_data_tx_finish(struct mm81x_skbq *mq, struct sk_buff *skb,
+				  struct mm81x_skb_tx_status *tx_sts)
+{
+	struct mm81x *mm = mq->mm;
+	struct mm81x_update_sta_iter_data iter = {};
+
+	__mm81x_skbq_unlink(mq, &mq->pending, skb);
+	iter.mm = mm;
+	iter.skb = skb;
+	iter.tx_sts = tx_sts;
+	iter.tx_attempts = mm81x_tx_h_get_attempts(mm, tx_sts);
+
+	ieee80211_iterate_active_interfaces_atomic(mm->hw,
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   mm81x_tx_h_update_sta_iter,
+						   &iter);
+
+	ieee80211_tx_status_skb(mm->hw, skb);
+}
+
+void mm81x_skbq_skb_finish(struct mm81x_skbq *mq, struct sk_buff *skb,
+			   struct mm81x_skb_tx_status *tx_sts)
+{
+	if (mq->flags & MM81X_HIF_FLAGS_COMMAND)
+		__skbq_cmd_finish(mq, skb);
+	else
+		__skbq_data_tx_finish(mq, skb, tx_sts);
+}
+
+void mm81x_skbq_tx_flush(struct mm81x_skbq *mq)
+{
+	struct sk_buff *pfirst, *pnext;
+
+	spin_lock_bh(&mq->lock);
+	skb_queue_walk_safe(&mq->pending, pfirst, pnext) {
+		__mm81x_skbq_unlink(mq, &mq->pending, pfirst);
+		ieee80211_free_txskb(mq->mm->hw, pfirst);
+	}
+
+	skb_queue_walk_safe(&mq->skbq, pfirst, pnext) {
+		__mm81x_skbq_unlink(mq, &mq->skbq, pfirst);
+		ieee80211_free_txskb(mq->mm->hw, pfirst);
+	}
+	spin_unlock_bh(&mq->lock);
+}
+
+void mm81x_skbq_init(struct mm81x *mm, struct mm81x_skbq *mq, u16 flags)
+{
+	spin_lock_init(&mq->lock);
+	__skb_queue_head_init(&mq->skbq);
+	__skb_queue_head_init(&mq->pending);
+	mq->mm = mm;
+	mq->skbq_size = 0;
+	mq->flags = flags;
+	mq->pkt_seq = 0;
+	if (flags & MM81X_HIF_FLAGS_DIR_TO_HOST)
+		INIT_WORK(&mq->dispatch_work, mm81x_skbq_dispatch_work);
+}
+
+void mm81x_skbq_finish(struct mm81x_skbq *mq)
+{
+	if (mq->skbq_size > 0)
+		mm81x_dbg(mq->mm, MM81X_DBG_SKBQ,
+			  "Purging a non empty MorseQ. Dropping data!");
+
+	/* Clean up link to hif */
+	if (mq->flags & MM81X_HIF_FLAGS_DIR_TO_HOST)
+		cancel_work_sync(&mq->dispatch_work);
+	mm81x_skbq_purge(mq, &mq->skbq);
+	mm81x_skbq_purge(mq, &mq->pending);
+	mq->skbq_size = 0;
+}
+
+u32 mm81x_skbq_size(struct mm81x_skbq *mq)
+{
+	u32 count;
+
+	spin_lock_bh(&mq->lock);
+	count = __mm81x_skbq_size(mq);
+	spin_unlock_bh(&mq->lock);
+	return count;
+}
+
+u32 mm81x_skbq_count(struct mm81x_skbq *mq)
+{
+	u32 count = 0;
+
+	spin_lock_bh(&mq->lock);
+	count += skb_queue_len(&mq->skbq);
+	spin_unlock_bh(&mq->lock);
+	return count;
+}
+
+u32 mm81x_skbq_pending_count(struct mm81x_skbq *mq)
+{
+	u32 count;
+
+	spin_lock_bh(&mq->lock);
+	count = skb_queue_len(&mq->pending);
+	spin_unlock_bh(&mq->lock);
+	return count;
+}
+
+u32 mm81x_skbq_count_tx_ready(struct mm81x_skbq *mq)
+{
+	struct mm81x *mm = mq->mm;
+
+	if (!mm81x_is_data_tx_allowed(mm))
+		return 0;
+
+	return mm81x_skbq_count(mq);
+}
+
+u32 mm81x_skbq_space(struct mm81x_skbq *mq)
+{
+	u32 space;
+
+	spin_lock_bh(&mq->lock);
+	space = __mm81x_skbq_space(mq);
+	spin_unlock_bh(&mq->lock);
+
+	return space;
+}
+
+struct sk_buff *mm81x_skbq_alloc_skb(struct mm81x_skbq *mq, unsigned int length)
+{
+	struct sk_buff *skb;
+	int tx_headroom =
+		sizeof(struct mm81x_skb_hdr) + mm81x_bus_get_alignment(mq->mm);
+	int skb_len = tx_headroom + length + MM81X_PAD4(length);
+
+	skb = dev_alloc_skb(skb_len);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, tx_headroom);
+	skb_put(skb, length);
+	return skb;
+}
+
+static int mm81x_skb_tx_h_validate_channel(const struct mm81x *mm, u8 channel)
+{
+	if (channel == MM81X_SKB_CHAN_COMMAND) {
+		if (test_bit(MM81X_STATE_HOST_TO_CHIP_CMD_BLOCKED,
+			     &mm->state_flags))
+			return -EPERM;
+	} else {
+		if (test_bit(MM81X_STATE_HOST_TO_CHIP_TX_BLOCKED,
+			     &mm->state_flags))
+			return -EPERM;
+	}
+
+	return 0;
+}
+
+int mm81x_skbq_skb_tx(struct mm81x_skbq *mq, struct sk_buff **skb_orig,
+		      struct mm81x_skb_tx_info *tx_info, u8 channel)
+{
+	int ret;
+	struct mm81x_skb_hdr hdr;
+	struct mm81x *mm = mq->mm;
+	size_t end_of_skb_pad;
+	struct sk_buff *skb = *skb_orig;
+	u8 *aligned_head, *data;
+
+	if (test_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mm->state_flags)) {
+		dev_kfree_skb_any(skb);
+		return -ENODEV;
+	}
+
+	ret = mm81x_skb_tx_h_validate_channel(mm, channel);
+	if (ret) {
+		dev_kfree_skb_any(skb);
+		return ret;
+	}
+
+	mm81x_skbq_set_queued_tx_skb_expiry(skb);
+
+	data = skb->data;
+	aligned_head = PTR_ALIGN_DOWN((data - sizeof(hdr)),
+				      mm81x_bus_get_alignment(mm));
+	hdr.sync = MM81X_SKB_HEADER_SYNC;
+	hdr.channel = channel;
+	hdr.len = cpu_to_le16(skb->len);
+	hdr.offset = data - (aligned_head + sizeof(hdr));
+	hdr.checksum_upper = 0;
+	hdr.checksum_lower = 0;
+	if (tx_info)
+		memcpy(&hdr.tx_info, tx_info, sizeof(*tx_info));
+	else
+		memset(&hdr.tx_info, 0, sizeof(hdr.tx_info));
+
+	skb_push(skb, data - aligned_head);
+	memcpy(skb->data, &hdr, sizeof(hdr));
+
+	end_of_skb_pad = MM81X_PAD4(skb->len);
+	if (end_of_skb_pad && skb_pad(skb, end_of_skb_pad))
+		return -EINVAL;
+
+	ret = mm81x_skbq_tx(mq, skb, channel);
+	if (ret) {
+		mm81x_err(mm, "mm81x_skbq_tx fail: %d", ret);
+		dev_kfree_skb_any(skb);
+	}
+
+	return ret;
+}
+
+void mm81x_skbq_data_traffic_pause(struct mm81x *mm)
+{
+	set_bit(MM81X_STATE_DATA_TX_STOPPED, &mm->state_flags);
+	/* power-save requirements will be re-evaluated by the caller */
+}
+
+void mm81x_skbq_data_traffic_resume(struct mm81x *mm)
+{
+	clear_bit(MM81X_STATE_DATA_TX_STOPPED, &mm->state_flags);
+
+	/* Set the TX_DATA_PEND bit. This will kick the transmission path to
+	 * send any frames pending in the TX buffers, and wake the mac80211
+	 * data Qs if they were previously stopped.
+	 */
+	set_bit(MM81X_HIF_EVT_TX_DATA_PEND, &mm->hif.event_flags);
+}
+
+bool mm81x_skbq_validate_checksum(u8 *data)
+{
+	int i;
+	u32 xor = 0;
+	struct mm81x_skb_hdr *skb_hdr = (struct mm81x_skb_hdr *)data;
+	struct ieee80211_hdr *hdr =
+		(struct ieee80211_hdr *)(data + sizeof(*skb_hdr));
+	u16 len = le16_to_cpu(skb_hdr->len) + sizeof(*skb_hdr);
+	u32 *data_to_xor = (u32 *)data;
+	u32 header_xor = (le16_to_cpu(skb_hdr->checksum_upper) << 8) |
+			 (skb_hdr->checksum_lower);
+
+	/*
+	 * For data frames the calculate the xor for skb header, mac header
+	 * and ccmp header. For all other channel the xor is calculated for
+	 * the full skb.
+	 */
+	if (skb_hdr->channel == MM81X_SKB_CHAN_DATA &&
+	    (ieee80211_is_data(hdr->frame_control) ||
+	     ieee80211_is_data_qos(hdr->frame_control))) {
+		u16 data_len = sizeof(*skb_hdr) +
+			       sizeof(struct ieee80211_qos_hdr) +
+			       IEEE80211_CCMP_HDR_LEN;
+
+		len = min(len, data_len);
+		len = ROUND_DOWN_TO_WORD(len);
+	}
+
+	skb_hdr->checksum_upper = 0;
+	skb_hdr->checksum_lower = 0;
+
+	for (i = 0; i < len; i += 4) {
+		xor ^= *data_to_xor;
+		data_to_xor++;
+	}
+
+	xor &= 0x00FFFFFF;
+
+	return xor == header_xor;
+}
-- 
2.43.0


