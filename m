Return-Path: <linux-wireless+bounces-36891-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE3bG7DdFGrlQwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36891-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 01:39:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6C5CF2FF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 01:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D42073016EC1
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5C935F197;
	Mon, 25 May 2026 23:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLyArAqn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732F835F185
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779752365; cv=none; b=VpH9anRyBMJRtt1e9o00ulVuw/QX6AtCw0tVUSiZVnl7hPwAXI0wxOOuE1J/Ug6NrEq3CwNC1wjmraf6kK4mJrJvFJyikx1YRe12dnqQyOWDWxU5LUeJcQc7oy+hPljjPBH6b5ph48Or4oS5oHkqfbN+WSXnsBO6t1EC8ZztU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779752365; c=relaxed/simple;
	bh=TwaR9rNjfO1YXq/OpxXJ62k/m8ozs8VgZpfuDG1nAKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F1XBnXZc7RCslO+iNE6hBsNCtxFpGci2CQUvaYVdY625xTQKJcRDSB+1mUQDpp4REIDssRtcb+EmcWfleAlVIFAJggsxeEtmqDXCUbKD+DevOSdTCDSsqzg8eCoMQXXxBGuJeQTWcDsOHPzolIntv4jFXhV6hPd37MoGRGtPR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLyArAqn; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f33ae12f97so238223eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 16:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779752363; x=1780357163; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgCJAEw2PrZATRMnXWI0xF7ma4Zgqhob/5XHNTbJWRk=;
        b=XLyArAqnhI19le9pkZ1a3yVGgcfeo+YUNteCHxfnLEZltnJBLBm/6EJPNHMKCwBR1O
         HU9rHFjhXseHZEV2yi7kkSR6/fvscoFrUEkecjyr0pzzE9dsd3Zey4zMdgO0I7vq6CcZ
         TXduBHBpbMboYZM4G2nS+NaZUe7ifqAbl9cIqKoAKot0oOr6TCJjQIh+lSU7s4hHZIGM
         eBayGhJvWyKEA3n+EkoTWK+LApCUdF+WPOotL2EUqpCAqf254fF6yzC4qWSWLA8hrMc2
         7MIKHjGz9HWMni/7t1eISoQW0Go0zCHiKmdG7kXFIQdVm1GF1q21dJETF1N3Yin06eJj
         pRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779752363; x=1780357163;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgCJAEw2PrZATRMnXWI0xF7ma4Zgqhob/5XHNTbJWRk=;
        b=OOFIj2+zM8Zk4Ub/x0AfWvFMA4Z1xORbwwYQ5joVwSfILgj0KzbM6uKXduHeT0+UFd
         Vp8hzRANbDLLacTEEOpYVj+DRJAAo6H1l7+FFe2cUySw9MAQ/vCj4I/4msr9rX4c6uh4
         OK7Fn7+8ddjvEzcwql0Spel83vblpLkWGPMXWYjBGsHKwfw0sOzY/xNYLTwBtM2o06jM
         LQHTssWgvLdk3h98yBQFUVelrXl/9ufSk+s5eFrR/7f0CVKGsgjSUndAye4a8sTlK4h3
         Q4mId0ab7oP9Noq6RBOYTlnV/oMOOP+MZr9aFmsVFGi20kh+QgilQeEh2CFzQAvWK/C0
         Y3gA==
X-Gm-Message-State: AOJu0Yy2rnwe+r9RuK7iuUWqJaDr2EOtGijwSEU4nNS4fJlgH1OGQOXp
	BVXicSFdztiWEKk0jjOS27U35XXqlV38+5JHXFcRDKbH9IfyFYN+230idwnhxwxGUkhwUg==
X-Gm-Gg: Acq92OGd9ie8I1vGixQuZW0LZEXj3KATcwklRHeKl4cPehIPaGACKZpowLjOTBQz+VR
	fEsTk5r88UsIlRl5YDfA8L4e7HW92uvQj+RWBP4VPz9Kg6g59iLmvdaSNGen35+jQ7FJDKg2n5z
	gCB1LRg53pcknT0XqT1EhOy+qAb1Azi3nsoqgyT+yCfmYM4EZiwJenjcVbUS+S7QF8KGLDCFBzv
	XRlBhu3w1fnsiyKI6IChXowG4fgXMNeMBQhxqPyo/N9l3T9Hu5uzYL5xL1S6KQrK8ignfDfyjvA
	IQ2iLvxY2LdsfEZk23JfvEeWlfD46BS68zKkHaLS1dFgluC9u1ZxZLK732/LE8lv6IhvQcd+UMT
	v6XbKpqYAh5qklToOunzwU2+jOuCTFjY3BmoxYBeKlvHzVbXybslVxyDyJTCWw6Wte2qU9dJKEI
	P8gwPCL57EXygjMryNef42dR5wD8ANqLHV
X-Received: by 2002:a05:693c:2b10:b0:2e7:c701:aa85 with SMTP id 5a478bee46e88-304491415edmr8291255eec.17.1779752362366;
        Mon, 25 May 2026 16:39:22 -0700 (PDT)
Received: from wico-dev.wnam.ru ([23.95.253.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm11858903eec.13.2026.05.25.16.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 16:39:21 -0700 (PDT)
Date: Tue, 26 May 2026 02:39:16 +0300
From: Ruslan Isaev <legale.legale@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: sean.wang@mediatek.com, nbd@nbd.name, lorenzo@kernel.org,
	ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: track rx napi ownership for cleanup
Message-ID: <ahTdpNQp2va_xTVR@wico-dev.wnam.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36891-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legalelegale@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wico-dev.wnam.ru:mid]
X-Rspamd-Queue-Id: BEA6C5CF2FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


mt76_dma_cleanup() deletes rx napi instances for every allocated rx
queue. This is not symmetric with mt76_dma_init(), which skips WED_RRO
queues when adding rx napi.

Adding an unconditional napi_disable() in the cleanup path fixes the
mt7915 remove warning, but it is not safe for all other mt76 paths. mt7921 and
mt7925 can already disable rx napi in their unregister
paths before calling mt76_dma_cleanup(). On mt7996/mt7992 WED_RRO
queues may have ndesc set even though mt76 never added or enabled napi for them.

Track rx napi ownership and enabled state in struct mt76_queue so
cleanup only disables and deletes napi instances that were actually
added by mt76.

This keeps the existing reset/suspend/remove ordering intact while
avoiding double napi_disable() and avoiding napi cleanup on WED_RRO
queues without napi.

Signed-off-by: Ruslan Isaev <legale.legale@gmail.com>
---
v2:
- track mt76 rx napi state added/enabled
- avoid double napi_disable() on mt7921/mt7925 cleanup paths
- avoid napi cleanup on WED_RRO queues without napi

 drivers/net/wireless/mediatek/mt76/dma.c      |  9 +++--
 drivers/net/wireless/mediatek/mt76/mt76.h     | 40 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  8 ++--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  6 +--
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  4 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  8 ++--
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  8 ++--
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  8 ++--
 .../wireless/mediatek/mt76/mt7925/pci_mac.c   |  8 ++--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  8 ++--
 drivers/net/wireless/mediatek/mt76/npu.c      |  3 +-
 15 files changed, 86 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f8c2fe5f2f58..5c531131a25f 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -1099,9 +1099,12 @@ static void
 mt76_dma_rx_queue_init(struct mt76_dev *dev, enum mt76_rxq_id qid,
 		       int (*poll)(struct napi_struct *napi, int budget))
 {
+	struct mt76_queue *q = &dev->q_rx[qid];
+
 	netif_napi_add(dev->napi_dev, &dev->napi[qid], poll);
-	mt76_dma_rx_fill_buf(dev, &dev->q_rx[qid], false);
-	napi_enable(&dev->napi[qid]);
+	q->napi_state = MT76_NAPI_ADDED;
+	mt76_dma_rx_fill_buf(dev, q, false);
+	mt76_rx_napi_enable(dev, qid);
 }
 
 static int
@@ -1189,7 +1192,7 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
 
-		netif_napi_del(&dev->napi[i]);
+		mt76_rx_napi_del(dev, i);
 		mt76_dma_rx_cleanup(dev, q);
 
 		page_pool_destroy(q->page_pool);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 527bef97e122..3ce936bdcf88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -251,6 +251,7 @@ struct mt76_queue {
 	int buf_size;
 	bool stopped;
 	bool blocked;
+	u8 napi_state;
 
 	u8 buf_offset;
 	u16 flags;
@@ -1283,6 +1284,45 @@ static inline int mt76_wed_dma_setup(struct mt76_dev *dev, struct mt76_queue *q,
 	for (i = 0; i < ARRAY_SIZE((dev)->q_rx); i++)	\
 		if ((dev)->q_rx[i].ndesc)
 
+#define MT76_NAPI_ADDED		BIT(0)
+#define MT76_NAPI_ENABLED	BIT(1)
+
+static inline void mt76_rx_napi_enable(struct mt76_dev *dev, int qid)
+{
+	struct mt76_queue *q = &dev->q_rx[qid];
+
+	if (!(q->napi_state & MT76_NAPI_ADDED) ||
+	    (q->napi_state & MT76_NAPI_ENABLED))
+		return;
+
+	napi_enable(&dev->napi[qid]);
+	q->napi_state |= MT76_NAPI_ENABLED;
+}
+
+static inline void mt76_rx_napi_disable(struct mt76_dev *dev, int qid)
+{
+	struct mt76_queue *q = &dev->q_rx[qid];
+
+	if (!(q->napi_state & MT76_NAPI_ADDED) ||
+	    !(q->napi_state & MT76_NAPI_ENABLED))
+		return;
+
+	napi_disable(&dev->napi[qid]);
+	q->napi_state &= ~MT76_NAPI_ENABLED;
+}
+
+static inline void mt76_rx_napi_del(struct mt76_dev *dev, int qid)
+{
+	struct mt76_queue *q = &dev->q_rx[qid];
+
+	if (!(q->napi_state & MT76_NAPI_ADDED))
+		return;
+
+	mt76_rx_napi_disable(dev, qid);
+	netif_napi_del(&dev->napi[qid]);
+	q->napi_state = 0;
+}
+
 
 #define mt76_dereference(p, dev) \
 	rcu_dereference_protected(p, lockdep_is_held(&(dev)->mutex))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index d3110eeb45d7..be35ec0d31d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1423,8 +1423,8 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
-	napi_disable(&dev->mt76.napi[0]);
-	napi_disable(&dev->mt76.napi[1]);
+	mt76_rx_napi_disable(&dev->mt76, 0);
+	mt76_rx_napi_disable(&dev->mt76, 1);
 	napi_disable(&dev->mt76.tx_napi);
 
 	mutex_lock(&dev->mt76.mutex);
@@ -1474,8 +1474,8 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	mt7603_beacon_set_timer(dev, -1, beacon_int);
 
 	napi_enable(&dev->mt76.tx_napi);
-	napi_enable(&dev->mt76.napi[0]);
-	napi_enable(&dev->mt76.napi[1]);
+	mt76_rx_napi_enable(&dev->mt76, 0);
+	mt76_rx_napi_enable(&dev->mt76, 1);
 
 	local_bh_disable();
 	napi_schedule(&dev->mt76.tx_napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index f5018bfa317a..600b4f2bf1a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -92,7 +92,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	mt76_worker_disable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
-		napi_disable(&mdev->napi[i]);
+		mt76_rx_napi_disable(mdev, i);
 	}
 	tasklet_kill(&mdev->irq_tasklet);
 
@@ -127,7 +127,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 
 restore:
 	mt76_for_each_q_rx(mdev, i) {
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 	if (hif_suspend)
@@ -166,7 +166,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 	mt76_worker_enable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 53cb1eed1e4f..a83589c628f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -236,7 +236,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(&dev->mt76, i)
-		napi_disable(&dev->mt76.napi[i]);
+		mt76_rx_napi_disable(&dev->mt76, i);
 	napi_disable(&dev->mt76.tx_napi);
 
 	mt7615_mutex_acquire(dev);
@@ -264,7 +264,7 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	napi_enable(&dev->mt76.tx_napi);
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		napi_enable(&dev->mt76.napi[i]);
+		mt76_rx_napi_enable(&dev->mt76, i);
 	}
 
 	local_bh_disable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index f8d206a07f99..96380d016351 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -257,7 +257,7 @@ static int mt76x0e_suspend(struct pci_dev *pdev, pm_message_t state)
 	napi_disable(&mdev->tx_napi);
 
 	mt76_for_each_q_rx(mdev, i)
-		napi_disable(&mdev->napi[i]);
+		mt76_rx_napi_disable(mdev, i);
 
 	mt76x02_dma_disable(dev);
 	mt76x02_mcu_cleanup(dev);
@@ -285,7 +285,7 @@ static int mt76x0e_resume(struct pci_dev *pdev)
 
 	mt76_for_each_q_rx(mdev, i) {
 		mt76_queue_rx_reset(dev, i);
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index dc7c03d23123..0da4bbad5ba3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -444,7 +444,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	napi_disable(&dev->mt76.tx_napi);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		napi_disable(&dev->mt76.napi[i]);
+		mt76_rx_napi_disable(&dev->mt76, i);
 	}
 
 	mutex_lock(&dev->mt76.mutex);
@@ -505,7 +505,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	napi_enable(&dev->mt76.tx_napi);
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		napi_enable(&dev->mt76.napi[i]);
+		mt76_rx_napi_enable(&dev->mt76, i);
 	}
 
 	local_bh_disable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 491a32921a06..a23c2560e90f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -119,7 +119,7 @@ mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
 	mt76_worker_disable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i)
-		napi_disable(&mdev->napi[i]);
+		mt76_rx_napi_disable(mdev, i);
 
 	pci_enable_wake(pdev, pci_choose_state(pdev, state), true);
 	pci_save_state(pdev);
@@ -131,7 +131,7 @@ mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
 
 restore:
 	mt76_for_each_q_rx(mdev, i)
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	napi_enable(&mdev->tx_napi);
 
 	return err;
@@ -153,7 +153,7 @@ mt76x2e_resume(struct pci_dev *pdev)
 	mt76_worker_enable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cec2c4208255..354ed0b69013 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1327,7 +1327,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(mdev, i) {
 		if (mdev->q_rx[i].ndesc)
-			napi_disable(&dev->mt76.napi[i]);
+			mt76_rx_napi_disable(&dev->mt76, i);
 	}
 	napi_disable(&dev->mt76.tx_napi);
 
@@ -1339,7 +1339,7 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 
 	mt76_for_each_q_rx(mdev, i) {
 		if (mdev->q_rx[i].ndesc) {
-			napi_enable(&dev->mt76.napi[i]);
+			mt76_rx_napi_enable(&dev->mt76, i);
 		}
 	}
 
@@ -1527,7 +1527,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(&dev->mt76, i)
-		napi_disable(&dev->mt76.napi[i]);
+		mt76_rx_napi_disable(&dev->mt76, i);
 	napi_disable(&dev->mt76.tx_napi);
 
 
@@ -1558,7 +1558,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 		clear_bit(MT76_RESET, &phy2->mt76->state);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		napi_enable(&dev->mt76.napi[i]);
+		mt76_rx_napi_enable(&dev->mt76, i);
 	}
 
 	local_bh_disable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 7a790ddf43bb..c3188b344e50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -52,7 +52,7 @@ static void mt7921e_unregister_device(struct mt792x_dev *dev)
 	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
 	mt76_for_each_q_rx(&dev->mt76, i)
-		napi_disable(&dev->mt76.napi[i]);
+		mt76_rx_napi_disable(&dev->mt76, i);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 	cancel_work_sync(&dev->reset_work);
@@ -492,7 +492,7 @@ static int mt7921_pci_suspend(struct device *device)
 	mt76_worker_disable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
-		napi_disable(&mdev->napi[i]);
+		mt76_rx_napi_disable(mdev, i);
 	}
 
 	/* wait until dma is idle  */
@@ -518,7 +518,7 @@ static int mt7921_pci_suspend(struct device *device)
 
 restore_napi:
 	mt76_for_each_q_rx(mdev, i) {
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 
@@ -564,7 +564,7 @@ static int mt7921_pci_resume(struct device *device)
 	mt76_worker_enable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 0db7acb3a637..5d7871b8f77c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -72,7 +72,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		napi_disable(&dev->mt76.napi[i]);
+		mt76_rx_napi_disable(&dev->mt76, i);
 	}
 	napi_disable(&dev->mt76.tx_napi);
 
@@ -82,7 +82,7 @@ int mt7921e_mac_reset(struct mt792x_dev *dev)
 	mt792x_wpdma_reset(dev, true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		napi_enable(&dev->mt76.napi[i]);
+		mt76_rx_napi_enable(&dev->mt76, i);
 	}
 
 	local_bh_disable();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..1da650ac7f4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -40,7 +40,7 @@ static void mt7925e_unregister_device(struct mt792x_dev *dev)
 	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
 	mt76_for_each_q_rx(&dev->mt76, i)
-		napi_disable(&dev->mt76.napi[i]);
+		mt76_rx_napi_disable(&dev->mt76, i);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
 	cancel_work_sync(&dev->reset_work);
@@ -481,7 +481,7 @@ static int mt7925_pci_suspend(struct device *device)
 	mt76_worker_disable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
-		napi_disable(&mdev->napi[i]);
+		mt76_rx_napi_disable(mdev, i);
 	}
 
 	/* wait until dma is idle  */
@@ -509,7 +509,7 @@ static int mt7925_pci_suspend(struct device *device)
 
 restore_napi:
 	mt76_for_each_q_rx(mdev, i) {
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 
@@ -559,7 +559,7 @@ static int _mt7925_pci_resume(struct device *device, bool restore)
 	mt76_worker_enable(&mdev->tx_worker);
 
 	mt76_for_each_q_rx(mdev, i) {
-		napi_enable(&mdev->napi[i]);
+		mt76_rx_napi_enable(mdev, i);
 	}
 	napi_enable(&mdev->tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
index 3072850c2752..6bb47db8d16a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c
@@ -88,11 +88,11 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 
 	mt76_worker_disable(&dev->mt76.tx_worker);
 	if (irq_map->rx.data_complete_mask)
-		napi_disable(&dev->mt76.napi[MT_RXQ_MAIN]);
+		mt76_rx_napi_disable(&dev->mt76, MT_RXQ_MAIN);
 	if (irq_map->rx.wm_complete_mask)
-		napi_disable(&dev->mt76.napi[MT_RXQ_MCU]);
+		mt76_rx_napi_disable(&dev->mt76, MT_RXQ_MCU);
 	if (irq_map->rx.wm2_complete_mask)
-		napi_disable(&dev->mt76.napi[MT_RXQ_MCU_WA]);
+		mt76_rx_napi_disable(&dev->mt76, MT_RXQ_MCU_WA);
 	if (irq_map->tx.all_complete_mask)
 		napi_disable(&dev->mt76.tx_napi);
 
@@ -102,7 +102,7 @@ int mt7925e_mac_reset(struct mt792x_dev *dev)
 	mt792x_wpdma_reset(dev, true);
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		napi_enable(&dev->mt76.napi[i]);
+		mt76_rx_napi_enable(&dev->mt76, i);
 	}
 	napi_enable(&dev->mt76.tx_napi);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e2a83da3a09c..a75238ce8807 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2262,7 +2262,7 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 			continue;
 
 		if (mdev->q_rx[i].ndesc)
-			napi_disable(&dev->mt76.napi[i]);
+			mt76_rx_napi_disable(&dev->mt76, i);
 	}
 	napi_disable(&dev->mt76.tx_napi);
 
@@ -2278,7 +2278,7 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 			continue;
 
 		if (mdev->q_rx[i].ndesc) {
-			napi_enable(&dev->mt76.napi[i]);
+			mt76_rx_napi_enable(&dev->mt76, i);
 			local_bh_disable();
 			napi_schedule(&dev->mt76.napi[i]);
 			local_bh_enable();
@@ -2534,7 +2534,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		if (mt76_queue_is_npu_txfree(&dev->mt76.q_rx[i]))
 			continue;
 
-		napi_disable(&dev->mt76.napi[i]);
+		mt76_rx_napi_disable(&dev->mt76, i);
 	}
 	napi_disable(&dev->mt76.tx_napi);
 
@@ -2596,7 +2596,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		if (mt76_queue_is_npu_txfree(&dev->mt76.q_rx[i]))
 			continue;
 
-		napi_enable(&dev->mt76.napi[i]);
+		mt76_rx_napi_enable(&dev->mt76, i);
 		local_bh_disable();
 		napi_schedule(&dev->mt76.napi[i]);
 		local_bh_enable();
diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireless/mediatek/mt76/npu.c
index c4c7c0af6321..fb4ba5bdbf48 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -291,8 +291,9 @@ int mt76_npu_rx_queue_init(struct mt76_dev *dev, struct mt76_queue *q)
 		goto out;
 
 	netif_napi_add(dev->napi_dev, &dev->napi[qid], mt76_npu_rx_poll);
+	q->napi_state = MT76_NAPI_ADDED;
 	mt76_npu_fill_rx_queue(dev, q);
-	napi_enable(&dev->napi[qid]);
+	mt76_rx_napi_enable(dev, qid);
 out:
 	mutex_unlock(&dev->mutex);
 
-- 
2.39.5


