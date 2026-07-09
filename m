Return-Path: <linux-wireless+bounces-38811-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NMaiBYBVT2qYegIAu9opvQ
	(envelope-from <linux-wireless+bounces-38811-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:02:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F172E049
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 10:02:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=OLHl2lwp;
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38811-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38811-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BC0230AEC93
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86A3E6DEC;
	Thu,  9 Jul 2026 07:56:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3EF3DE44C
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 07:56:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583783; cv=none; b=rVYzoBLCtHT7b9wUz8okFWguMkXa4d/sJ4wtLBAum7h/2mCFxF/P6PMI4H3aF75rgPn9zjAjtHHrXPn1LL7z0sxBoFhQFOToGJUyAebJzAXJvSnRJLy3JphKUgu+Shsf09BfroHyAWne6X5rwi+NHN/fHgjRGMjzGiMaXCJ2o84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583783; c=relaxed/simple;
	bh=d5QskRb9tWhxj+T5DqfsPbWBm4a4I9V6AnZ4beMdT5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWlr5vwIPnSgTYUNL2ul0M/dR2sEVnAH4MWgIm/XDPbM2kLa1UAAU1bcT77Qkg82M7FRxtWGi2NibLIJM8JnJlYkrxofAv6RLOckEDiG3Ed7EbUkSOBdnHwQZFTgAdZehCdfJ3uyIHv0sLtuDlRgp7XffOvS7gpY30TGbTbrXh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OLHl2lwp; arc=none smtp.client-ip=210.61.82.184
X-UUID: a89e389c7b6b11f18dc8c9802ae25ab1-20260709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nd9R7pzCUtLZPwwIvxP5DkpQqu2Y3+lqlCBrszORcZ0=;
	b=OLHl2lwpEQkUYoWKag4vmwV8NbbPj6kFp8aD+UxDqGhZYe6ozQOH5KagOw6MgIRQOcf8ldRMpMP6hDt2oDskEEmkw9zzgvm27wFy1PzHU4VoLGQcyBjWx4n077GsM9c+DHB2ZpA1hOfKrFEOMw3HT1bACAYseSdWkcdzwT4zzKs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:68b313ca-7041-4f98-91e3-10509b1a7047,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:d497b38,CLOUDID:1ce22f82-6310-4e6b-a6b1-aca20d98ed8b,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a89e389c7b6b11f18dc8c9802ae25ab1-20260709
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <eason.lai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1570717831; Thu, 09 Jul 2026 15:56:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
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
Subject: [PATCH 1/3] wifi: mt76: Separate skb and page_pool_buf pointers in mt76_txwi_cache
Date: Thu, 9 Jul 2026 15:55:56 +0800
Message-ID: <20260709075558.1654164-2-eason.lai@mediatek.com>
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
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38811-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Yf.Luo@mediatek.com,m:kun.wu@mediatek.com,m:deren.wu@mediatek.com,m:sean.wang@mediatek.com,m:quan.zhou@mediatek.com,m:ryder.lee@mediatek.com,m:leon.yen@mediatek.com,m:litien.chang@mediatek.com,m:jb.tsai@mediatek.com,m:eason.lai@mediatek.com,m:Eason.Lai@mediatek.com,s:lists@lfdr.de];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eason.lai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 185F172E049

From: Eason Lai <Eason.Lai@mediatek.com>

Refactor mt76_txwi_cache structure to use separate skb and page_pool_buf
fields instead of a union with ptr. This improves type safety and makes
the code more explicit about which pointer type is being used in
different contexts.

Also add skip_unmap flag to tx_info.buf to handle cases where DMA
unmapping should be skipped.

Signed-off-by: Eason Lai <Eason.Lai@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/dma.c      | 29 ++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt76.h     |  4 +--
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 10 +++----
 drivers/net/wireless/mediatek/mt76/tx.c       |  2 +-
 drivers/net/wireless/mediatek/mt76/wed.c      |  6 ++--
 5 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index f8c2fe5f2f58..2716278788bd 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -43,7 +43,8 @@ mt76_alloc_rxwi(struct mt76_dev *dev)
 	if (!t)
 		return NULL;
 
-	t->ptr = NULL;
+	t->skb = NULL;
+	t->page_pool_buf = NULL;
 	return t;
 }
 
@@ -84,8 +85,11 @@ mt76_get_txwi(struct mt76_dev *dev)
 {
 	struct mt76_txwi_cache *t = __mt76_get_txwi(dev);
 
-	if (t)
+	if (t) {
+		t->skb = NULL;
+		t->page_pool_buf = NULL;
 		return t;
+	}
 
 	return mt76_alloc_txwi(dev);
 }
@@ -147,8 +151,8 @@ mt76_free_pending_rxwi(struct mt76_dev *dev)
 
 	local_bh_disable();
 	while ((t = __mt76_get_rxwi(dev)) != NULL) {
-		if (t->ptr)
-			mt76_put_page_pool_buf(t->ptr, false);
+		if (t->page_pool_buf)
+			mt76_put_page_pool_buf(t->page_pool_buf, false);
 		kfree(t);
 	}
 	local_bh_enable();
@@ -475,14 +479,14 @@ mt76_dma_get_rxdmad_c_buf(struct mt76_dev *dev, struct mt76_queue *q,
 	if (more)
 		*more = !FIELD_GET(RRO_RXDMAD_DATA1_LS_MASK, data1);
 
-	buf = t->ptr;
+	buf = t->page_pool_buf;
 	ind_reason = FIELD_GET(RRO_RXDMAD_DATA2_IND_REASON_MASK, data2);
 	if (ind_reason == MT_DMA_WED_IND_REASON_REPEAT ||
 	    ind_reason == MT_DMA_WED_IND_REASON_OLDPKT) {
 		mt76_put_page_pool_buf(buf, false);
 		buf = ERR_PTR(-EAGAIN);
 	}
-	t->ptr = NULL;
+	t->page_pool_buf = NULL;
 	t->dma_addr = 0;
 
 	mt76_put_rxwi(dev, t);
@@ -529,9 +533,9 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct mt76_queue *q, int idx,
 				SKB_WITH_OVERHEAD(q->buf_size),
 				page_pool_get_dma_dir(q->page_pool));
 
-		buf = t->ptr;
+		buf = t->page_pool_buf;
 		t->dma_addr = 0;
-		t->ptr = NULL;
+		t->page_pool_buf = NULL;
 
 		mt76_put_rxwi(dev, t);
 		if (drop)
@@ -694,6 +698,7 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 			goto unmap;
 
 		tx_info.buf[n].addr = addr;
+		tx_info.buf[n].skip_unmap = false;
 		tx_info.buf[n++].len = iter->len;
 	}
 	tx_info.nbuf = n;
@@ -718,9 +723,11 @@ mt76_dma_tx_queue_skb(struct mt76_phy *phy, struct mt76_queue *q,
 				tx_info.info, tx_info.skb, t);
 
 unmap:
-	for (n--; n > 0; n--)
-		dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
-				 tx_info.buf[n].len, DMA_TO_DEVICE);
+	for (n--; n > 0; n--) {
+		if (!tx_info.buf[n].skip_unmap)
+			dma_unmap_single(dev->dma_dev, tx_info.buf[n].addr,
+					 tx_info.buf[n].len, DMA_TO_DEVICE);
+	}
 
 free:
 #ifdef CONFIG_NL80211_TESTMODE
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 527bef97e122..927c21536f4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -445,10 +445,8 @@ struct mt76_txwi_cache {
 	struct list_head list;
 	dma_addr_t dma_addr;
 
-	union {
 		struct sk_buff *skb;
-		void *ptr;
-	};
+	void *page_pool_buf;
 
 	u8 qid;
 	u8 phy_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index e2a83da3a09c..924b0dc0ff1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1775,12 +1775,12 @@ static void mt7996_rx_token_put(struct mt7996_dev *dev)
 		struct mt76_txwi_cache *t;
 
 		t = mt76_rx_token_release(&dev->mt76, i);
-		if (!t || !t->ptr)
+		if (!t || !t->page_pool_buf)
 			continue;
 
-		mt76_put_page_pool_buf(t->ptr, false);
+		mt76_put_page_pool_buf(t->page_pool_buf, false);
 		t->dma_addr = 0;
-		t->ptr = NULL;
+		t->page_pool_buf = NULL;
 
 		mt76_put_rxwi(&dev->mt76, t);
 	}
@@ -1928,14 +1928,14 @@ void mt7996_rro_rx_process(struct mt76_dev *mdev, void *data)
 				goto next_page;
 
 			qid = t->qid;
-			buf = t->ptr;
+			buf = t->page_pool_buf;
 			q = &mdev->q_rx[qid];
 			dma_sync_single_for_cpu(mdev->dma_dev, t->dma_addr,
 						SKB_WITH_OVERHEAD(q->buf_size),
 						page_pool_get_dma_dir(q->page_pool));
 
 			t->dma_addr = 0;
-			t->ptr = NULL;
+			t->page_pool_buf = NULL;
 			mt76_put_rxwi(mdev, t);
 			if (!buf)
 				goto next_page;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 22f9690634c9..665156a7ea65 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -899,7 +899,7 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void *ptr,
 	token = idr_alloc(&dev->rx_token, t, 0, dev->rx_token_size,
 			  GFP_ATOMIC);
 	if (token >= 0) {
-		t->ptr = ptr;
+		t->page_pool_buf = ptr;
 		t->dma_addr = phys;
 	}
 	spin_unlock_bh(&dev->rx_token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/wed.c b/drivers/net/wireless/mediatek/mt76/wed.c
index ed657d952de2..e1cf81d722b8 100644
--- a/drivers/net/wireless/mediatek/mt76/wed.c
+++ b/drivers/net/wireless/mediatek/mt76/wed.c
@@ -15,11 +15,11 @@ void mt76_wed_release_rx_buf(struct mtk_wed_device *wed)
 		struct mt76_txwi_cache *t;
 
 		t = mt76_rx_token_release(dev, i);
-		if (!t || !t->ptr)
+		if (!t || !t->page_pool_buf)
 			continue;
 
-		mt76_put_page_pool_buf(t->ptr, false);
-		t->ptr = NULL;
+		mt76_put_page_pool_buf(t->page_pool_buf, false);
+		t->page_pool_buf = NULL;
 
 		mt76_put_rxwi(dev, t);
 	}
-- 
2.45.2


