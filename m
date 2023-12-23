Return-Path: <linux-wireless+bounces-1259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74F81D20D
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 05:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B391C228DB
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 04:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8A2117;
	Sat, 23 Dec 2023 04:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SVArxqMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B441FB0
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c640dbeea14711eeba30773df0976c77-20231223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WzPfFq3PXd/eEY3q3pIRTwOEtnm5hPd8UW2giEGbMc0=;
	b=SVArxqMG1NFSiTbVw2Egjfw73nFNhMMstyBCbw/W/fkBO2jOiU8qTstR4uuOI/T/DnDldVfbjrqx6z5QBPqQ6aSrFc8nHid9BGQwFX+TsaM6ioWd9ByVS3cPqyIG2QdClhwx+zP56t9TA4LEV7obfb4qaxUpBvnzMGBxMz94wH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b36289bf-f4cc-4501-8a6e-7ed9389817cf,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:41f47b8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c640dbeea14711eeba30773df0976c77-20231223
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1231620259; Sat, 23 Dec 2023 12:00:13 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 23 Dec 2023 12:00:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 23 Dec 2023 12:00:12 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: usb: store usb endpoint in mt76_queue
Date: Sat, 23 Dec 2023 11:43:07 +0800
Message-ID: <5f955adb9abacf1f55151f86907dde539db6ea93.1703301666.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3eb3a860ccdf465b77ae63d6ddcf6a584d1729ce.1703301666.git.deren.wu@mediatek.com>
References: <3eb3a860ccdf465b77ae63d6ddcf6a584d1729ce.1703301666.git.deren.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

From: Lorenzo Bianconi <lorenzo@kernel.org>

Store usb endpoint in mt76_queue structure and rework q2ep routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     | 10 ++----
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 drivers/net/wireless/mediatek/mt76/usb.c      | 35 ++++++++++++-------
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b20c34d5a0f7..98fe533af20f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -210,6 +210,8 @@ struct mt76_queue {
 	u16 first;
 	u16 head;
 	u16 tail;
+	u8 hw_idx;
+	u8 ep;
 	int ndesc;
 	int queued;
 	int buf_size;
@@ -217,7 +219,6 @@ struct mt76_queue {
 	bool blocked;
 
 	u8 buf_offset;
-	u8 hw_idx;
 	u16 flags;
 
 	struct mtk_wed_device *wed;
@@ -1470,13 +1471,6 @@ static inline bool mt76u_urb_error(struct urb *urb)
 	       urb->status != -ENOENT;
 }
 
-/* Map hardware queues to usb endpoints */
-static inline u8 q2ep(u8 qid)
-{
-	/* TODO: take management packets to queue 5 */
-	return qid + 1;
-}
-
 static inline int
 mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	       int timeout, int ep)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 85a78dea4085..29b9a15f8dbe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -67,7 +67,7 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, void *data,
 			    struct mt76_tx_info *tx_info)
 {
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
-	int pid, len = tx_info->skb->len, ep = q2ep(dev->mphy.q_tx[qid]->hw_idx);
+	int pid, len = tx_info->skb->len, ep = dev->mphy.q_tx[qid]->ep;
 	struct mt76x02_txwi *txwi;
 	bool ampdu = IEEE80211_SKB_CB(tx_info->skb)->flags & IEEE80211_TX_CTL_AMPDU;
 	enum mt76_qsel qsel;
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 9958399ff57e..55b74919df21 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -872,9 +872,8 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 	if (err < 0)
 		return err;
 
-	mt76u_fill_bulk_urb(dev, USB_DIR_OUT, q2ep(q->hw_idx),
-			    q->entry[idx].urb, mt76u_complete_tx,
-			    &q->entry[idx]);
+	mt76u_fill_bulk_urb(dev, USB_DIR_OUT, q->ep, q->entry[idx].urb,
+			    mt76u_complete_tx, &q->entry[idx]);
 
 	q->head = (q->head + 1) % q->ndesc;
 	q->entry[idx].skb = tx_info.skb;
@@ -906,9 +905,13 @@ static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 	}
 }
 
-static u8 mt76u_ac_to_hwq(struct mt76_dev *dev, u8 ac)
+static void
+mt76u_ac_to_hwq(struct mt76_dev *dev, struct mt76_queue *q, u8 qid)
 {
-	if (mt76_chip(dev) == 0x7663) {
+	u8 ac = qid < IEEE80211_NUM_ACS ? qid : IEEE80211_AC_BE;
+
+	switch (mt76_chip(dev)) {
+	case 0x7663: {
 		static const u8 lmac_queue_map[] = {
 			/* ac to lmac mapping */
 			[IEEE80211_AC_BK] = 0,
@@ -917,13 +920,20 @@ static u8 mt76u_ac_to_hwq(struct mt76_dev *dev, u8 ac)
 			[IEEE80211_AC_VO] = 4,
 		};
 
-		if (WARN_ON(ac >= ARRAY_SIZE(lmac_queue_map)))
-			return 1; /* BE */
-
-		return lmac_queue_map[ac];
+		q->hw_idx = lmac_queue_map[ac];
+		q->ep = q->hw_idx + 1;
+		break;
+	}
+	case 0x7961:
+	case 0x7925:
+		q->hw_idx = mt76_ac_to_hwq(ac);
+		q->ep = qid == MT_TXQ_PSD ? MT_EP_OUT_HCCA : q->hw_idx + 1;
+		break;
+	default:
+		q->hw_idx = mt76_ac_to_hwq(ac);
+		q->ep = q->hw_idx + 1;
+		break;
 	}
-
-	return mt76_ac_to_hwq(ac);
 }
 
 static int mt76u_alloc_tx(struct mt76_dev *dev)
@@ -939,8 +949,7 @@ static int mt76u_alloc_tx(struct mt76_dev *dev)
 			return -ENOMEM;
 
 		spin_lock_init(&q->lock);
-		q->hw_idx = mt76u_ac_to_hwq(dev, i);
-
+		mt76u_ac_to_hwq(dev, q, i);
 		dev->phy.q_tx[i] = q;
 
 		q->entry = devm_kcalloc(dev->dev,
-- 
2.18.0


