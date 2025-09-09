Return-Path: <linux-wireless+bounces-27170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E59B4A8B5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 11:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 814E54E2973
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C2E310768;
	Tue,  9 Sep 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcwdT+OC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230EE2848A9
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411156; cv=none; b=iBYNLi6aUQb24R55WLlORI7YyaHffYYJ1dqMAFLOciaSOOmshbZxAATohVzYUMw5pUEBvbOb/BW9EBK8xIHrmzw8gTBKFJQkQ8cE+I8dCDnESldG1l5g+qZqFq4hrYrcmbXRuEhzP+duZGYcohPYGZ5WpHDaVYgINI595y2Xi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411156; c=relaxed/simple;
	bh=EUhkUMfw1b7lsBxEJUJ8IzKLWhCX2S0YTK0t5XvCpyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upucEuRsLflaCExplRcrD/ad2G6h9Xno0DMBBwQQVkjoyuF0uqAKQ5N3ua6rB6UFF2eebWuKrgK3UPBeHT2eeV7MeQ8/srfQ2r/eY7jT3oaeCB0PV+f0b9dNPuFCZA+S7HcBdAXXZYDbYL3y1U8iysQJyi9IhyGvusLcdNOswBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcwdT+OC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF45C4CEF4;
	Tue,  9 Sep 2025 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411155;
	bh=EUhkUMfw1b7lsBxEJUJ8IzKLWhCX2S0YTK0t5XvCpyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NcwdT+OCyfz9ujnAk87NOiTZgMnC9VQPSfif91Azi38n3jm3ymOkMr4FCHdqbNF0o
	 4KoEGQygUrEo9Y5e2whY4c/YjZBj/kvdX98lheT4ELZ6rTi0Wc+jTAsxdsEtY3BjZs
	 2UO4E6lkMEVT114sujyksDlZV+Jrfv1S+yRl3s+GGZaC6pYB4c81REpreeb/Ds36bC
	 eR+lOeZybO3aA44ReIsPZxh3W+ARffMIKYhWSXg71stHP7DJrSpHTUnDtFQ5WKvfGd
	 6zb4XaEc9db9AZ0Ut0BvM5VyOGpnHFpCi19z/ZZqsg+f7+fgWVsSdZCnxiusY00rLQ
	 3FbyRvE1PJvDA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 09 Sep 2025 11:45:20 +0200
Subject: [PATCH mt76 v5 12/16] wifi: mt76: mt7996: Introduce RRO MSDU
 callbacks
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mt7996-rro-rework-v5-12-7d66f6eb7795@kernel.org>
References: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
In-Reply-To: <20250909-mt7996-rro-rework-v5-0-7d66f6eb7795@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Bo Jiao <Bo.Jiao@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Rex Lu <rex.lu@mediatek.com>
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
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 352 +++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c   |   2 +
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  38 +++
 7 files changed, 409 insertions(+)

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
index 58d8aa213bb7bf7d1bab0926eca23303d8a733a7..60a3f13ac99125f66f3af406a2a37c25b257a762 100644
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
index f70e24d989cbd0454fa4f9273c87057258ded0f9..701efbf20d1282dc77bdf0825cde2c53b2fa366e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -774,6 +774,10 @@ void mt7996_rro_hw_init(struct mt7996_dev *dev)
 	if (!dev->has_rro)
 		return;
 
+	INIT_LIST_HEAD(&dev->wed_rro.page_cache);
+	for (i = 0; i < ARRAY_SIZE(dev->wed_rro.page_map); i++)
+		INIT_LIST_HEAD(&dev->wed_rro.page_map[i]);
+
 	if (is_mt7992(&dev->mt76)) {
 		/* Set emul 3.0 function */
 		mt76_wr(dev, MT_RRO_3_0_EMU_CONF,
@@ -1658,6 +1662,8 @@ void mt7996_unregister_device(struct mt7996_dev *dev)
 	mt7996_mcu_exit(dev);
 	mt7996_tx_token_put(dev);
 	mt7996_dma_cleanup(dev);
+	if (dev->has_rro && !mtk_wed_device_active(&dev->mt76.mmio.wed))
+		mt7996_rro_msdu_page_map_free(dev);
 	tasklet_disable(&dev->mt76.irq_tasklet);
 
 	mt76_free_device(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e31e3324acf97b309c317a5203b78cf55306abdf..1b2ec5d55434166421d9496e80f9a2de5b765ac3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1630,6 +1630,358 @@ void mt7996_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
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
+
+		t = mt76_rx_token_release(&dev->mt76, i);
+		if (!t || !t->ptr)
+			continue;
+
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
+	pinfo->data |= cpu_to_le32(FIELD_PREP(MSDU_PAGE_INFO_OWNER_MASK, 1));
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
+		dma_addr_t dma_addr = 0;
+		u16 rx_token_id, count;
+		struct mt76_queue *q;
+		struct sk_buff *skb;
+		u32 info = 0, data;
+		u8 signature;
+		void *buf;
+		bool ls;
+
+		seq_num = FIELD_GET(MT996_RRO_SN_MASK, cmd->start_sn + i);
+		e = mt7996_rro_addr_elem_get(dev, cmd->se_id, seq_num);
+		data = le32_to_cpu(e->data);
+		signature = FIELD_GET(WED_RRO_ADDR_SIGNATURE_MASK, data);
+		if (signature != (seq_num / MT7996_RRO_WINDOW_MAX_LEN)) {
+			u32 val = FIELD_PREP(WED_RRO_ADDR_SIGNATURE_MASK,
+					     0xff);
+
+			e->data |= cpu_to_le32(val);
+			goto update_ack_seq_num;
+		}
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+		dma_addr = FIELD_GET(WED_RRO_ADDR_HEAD_HIGH_MASK, data);
+		dma_addr <<= 32;
+#endif
+		dma_addr |= le32_to_cpu(e->head_low);
+
+		count = FIELD_GET(WED_RRO_ADDR_COUNT_MASK, data);
+		for (j = 0; j < count; j++) {
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
+			len = FIELD_GET(RRO_HIF_DATA1_SDL_MASK,
+					le32_to_cpu(rxd->data1));
+
+			rx_token_id = FIELD_GET(RRO_HIF_DATA4_RX_TOKEN_ID_MASK,
+						le32_to_cpu(rxd->data4));
+			t = mt76_rx_token_release(mdev, rx_token_id);
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
+			ls = FIELD_GET(RRO_HIF_DATA1_LS_MASK,
+				       le32_to_cpu(rxd->data1));
+			if (q->rx_head) {
+				/* TODO: Take into account non-linear skb. */
+				mt76_put_page_pool_buf(buf, false);
+				if (ls) {
+					dev_kfree_skb(q->rx_head);
+					q->rx_head = NULL;
+				}
+				goto next_page;
+			}
+
+			if (ls && !mt7996_rx_check(mdev, buf, len))
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
+			if (!ls) {
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
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+				dma_addr =
+					FIELD_GET(MSDU_PAGE_INFO_PG_HIGH_MASK,
+						  le32_to_cpu(pinfo->data));
+				dma_addr <<= 32;
+				dma_addr |= le32_to_cpu(pinfo->pg_low);
+#else
+				dma_addr = le32_to_cpu(pinfo->pg_low);
+#endif
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
index 313f6923d071a71152cadceaaf09dfd80b005287..1b3ec264fad534c92e81b4d57ac840e3dbcec8a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -112,6 +112,7 @@
 #define MT7996_CRIT_TEMP		110
 #define MT7996_MAX_TEMP			120
 
+#define MT7996_MAX_HIF_RXD_IN_PG	5
 #define MT7996_RRO_MSDU_PG_HASH_SIZE	127
 #define MT7996_RRO_MAX_SESSION		1024
 #define MT7996_RRO_WINDOW_MAX_LEN	1024
@@ -298,6 +299,36 @@ struct mt7996_wed_rro_session_id {
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
+/* data1 */
+#define RRO_HIF_DATA1_LS_MASK		BIT(30)
+#define RRO_HIF_DATA1_SDL_MASK		GENMASK(29, 16)
+/* data4 */
+#define RRO_HIF_DATA4_RX_TOKEN_ID_MASK	GENMASK(15, 0)
+struct mt7996_rro_hif {
+	__le32 data0;
+	__le32 data1;
+	__le32 data2;
+	__le32 data3;
+	__le32 data4;
+	__le32 data5;
+};
+
+#define MSDU_PAGE_INFO_OWNER_MASK	BIT(31)
+#define MSDU_PAGE_INFO_PG_HIGH_MASK	GENMASK(3, 0)
+struct mt7996_msdu_page_info {
+	struct mt7996_rro_hif rxd[MT7996_MAX_HIF_RXD_IN_PG];
+	__le32 pg_low;
+	__le32 data;
+};
+
 struct mt7996_phy {
 	struct mt76_phy *mt76;
 	struct mt7996_dev *dev;
@@ -415,6 +446,9 @@ struct mt7996_dev {
 		struct work_struct work;
 		struct list_head poll_list;
 		spinlock_t lock;
+
+		struct list_head page_cache;
+		struct list_head page_map[MT7996_RRO_MSDU_PG_HASH_SIZE];
 	} wed_rro;
 
 	bool ibf;
@@ -772,6 +806,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
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
2.51.0


