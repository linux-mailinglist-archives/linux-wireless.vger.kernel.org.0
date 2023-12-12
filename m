Return-Path: <linux-wireless+bounces-689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422FF80E722
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 10:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2E11F21873
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B615812A;
	Tue, 12 Dec 2023 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTzWB8E3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE15811B
	for <linux-wireless@vger.kernel.org>; Tue, 12 Dec 2023 09:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE2C433C7;
	Tue, 12 Dec 2023 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702372527;
	bh=FR6eSFR1DdCBefwAt+83BDLOHz5IyrhGNmJV1nYYKmw=;
	h=From:To:Cc:Subject:Date:From;
	b=NTzWB8E310b4xVRFr26JzLuPUehbe2Hi0iQ0WxAO7iQcr5mmefg7AGQ24lCCqDQmL
	 XvLV88D9UBwOCMxTGpG/M8Yh83OMlCK9Ts4ZSkdGt4aefsUwCClKD/8ms8fVuNJ4Kp
	 nMl4LrzxWZMrle94r0KxpBnZF3LTBGCfloRxYYfWliMXUuZ6r/bzmwHFnXoIpEoXJ1
	 6XB8GRqB1dXZzy10zUlXGWDvZihDTgX+VuXvetcIHT1BZNwV7zlSmkylLrvqjxShm5
	 sTr7OUPxNATsSQn9gOKdy3WE1jyJFwdpl3X/XSksFaNE5hCAJPE3Z9KA3cXBid0dr6
	 T/F2Cq6O7wrLQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: mt76: set page_pool napi pointer for mmio devices
Date: Tue, 12 Dec 2023 10:15:19 +0100
Message-ID: <fd60f357f603d2ac4a41e8820b9b4c01e156a3c7.1702372069.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to recycle skbs in the page_pool "hot" cache in
napi_pp_put_page routine, set napi pointer for MMIO devices in
mt76_create_page_pool().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- do not allocate page_pools for tx queues
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 10 +++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5cc608d20619..516980cf4caf 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -579,13 +579,18 @@ EXPORT_SYMBOL_GPL(mt76_unregister_phy);
 
 int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 {
+	bool is_qrx = mt76_queue_is_rx(dev, q);
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = 0,
 		.nid = NUMA_NO_NODE,
 		.dev = dev->dma_dev,
 	};
-	int idx = q - dev->q_rx;
+	int idx = is_qrx ? q - dev->q_rx : -1;
+
+	/* Allocate page_pools just for rx/wed_tx_free queues */
+	if (!is_qrx && !mt76_queue_is_wed_tx_free(q))
+		return 0;
 
 	switch (idx) {
 	case MT_RXQ_MAIN:
@@ -604,6 +609,9 @@ int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 		pp_params.dma_dir = DMA_FROM_DEVICE;
 		pp_params.max_len = PAGE_SIZE;
 		pp_params.offset = 0;
+		/* NAPI is available just for rx queues */
+		if (idx >= 0 && idx < ARRAY_SIZE(dev->napi))
+			pp_params.napi = &dev->napi[idx];
 	}
 
 	q->page_pool = page_pool_create(&pp_params);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c7286dbeeaae..0da88f153427 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1613,6 +1613,18 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			      struct mt76_power_limits *dest,
 			      s8 target_power);
 
+static inline bool mt76_queue_is_rx(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
+		if (q == &dev->q_rx[i])
+			return true;
+	}
+
+	return false;
+}
+
 static inline bool mt76_queue_is_wed_tx_free(struct mt76_queue *q)
 {
 	return (q->flags & MT_QFLAG_WED) &&
-- 
2.43.0


