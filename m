Return-Path: <linux-wireless+bounces-38856-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wlqDOfQVUWrB/AIAu9opvQ
	(envelope-from <linux-wireless+bounces-38856-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 17:55:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5673C68A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 17:55:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ZWYC8qzn;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38856-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38856-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBE413017BD7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3DB3FB05C;
	Fri, 10 Jul 2026 15:55:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C573C4154
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 15:55:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783698914; cv=none; b=UqnFp+esWnTdDk0dukfm0DNEG1HN9ojuCue4arTjDyyVO3Cx7wem6R9LPmnxdxk4ckHXeD23PK9aEhyoN/fGwr3OmM+0hfHznhtvJeQS1Qc4YmDeysoeWa7CQ34av3S+dDYgfBFP4MEfSJwQ5n5TyEIZ9w5M2tZAc934RnVcKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783698914; c=relaxed/simple;
	bh=KOKM8Z5Og3W70F08Udtk/Tu48PLz+1SrvQ0yLlM63aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJjQRpFsUEKtsUo8AkOzKIeBYeGWpqFaCmjrAaCHI/rVxwp642aKvTSpcP8Rw/XMzyf2ZT75SFmpy8mWCDNbFY/VUNs+mNCJhLWKiaKSuAcJ18v8HUeJpXsMQC8K8eYV2ZFI38O91FcZIoVO+HRig00P5RHXu9+xa1FMqjrZpMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWYC8qzn; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783698912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=REFOK+cOhS8y8vRAa+RbtY6r4AJSAQeyMeqjIcisduI=;
	b=ZWYC8qznTTwYJnrVw2JPq1gmVya2hgFrwfNAZ6Z962C6RfE4krb8kkJZAUumW/F6dRafDL
	886z7C2B2arGbGeXzALo3bYtIBTjNd+hjSZaX37d0IfFrCbzrRb4frWbhr8EoAT0O12elG
	vEff1sIIbTaAHujluO5Rc9b/bjVgLVo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-qHcaYnJAMv6p54d2-a3U0Q-1; Fri,
 10 Jul 2026 11:55:09 -0400
X-MC-Unique: qHcaYnJAMv6p54d2-a3U0Q-1
X-Mimecast-MFC-AGG-ID: qHcaYnJAMv6p54d2-a3U0Q_1783698908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E81A81955DD1;
	Fri, 10 Jul 2026 15:55:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.25])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DC791800480;
	Fri, 10 Jul 2026 15:55:05 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH 2/2] wifi: ath12k: implement custom wake_tx_queue with flow control
Date: Fri, 10 Jul 2026 17:54:43 +0200
Message-ID: <20260710155443.1761760-3-jtornosm@redhat.com>
In-Reply-To: <20260710155443.1761760-1-jtornosm@redhat.com>
References: <20260710155443.1761760-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38856-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jtornosm@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58C5673C68A

Under heavy traffic, ath12k can hang and experiences -ENOMEM errors
("failed to transmit frame -12") when the hardware TCL ring fills up.
This issue is more commonly observed in VMs with PCIe passthrough but
also occurs on bare metal systems.

Implement a custom wake_tx_queue operation that:

1. Checks hardware ring space before dequeuing packets from mac80211
2. Uses per-packet locking to serialize ring access and prevent races
3. Syncs with hardware state to get accurate free slot count
4. Returns early during firmware crash in the same way as other tx paths

This approach follows the pattern used in the iwlwifi driver, adapted
for ath12k's hardware ring architecture.

This prevents hangs, eliminates -ENOMEM errors, and improves throughput
by optimizing resource usage and preventing unnecessary packet drops.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/ath/ath12k/dp.c       |  1 +
 drivers/net/wireless/ath/ath12k/dp.h       |  2 +
 drivers/net/wireless/ath/ath12k/hal.c      |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 50 +++++++++++++++++++++-
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index af5f11fc1d84..3d46cfbf0a1c 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1539,6 +1539,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
 	}
 
 	for (i = 0; i < ab->hw_params->max_tx_ring; i++) {
+		spin_lock_init(&dp->tx_ring[i].wake_tx_lock);
 		dp->tx_ring[i].tcl_data_ring_id = i;
 
 		dp->tx_ring[i].tx_status_head = 0;
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index f8cfc7bb29dd..68d2020be9b8 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -58,6 +58,8 @@ struct dp_tx_ring {
 	u8 tcl_data_ring_id;
 	struct dp_srng tcl_data_ring;
 	struct dp_srng tcl_comp_ring;
+	/* Serializes wake_tx_queue operations for this ring */
+	spinlock_t wake_tx_lock;
 	struct hal_wbm_completion_ring_tx *tx_status;
 	int tx_status_head;
 	int tx_status_tail;
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a164563fff28..c1c656e4550b 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -390,6 +390,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
 	else
 		return ((srng->ring_size - hp + tp) / srng->entry_size) - 1;
 }
+EXPORT_SYMBOL(ath12k_hal_srng_src_num_free);
 
 void *ath12k_hal_srng_src_next_peek(struct ath12k_base *ab,
 				    struct hal_srng *srng)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index d9fdd2fc8298..e3a6f9cdee24 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -1100,9 +1100,57 @@ static void ath12k_wifi7_mac_op_tx(struct ieee80211_hw *hw,
 	}
 }
 
+static void ath12k_wifi7_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
+					      struct ieee80211_txq *txq)
+{
+	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
+	struct ieee80211_tx_control control = {
+		.sta = txq->sta,
+	};
+	struct ath12k *ar = ah->radio;
+	struct dp_tx_ring *tx_ring;
+	struct hal_srng *tcl_ring;
+	struct ath12k_dp *dp;
+	struct sk_buff *skb;
+	int num_free;
+
+	if (!ar)
+		return;
+
+	if (unlikely(test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags)))
+		return;
+
+	dp = ar->ab->dp;
+	tx_ring = &dp->tx_ring[txq->ac % dp->hw_params->max_tx_ring];
+	tcl_ring = &dp->hal->srng_list[tx_ring->tcl_data_ring.ring_id];
+
+	while (1) {
+		spin_lock_bh(&tx_ring->wake_tx_lock);
+
+		spin_lock(&tcl_ring->lock);
+		num_free = ath12k_hal_srng_src_num_free(ar->ab, tcl_ring, true);
+		spin_unlock(&tcl_ring->lock);
+
+		if (num_free == 0) {
+			spin_unlock_bh(&tx_ring->wake_tx_lock);
+			break;
+		}
+
+		skb = ieee80211_tx_dequeue(hw, txq);
+		if (!skb) {
+			spin_unlock_bh(&tx_ring->wake_tx_lock);
+			break;
+		}
+
+		ath12k_wifi7_mac_op_tx(hw, &control, skb);
+
+		spin_unlock_bh(&tx_ring->wake_tx_lock);
+	}
+}
+
 static const struct ieee80211_ops ath12k_ops_wifi7 = {
 	.tx				= ath12k_wifi7_mac_op_tx,
-	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
+	.wake_tx_queue			= ath12k_wifi7_mac_op_wake_tx_queue,
 	.start                          = ath12k_mac_op_start,
 	.stop                           = ath12k_mac_op_stop,
 	.reconfig_complete              = ath12k_mac_op_reconfig_complete,
-- 
2.54.0


