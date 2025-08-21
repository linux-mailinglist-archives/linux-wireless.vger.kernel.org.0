Return-Path: <linux-wireless+bounces-26521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD74B2FA2A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5626A2694D
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 13:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B3F334377;
	Thu, 21 Aug 2025 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4elKpBC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294033436F
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782227; cv=none; b=T9LobVXO70cwDVP1xxSoKaYnKkOmt+yvIvLZ97aPRSMEPh4L84q276TOrME8+npvXyF/MWamE9yKi8+Qd8zlhA1GDyJBScyKZDHPxtvHqxJ1CjyznoOYVmzDAmqQ3463jtlBr0FCcqRMMdEhOJT104gaBpfnOH6MkNx9hTjPS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782227; c=relaxed/simple;
	bh=66lSDFjwC4EgcHV9iXeIB9o8i0uuXs7Uf1Q6DHvEHMc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXsl7fK5y6R3e9rOvy5G8mP70oonr3OmnJQuNXCJHUG8bv8ugICDYGl/6yaNS0+7L97BpzYoG6WZE1HYGvKNhRlRheAVHDC4d8oHqkfOXtv9F+EW40Au8/mNivCGXYqOyGlrN48LkA7k+C+4+YAuGzqdcM7YX77R6qMrf0Nc6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4elKpBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D51C113CF;
	Thu, 21 Aug 2025 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755782226;
	bh=66lSDFjwC4EgcHV9iXeIB9o8i0uuXs7Uf1Q6DHvEHMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A4elKpBCiQ73skpvRkYpH15svyXnBKaZeG/CKdy0HdPbVF5DFkGSGiolM7qjw4OCb
	 HrQrmrMkac581vl22NYBBdvXq6OHEESqC2EvKalcEKiGeGpGZ5uvfjCoxwq7QmWJFH
	 7w8ICo+aeMIDZWM1ybXve0kTYABx20iPdulGZ/GCokJSvnZRjtWfKRa31k72LsxPHR
	 ObFz4o+HQJ66xvuV5DcLDDj2lLf1bDWLjyHU1sN3vCbxh3q5EcKUppFKV5ge+NCU8J
	 Hu3fi8RprqY5i+PXwCcya81jEJmfdGczbZvMmQQfXaP8vm+4kQaf2K6ENm0Yz4hpiL
	 6t7ML88JsJMjA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 21 Aug 2025 15:15:02 +0200
Subject: [PATCH mt76 10/14] wifi: mt76: mt7996: Introduce RRO MSDU
 callbacks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-mt7996-rro-rework-v1-10-6c8477ad969f@kernel.org>
References: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
In-Reply-To: <20250821-mt7996-rro-rework-v1-0-6c8477ad969f@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Rex Lu <rex.lu@mediatek.com>
X-Mailer: b4 0.14.2

From: Rex Lu <rex.lu@mediatek.com>

Introduce rx_rro_ind_process and rx_rro_add_msdu_page callbacks and the
related logic in the MT7996 driver. This is a preliminary patch to
decouple RRO logic from WED support and reuse RRO when WED module is not
available.

Signed-off-by: Rex Lu <rex.lu@mediatek.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c           |   2 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   6 +
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c    |   3 +
 drivers/net/wireless/mediatek/mt76/mt7996/init.c   |   6 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 332 +++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  51 ++++
 7 files changed, 402 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f882b4e10858a233a5422ede80d79c21965136e9..b8bb8cdfb69bd6aa8102bff474d8a25a881fb29d 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -256,6 +256,8 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 
 		buf1 |= FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
 		ctrl |= MT_DMA_CTL_TO_HOST;
+
+		txwi->qid = q - dev->q_rx;
 	}
 
 	WRITE_ONCE(desc->buf0, cpu_to_le32(buf->addr));
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4559ff608df02c5b482a901923a6a43493cd37b3..2db56d4be36a23e1689adf78dc887f9f5304e73c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -418,6 +418,8 @@ struct mt76_txwi_cache {
 		struct sk_buff *skb;
 		void *ptr;
 	};
+
+	u8 qid;
 };
 
 struct mt76_rx_tid {
@@ -534,6 +536,10 @@ struct mt76_driver_ops {
 
 	void (*rx_poll_complete)(struct mt76_dev *dev, enum mt76_rxq_id q);
 
+	void (*rx_rro_ind_process)(struct mt76_dev *dev, void *data);
+	int (*rx_rro_add_msdu_page)(struct mt76_dev *dev, struct mt76_queue *q,
+				    dma_addr_t p, void *data);
+
 	void (*sta_ps)(struct mt76_dev *dev, struct ieee80211_sta *sta,
 		       bool ps);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index c5fd25acf9a1a60d4aaffe8ba6d2cf2aafe4fd87..2412767bfaa7e26cdce45b482fb56dea2add8280 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -854,6 +854,9 @@ void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
 
 	mt76_tx_status_check(&dev->mt76, true);
 
+	if (dev->has_rro && !mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mt7996_rro_msdu_page_map_free(dev);
+
 	/* reset wfsys */
 	if (force)
 		mt7996_wfsys_reset(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index f1336c7441d27fd150ff6994147cb7c5b0d0b127..497095d263c9151464b9eff38e88fbcb10f4a84e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -744,6 +744,10 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 	if (!dev->has_rro)
 		return;
 
+	INIT_LIST_HEAD(&dev->wed_rro.page_cache);
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.page_map); i++)
+		INIT_LIST_HEAD(&dev->wed_rro.page_map[i]);
+
 	if (is_mt7992(&dev->mt76)) {
 		/* Set emul 3.0 function */
 		mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
@@ -1627,6 +1631,8 @@ void mt7996_unregister_device(struct mt7996_dev *dev)
 	mt7996_mcu_exit(dev);
 	mt7996_tx_token_put(dev);
 	mt7996_dma_cleanup(dev);
+	if (dev->has_rro && !mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mt7996_rro_msdu_page_map_free(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
 	mt76_free_device(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2ca10588b7a67be8a6d72b81c63322ec38cca257..833451957f4371949e444c6958f41bca51858491 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1572,6 +1572,338 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 	}
 }
 
+static struct mt7996_msdu_page *
+mt7996_msdu_page_get_from_cache(struct mt7996_dev *dev)
+{
+	struct mt7996_msdu_page *p = NULL;
+
+	spin_lock(&dev->wed_rro.lock);
+
+	if (!list_empty(&dev->wed_rro.page_cache)) {
+		p = list_first_entry(&dev->wed_rro.page_cache,
+				     struct mt7996_msdu_page, list);
+		if (p)
+			list_del(&p->list);
+	}
+
+	spin_unlock(&dev->wed_rro.lock);
+
+	return p;
+}
+
+static struct mt7996_msdu_page *mt7996_msdu_page_get(struct mt7996_dev *dev)
+{
+	struct mt7996_msdu_page *p;
+
+	p = mt7996_msdu_page_get_from_cache(dev);
+	if (!p) {
+		p = kzalloc(L1_CACHE_ALIGN(sizeof(*p)), GFP_ATOMIC);
+		if (p)
+			INIT_LIST_HEAD(&p->list);
+	}
+
+	return p;
+}
+
+static void mt7996_msdu_page_put_to_cache(struct mt7996_dev *dev,
+					  struct mt7996_msdu_page *p)
+{
+	if (p->buf) {
+		mt76_put_page_pool_buf(p->buf, false);
+		p->buf = NULL;
+	}
+
+	spin_lock(&dev->wed_rro.lock);
+	list_add(&p->list, &dev->wed_rro.page_cache);
+	spin_unlock(&dev->wed_rro.lock);
+}
+
+static void mt7996_msdu_page_free_cache(struct mt7996_dev *dev)
+{
+	while (true) {
+		struct mt7996_msdu_page *p;
+
+		p = mt7996_msdu_page_get_from_cache(dev);
+		if (!p)
+			break;
+
+		if (p->buf)
+			mt76_put_page_pool_buf(p->buf, false);
+
+		kfree(p);
+	}
+}
+
+static u32 mt7996_msdu_page_hash_from_addr(dma_addr_t dma_addr)
+{
+	u32 val = 0;
+	int i = 0;
+
+	while (dma_addr) {
+		val += (u32)((dma_addr & 0xff) + i) % MT7996_RRO_MSDU_PG_HASH_SIZE;
+		dma_addr >>= 8;
+		i += 13;
+	}
+
+	return val % MT7996_RRO_MSDU_PG_HASH_SIZE;
+}
+
+static struct mt7996_msdu_page *
+mt7996_rro_msdu_page_get(struct mt7996_dev *dev, dma_addr_t dma_addr)
+{
+	u32 hash = mt7996_msdu_page_hash_from_addr(dma_addr);
+	struct mt7996_msdu_page *p, *tmp, *addr = NULL;
+
+	spin_lock(&dev->wed_rro.lock);
+
+	list_for_each_entry_safe(p, tmp, &dev->wed_rro.page_map[hash],
+				 list) {
+		if (p->dma_addr == dma_addr) {
+			list_del(&p->list);
+			addr = p;
+			break;
+		}
+	}
+
+	spin_unlock(&dev->wed_rro.lock);
+
+	return addr;
+}
+
+static void mt7996_rx_token_put(struct mt7996_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->mt76.rx_token_size; i++) {
+		struct mt76_txwi_cache *t;
+		struct mt76_queue *q;
+
+		t = mt76_rx_token_release(&dev->mt76, i);
+		if (!t || !t->ptr)
+			continue;
+
+		q = &dev->mt76.q_rx[t->qid];
+		mt76_put_page_pool_buf(t->ptr, false);
+		t->dma_addr = 0;
+		t->ptr = NULL;
+
+		mt76_put_rxwi(&dev->mt76, t);
+	}
+}
+
+void mt7996_rro_msdu_page_map_free(struct mt7996_dev *dev)
+{
+	struct mt7996_msdu_page *p, *tmp;
+	int i;
+
+	local_bh_disable();
+
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.page_map); i++) {
+		list_for_each_entry_safe(p, tmp, &dev->wed_rro.page_map[i],
+					 list) {
+			list_del_init(&p->list);
+			if (p->buf)
+				mt76_put_page_pool_buf(p->buf, false);
+			kfree(p);
+		}
+	}
+	mt7996_msdu_page_free_cache(dev);
+
+	local_bh_enable();
+
+	mt7996_rx_token_put(dev);
+}
+
+int mt7996_rro_msdu_page_add(struct mt76_dev *mdev, struct mt76_queue *q,
+			     dma_addr_t dma_addr, void *data)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct mt7996_msdu_page_info *pinfo = data;
+	struct mt7996_msdu_page *p;
+	u32 hash;
+
+	pinfo->owner = 1;
+	p = mt7996_msdu_page_get(dev);
+	if (!p)
+		return -ENOMEM;
+
+	p->buf = data;
+	p->dma_addr = dma_addr;
+	p->q = q;
+
+	hash = mt7996_msdu_page_hash_from_addr(dma_addr);
+
+	spin_lock(&dev->wed_rro.lock);
+	list_add_tail(&p->list, &dev->wed_rro.page_map[hash]);
+	spin_unlock(&dev->wed_rro.lock);
+
+	return 0;
+}
+
+static struct mt7996_wed_rro_addr *
+mt7996_rro_addr_elem_get(struct mt7996_dev *dev, u16 session_id, u16 seq_num)
+{
+	u32 idx = 0;
+	void *addr;
+
+	if (session_id == MT7996_RRO_MAX_SESSION) {
+		addr = dev->wed_rro.session.ptr;
+	} else {
+		idx = session_id / MT7996_RRO_BA_BITMAP_SESSION_SIZE;
+		addr = dev->wed_rro.addr_elem[idx].ptr;
+
+		idx = session_id % MT7996_RRO_BA_BITMAP_SESSION_SIZE;
+		idx = idx * MT7996_RRO_WINDOW_MAX_LEN;
+	}
+	idx += seq_num % MT7996_RRO_WINDOW_MAX_LEN;
+
+	return addr + idx * sizeof(struct mt7996_wed_rro_addr);
+}
+
+#define MT996_RRO_SN_MASK	GENMASK(11, 0)
+
+void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
+{
+	struct mt7996_dev *dev = container_of(mdev, struct mt7996_dev, mt76);
+	struct mt76_wed_rro_ind *cmd = (struct mt76_wed_rro_ind *)data;
+	struct mt7996_msdu_page_info *pinfo = NULL;
+	struct mt7996_msdu_page *p = NULL;
+	int i, seq_num = 0;
+
+	for (i = 0; i < cmd->ind_cnt; i++) {
+		struct mt7996_wed_rro_addr *e;
+		struct mt76_rx_status *status;
+		struct mt7996_rro_hif *rxd;
+		int j, len, qid, data_len;
+		struct mt76_txwi_cache *t;
+		struct mt76_queue *q;
+		dma_addr_t dma_addr;
+		struct sk_buff *skb;
+		u32 info = 0;
+		void *buf;
+
+		seq_num = FIELD_GET(MT996_RRO_SN_MASK, cmd->start_sn + i);
+		e = mt7996_rro_addr_elem_get(dev, cmd->se_id, seq_num);
+		if (e->signature != (seq_num / MT7996_RRO_WINDOW_MAX_LEN)) {
+			e->signature = 0xff;
+			goto update_ack_seq_num;
+		}
+
+		dma_addr = e->head_high;
+		dma_addr <<= 32;
+		dma_addr |= e->head_low;
+
+		for (j = 0; j < e->count; j++) {
+			if (!p) {
+				p = mt7996_rro_msdu_page_get(dev, dma_addr);
+				if (!p)
+					continue;
+
+				dma_sync_single_for_cpu(mdev->dma_dev, p->dma_addr,
+							SKB_WITH_OVERHEAD(p->q->buf_size),
+							page_pool_get_dma_dir(p->q->page_pool));
+				pinfo = (struct mt7996_msdu_page_info *)p->buf;
+			}
+
+			rxd = &pinfo->rxd[j % MT7996_MAX_HIF_RXD_IN_PG];
+			len = rxd->sdl;
+
+			t = mt76_rx_token_release(mdev, rxd->rx_token_id);
+			if (!t)
+				goto next_page;
+
+			qid = t->qid;
+			buf = t->ptr;
+			q = &mdev->q_rx[qid];
+			dma_sync_single_for_cpu(mdev->dma_dev, t->dma_addr,
+						SKB_WITH_OVERHEAD(q->buf_size),
+						page_pool_get_dma_dir(q->page_pool));
+
+			t->dma_addr = 0;
+			t->ptr = NULL;
+			mt76_put_rxwi(mdev, t);
+			if (!buf)
+				goto next_page;
+
+			if (q->rx_head)
+				data_len = q->buf_size;
+			else
+				data_len = SKB_WITH_OVERHEAD(q->buf_size);
+
+			if (data_len < len + q->buf_offset) {
+				dev_kfree_skb(q->rx_head);
+				mt76_put_page_pool_buf(buf, false);
+				q->rx_head = NULL;
+				goto next_page;
+			}
+
+			if (q->rx_head) {
+				/* TODO: Take into account non-linear skb. */
+				mt76_put_page_pool_buf(buf, false);
+				if (rxd->ls) {
+					dev_kfree_skb(q->rx_head);
+					q->rx_head = NULL;
+				}
+				goto next_page;
+			}
+
+			if (rxd->ls && !mt7996_rx_check(mdev, buf, len))
+				goto next_page;
+
+			skb = build_skb(buf, q->buf_size);
+			if (!skb)
+				goto next_page;
+
+			skb_reserve(skb, q->buf_offset);
+			skb_mark_for_recycle(skb);
+			__skb_put(skb, len);
+
+			if (cmd->ind_reason == 1 || cmd->ind_reason == 2) {
+				dev_kfree_skb(skb);
+				goto next_page;
+			}
+
+			if (!rxd->ls) {
+				q->rx_head = skb;
+				goto next_page;
+			}
+
+			status = (struct mt76_rx_status *)skb->cb;
+			if (cmd->se_id != MT7996_RRO_MAX_SESSION)
+				status->aggr = true;
+
+			mt7996_queue_rx_skb(mdev, qid, skb, &info);
+next_page:
+			if ((j + 1) % MT7996_MAX_HIF_RXD_IN_PG == 0) {
+				dma_addr = pinfo->next_pg_high;
+				dma_addr <<= 32;
+				dma_addr |= pinfo->next_pg_low;
+				mt7996_msdu_page_put_to_cache(dev, p);
+				p = NULL;
+			}
+		}
+
+update_ack_seq_num:
+		if ((i + 1) % 4 == 0)
+			mt76_wr(dev, MT_RRO_ACK_SN_CTRL,
+				FIELD_PREP(MT_RRO_ACK_SN_CTRL_SESSION_MASK,
+					   cmd->se_id) |
+				FIELD_PREP(MT_RRO_ACK_SN_CTRL_SN_MASK,
+					   seq_num));
+		if (p) {
+			mt7996_msdu_page_put_to_cache(dev, p);
+			p = NULL;
+		}
+	}
+
+	/* Update ack_seq_num for remaining addr_elem */
+	if (i % 4)
+		mt76_wr(dev, MT_RRO_ACK_SN_CTRL,
+			FIELD_PREP(MT_RRO_ACK_SN_CTRL_SESSION_MASK,
+				   cmd->se_id) |
+			FIELD_PREP(MT_RRO_ACK_SN_CTRL_SN_MASK, seq_num));
+}
+
 void mt7996_mac_cca_stats_reset(struct mt7996_phy *phy)
 {
 	struct mt7996_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index aa70e5fce98f005ef5c3f588203f61e179ff04e8..38c15b061dfffc512f99fe4c7d70dcfd92f14c6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -821,6 +821,8 @@ struct mt7996_dev *mt7996_mmio_probe(struct device *pdev,
 		.rx_skb = mt7996_queue_rx_skb,
 		.rx_check = mt7996_rx_check,
 		.rx_poll_complete = mt7996_rx_poll_complete,
+		.rx_rro_ind_process = mt7996_rro_rx_process,
+		.rx_rro_add_msdu_page = mt7996_rro_msdu_page_add,
 		.update_survey = mt7996_update_channel,
 		.set_channel = mt7996_set_channel,
 		.vif_link_add = mt7996_vif_link_add,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 0182cc47959e422d07550c3f4781bd1946ac7170..aa33068a6649b8e9b73061c2617f2ce318b8b0db 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -112,6 +112,7 @@
 #define MT7996_CRIT_TEMP		110
 #define MT7996_MAX_TEMP			120
 
+#define MT7996_MAX_HIF_RXD_IN_PG	5
 #define MT7996_RRO_MSDU_PG_HASH_SIZE	127
 #define MT7996_RRO_MAX_SESSION		1024
 #define MT7996_RRO_WINDOW_MAX_LEN	1024
@@ -299,6 +300,49 @@ struct mt7996_wed_rro_session_id {
 	u16 id;
 };
 
+struct mt7996_msdu_page {
+	struct list_head list;
+
+	struct mt76_queue *q;
+	dma_addr_t dma_addr;
+	void *buf;
+};
+
+struct mt7996_rro_hif {
+	u32 rx_blk_base_low;
+	u32 rx_blk_base_high	: 4;
+	u32 eth_hdr_ofst	: 7;
+	u32 rsv			: 1;
+	u32 ring_no		: 2;
+	u32 dst_sel		: 2;
+	u32 sdl			: 14;
+	u32 ls			: 1;
+	u32 rsv2		: 1;
+	u32 pn_31_0;
+	u32 pn_47_32		: 16;
+	u32 cs_status		: 4;
+	u32 cs_type		: 4;
+	u32 c			: 1;
+	u32 f			: 1;
+	u32 un			: 1;
+	u32 rsv3		: 1;
+	u32 is_fc_data		: 1;
+	u32 uc			: 1;
+	u32 mc			: 1;
+	u32 bc			: 1;
+	u16 rx_token_id;
+	u16 rsv4;
+	u32 rsv5;
+};
+
+struct mt7996_msdu_page_info {
+	struct mt7996_rro_hif rxd[MT7996_MAX_HIF_RXD_IN_PG];
+	u32 next_pg_low;
+	u32 next_pg_high	: 4;
+	u32 rsv			: 27;
+	u32 owner		: 1;
+};
+
 struct mt7996_phy {
 	struct mt76_phy *mt76;
 	struct mt7996_dev *dev;
@@ -416,6 +460,9 @@ struct mt7996_dev {
 		struct work_struct work;
 		struct list_head poll_list;
 		spinlock_t lock;
+
+		struct list_head page_cache;
+		struct list_head page_map[MT7996_RRO_MSDU_PG_HASH_SIZE];
 	} wed_rro;
 
 	bool ibf;
@@ -775,6 +822,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 void mt7996_tx_token_put(struct mt7996_dev *dev);
 void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb, u32 *info);
+void mt7996_rro_msdu_page_map_free(struct mt7996_dev *dev);
+int mt7996_rro_msdu_page_add(struct mt76_dev *mdev, struct mt76_queue *q,
+			     dma_addr_t dma_addr, void *data);
+void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data);
 bool mt7996_rx_check(struct mt76_dev *mdev, void *data, int len);
 void mt7996_stats_work(struct work_struct *work);
 int mt76_dfs_start_rdd(struct mt7996_dev *dev, bool force);

-- 
2.50.1


