Return-Path: <linux-wireless+bounces-663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D990C80CE93
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BF6B20E2A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 14:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE6248CD6;
	Mon, 11 Dec 2023 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY3ZyKE0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C1B208DF
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 14:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25BDC433C7;
	Mon, 11 Dec 2023 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702305813;
	bh=GzbXCOCc2WwY557q2yBZz3bnpGAny1KtvGpTavHoBVY=;
	h=From:To:Cc:Subject:Date:From;
	b=GY3ZyKE0/JaWbfgKmJlq29CM3KPljt/9gPRYZLsF5WgLM2swZNc0wgGVw7F2wZfV0
	 SDSNPV1y5dR9rO5GLYzuGpUTgieSSLPXILgDYc5GQWrkEK6h85umM3VKkXHtqUPbdu
	 OvX1DVZ2hD/pdqkzHJkwQBMEipBhzgkk6vlnGIkS100o/ky1xTmFhpp6PmKYVpbizx
	 x05CgQdil+2TCBX5n8uumLLcx0jhwWS10ZjfTO1AWzZKBtkPpm/IGpj22B5F3tEJoU
	 vRCWduMyxBWVCh6fes7VX7uMtim9oj2SrCfesLUsvUDr4MbtgHS8oXrVKuLl04uMCh
	 zcM+8qSdTeEow==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: nbd@nbd.name
Cc: lorenzo.bianconi@redhat.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: set page_pool napi pointer for mmio devices
Date: Mon, 11 Dec 2023 15:43:27 +0100
Message-ID: <7de511de4e16b9c279acd168b3b6cb2d342736d8.1702305781.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt76.h     | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5cc608d20619..ec89982b4fda 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -579,13 +579,13 @@ EXPORT_SYMBOL_GPL(mt76_unregister_phy);
 
 int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 {
+	int idx = mt76_get_rx_queue_index(dev, q);
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = 0,
 		.nid = NUMA_NO_NODE,
 		.dev = dev->dma_dev,
 	};
-	int idx = q - dev->q_rx;
 
 	switch (idx) {
 	case MT_RXQ_MAIN:
@@ -604,6 +604,8 @@ int mt76_create_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
 		pp_params.dma_dir = DMA_FROM_DEVICE;
 		pp_params.max_len = PAGE_SIZE;
 		pp_params.offset = 0;
+		if (idx >= 0 && idx < ARRAY_SIZE(dev->napi))
+			pp_params.napi = &dev->napi[idx];
 	}
 
 	q->page_pool = page_pool_create(&pp_params);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index c7286dbeeaae..99712ce33e9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1613,6 +1613,19 @@ s8 mt76_get_rate_power_limits(struct mt76_phy *phy,
 			      struct mt76_power_limits *dest,
 			      s8 target_power);
 
+static inline int mt76_get_rx_queue_index(struct mt76_dev *dev,
+					  struct mt76_queue *q)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++) {
+		if (q == &dev->q_rx[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static inline bool mt76_queue_is_wed_tx_free(struct mt76_queue *q)
 {
 	return (q->flags & MT_QFLAG_WED) &&
-- 
2.43.0


