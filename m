Return-Path: <linux-wireless+bounces-39144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +b+HBXmEV2rtVgAAu9opvQ
	(envelope-from <linux-wireless+bounces-39144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:00:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99575E68A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 15:00:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XoIAjioq;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39144-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39144-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C8263034503
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 12:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1414921BA;
	Wed, 15 Jul 2026 12:50:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4248B365
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jul 2026 12:50:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119852; cv=none; b=m1RHY4K5QVAU5/wT6aZgOtiv2Z+selxFizz6HZZGQKHtVRWVGnL40V6Q0D9sGMc+N2K10xRIdNxgxzmFR91b4oWJQHh+r/rj3nFdpWTN8iynBrP7bR3CycrV8Wxskp7ienUdzlg+bwiNtGM3LFzgwf7ppZADAZMAzZPgKO4PTPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119852; c=relaxed/simple;
	bh=andR7bQAoASJ8S6q3NTPat+pocjAmDIHyod6JeH/zuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFQeU3szi6y8C3K4Tzd21B9J1gVZRckoIPlwKj5dEPs2HlAX+b0lGOX/QzhWxyGzLybYxXxYjG7m+UgEoYntJIfZ5PA5HsDW1ArlccIYyfO2cpueqF/SGP5FCKxJewyPwi0twYyPNMLrqiXivTf1wLGATsHD+6WGaPhZorrd/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoIAjioq; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784119847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRIQneSsCXgEblyRWAj+jDpk9+Lz0CbWcYqWL2Sv4/M=;
	b=XoIAjioq8e5zWvC2SHr6+vtUswEKyZztHXSYbD4GsF4y/LHumuswvfkaBFk9QMT3gwb1/9
	enqjoZvPlIxVDq8qyYyURiEeutIWxvcmk287m9LjJuWbPASNx9ANYcYGOjqt1pSzDommmy
	zgjwC+ts6fUvhdw0pbxJmhdilGPfY+s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-jozWR3ePMgq1bqa5qCLMIw-1; Wed,
 15 Jul 2026 08:50:43 -0400
X-MC-Unique: jozWR3ePMgq1bqa5qCLMIw-1
X-Mimecast-MFC-AGG-ID: jozWR3ePMgq1bqa5qCLMIw_1784119842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDAFC18001FB;
	Wed, 15 Jul 2026 12:50:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6746518004D4;
	Wed, 15 Jul 2026 12:50:39 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jjohnson@kernel.org
Cc: ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH v2 2/3] wifi: ath11k: implement custom wake_tx_queue with flow control
Date: Wed, 15 Jul 2026 14:50:15 +0200
Message-ID: <20260715125017.277242-3-jtornosm@redhat.com>
In-Reply-To: <20260715125017.277242-1-jtornosm@redhat.com>
References: <20260715125017.277242-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	TAGGED_FROM(0.00)[bounces-39144-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C99575E68A
X-Rspamd-Action: no action

Under heavy traffic, ath11k experiences frequent -ENOMEM errors
("failed to transmit frame -12") when the hardware TCL ring fills up.
This issue is more commonly observed in VMs with PCIe passthrough but
also occurs on bare metal systems. It is particularly problematic on
devices with a single shared TCL ring where all traffic classes
compete for the same 512 descriptor slots.

Implement a custom wake_tx_queue operation that:

1. Checks hardware ring space before dequeuing packets from mac80211
2. Uses per-ring locking to serialize ring access and prevent races
3. Syncs with hardware state to get accurate free slot count
4. Uses ieee80211_tx_peek() to determine the exact target ring via
   get_ring_selector(), matching dp_tx on all platforms
5. Returns early during firmware crash in the same way as other
   tx paths

This approach follows the pattern used in the iwlwifi driver, adapted
for ath11k's hardware ring architecture.

This eliminates -ENOMEM errors and improves throughput by optimizing
resource usage and preventing unnecessary packet drops.

Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
v2: Address feedback from Zhi-Jun You:
    - Add ieee80211_tx_peek() API in mac80211 to peek at the next frame
      without dequeuing, enabling accurate ring selection before dequeue
    - Use get_ring_selector() on the peeked skb to determine the exact
      target ring matching dp_tx, fixing ring mismatch on multi-ring
      platforms (ipq8074, wcn6750, qcn9274, wcn7850)
    Move CRASH_FLUSH check inside the TX loop
v1: https://lore.kernel.org/all/20260710155443.1761760-2-jtornosm@redhat.com/

 drivers/net/wireless/ath/ath11k/dp.c  |  1 +
 drivers/net/wireless/ath/ath11k/dp.h  |  2 +
 drivers/net/wireless/ath/ath11k/mac.c | 60 ++++++++++++++++++++++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index f389b97acbdd..2e5978ec2b05 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -1087,6 +1087,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
 	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
 		idr_init(&dp->tx_ring[i].txbuf_idr);
 		spin_lock_init(&dp->tx_ring[i].tx_idr_lock);
+		spin_lock_init(&dp->tx_ring[i].wake_tx_lock);
 		dp->tx_ring[i].tcl_data_ring_id = i;
 
 		dp->tx_ring[i].tx_status_head = 0;
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 84f66839f0c6..6d99501aa269 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -87,6 +87,8 @@ struct dp_tx_ring {
 	struct idr txbuf_idr;
 	/* Protects txbuf_idr and num_pending */
 	spinlock_t tx_idr_lock;
+	/* Serializes wake_tx_queue operations for this ring */
+	spinlock_t wake_tx_lock;
 	struct hal_wbm_release_ring *tx_status;
 	int tx_status_head;
 	int tx_status_tail;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2d55cdc4d165..046cefd53178 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -10065,9 +10065,67 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static void ath11k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
+					struct ieee80211_txq *txq)
+{
+	struct ieee80211_tx_control control = {
+		.sta = txq->sta,
+	};
+	const struct sk_buff *peek_skb;
+	struct ath11k *ar = hw->priv;
+	struct dp_tx_ring *tx_ring;
+	struct hal_srng *tcl_ring;
+	struct sk_buff *skb;
+	u32 ring_selector;
+	int num_free;
+	u8 ring_id;
+
+	if (!ar)
+		return;
+
+	while (1) {
+		if (unlikely(test_bit(ATH11K_FLAG_CRASH_FLUSH,
+				      &ar->ab->dev_flags)))
+			break;
+
+		peek_skb = ieee80211_tx_peek(hw, txq);
+		if (!peek_skb)
+			break;
+
+		ring_selector = ar->ab->hw_params.hw_ops->get_ring_selector(
+					(struct sk_buff *)peek_skb);
+		ring_id = ring_selector %
+			  ar->ab->hw_params.hal_params->num_tx_rings;
+
+		tx_ring = &ar->ab->dp.tx_ring[ring_id];
+		tcl_ring = &ar->ab->hal.srng_list[tx_ring->tcl_data_ring.ring_id];
+
+		spin_lock_bh(&tx_ring->wake_tx_lock);
+
+		spin_lock(&tcl_ring->lock);
+		num_free = ath11k_hal_srng_src_num_free(ar->ab, tcl_ring, true);
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
+		ath11k_mac_op_tx(hw, &control, skb);
+
+		spin_unlock_bh(&tx_ring->wake_tx_lock);
+	}
+}
+
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
-	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
+	.wake_tx_queue			= ath11k_mac_op_wake_tx_queue,
 	.start                          = ath11k_mac_op_start,
 	.stop                           = ath11k_mac_op_stop,
 	.reconfig_complete              = ath11k_mac_op_reconfig_complete,
-- 
2.54.0


