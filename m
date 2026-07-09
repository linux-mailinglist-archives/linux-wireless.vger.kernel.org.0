Return-Path: <linux-wireless+bounces-38809-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7X1eKl9VT2qGegIAu9opvQ
	(envelope-from <linux-wireless+bounces-38809-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:01:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E972E034
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:01:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=s33VaGCu;
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38809-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38809-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB501309FC45
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD03E63A4;
	Thu,  9 Jul 2026 07:56:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B59D3DDDCF
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 07:56:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583782; cv=none; b=GaSREUxGcvaGQiKQKbgl/BNHw5cjpXWr96uyuuhmpT6/0FG3I5b6JY73Fc8D17SzTUJ5PV4BlOpqAFK+9fcmaHZ7xPuw5uK6K1nrK2BDTGcRwtiUzL9VWb1t/K7JdP7ZomIuywYX75d+Ntizg4oWsyO26MESmFezdulX3u0X7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583782; c=relaxed/simple;
	bh=X7+JGLpx8boXQ1l0FlyCVO27wk1wDyUU5swjxyZ5PKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsCDUh3+vqUGVAd9Cw90JDWKLauM8H52A8GddqMwwmB94wbk74C56EwxPdk8grQW8Ogwpul6MmLYcPPhWxXZ8gZgFWdkaZEPnAXcGex9sK6s20Tf8gOd8d/B/QwGPIsZxFDMqtR86HpaulHHOc/STSB9xLnZTAuGTm9wBLu8PbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s33VaGCu; arc=none smtp.client-ip=60.244.123.138
X-UUID: a824d1467b6b11f1b1788b6acf885367-20260709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8VMQAkoyg1uuUbVqb1hAkPag8hPCx00MNhELw8RQtq4=;
	b=s33VaGCuqmQLn1eNo0+7C1YsvAm7som6eb/KBn1MVW8jM5eHrN181Gi770GtqqfcLGea2UUCyA4r03ZT1DE1shp7QtwuwCiBdO5zK+db+mz52+cWoP070Fp4fQ8pwhy6JUGGgQj3wDqn5LbTMOytWoiIL32PUR+J8qUE5QtGRvs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:8aa9378e-57e9-4fbf-b53c-131a3cde8521,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:d497b38,CLOUDID:563eee14-ea64-44d4-98db-4e1fb89955a3,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|136|836|865|888|898,TC:-5,Content:0|
	15|50|99,EDM:-3|-100,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a824d1467b6b11f1b1788b6acf885367-20260709
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1499306179; Thu, 09 Jul 2026 15:56:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 9 Jul 2026 15:56:13 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 9 Jul 2026 15:56:13 +0800
From: Eason Lai <eason.lai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Yf.Luo@mediatek.com>, <kun.wu@mediatek.com>, <deren.wu@mediatek.com>,
	<sean.wang@mediatek.com>, <quan.zhou@mediatek.com>, <ryder.lee@mediatek.com>,
	<leon.yen@mediatek.com>, <litien.chang@mediatek.com>, <jb.tsai@mediatek.com>,
	<eason.lai@mediatek.com>, Eason Lai <Eason.Lai@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt792x: Add TX page pool support for IOMMU-enabled systems
Date: Thu, 9 Jul 2026 15:55:57 +0800
Message-ID: <20260709075558.1654164-3-eason.lai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709075558.1654164-1-eason.lai@mediatek.com>
References: <20260709075558.1654164-1-eason.lai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38809-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,m:eason.lai@mediatek.com,m:Eason.Lai@mediatek.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	RSPAMD_URIBL_FAIL(0.00)[mediatek.com:query timed out,vger.kernel.org:query timed out];
	RSPAMD_EMAILBL_FAIL(0.00)[eason.lai@mediatek.com:query timed out,eason.lai.mediatek.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C74E972E034

From: Eason Lai <Eason.Lai@mediatek.com>

Add support for TX page pool allocation in mt792x devices when IOMMU is
enabled. This optimization reduces DMA mapping overhead by
pre-allocating and reusing page pool buffers for TX operations.

Key changes:
- Export DMA helper functions and ops for mt792x usage
  - Add tx_prealloc_enabled flag to track page pool state
    - Implement mt792x-specific DMA queue operations with TX page pool
      - Create page pools per TX queue when IOMMU is detected
        - Handle page pool buffer cleanup in both success and error
          paths
- Add proper skip_unmap flag handling for page pool buffers

The page pool path is used for linear skbs without fragments, falling
back to standard DMA mapping for complex skb structures.

Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      |  26 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  11 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |   6 +
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |   4 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   2 +
 .../net/wireless/mediatek/mt76/mt792x_dma.c   | 322 ++++++++++++++++++
 6 files changed, 362 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 2716278788bd..df89c0d1d526 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <net/page_pool/helpers.h>
 #include "mt76.h"
 #include "dma.h"
 #include "mt76_connac.h"
@@ -80,7 +82,7 @@ __mt76_get_rxwi(struct mt76_dev *dev)
 	return t;
 }
 
-static struct mt76_txwi_cache *
+struct mt76_txwi_cache *
 mt76_get_txwi(struct mt76_dev *dev)
 {
 	struct mt76_txwi_cache *t = __mt76_get_txwi(dev);
@@ -93,6 +95,7 @@ mt76_get_txwi(struct mt76_dev *dev)
 
 	return mt76_alloc_txwi(dev);
 }
+EXPORT_SYMBOL_GPL(mt76_get_txwi);
 
 struct mt76_txwi_cache *
 mt76_get_rxwi(struct mt76_dev *dev)
@@ -137,8 +140,10 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 
 	local_bh_disable();
 	while ((t = __mt76_get_txwi(dev)) != NULL) {
-		dma_unmap_single(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
-				 DMA_TO_DEVICE);
+		if (dev->dma_dev) {
+			dma_unmap_single(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
+					 DMA_TO_DEVICE);
+		}
 		kfree(mt76_get_txwi_ptr(dev, t));
 	}
 	local_bh_enable();
@@ -190,7 +195,7 @@ mt76_dma_queue_magic_cnt_init(struct mt76_dev *dev, struct mt76_queue *q)
 	}
 }
 
-static void
+void
 mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	if ((q->flags & MT_QFLAG_WED_RRO_EN) &&
@@ -208,6 +213,7 @@ mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q)
 	q->head = Q_READ(q, dma_idx);
 	q->tail = q->head;
 }
+EXPORT_SYMBOL_GPL(mt76_dma_sync_idx);
 
 void mt76_dma_queue_reset(struct mt76_dev *dev, struct mt76_queue *q,
 			  bool reset_idx)
@@ -310,7 +316,7 @@ mt76_dma_add_rx_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	return idx;
 }
 
-static int
+int
 mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 		 struct mt76_queue_buf *buf, int nbufs, u32 info,
 		 struct sk_buff *skb, void *txwi)
@@ -378,8 +384,9 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
 
 	return idx;
 }
+EXPORT_SYMBOL_GPL(mt76_dma_add_buf);
 
-static void
+void
 mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 			struct mt76_queue_entry *prev_e)
 {
@@ -399,8 +406,9 @@ mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 	*prev_e = *e;
 	memset(e, 0, sizeof(*e));
 }
+EXPORT_SYMBOL_GPL(mt76_dma_tx_cleanup_idx);
 
-static void
+void
 mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 {
 	wmb();
@@ -409,6 +417,7 @@ mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q)
 	else
 		Q_WRITE(q, cpu_idx, q->head);
 }
+EXPORT_SYMBOL_GPL(mt76_dma_kick_queue);
 
 static void
 mt76_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
@@ -1152,7 +1161,7 @@ mt76_dma_init(struct mt76_dev *dev,
 	return 0;
 }
 
-static const struct mt76_queue_ops mt76_dma_ops = {
+const struct mt76_queue_ops mt76_dma_ops = {
 	.init = mt76_dma_init,
 	.alloc = mt76_dma_alloc_queue,
 	.reset_q = mt76_dma_queue_reset,
@@ -1164,6 +1173,7 @@ static const struct mt76_queue_ops mt76_dma_ops = {
 	.rx_reset = mt76_dma_rx_reset,
 	.kick = mt76_dma_kick_queue,
 };
+EXPORT_SYMBOL_GPL(mt76_dma_ops);
 
 void mt76_dma_attach(struct mt76_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 927c21536f4e..25e24fa36eca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -957,6 +957,8 @@ struct mt76_dev {
 	int tx_dma_idx[4];
 	enum mt76_hwrro_mode hwrro_mode;
 
+	bool tx_prealloc_enabled;
+
 	struct mt76_worker tx_worker;
 	struct napi_struct tx_napi;
 
@@ -1785,7 +1787,16 @@ mt76_tx_status_get_hw(struct mt76_dev *dev, struct sk_buff *skb)
 
 void mt76_put_txwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
 void mt76_put_rxwi(struct mt76_dev *dev, struct mt76_txwi_cache *t);
+struct mt76_txwi_cache *mt76_get_txwi(struct mt76_dev *dev);
 struct mt76_txwi_cache *mt76_get_rxwi(struct mt76_dev *dev);
+int mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_queue *q,
+		     struct mt76_queue_buf *buf, int nbufs, u32 info,
+		     struct sk_buff *skb, void *txwi);
+void mt76_dma_tx_cleanup_idx(struct mt76_dev *dev, struct mt76_queue *q, int idx,
+			     struct mt76_queue_entry *prev_e);
+void mt76_dma_kick_queue(struct mt76_dev *dev, struct mt76_queue *q);
+void mt76_dma_sync_idx(struct mt76_dev *dev, struct mt76_queue *q);
+extern const struct mt76_queue_ops mt76_dma_ops;
 void mt76_free_pending_rxwi(struct mt76_dev *dev);
 void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 		      struct napi_struct *napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0339e2e7ab60..d4b36b0832b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -250,6 +250,12 @@ void mt76_connac_txp_skb_unmap(struct mt76_dev *dev,
 {
 	struct mt76_connac_txp_common *txp;
 
+	if (t->page_pool_buf) {
+		mt76_put_page_pool_buf(t->page_pool_buf, false);
+		t->page_pool_buf = NULL;
+		return;
+	}
+
 	txp = mt76_connac_txwi_to_txp(dev, t);
 	if (is_mt76_fw_txp(dev))
 		mt76_connac_txp_skb_unmap_fw(dev, &txp->fw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c4161754c01d..3d69d8c67dea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -214,7 +214,7 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 {
 	int ret;
 
-	mt76_dma_attach(&dev->mt76);
+	mt792x_dma_attach(&dev->mt76);
 
 	ret = mt792x_dma_disable(dev, true);
 	if (ret)
@@ -263,6 +263,8 @@ static int mt7925_dma_init(struct mt792x_dev *dev)
 			  mt792x_poll_tx);
 	napi_enable(&dev->mt76.tx_napi);
 
+	mt792x_dma_tx_page_pool_init(dev);
+
 	return mt792x_dma_enable(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 4ff93f2cd624..7ac0318dc249 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -418,8 +418,10 @@ void mt792x_sta_statistics(struct ieee80211_hw *hw,
 			   struct station_info *sinfo);
 void mt792x_set_coverage_class(struct ieee80211_hw *hw, int radio_idx,
 			       s16 coverage_class);
+void mt792x_dma_attach(struct mt76_dev *dev);
 void mt792x_dma_cleanup(struct mt792x_dev *dev);
 int mt792x_dma_enable(struct mt792x_dev *dev);
+int mt792x_dma_tx_page_pool_init(struct mt792x_dev *dev);
 int mt792x_wpdma_reset(struct mt792x_dev *dev, bool force);
 int mt792x_wpdma_reinit_cond(struct mt792x_dev *dev);
 int mt792x_dma_disable(struct mt792x_dev *dev, bool force);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
index 002aece857b2..b341f1cb3ce0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_dma.c
@@ -3,6 +3,9 @@
 
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/iommu.h>
+#include <net/page_pool/helpers.h>
+#include <linux/of.h>
 
 #include "mt792x.h"
 #include "dma.h"
@@ -266,6 +269,323 @@ int mt792x_wpdma_reinit_cond(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt792x_wpdma_reinit_cond);
 
+static int mt792x_create_tx_page_pool(struct mt76_dev *dev, struct mt76_queue *q)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = 0,
+		.nid = NUMA_NO_NODE,
+		.dev = dev->dma_dev,
+	};
+
+	if (!q || !dev->tx_prealloc_enabled)
+		return 0;
+
+	if (!mt76_is_mmio(dev))
+		return 0;
+
+	pp_params.pool_size = 256;
+	pp_params.flags |= PP_FLAG_DMA_MAP;
+	pp_params.dma_dir = DMA_BIDIRECTIONAL;
+	pp_params.max_len = PAGE_SIZE;
+	pp_params.offset = 0;
+
+	q->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(q->page_pool)) {
+		int err = PTR_ERR(q->page_pool);
+
+		q->page_pool = NULL;
+		dev_warn(dev->dev, "Failed to create TX page pool for queue %d (err=%d)\n",
+			 q->hw_idx, err);
+		return 0;
+	}
+
+	return 0;
+}
+
+int mt792x_dma_tx_page_pool_init(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	int i, ret, pool_count = 0;
+
+	if (!iommu_get_domain_for_dev(mdev->dma_dev))
+		return 0;
+
+	if (!mt76_is_mmio(mdev))
+		return 0;
+
+	mdev->tx_prealloc_enabled = true;
+
+	for (i = 0; i < ARRAY_SIZE(mdev->phy.q_tx); i++) {
+		struct mt76_queue *q = mdev->phy.q_tx[i];
+
+		if (!q)
+			continue;
+
+		ret = mt792x_create_tx_page_pool(mdev, q);
+		if (ret)
+			return ret;
+
+		if (q->page_pool)
+			pool_count++;
+	}
+
+	if (pool_count > 0)
+		dev_info(mdev->dev,
+			 "IOMMU enabled, created %d TX page pools\n", pool_count);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_tx_page_pool_init);
+
+static void mt792x_dma_tx_page_pool_cleanup(struct mt792x_dev *dev)
+{
+	struct mt76_dev *mdev = &dev->mt76;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mdev->phy.q_tx); i++) {
+		struct mt76_queue *q = mdev->phy.q_tx[i];
+
+		if (!q || !q->page_pool)
+			continue;
+
+		page_pool_destroy(q->page_pool);
+		q->page_pool = NULL;
+	}
+
+	mdev->tx_prealloc_enabled = false;
+}
+
+static void *
+mt792x_dma_tx_alloc_page_pool_buf(struct mt76_dev *dev, struct mt76_queue *q,
+				  struct sk_buff *skb, dma_addr_t *dma_addr,
+				  int *buf_len)
+{
+	struct page *page;
+	void *buf;
+	int len;
+	u32 offset;
+
+	if (!q->page_pool || !dev->tx_prealloc_enabled)
+		return NULL;
+
+	len = skb_headlen(skb);
+	if (len > PAGE_SIZE)
+		return NULL;
+
+	buf = mt76_get_page_pool_buf(q, &offset, len);
+	if (!buf)
+		return NULL;
+
+	page = virt_to_head_page(buf);
+	*dma_addr = page_pool_get_dma_addr(page) + offset;
+	if (unlikely(!*dma_addr)) {
+		dev_warn_ratelimited(dev->dev, "Page pool returned NULL DMA address\n");
+		mt76_put_page_pool_buf(buf, false);
+		return NULL;
+	}
+
+	*buf_len = len;
+
+	dma_sync_single_for_cpu(dev->dma_dev, *dma_addr, len, DMA_TO_DEVICE);
+	skb_copy_from_linear_data(skb, buf, len);
+	dma_sync_single_for_device(dev->dma_dev, *dma_addr, len, DMA_TO_DEVICE);
+
+	return buf;
+}
+
+static int
+mt792x_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
+			enum mt76_txq_id qid, struct sk_buff *skb,
+			struct mt76_wcid *wcid, struct ieee80211_sta *sta)
+{
+	struct ieee80211_tx_status status = {
+		.sta = sta,
+	};
+	struct mt76_tx_info tx_info = {
+		.skb = skb,
+	};
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_hw *hw;
+	int len, n = 0, ret = -ENOMEM;
+	struct mt76_txwi_cache *t;
+	struct sk_buff *iter;
+	dma_addr_t addr;
+	u8 *txwi;
+
+	if (test_bit(MT76_RESET, &phy->state))
+		goto free_skb;
+
+	t = mt76_get_txwi(dev);
+	if (!t)
+		goto free_skb;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	skb->prev = NULL;
+	skb->next = NULL;
+	if (dev->drv->drv_flags & MT_DRV_TX_ALIGNED4_SKBS)
+		mt76_insert_hdr_pad(skb);
+
+	len = skb_headlen(skb);
+
+	if (dev->tx_prealloc_enabled && q->page_pool &&
+	    !skb_has_frag_list(skb) && !skb_shinfo(skb)->nr_frags) {
+		void *buf;
+		int pp_len;
+
+		buf = mt792x_dma_tx_alloc_page_pool_buf(dev, q, skb, &addr, &pp_len);
+		if (buf) {
+			t->page_pool_buf = buf;
+			len = pp_len;
+
+			tx_info.buf[n].addr = t->dma_addr;
+			tx_info.buf[n++].len = dev->drv->txwi_size;
+			tx_info.buf[n].addr = addr;
+			tx_info.buf[n].len = len;
+			tx_info.buf[n].skip_unmap = true;
+			n++;
+
+			goto skip_dma_map;
+		}
+	}
+
+	addr = dma_map_single(dev->dma_dev, skb->data, len, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
+		goto free;
+
+	t->page_pool_buf = NULL;
+
+	tx_info.buf[n].addr = t->dma_addr;
+	tx_info.buf[n++].len = dev->drv->txwi_size;
+	tx_info.buf[n].addr = addr;
+	tx_info.buf[n++].len = len;
+
+skip_dma_map:
+	skb_walk_frags(skb, iter) {
+		if (n == ARRAY_SIZE(tx_info.buf))
+			goto unmap;
+
+		addr = dma_map_single(dev->dma_dev, iter->data, iter->len,
+				      DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
+			goto unmap;
+
+		tx_info.buf[n].addr = addr;
+		tx_info.buf[n].skip_unmap = false;
+		tx_info.buf[n++].len = iter->len;
+	}
+	tx_info.nbuf = n;
+
+	if (q->queued + (tx_info.nbuf + 1) / 2 >= q->ndesc - 1) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
+	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
+				DMA_TO_DEVICE);
+	ret = dev->drv->tx_prepare_skb(dev, txwi, qid, wcid, sta, &tx_info);
+	dma_sync_single_for_device(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
+				   DMA_TO_DEVICE);
+	if (ret < 0)
+		goto unmap;
+
+	return mt76_dma_add_buf(dev, q, tx_info.buf, tx_info.nbuf,
+				tx_info.info, tx_info.skb, t);
+
+unmap:
+	for (n--; n > 0; n--) {
+		if (!tx_info.buf[n].skip_unmap)
+			dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
+					 tx_info.buf[n].len, DMA_TO_DEVICE);
+	}
+
+	if (t->page_pool_buf) {
+		mt76_put_page_pool_buf(t->page_pool_buf, false);
+		t->page_pool_buf = NULL;
+	}
+
+free:
+#ifdef CONFIG_NL80211_TESTMODE
+	if (mt76_is_testmode_skb(dev, skb, &hw)) {
+		struct mt76_phy *phy = hw->priv;
+
+		if (tx_info.skb == phy->test.tx_skb)
+			phy->test.tx_done--;
+	}
+#endif
+
+	mt76_put_txwi(dev, t);
+
+free_skb:
+	status.skb = tx_info.skb;
+	hw = mt76_tx_status_get_hw(dev, tx_info.skb);
+	spin_lock_bh(&dev->rx_lock);
+	ieee80211_tx_status_ext(hw, &status);
+	spin_unlock_bh(&dev->rx_lock);
+
+	return ret;
+}
+
+static void
+mt792x_dma_tx_cleanup(struct mt76_dev *dev, struct mt76_queue *q, bool flush)
+{
+	struct mt76_queue_entry entry;
+	int last;
+
+	if (!q || !q->ndesc)
+		return;
+
+	spin_lock_bh(&q->cleanup_lock);
+	if (flush)
+		last = -1;
+	else
+		last = Q_READ(q, dma_idx);
+
+	while (q->queued > 0 && q->tail != last) {
+		mt76_dma_tx_cleanup_idx(dev, q, q->tail, &entry);
+		mt76_npu_txdesc_cleanup(q, q->tail);
+		mt76_queue_tx_complete(dev, q, &entry);
+
+		if (entry.txwi) {
+			if (entry.skb && entry.txwi->page_pool_buf) {
+				mt76_put_page_pool_buf(entry.txwi->page_pool_buf, false);
+				entry.txwi->page_pool_buf = NULL;
+			}
+
+			if (!(dev->drv->drv_flags & MT_DRV_TXWI_NO_FREE))
+				mt76_put_txwi(dev, entry.txwi);
+		}
+
+		if (!flush && q->tail == last)
+			last = Q_READ(q, dma_idx);
+	}
+	spin_unlock_bh(&q->cleanup_lock);
+
+	if (flush) {
+		spin_lock_bh(&q->lock);
+		mt76_dma_sync_idx(dev, q);
+		mt76_dma_kick_queue(dev, q);
+		spin_unlock_bh(&q->lock);
+	}
+
+	if (!q->queued)
+		wake_up(&dev->tx_wait);
+}
+
+static struct mt76_queue_ops mt792x_queue_ops;
+
+void mt792x_dma_attach(struct mt76_dev *dev)
+{
+	mt792x_queue_ops = mt76_dma_ops;
+
+	mt792x_queue_ops.tx_queue_skb = mt792x_dma_tx_queue_skb;
+	mt792x_queue_ops.tx_cleanup = mt792x_dma_tx_cleanup;
+
+	dev->queue_ops = &mt792x_queue_ops;
+}
+EXPORT_SYMBOL_GPL(mt792x_dma_attach);
+
 int mt792x_dma_disable(struct mt792x_dev *dev, bool force)
 {
 	/* disable WFDMA0 */
@@ -326,6 +646,8 @@ void mt792x_dma_cleanup(struct mt792x_dev *dev)
 		 MT_WFDMA0_RST_LOGIC_RST);
 
 	mt76_dma_cleanup(&dev->mt76);
+
+	mt792x_dma_tx_page_pool_cleanup(dev);
 }
 EXPORT_SYMBOL_GPL(mt792x_dma_cleanup);
 
-- 
2.45.2


