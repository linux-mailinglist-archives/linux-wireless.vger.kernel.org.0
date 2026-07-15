Return-Path: <linux-wireless+bounces-39143-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id raoBFbuDV2qDVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39143-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:57:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8875E63E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:57:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MudTshjB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39143-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39143-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2069308A273
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF0481AAC;
	Wed, 15 Jul 2026 12:50:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DC481257
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 12:50:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119840; cv=none; b=qfFKuX1109aAWEgtfn8A/dG9bIDzRKs+rgdpSMpuFjbFa4Yl/0i5P+6UZhSEXGMzbcGX941uPpbmLqu+g9ZvvfEE8i7Jw4pqNqY/rv9icaAjg0FuBjqAFD+IJOqMTCldt/jLPw9Rpp/YopNlZycjsoq2Rv4uQ0qe/1F4GZYzMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119840; c=relaxed/simple;
	bh=8fE9EBogaHt7KXm3RV616SCPYPD49SJGeiEVSWgXwdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emJBwztsfAVI/KJbrHPaAcyg0OzYDicaOxLbizcHHzo70tme27s3kNg0Rqp+CBTEehOgAVXulJLBoezNZDiaK4ffF7HwhrIyquj5sZyL0o5lmYGpP773CLpuuv6UfBmIrfrQsCccTb889uveJjQ/Xpp0hAa+QOc9dD1ISjMdij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MudTshjB; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784119834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtfzWGFBtflnyedcTL2bNv4P5mVxZBab52qWUKk3QRA=;
	b=MudTshjBb2O8hi6iKL0SH1yFLGi4uPIBxwVigfsHWd6aoXdgLtLeXpj7gk18I/pphuExUb
	BndqhGt7mBxjZqCMaysjAEf/PHwQNNDe3QW51UH89KbJGPCyCdZwDeoQ6GejgT4MkAVStj
	8en8D0w5VF3Cib1/2aQE7lZoIIwJZ6k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-WcQPVKSEOLCfklTIe-z3vw-1; Wed,
 15 Jul 2026 08:50:31 -0400
X-MC-Unique: WcQPVKSEOLCfklTIe-z3vw-1
X-Mimecast-MFC-AGG-ID: WcQPVKSEOLCfklTIe-z3vw_1784119830
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCF0E180064D;
	Wed, 15 Jul 2026 12:50:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DBD218004D4;
	Wed, 15 Jul 2026 12:50:26 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2 1/3] mac80211: add ieee80211_tx_peek API
Date: Wed, 15 Jul 2026 14:50:14 +0200
Message-ID: <20260715125017.277242-2-jtornosm@redhat.com>
In-Reply-To: <20260715125017.277242-1-jtornosm@redhat.com>
References: <20260715125017.277242-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39143-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5E8875E63E
X-Rspamd-Action: no action

Add ieee80211_tx_peek() to allow drivers to inspect the next frame
in a TXQ without removing it.

Drivers implementing custom wake_tx_queue operations may need to
determine which hardware TX ring to use before dequeuing a packet,
using properties like the skb hash or queue mapping that are only
available from the skb itself.

The function checks pending fragments first, then iterates through
all fair-queue flows (new_flows and old_flows) to find the first
queued frame, matching the iteration behavior of fq_tin_dequeue.
It also pre-caches the skb hash via skb_get_hash() so that
hash-based ring selectors see a stable value through the subsequent
dequeue and TX path.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
New in v2

 include/net/mac80211.h | 20 ++++++++++++++++++++
 net/mac80211/tx.c      | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4f95da023746..9289b8dca972 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7742,6 +7742,26 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *sta, u8 tid);
 struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 				     struct ieee80211_txq *txq);
 
+/**
+ * ieee80211_tx_peek - peek at the next packet in a software tx queue
+ *
+ * @hw: pointer as obtained from ieee80211_alloc_hw()
+ * @txq: pointer obtained from station or virtual interface, or from
+ *	ieee80211_next_txq()
+ *
+ * Return: the next skb without dequeuing it, or %NULL if the queue is empty.
+ * The returned pointer is const — the caller must not modify or free the skb.
+ * The skb remains queued and will be returned by a subsequent
+ * ieee80211_tx_dequeue() call.
+ *
+ * This is useful for drivers that need to inspect the next frame (e.g. to
+ * determine the target TX ring) before deciding whether to dequeue.
+ *
+ * Must be called in the same context as ieee80211_tx_dequeue().
+ */
+const struct sk_buff *ieee80211_tx_peek(struct ieee80211_hw *hw,
+					struct ieee80211_txq *txq);
+
 /**
  * ieee80211_tx_dequeue_ni - dequeue a packet from a software tx queue
  * (in process context)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c13b209fad47..91bfd8ef9428 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3857,6 +3857,45 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	return true;
 }
 
+const struct sk_buff *ieee80211_tx_peek(struct ieee80211_hw *hw,
+					struct ieee80211_txq *txq)
+{
+	struct txq_info *txqi = container_of(txq, struct txq_info, txq);
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct fq_tin *tin = &txqi->tin;
+	struct fq *fq = &local->fq;
+	struct sk_buff *skb = NULL;
+	struct fq_flow *flow;
+
+	WARN_ON_ONCE(softirq_count() == 0);
+
+	spin_lock_bh(&fq->lock);
+
+	skb = skb_peek(&txqi->frags);
+	if (skb)
+		goto out;
+
+	list_for_each_entry(flow, &tin->new_flows, flowchain) {
+		skb = skb_peek(&flow->queue);
+		if (skb)
+			goto out;
+	}
+
+	list_for_each_entry(flow, &tin->old_flows, flowchain) {
+		skb = skb_peek(&flow->queue);
+		if (skb)
+			goto out;
+	}
+
+out:
+	if (skb)
+		skb_get_hash(skb);
+
+	spin_unlock_bh(&fq->lock);
+	return skb;
+}
+EXPORT_SYMBOL_GPL(ieee80211_tx_peek);
+
 struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 				     struct ieee80211_txq *txq)
 {
-- 
2.54.0


